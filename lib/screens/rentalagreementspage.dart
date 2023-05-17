import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vehicle_rental/models/rentalagreement.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_rental/screens/agreementpage.dart';

import '../env.dart';

class RentalAgreementsPage extends StatefulWidget {
  const RentalAgreementsPage({super.key});

  @override
  State<RentalAgreementsPage> createState() => _RentalAgreementsPageState();
}

class _RentalAgreementsPageState extends State<RentalAgreementsPage> {
  late Future<List<RentalAgreement>> agreements;
  final vehicleListKey = GlobalKey<_RentalAgreementsPageState>();

  @override
  void initState() {
    super.initState();
    agreements = getAgreements();
  }

  Future<List<RentalAgreement>> getAgreements() async {
    final response = await http.get(Uri.parse('${Env.prefix}/agreements'));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<RentalAgreement> agreements = items.map<RentalAgreement>((json) {
      return RentalAgreement.fromJson(json);
    }).toList();

    return agreements;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: vehicleListKey,
      appBar: AppBar(
        title: const Text('Vehicles'),
      ),
      body: Center(
        child: FutureBuilder<List<RentalAgreement>>(
          future: agreements,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    RentalAgreement agreementData = RentalAgreement(
                        rentID: data.rentID,
                        rentDate: data.rentDate,
                        numberOfDays: data.numberOfDays,
                        rentDue: data.rentDue,
                        account: data.account,
                        vehicle: data.vehicle);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AgreementPage(
                              agreement: agreementData,
                            )));
                  },
                  child: Card(
                    child: ListTile(title: Text(data.rentID)),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
