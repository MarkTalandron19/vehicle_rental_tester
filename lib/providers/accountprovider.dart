import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vehicle_rental/models/account.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

class AccountProvider extends ChangeNotifier {
  Account? _account;

  Account? get acc => _account;

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('${Env.prefix}/login/'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // The user was authenticated, so store the account data in the provider
      final data = jsonDecode(response.body);
      final account = Account.fromJson(data['account']);
      setAccount(account);
      return true;
    } else {
      // The login request failed, so return false
      return false;
    }
  }

  void setAccount(Account account) {
    _account = account;
    notifyListeners();
  }
}
