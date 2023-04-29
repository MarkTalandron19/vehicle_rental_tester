import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_rental/providers/accountprovider.dart';
import 'package:vehicle_rental/widgets/accountwidget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Consumer<AccountProvider>(
        builder: (context, value, child) {
          return AccountWidget(
            account: value.acc,
          );
        },
      ),
    ));
  }
}
