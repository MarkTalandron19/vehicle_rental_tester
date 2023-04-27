import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import 'package:vehicle_rental/screens/availablecars.dart';
import 'package:vehicle_rental/screens/loginpage.dart';
import 'package:vehicle_rental/screens/registerpage.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => AccountProvider(),
    child: const MyApp(),
  ));
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
      routes: {'/': (context) => LogInPage()},
    );
  }
}
