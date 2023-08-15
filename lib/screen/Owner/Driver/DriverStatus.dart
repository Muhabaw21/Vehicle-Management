import 'dart:convert';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../../config/APIService.dart';
import 'OwnersDriver.dart';
import 'getDriverByStatus.dart';

class DriverStatus extends StatelessWidget {
  DriverStatus({super.key});
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  String onroutedriver = "";
  String assign = "";
  String Parked = "";
  String permit = "";
  String Unassigned = "";
  String total = "";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              Container(color: Colors.red, child: OwnersDriver()),
              Container(
                  color: Colors.red,
                  child: getDriversBystatus(
                      driverStatus: 'ASSIGNED', driverList: 'drivers')),
              Container(
                color: Colors.red,
                child: getDriversBystatus(
                    driverStatus: 'UNASSIGNED', driverList: 'drivers'),
              ),
              Container(
                  color: Colors.red,
                  child: getDriversBystatus(
                      driverStatus: 'PERMIT', driverList: 'drivers')),
              getDriversBystatus(
                  driverStatus: 'ONROUTE', driverList: 'drivers'),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 40),
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: TabBar(
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 5,
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
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
                  text: TranslationUtil.text("Total Drivers"),
                  icon: Container(
                    child: FutureBuilder(
                      future: _totaldriver(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        print(total);
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.03,
                            width: width * 0.06,
                            child: Text(
                              snapshot.data.toString(),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
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
                    text: TranslationUtil.text("Assigned Drivers"),
                    icon: Container(
                      child: FutureBuilder(
                        future: _assignedDriver(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("");
                          return SizedBox(
                              height: screenHeight * 0.03,
                              width: width * 0.07,
                              child: Text(
                                snapshot.data.toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ));
                        },
                      ),
                    )),
                Tab(
                  text: TranslationUtil.text("UnAssigned Drivers"),
                  icon: Container(
                    child: FutureBuilder(
                      future: _driverUnassigned(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState != ConnectionState.done)
                          return Text("");
                        return SizedBox(
                            height: screenHeight * 0.03,
                            width: width * 0.07,
                            child: Text(
                              snapshot.data.toString(),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ));
                      },
                    ),
                  ),
                ),
                Tab(
                    text: TranslationUtil.text("Permit"),
                    icon: Container(
                      child: FutureBuilder(
                        future: _permit(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("");
                          return SizedBox(
                              height: screenHeight * 0.03,
                              width: width * 0.07,
                              child: Text(
                                snapshot.data.toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ));
                        },
                      ),
                    )),
                Tab(
                    text: TranslationUtil.text(
                      "OnRoute Drivers",
                    ),
                    icon: Container(
                      child: FutureBuilder(
                        future: _onroutedriver(),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState != ConnectionState.done)
                            return Text("");
                          return SizedBox(
                              height: screenHeight * 0.03,
                              width: width * 0.07,
                              child: Text(
                                snapshot.data.toString(),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ));
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> _onroutedriver() async {
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
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/ONROUTE"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "onroutedriver", value: data["totalDrivers"].toString());

      onroutedriver = (await storage.read(key: 'onroutedriver'))!;
      return onroutedriver;
    } else {
      throw Exception('Failed to load image');
    }
  }

// fetch total  vehicle onstock
  Future<String> _permit() async {
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
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/PERMIT"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "permit", value: data["totalDrivers"].toString());

      permit = (await storage.read(key: 'permit'))!;
      return permit;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch vehicle on route
  Future<String> _assignedDriver() async {
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
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/ASSIGNED"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "assign", value: data["totalDrivers"].toString());

      assign = (await storage.read(key: 'assign'))!;
      return assign;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch  on total driver
  Future<String> _totaldriver() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(key: "total", value: data["totalDrivers"].toString());

      total = (await storage.read(key: 'total'))!;
      return total;
    } else {
      throw Exception('Failed to load image');
    }
  }

  // fetch  on park
  Future<String> _driverUnassigned() async {
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
            "http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/UNASSIGNED"),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);
      await storage.write(
          key: "assigned", value: data["totalDrivers"].toString());

      Unassigned = (await storage.read(key: 'assigned'))!;
      return Unassigned;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
