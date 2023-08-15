import 'dart:convert';

import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/domian/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Vehicles_withDrivers {
  var client = http.Client();
  final storage = new FlutterSecureStorage();
// fetch car on maintaining
  static assignedDrivers() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse(
            'http://198.199.67.201:9090/Api/Vehicle/All/Driver'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      List results = mapResponse['unassigned'];
      return results;
    } else {
      throw Exception('not loaded ');
    }
  }
}
