import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vehicle_rental/constants.dart';
import 'package:vehicle_rental/models/Vehicle.dart';
import 'package:vehicle_rental/screens/receiptscreen.dart';

import '../env.dart';
import '../models/rentalagreement.dart';
import '../providers/accountprovider.dart';
import 'package:http/http.dart' as http;

class RentScreen extends StatelessWidget {
  Vehicle current;
  TextEditingController daysController = TextEditingController();
  RentScreen({super.key, required this.current});

  Future<void> showFailure(BuildContext context, String message) async {
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
            content: const Text("Input number of days.",
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

  @override
  Widget build(BuildContext context) {
    String image = current.image ?? 'null';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Rent Vehicle for How Many Days',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          color: cardColor,
          shape: const RoundedRectangleBorder(
            side: BorderSide(color: cardBorder),
          ),
          shadowColor: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Image.asset(image),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Input Number of Days'),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: TextField(
                      controller: daysController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    if (daysController.text.isNotEmpty) {
                      String id = const Uuid().v4();
                      String accountID = context.read<AccountProvider>().id!;
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
                      int days = int.parse(daysController.text);
                      RentalAgreement newAgreement = RentalAgreement(
                        rentID: id,
                        rentDate: formattedDate,
                        numberOfDays: days,
                        rentDue: (current.vehicleRentRate * days) * 100,
                        account: accountID,
                        vehicle: current.vehicleID,
                      );
                      Map<String, String> headers = {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                      };

                      String url = '${Env.prefix}/rent/';

                      http.post(Uri.parse(url),
                          headers: headers,
                          body: jsonEncode(newAgreement.toJson()));

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ReceiptScreen(
                          numberOfDays: newAgreement.numberOfDays!,
                          rentDue: newAgreement.rentDue!,
                        ),
                      ));
                    } else if (daysController.text == '0') {
                      showFailure(context, 'Inputted a zero');
                    } else {
                      showFailure(context, 'Input number of days.');
                    }
                  },
                  child: const Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
