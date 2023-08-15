// To parse this JSON data, do
//
//     final driverResponseModel = driverResponseModelFromJson(jsonString);

import 'dart:convert';

DriverResponseModel driverResponseModelFromJson(String str) => DriverResponseModel.fromJson(json.decode(str));

String driverResponseModelToJson(DriverResponseModel data) => json.encode(data.toJson());

class DriverResponseModel {
    DriverResponseModel({
        required this.totalDrivers,
        required this.drivers,
    });

    int totalDrivers;
    List<Driver> drivers;

    factory DriverResponseModel.fromJson(Map<String, dynamic> json) => DriverResponseModel(
        totalDrivers: json["totalDrivers"],
        drivers: List<Driver>.from(json["drivers"].map((x) => Driver.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalDrivers": totalDrivers,
        "drivers": List<dynamic>.from(drivers.map((x) => x.toJson())),
    };
}

class Driver {
    Driver({
        required this.id,
        required this.licenseNumber,
        this.licensePic,
        this.driverPic,
        required this.driverName,
        required this.status,
        required this.phoneNumber,
        required this.birthDate,
        required this.experience,
        required this.licenseGrade,
        required this.gender,
        required this.licenseIssueDate,
        required this.licenseExpireDate,
        required this.vehicleOwner,
        required this.roles,
        required this.statMessage,
    });

    int id;
    String licenseNumber;
    dynamic licensePic;
    dynamic driverPic;
    String driverName;
    String status;
    String phoneNumber;
    DateTime birthDate;
    String experience;
    String licenseGrade;
    String gender;
    DateTime licenseIssueDate;
    DateTime licenseExpireDate;
    String vehicleOwner;
    String roles;
    bool statMessage;

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        licenseNumber: json["licenseNumber"],
        licensePic: json["licensePic"],
        driverPic: json["driverPic"],
        driverName: json["driverName"],
        status: json["status"],
        phoneNumber: json["phoneNumber"],
        birthDate: DateTime.parse(json["birthDate"]),
        experience: json["experience"],
        licenseGrade: json["licenseGrade"],
        gender: json["gender"],
        licenseIssueDate: DateTime.parse(json["licenseIssueDate"]),
        licenseExpireDate: DateTime.parse(json["licenseExpireDate"]),
        vehicleOwner: json["vehicleOwner"],
        roles: json["roles"],
        statMessage: json["statMessage"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "licenseNumber": licenseNumber,
        "licensePic": licensePic,
        "driverPic": driverPic,
        "driverName": driverName,
        "status": status,
        "phoneNumber": phoneNumber,
        "birthDate": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "experience": experience,
        "licenseGrade": licenseGrade,
        "gender": gender,
        "licenseIssueDate": "${licenseIssueDate.year.toString().padLeft(4, '0')}-${licenseIssueDate.month.toString().padLeft(2, '0')}-${licenseIssueDate.day.toString().padLeft(2, '0')}",
        "licenseExpireDate": "${licenseExpireDate.year.toString().padLeft(4, '0')}-${licenseExpireDate.month.toString().padLeft(2, '0')}-${licenseExpireDate.day.toString().padLeft(2, '0')}",
        "vehicleOwner": vehicleOwner,
        "roles": roles,
        "statMessage": statMessage,
    };
}
