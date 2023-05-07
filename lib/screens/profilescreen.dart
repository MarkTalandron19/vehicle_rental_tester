import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/constants.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import 'package:vehicle_rental/screens/editprofile.dart';
import 'package:vehicle_rental/widgets/accountwidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Consumer<AccountProvider>(
            builder: (context, value, child) {
              return AccountWidget(
                account: value.acc,
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditProfile()));
              },
              child: const Text('Edit Profile')),
        ],
      ),
    );
  }
}
