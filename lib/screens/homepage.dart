import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_rental/constants.dart';
import 'package:vehicle_rental/models/vehicle.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import 'package:vehicle_rental/screens/availablecars.dart';
import 'package:vehicle_rental/screens/profilescreen.dart';
import 'package:vehicle_rental/screens/rentedcars.dart';
import '../env.dart';
import '../models/rentalagreement.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RentalAgreement? agreement;
  Vehicle? vehicle;

  @override
  void initState() {
    super.initState();
    getRecentTransaction(context);
    getRecentVehicle(context);
  }

  Future<void> getRecentTransaction(BuildContext context) async {
    var id = context.read<AccountProvider>().id;
    final response = await http.post(
      Uri.parse('${Env.prefix}/recent/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'account': id,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      RentalAgreement agreement = RentalAgreement.fromJson(data);
      setState(() {
        this.agreement = agreement;
      });
    } else {
      throw Exception('Failed to get rent due');
    }
  }

  Future<void> getRecentVehicle(BuildContext context) async {
    var id = context.read<AccountProvider>().id;
    final response = await http.post(
      Uri.parse('${Env.prefix}/recent_vehicle/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'account': id,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      Vehicle vehicle = Vehicle.fromJson(data);
      setState(() {
        this.vehicle = vehicle;
      });
    }
    // else {
    //   throw Exception('Failed to get recent car');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  context.read<AccountProvider>().setNull();
                  Navigator.pop(context);
                },
                child: const Text('Log Out'))
          ],
        ),
        drawer: getDrawer(context),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blue,
                    ),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.search),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 17,
                            letterSpacing: -0.41,
                          ),
                          decoration: InputDecoration(
                              hintText: "Search",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: 17,
                                letterSpacing: -0.41,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Card(
                  color: cardColor,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: cardBorder),
                  ),
                  shadowColor: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'New Arrivals',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            color: titleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 100,
                            child: Image.asset(
                                'images/cars/auto-lada-russische-auto.jpg'),
                          ),
                          SizedBox(
                            height: 100,
                            child: Image.asset(
                                'images/cars/auto-mustang-autoachtergrond.jpg'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Card(
                  color: cardColor,
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: cardBorder),
                  ),
                  shadowColor: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Recent Transaction',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 28,
                            color: titleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      agreement != null && vehicle != null
                          ? Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.black,
                              )),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  if (vehicle != null)
                                    SizedBox(
                                        height: 200,
                                        child: Image.asset(
                                          vehicle?.image ??
                                              'images/cars/auto-mustang-autoachtergrond.jpg',
                                        )),
                                  Text(
                                    'Rent Date: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(agreement?.rentDate ?? '') ?? DateTime.now())}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Number of Days: ${agreement?.numberOfDays}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: textColor,
                                    ),
                                  ),
                                  Text(
                                    'Amount Due: ${agreement!.rentDue?.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const Text(
                              'No new transactions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 28,
                                  color: titleColor,
                                  fontWeight: FontWeight.bold),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
