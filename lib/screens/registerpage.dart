import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
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
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Username'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * .85,
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
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
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'First Name'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: width * .85,
              child: const TextField(
                decoration: InputDecoration(
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
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
