class Vehicle {
  final String vehicleID;
  final String vehicleName;
  final String vehicleModel;
  final String vehicleBrand;
  final String vehicleManufacturer;
  final String vehicleType;
  final double vehicleRentRate;

  Vehicle(
      {required this.vehicleID,
      required this.vehicleName,
      required this.vehicleModel,
      required this.vehicleBrand,
      required this.vehicleManufacturer,
      required this.vehicleType,
      required this.vehicleRentRate});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleID: json['vehicleID'],
      vehicleName: json['vehicleName'],
      vehicleModel: json['vehicleModel'],
      vehicleBrand: json['vehicleBrand'],
      vehicleManufacturer: json['vehicleManufacturer'],
      vehicleType: json['vehicleType'],
      vehicleRentRate: json['vehicleRentRate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicleID': vehicleID,
        'vehicleName': vehicleName,
        'vehicleModel': vehicleModel,
        'vehicleBrand': vehicleBrand,
        'vehicleManufacturer': vehicleManufacturer,
        'vehicleType': vehicleType,
        'vehicleRentRate': vehicleRentRate
      };
}
