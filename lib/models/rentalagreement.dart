class RentalAgreement {
  String rentID;
  String rentDate;
  int numberOfDays;
  double rentDue;
  String account;
  String vehicle;

  RentalAgreement(
      {required this.rentID,
      required this.rentDate,
      required this.numberOfDays,
      required this.rentDue,
      required this.account,
      required this.vehicle});

  factory RentalAgreement.fromJson(Map<String, dynamic> json) {
    return RentalAgreement(
        rentID: json['rentID'],
        rentDate: json['rentDate'],
        numberOfDays: json['numberOfDays'],
        rentDue: json['rentDue'],
        account: json['account'],
        vehicle: json['vehicle']);
  }

  Map<String, dynamic> toJson() => {
        'rentID': rentID,
        'rentDate': rentDate,
        'numberOfDays': numberOfDays,
        'rentDue': rentDue,
        'account': account,
        'vehicle': vehicle,
      };
}
