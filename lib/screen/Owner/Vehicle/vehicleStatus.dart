import 'dart:convert';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../config/APIService.dart';
import '../Vehicle/TotalVehicles.dart';
import 'package:http/http.dart' as http;
import '../Vehicle/getvehicleBystautus.dart';

class VehicleStatus extends StatefulWidget {
  VehicleStatus({super.key});
  static bool isPressed = true;

  @override
  State<VehicleStatus> createState() => _VehicleStatusState();
}

class _VehicleStatusState extends State<VehicleStatus> {
  Offset distance = VehicleStatus.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = VehicleStatus.isPressed ? 5.0 : 30.0;
  String total = "";
  String Onroute = "";
  String Parked = "";
  String Instockvehicle = "";
  String Maintaing = "";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600.withOpacity(0.3),
                spreadRadius: -1,
                blurRadius: 1,
                offset: Offset(0, -6), // horizontal, vertical offset
              ),
            ],
          ),
          child: TabBarView(
            children: [
              OwnersVehicle(),
              getvehicleBystatus(route: 'ONROUTE', onroute: 'inRoutelist'),
              getvehicleBystatus(route: 'PARKED', onroute: 'parkedList'),
              getvehicleBystatus(route: 'INSTOCK', onroute: 'stockedList'),
              getvehicleBystatus(
                  route: 'MAINTAINING', onroute: 'maintainingList'),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 42),
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: TabBar(
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              labelColor: Colors.black,
              indicatorPadding: EdgeInsets.all(4),
              indicatorColor: Color.fromRGBO(178, 142, 22, 1),
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.black;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.orange;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.pinkAccent;
                }

                return Colors.transparent;
              }),
              tabs: [
                Tab(
                  text: "Total Vehicle",
                  icon: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.07),
                    child: FutureBuilder(
                      future: _totalvehicle(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(total);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.06,
                            child: Text(
                              total,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                  text: "OnRoute  ",
                  icon: Container(
                    child: FutureBuilder(
                      future: _onroutevehicle(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(total);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.06,
                            child: Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                  text: " Parked",
                  icon: Container(
                    child: FutureBuilder(
                      future: _parkedvehicle(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(Instockvehicle);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.06,
                            child: Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                  text: "Instock ",
                  icon: Container(
                    child: FutureBuilder(
                      future: _onstcokvehicle(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(Instockvehicle);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.06,
                            child: Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                  text: "MAINTAINING",
                  icon: Container(
                    child: FutureBuilder(
                      future: _maintainVehicle(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(Instockvehicle);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.06,
                            child: Text(
                              snapshot.data.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _totalvehicle() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse(ApIConfig.allvehicle),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "total", value: data["totalVehicles"].toString());

      total = (await storage.read(key: 'total'))!;
      return total;
    } else {
      throw Exception('Failed to load image');
    }
  }

// fetch total  vehicle onstock
  Future<String> _onstcokvehicle() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Status/INSTOCK"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "Instockvehicle", value: data["stockedVehicles"].toString());

      Instockvehicle = (await storage.read(key: 'Instockvehicle'))!;
      return Instockvehicle;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch vehicle on route
  Future<String> _onroutevehicle() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Status/ONROUTE"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "onroute", value: data["inRouteVehicles"].toString());

      Onroute = (await storage.read(key: 'onroute'))!;
      return Onroute;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch  on park
  Future<String> _parkedvehicle() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse("http://164.90.174.113:9090/Api/Vehicle/Owner/Status/PARKED"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "parked", value: data["parkedVehicles"].toString());

      Parked = (await storage.read(key: 'parked'))!;
      return Parked;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch  on park
  Future<String> _maintainVehicle() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Status/MAINTAINING"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "maintainvehicle",
          value: data["maintainingVehicles"].toString());

      Maintaing = (await storage.read(key: 'maintainvehicle'))!;
      return Maintaing;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
