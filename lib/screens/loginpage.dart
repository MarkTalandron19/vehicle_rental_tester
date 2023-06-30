import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_rental/constants.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import 'package:vehicle_rental/screens/adminpage.dart';
import 'package:vehicle_rental/screens/homepage.dart';
import 'package:vehicle_rental/screens/registerpage.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../models/account.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<Account?> _login() async {
    final url = Uri.parse('${Env.prefix}/login/');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'username': usernameController.text,
          'password': passwordController.text
        }));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      Map<String, dynamic> user = jsonBody['user'];
      Env.token = jsonBody['token'];
      final account = Account.fromJson(user);
      return account;
    } else {
      return null;
    }
  } //ebcd45a5838f7ad9fbc10e3f02e5966e7596dfc5

  Future<void> showFailure(BuildContext context) async {
    return showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text(
              "Error",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.red,
              ),
            ),
            content: const Text("Failed to login.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      color: titleColor,
                    ),
                  ),
                ],
              ),
              Column(
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
                          border: OutlineInputBorder(), labelText: 'Password'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width * .85,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    Account? account = await _login();
                    if (account != null) {
                      context.read<AccountProvider>().setAccount(account);
                      usernameController.clear();
                      passwordController.clear();
                      if (context.read<AccountProvider>().role == 'User') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AdminPage()));
                      }
                    } else {
                      showFailure(context);
                    }
                  },
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
