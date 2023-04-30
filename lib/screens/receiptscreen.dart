import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vehicle_rental/screens/homepage.dart';

class ReceiptScreen extends StatelessWidget {
  double rentDue;
  int numberOfDays;
  ReceiptScreen({super.key, required this.rentDue, required this.numberOfDays});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text(
              'Vehicle Rented',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            Text('You rented the vehicle for $numberOfDays days'),
            Text('You owe a total of \$$rentDue'),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                },
                child: const Text('Go to Homepage')),
          ],
        ),
      ),
    );
  }
}
