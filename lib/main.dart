import 'package:flutter/material.dart';
import 'package:vehicle_rental/screens/availablecars.dart';
import 'package:vehicle_rental/screens/loginpage.dart';
import 'package:vehicle_rental/screens/registerpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {'/': (context) => const RegisterPage()},
    );
  }
}
