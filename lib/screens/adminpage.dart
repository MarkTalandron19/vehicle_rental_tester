import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/screens/accountspage.dart';
import 'package:vehicle_rental/screens/rentalagreementspage.dart';
import 'package:vehicle_rental/screens/vehiclespage.dart';

import '../providers/accountprovider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Admin Page'),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () {
                context.read<AccountProvider>().setNull();
                Navigator.pop(context);
              },
              child: const Text('Log Out'))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AccountsPage()));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.person,
                    ),
                    Text('Account'),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VehiclesPage()));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.car_rental_rounded,
                    ),
                    Text('Vehicles'),
                  ],
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RentalAgreementsPage()));
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.edit_document,
                    ),
                    Text('Rental Agreements'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
