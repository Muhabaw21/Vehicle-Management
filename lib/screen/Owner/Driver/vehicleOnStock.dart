import 'dart:async';
import 'dart:convert';

import 'package:bazralogin/Theme/customAppBar.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../const/constant.dart';

import 'assignDriver.dart';

// ignore: must_be_immutable
class VehicleOnstock extends StatefulWidget {
  String? licenseNumber;
  VehicleOnstock({super.key, this.licenseNumber});
  @override
  State<VehicleOnstock> createState() => _VehicleOnstockState();
}

class _VehicleOnstockState extends State<VehicleOnstock> {
  TextEditingController _searchController = TextEditingController();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  String query = '';
  List Result = [];
  List findVehicle = [];
  // late var timer;
  List totalVehicles = [];
  var client = http.Client();
  final storage = new FlutterSecureStorage();
  bool _isLoading = true;
// fetch car on maintaining
  unassignedDrivers() async {
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://164.90.174.113:9090/Api/Vehicle/All/Driver'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      List results = mapResponse['unassigned'];
      setState(() {
        _isLoading = false;
        Result = results;
        findVehicle = Result;
      });
      return Result;
    } else {
      throw Exception('not loaded ');
    }
  }

  void vehiclesSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['vehicleName'].toLowerCase();
        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputPlateNumber = enterKeyboard.toLowerCase();
        return name.contains(inputName) ||
            plateNumber.contains(inputPlateNumber);
      }).toList();
    });

    setState(() {
      findVehicle = findVehicle;
    });
  }

  void initState() {
    super.initState();
    unassignedDrivers();

    controller.addListener(() {
      double value = controller.offset / 119;
      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(widget.licenseNumber);
    final double categoryHeight = screenHeight * 0.30;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromRGBO(178, 142, 22, 1),
            title: Container(
              margin: EdgeInsets.only(right: screenWidth * 0.12),
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Center(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Driver Name or Plate No',
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
          backgroundColor: kBackgroundColor,
          body: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: containerpaddingfordriverandowner,
                        child: Container(
                          width: screenWidth,
                          height: screenHeight * 0.08,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  left:
                                      BorderSide(color: Colors.blue, width: 6),
                                ),
                              ),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.25,
                                      child: const Text(
                                        "Vehicle",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.3,
                                      child: const Text(
                                        "Plate number ",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.25,
                                      child: const Text(
                                        "Status",
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                          children: findVehicle.map((vehicle) {
                        int index = findVehicle.indexOf(vehicle);
                        Color borderLeftColor = Colors.red;
                        if (index % 2 == 0) {
                          borderLeftColor = Colors
                              .green; // Update border color based on condition
                        } else {
                          borderLeftColor = Colors
                              .blue; // Update border color for the else case
                        }
                        return Container(
                          height: screenHeight * 0.1,
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        assignDriver(
                                          licenseNumber:
                                              '${widget.licenseNumber}',
                                          plateNumber: vehicle['plateNumber'],
                                        )),
                              );
                            }),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  bottomLeft: Radius.circular(6.0),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      left: BorderSide(
                                          color: borderLeftColor, width: 6),
                                    ),
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.25,
                                          child: Text(
                                            " " + vehicle['vehicleName'],
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.3,
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            vehicle['plateNumber'],
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: screenHeight * 0.03,
                                            width: screenWidth * 0.25,
                                            child: Center(
                                              child: Text(
                                                " " + vehicle['status'],
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ))
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                    ],
                  ),
                )),
    );
  }
}
