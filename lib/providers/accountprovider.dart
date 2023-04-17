import 'package:flutter/material.dart';
import 'package:vehicle_rental/models/account.dart';

class AccountProvider extends ChangeNotifier {
  Account? _account;

  Account? get acc => _account;

  void setAccount(Account account) {
    _account = account;
    notifyListeners();
  }
}
