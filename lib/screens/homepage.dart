import 'package:flutter/material.dart';
import 'package:vehicle_rental/screens/availablecars.dart';
import 'package:vehicle_rental/screens/profilescreen.dart';
import 'package:vehicle_rental/screens/rentedcars.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home Page'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
                },
                child: const Text('Profile')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AvailableCars()));
                },
                child: const Text('Rent a Car')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RentedCars()));
                },
                child: const Text('Rented Cars')),
          ],
        ));
  }
}
