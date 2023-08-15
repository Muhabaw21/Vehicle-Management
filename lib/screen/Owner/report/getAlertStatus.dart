import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;



import '../../../../const/constant.dart';
import '../Vehicle/vehicleDetial.dart';

class getAlertStatus extends StatefulWidget {
  String? alertList;
  String? alertType;
  getAlertStatus({super.key, this.alertList, required this.alertType});

  @override
  State<getAlertStatus> createState() => _getAlertStatusState();
}

class _getAlertStatusState extends State<getAlertStatus> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String query = '';
  List alertStatusList = [];
  late var timer;
  vehicleFetchbystatus() async {
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
            'http://198.199.67.201:9090/Api/Vehicle/Alerts/AlertType/${widget.alertType}'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      alertStatusList = mapResponse['${widget.alertList}'];
      print(alertStatusList);
      if (mounted) {
        timer = new Timer.periodic(
            Duration(seconds: 5),
            (Timer t) => setState(() {
                  alertStatusList = alertStatusList;
                }));
      }

      return alertStatusList;
    } else {
      throw Exception('not loaded ');
    }
  }

  void initState() {
    super.initState();
    vehicleFetchbystatus();
    timer = Duration(seconds: 5);
  }

  @override
  void dispose() {
    timer.cancel();
    timer;
    super.dispose();
  }

  void driversSearch(String enterKeyboard) {
    List findVehicle = [];
    setState(() {});
    if (enterKeyboard.isEmpty) {
      alertStatusList = findVehicle;
    } else {
      final findVehicle = alertStatusList.where((driver) {
        final name = driver['vehicleName'].toLowerCase();
        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || plateNumber.contains(inputName);
      }).toList();
      setState(() {
        this.alertStatusList = findVehicle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            backgroundColor: kPrimaryColor,
            title: Container(
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Center(
                child: TextField(
                  onChanged: driversSearch,
                  decoration: InputDecoration(
                    hintText: 'Driver Name or Plate No.',
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: alertStatusList.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(top: 130),
                      child: Center(child: CircularProgressIndicator()))
                  : Column(
                      children: [
                        Column(
                            children: alertStatusList.map((alert) {
                          return Container(
                            height: screenHeight * 0.08,
                            child: InkWell(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          vehicleDetial(
                                            id: alert['id'],
                                          )),
                                );
                              }),
                              child: Card(
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15, right: 10),
                                        child: Text(
                                          " " + alert['driver'].toString(),
                                          style: const TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black87),
                                        ),
                                      ),
                                      Container(
                                        width: screenWidth * 0.1,
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(
                                          alert['alertocation'],
                                          style: const TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                              color: Colors.black87),
                                        ),
                                      ),
                                      Container(
                                          height: screenHeight * 0.038,
                                          width: screenWidth * 0.25,
                                          margin: const EdgeInsets.only(
                                              left: 30, right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: kPrimaryColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              " " + alert['alertType'],
                                              style: const TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ))
                                    ]),
                              ),
                            ),
                          );
                        }).toList()),
                      ],
                    ))),
    );
    ;
  }
}
