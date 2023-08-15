import 'package:flutter/material.dart';

class PieData {
  static List<Data> data = [
    Data(status: 'Off Road', hour: 10, color: Color.fromRGBO(238, 2, 2, 1)),
    Data(status: 'On Road', hour: 36, color: Colors.green),
    Data(status: 'Park', hour: 14, color: Colors.blueGrey),
  ];
}

class Data {
  String status;

  final double hour;

  final Color color;
  Data({required this.status, required this.hour, required this.color});
}
