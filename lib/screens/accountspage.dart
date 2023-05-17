import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_rental/screens/addaccountpage.dart';
import 'package:vehicle_rental/screens/editaccountpage.dart';

import '../env.dart';
import '../models/account.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late Future<List<Account>> accounts;
  final vehicleListKey = GlobalKey<_AccountsPageState>();

  @override
  void initState() {
    super.initState();
    accounts = getAccounts();
  }

  Future<List<Account>> getAccounts() async {
    final response = await http.get(Uri.parse('${Env.prefix}/accounts'));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Account> accounts = items.map<Account>((json) {
      return Account.fromJson(json);
    }).toList();

    return accounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: vehicleListKey,
      appBar: AppBar(
        title: const Text('Vehicles'),
      ),
      body: Center(
        child: FutureBuilder<List<Account>>(
          future: accounts,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Account accountData = Account(
                        accountID: data.accountID,
                        username: data.username,
                        password: data.password,
                        firstName: data.firstName,
                        lastName: data.lastName,
                        accountRole: data.accountRole,
                        isActive: data.isActive,
                        isStaff: data.isStaff,
                        isSuperuser: data.isSuperuser);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditAccountPage(account: accountData)));
                  },
                  child: Card(
                    child: ListTile(
                        title: Text("${data.firstName} ${data.lastName}")),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddAccountPage()));
          },
          label: const Text('Add Account')),
    );
  }
}
