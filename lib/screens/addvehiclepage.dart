import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:vehicle_rental/models/vehicle.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_rental/screens/adminpage.dart';
import '../constants.dart';
import '../env.dart';

class AddVehiclePage extends StatelessWidget {
  const AddVehiclePage({super.key});
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
            content: const Text("Failed to add vehicle.",
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
    var size = MediaQuery.of(context).size;
    var width = size.width;
    TextEditingController vehicleNameController = TextEditingController();
    TextEditingController vehicleModelController = TextEditingController();
    TextEditingController vehicleBrandController = TextEditingController();
    TextEditingController vehicleManufacturerController =
        TextEditingController();
    TextEditingController vehicleTypeController = TextEditingController();
    TextEditingController vehicleRateController = TextEditingController();
    TextEditingController imageLocationController = TextEditingController();

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Register Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width * .85,
                child: TextField(
                  controller: vehicleNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Vehicle Name'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                child: TextField(
                  controller: vehicleModelController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Vehicle Model',
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                child: TextField(
                  controller: vehicleBrandController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Vehicle Brand'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                child: TextField(
                  controller: vehicleManufacturerController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Manufacturer'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                child: TextField(
                  controller: vehicleTypeController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Vehicle Type'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  controller: vehicleRateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Rent Rate'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                child: TextField(
                  controller: imageLocationController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Image Location'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width * .85,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (vehicleNameController.text.isNotEmpty &&
                        vehicleModelController.text.isNotEmpty &&
                        vehicleBrandController.text.isNotEmpty &&
                        vehicleManufacturerController.text.isNotEmpty &&
                        vehicleTypeController.text.isNotEmpty &&
                        vehicleRateController.text.isNotEmpty &&
                        imageLocationController.text.isNotEmpty) {
                      String id = const Uuid().v4();
                      Vehicle newVehicle = Vehicle(
                          vehicleID: id,
                          vehicleName: vehicleNameController.text,
                          vehicleModel: vehicleModelController.text,
                          vehicleBrand: vehicleBrandController.text,
                          vehicleManufacturer:
                              vehicleManufacturerController.text,
                          vehicleType: vehicleTypeController.text,
                          vehicleRentRate:
                              double.parse(vehicleRateController.text),
                          available: true,
                          image: imageLocationController.text);
                      Map<String, String> headers = {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                      };

                      String url = '${Env.prefix}/add_vehicle/';

                      http.post(Uri.parse(url),
                          headers: headers,
                          body: jsonEncode(newVehicle.toJson()));

                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AdminPage(),
                      ));
                    } else {
                      showFailure(context);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ));
  }
}
