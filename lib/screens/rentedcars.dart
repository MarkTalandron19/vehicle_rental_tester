import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/env.dart';
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

  @override
  void initState() {
    super.initState();
    rented = getRented();
  }

  Future<List<Vehicle>> getRented() async {
    final url = Uri.parse('${Env.prefix}/rented/');
    final headers = {'Content-Type': 'application/json'};
    final accountID = context.read<AccountProvider>().id!;
    final body = jsonEncode({'account': accountID});
    final response = await http.post(url, headers: headers, body: body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Vehicle> rents = items.map<Vehicle>((json) {
      return Vehicle.fromJson(json);
    }).toList();

    return rents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return Card(
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
                                ),
                              ),
                              Text(
                                'Model: ${data.vehicleModel}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Brand: ${data.vehicleBrand}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Rental Rate: ${data.vehicleRentRate}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
