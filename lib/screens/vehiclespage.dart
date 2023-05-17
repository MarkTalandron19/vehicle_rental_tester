import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_rental/screens/addvehiclepage.dart';
import 'package:vehicle_rental/screens/editvehiclepage.dart';

import '../env.dart';
import '../models/vehicle.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  late Future<List<Vehicle>> vehicles;
  final vehicleListKey = GlobalKey<_VehiclesPageState>();

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
    return Scaffold(
      key: vehicleListKey,
      appBar: AppBar(
        title: const Text('Vehicles'),
      ),
      body: Center(
        child: FutureBuilder<List<Vehicle>>(
          future: vehicles,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Vehicle vehicleData = Vehicle(
                        vehicleID: data.vehicleID,
                        vehicleName: data.vehicleName,
                        vehicleModel: data.vehicleModel,
                        vehicleBrand: data.vehicleBrand,
                        vehicleManufacturer: data.vehicleManufacturer,
                        vehicleType: data.vehicleType,
                        vehicleRentRate: data.vehicleRentRate,
                        available: data.available,
                        image: data.image);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditVehiclePage(
                              vehicle: vehicleData,
                            )));
                  },
                  child: Card(
                    child: ListTile(title: Text(data.vehicleName)),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddVehiclePage()));
          },
          label: const Text('Add Vehicle')),
    );
  }
}
