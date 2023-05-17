import 'package:flutter/material.dart';
import 'package:vehicle_rental/models/rentalagreement.dart';

import '../constants.dart';

class AgreementPage extends StatelessWidget {
  RentalAgreement agreement;
  AgreementPage({super.key, required this.agreement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agreement Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rent ID: ${agreement.rentID}",
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rent Date: ${agreement.rentDate}",
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Number of Days: ${agreement.numberOfDays}",
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rent Due: ${agreement.rentDue}",
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Associated Account: ${agreement.account}",
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rented Vehicle ID: ${agreement.vehicle}",
              style: const TextStyle(
                fontSize: 30,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
