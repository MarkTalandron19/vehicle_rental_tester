class Vehicle {
  String? vehicleID;
  String? vehicleName;
  String? vehicleModel;
  String? vehicleBrand;
  String? vehicleManufacturer;
  String? vehicleType;
  double vehicleRentRate;
  bool? available;
  String? image;

  Vehicle(
      {required this.vehicleID,
      required this.vehicleName,
      required this.vehicleModel,
      required this.vehicleBrand,
      required this.vehicleManufacturer,
      required this.vehicleType,
      this.vehicleRentRate = 0,
      required this.available,
      required this.image});

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vehicleID: json['vehicleID'],
      vehicleName: json['vehicleName'],
      vehicleModel: json['vehicleModel'],
      vehicleBrand: json['vehicleBrand'],
      vehicleManufacturer: json['vehicleManufacturer'],
      vehicleType: json['vehicleType'],
      vehicleRentRate: json['vehicleRentRate'],
      available: json['available'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'vehicleID': vehicleID,
        'vehicleName': vehicleName,
        'vehicleModel': vehicleModel,
        'vehicleBrand': vehicleBrand,
        'vehicleManufacturer': vehicleManufacturer,
        'vehicleType': vehicleType,
        'vehicleRentRate': vehicleRentRate,
        'available': available,
        'image': image
      };
}
