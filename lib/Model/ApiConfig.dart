import 'dart:convert';

import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/domian/secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'loginRequestModel.dart';

class APIService {
  var client = http.Client();
  static String Logoavtar = "";
  final storage = new FlutterSecureStorage();
  static String? ownername;
  static String? owner;
  static String? totalStockedVehicles;
  static String? totalVehicle;
  static String? totalDrivers;
  static String? totalMaintainingVehicles;
  static String? totalinRouteVehiclesVehicles;
  static String? totalparkedVehicle;
  static String? responsbody;

  // fetch list of car avilable
  static InStock() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Vehicle/Owner/Status/INSTOCK'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['stockedList'];
      await storage.write(
          key: "stockedVehicles",
          value: mapResponse["stockedVehicles"].toString());

      totalStockedVehicles = await storage.read(key: 'stockedVehicles');

      print(results);

      return results;
    } else {}
  }
  // fetch  parked car

  static parkedCar() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Vehicle/Owner/Status/PARKED'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['parkedList'];
      await storage.write(
          key: "parkedVehicles",
          value: mapResponse["parkedVehicles"].toString());

      totalparkedVehicle = await storage.read(key: 'parkedVehicles');

      // print(results);

      return results;
    } else {
      // throw Exception('not loaded ');
    }
  }

// fetch car onroute
  static onroutCar() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://64.226.104.50:9090/Api/Vehicle/Owner/Status/ONROUTE'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['inRoutelist'];
      await storage.write(
          key: "inRouteVehicles",
          value: mapResponse["inRouteVehicles"].toString());

      totalinRouteVehiclesVehicles = await storage.read(key: 'inRouteVehicles');

      // print(results);

      return results;
    } else {
      // throw Exception('not loaded ');
    }
  }

// fetch car on maintaining
  static maintainingCar() async {
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
            'http://64.226.104.50:9090/Api/Vehicle/Owner/Status/MAINTAINING'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      List results = mapResponse['maintainingList'];
      await storage.write(
          key: "maintainingVehicles",
          value: mapResponse["maintainingVehicles"].toString());

      totalMaintainingVehicles = await storage.read(key: 'maintainingVehicles');

      // print(results);

      return results;
    } else {
      // throw Exception('not loaded ');
    }
  }

  static vehicleFetch() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = ApIConfig.allvehicle;
    var response = await client.get(Uri.parse(url), headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      //  results= Vehicle.fromJson(mapResponse) as List<Vehicle>;

      var resultvehicle = mapResponse['vehiclesINF'];
      await storage.write(
          key: "totalVehicles", value: mapResponse["totalVehicles"].toString());

      totalVehicle = await storage.read(key: 'totalVehicles');
      print(mapResponse);

      return resultvehicle;
    } else {
      // throw Exception('not loaded ');
    }
  }

  static tripOptions() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.tripOptions);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body);
      //  results= Vehicle.fromJson(mapResponse) as List<Vehicle>;

      var resultvehicl = mapResponse['triptypes'];
      // await storage.write(
      //     key: "totalVehicles", value: mapResponse["totalVehicles"].toString());

      // totalVehicle = await storage.read(key: 'totalVehicles');
      print(mapResponse);

      return resultvehicl;
    } else {
      // throw Exception('not loaded ');
    }
  }

  static Future<bool> loginFetch(
    LoginRequestModel model,
  ) async {
    final storage = new FlutterSecureStorage();
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.logIn);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      responsbody = data["message"];

      await storage.write(key: "jwt", value: data["jwt"]);
      await storage.write(key: "user", value: data["user"]["username"]);

      ownername = data["user"]["role"][0];
      owner = await storage.read(key: 'user');
      var value = await storage.read(key: 'jwt');

      print(ownername);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> Driver(LoginRequestModel model) async {
    final storage = new FlutterSecureStorage();
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.logIn);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      await storage.write(key: "jwt", value: data["jwt"]);
      await storage.write(key: "user", value: data["username"]);

      var value = await storage.read(key: 'jwt');
      ownername = await storage.read(key: 'user');

      return true;
    } else {
      return false;
    }
  }
}
