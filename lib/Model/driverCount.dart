import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CountDrivers {
  var client = http.Client();
  final storage = new FlutterSecureStorage();
  static int? ownername;
  static int? totalDrivers;
  static int? totalAssigned;
  static int? totalUnassigned;
  static int? totalPermit;
  static int? totalOnroute;
  // fetch list of car avilable


  static AssignedDriver() async {
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
            'http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/ASSIGNED'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['drivers'];
      await storage.write(
          key: "totalDrivers", value: mapResponse["totalDrivers"].toString());

      totalAssigned = mapResponse['totalDrivers'];

      print(totalAssigned);

      return results;
    } else {}
  }
  // fetch  parked car

  static UnASSIGNED() async {
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
            'http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/UNASSIGNED'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['drivers'];
      await storage.write(
          key: "totalDrivers", value: mapResponse["totalDrivers"].toString());

      totalUnassigned = mapResponse['totalDrivers'];

      // print(results);

      return results;
    } else {}
  }

// fetch car onroute
  static ONROUTE() async {
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
            'http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/ONROUTE'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['drivers'];
      await storage.write(
          key: "totalDrivers", value: mapResponse["totalDrivers"].toString());

      totalOnroute = mapResponse['totalDrivers'];

      // print(results);

      return results;
    }
  }

// fetch car on maintaining
  static PERMIT() async {
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
            'http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/PERMIT'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['drivers'];
      await storage.write(
          key: "totalDrivers", value: mapResponse["totalDrivers"].toString());

      totalPermit = mapResponse['totalDrivers'];

      // print(results);

      return results;
    } else {}
  }
}
