import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import 'package:vehicle_rental/screens/availablecars.dart';
import 'package:vehicle_rental/screens/profilescreen.dart';
import 'package:vehicle_rental/screens/rentedcars.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
        ),
        drawer: getDrawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AvailableCars()));
            },
            icon: const Icon(Icons.car_rental_rounded),
            label: const Text('Rent Vehicle')),
      ),
    );
  }

  Widget getDrawer(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenu(context),
            ],
          ),
        ),
      );
  Widget buildHeader(BuildContext context) => Container(
        color: Colors.blue.shade700,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 52,
              child: Text('M'),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              '${context.read<AccountProvider>().firstName!} ${context.read<AccountProvider>().lastName!}',
              style: const TextStyle(fontSize: 28, color: Colors.white),
            )
          ],
        ),
      );
  Widget buildMenu(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.car_rental_outlined),
              title: const Text('Rented Vehicles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const RentedCars()));
              },
            ),
          ],
        ),
      );
}
