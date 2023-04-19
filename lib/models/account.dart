class Account {
  final String accountID;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String accountRole;

  Account(
      {required this.accountID,
      required this.username,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.accountRole});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountID: json['accountID'],
      username: json['username'],
      password: json['password'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      accountRole: json['accountRole'],
    );
  }

  Map<String, dynamic> toJson() => {
        'accountID': accountID,
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'accountRole': accountRole,
      };
}
