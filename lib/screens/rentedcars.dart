import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/constants.dart';
import 'package:vehicle_rental/env.dart';
import 'package:vehicle_rental/models/rentalagreement.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import '../models/Vehicle.dart';
import 'package:http/http.dart' as http;

class RentedCars extends StatefulWidget {
  const RentedCars({super.key});

  @override
  State<RentedCars> createState() => _RentedCarsState();
}

class _RentedCarsState extends State<RentedCars> {
  late Future<List<Vehicle>> rented;
  Map<String, double> rentDueMap = {};
  Map<String, int> daysMap = {};

  @override
  void initState() {
    super.initState();
    rented = getRented();
  }

  Future<void> showFailure(BuildContext context) async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              "Error",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.red,
              ),
            ),
            content: const Text("Failed to get rent due.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        }));
  }

  Future<List<Vehicle>> getRented() async {
    final url = Uri.parse('${Env.prefix}/rented/');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Token ${Env.token}'
    };
    final accountID = context.read<AccountProvider>().id!;
    final body = jsonEncode({'account': accountID});
    final response = await http.post(url, headers: headers, body: body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Vehicle> rents = items.map<Vehicle>((json) {
      return Vehicle.fromJson(json);
    }).toList();

    return rents;
  }

  Future<void> getRentInfo(String vehicleID) async {
    final response = await http.post(
      Uri.parse('${Env.prefix}/due/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'account': context.read<AccountProvider>().id,
        'vehicle': vehicleID
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      RentalAgreement agreement = RentalAgreement.fromJson(data);
      setState(() {
        rentDueMap[vehicleID] = agreement.rentDue!;
        daysMap[vehicleID] = agreement.numberOfDays!;
      });
    } else {
      showFailure(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Rented Vehicles'),
      ),
      body: Center(
        child: FutureBuilder(
          future: rented,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data[index];
                  if (!rentDueMap.containsKey(data.vehicleID) &&
                      !daysMap.containsKey(data.vehicleID)) {
                    getRentInfo(data.vehicleID);
                  }
                  return Card(
                    color: cardColor,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(
                      color: cardBorder,
                    )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                            child: Image.asset(
                          data.image,
                          fit: BoxFit.cover,
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${data.vehicleName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Model: ${data.vehicleModel}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Brand: ${data.vehicleBrand}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Number of Days: ${daysMap[data.vehicleID] ?? ""}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                'Amount Due: \$${rentDueMap[data.vehicleID] ?? ""}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
