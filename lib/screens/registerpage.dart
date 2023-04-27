import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:vehicle_rental/models/account.dart';
import 'dart:convert';

import '../env.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width * .85,
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * .85,
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * .85,
              child: TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * .85,
              child: TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Last Name'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * .85,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  String id = const Uuid().v4();
                  Account newAccount = Account(
                      accountID: id,
                      username: usernameController.text,
                      password: passwordController.text,
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      accountRole: 'User',
                      isActive: true,
                      isStaff: false,
                      isSuperuser: false);
                  Map<String, String> headers = {
                    'Content-type': 'application/json',
                    'Accept': 'application/json',
                  };

                  String url = '${Env.prefix}/register/';

                  http.post(Uri.parse(url),
                      headers: headers, body: jsonEncode(newAccount.toJson()));

                  Navigator.pop(context);
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
