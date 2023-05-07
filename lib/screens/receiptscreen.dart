import 'package:flutter/material.dart';
import 'package:vehicle_rental/constants.dart';
import 'package:vehicle_rental/screens/homepage.dart';

class ReceiptScreen extends StatelessWidget {
  double rentDue;
  int numberOfDays;
  ReceiptScreen({super.key, required this.rentDue, required this.numberOfDays});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Vehicle Rented',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: titleColor,
                  ),
                ),
                Text(
                  'You rented the vehicle for $numberOfDays days',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: textColor,
                  ),
                ),
                Text(
                  'You owe a total of \$${rentDue.toStringAsFixed(2)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: textColor,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil((route) => route.settings.name == '/');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));
                    },
                    child: const Text('Go to Homepage')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
