import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/account.dart';

class AccountWidget extends StatelessWidget {
  Account? account;
  AccountWidget({super.key, this.account});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Username: ${account?.username}'),
          Text('Password: ${account?.password}'),
          Text('First Name: ${account?.firstName}'),
          Text('Last Name: ${account?.lastName}'),
        ],
      ),
    );
  }
}
