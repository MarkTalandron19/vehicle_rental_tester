import 'package:flutter/material.dart';
import 'package:vehicle_rental/models/Vehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../env.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Vehicle>>? vehicles;
  final vehicleListKey = GlobalKey<_HomePageState>();

  @override
  void initState() {
    super.initState();
    vehicles = getVehicles();
  }

  Future<List<Vehicle>> getVehicles() async {
    final response = await http.get(Uri.parse('${Env.prefix}/vehicledetails'));

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
        title: const Text('Test Vehicle'),
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
                return Card(
                  child: ListTile(title: Text(data.vehicleName)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
