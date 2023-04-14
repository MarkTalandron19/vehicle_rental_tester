import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                height: 0,
              ),
              Flexible(
                flex: 4,
                child: SizedBox(
                  width: 390,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Flexible(
                        flex: 5,
                        child: Icon(
                          Icons.car_rental,
                          size: 130,
                        ),
                      ),
                      Flexible(
                          flex: 7,
                          child: Text(
                            'Vehicle Rental',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: SizedBox(
                  width: 390,
                  child: Column(
                    children: const [
                      SizedBox(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username'),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                  flex: 15,
                  child: SizedBox(
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Log In'),
                    ),
                  )),
              Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No Account?',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Register Here!',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
