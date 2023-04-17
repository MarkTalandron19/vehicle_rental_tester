import 'package:flutter/material.dart';
import 'package:vehicle_rental/screens/registerpage.dart';

import '../models/account.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 0,
              ),
              SizedBox(
                width: width,
                child: Row(
                  children: const [
                    Icon(
                      Icons.car_rental,
                      size: 130,
                    ),
                    Text(
                      'Vehicle Rental',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: width * .85,
                    child: TextField(
                      controller: _usernameController,
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width * .85,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log In'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No Account?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      'Register Here!',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
