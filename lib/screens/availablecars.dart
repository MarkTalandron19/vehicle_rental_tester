import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../models/Vehicle.dart';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  late Future<List<Vehicle>> vehicles;
  final vehicleListKey = GlobalKey<_AvailableCarsState>();

  @override
  void initState() {
    super.initState();
    vehicles = getVehicles();
  }

  Future<List<Vehicle>> getVehicles() async {
    final response = await http.get(Uri.parse('${Env.prefix}/vehicles'));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Vehicle> vehicles = items.map<Vehicle>((json) {
      return Vehicle.fromJson(json);
    }).toList();

    return vehicles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: vehicles,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 0.75,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var data = snapshot.data[index];
              return Card(
                  child: Column(
                children: [
                  Expanded(
                      child: Image.asset(
                    data.image,
                    fit: BoxFit.cover,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          data.vehicleName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.vehicleModel,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
            },
          );
        });
  }
}
