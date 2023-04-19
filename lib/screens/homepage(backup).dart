import 'package:flutter/material.dart';
import 'package:vehicle_rental/models/Vehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../env.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  late Future<List<Vehicle>> vehicles;
  final vehicleListKey = GlobalKey<_HomePage2State>();

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
