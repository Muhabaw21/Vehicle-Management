import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import '../../../../const/constant.dart';

import 'driverDetial.dart';
import 'modifyDriverStatus.dart';

class getDriversBystatus extends StatefulWidget {
  String? driverList;
  String? driverStatus;
  getDriversBystatus({super.key, this.driverList, required this.driverStatus});

  @override
  State<getDriversBystatus> createState() => _getDriversBystatusState();
}

class _getDriversBystatusState extends State<getDriversBystatus> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String query = '';
  List books = [];
  List vehicleStatusList = [];
  List findVehicle = [];
  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
  Color borderLeftColor = Colors.red;
  bool _isLoading = true;
  // driver  fetch by status
  driverFetchbystatus() async {
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
            'http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/${widget.driverStatus}'),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      if ("${widget.driverStatus}" == "ASSIGNED") {
        borderLeftColor =
            Colors.green; // Update border color based on condition
      } else if ("${widget.driverStatus}" == "ONROUTE") {
        borderLeftColor = Colors.blue; // Update border color for the else case
      }
      vehicleStatusList = mapResponse['${widget.driverList}'];
      print(vehicleStatusList);
      setState(() {
        _isLoading = false;
        vehicleStatusList = vehicleStatusList;

        findVehicle = vehicleStatusList;
      });

      return vehicleStatusList;
    } else {}
  }

  // driver search by status
  void driversSearch(String enterKeyboard) {
    final findVehicle = vehicleStatusList.where((driver) {
      final name = driver['driverName'].toLowerCase();
      final plateNumber = driver['licenseNumber'].toLowerCase();
      final inputName = enterKeyboard.toLowerCase();
      final inputLicense = enterKeyboard.toLowerCase();
      return name.contains(inputName) || plateNumber.contains(inputName);
    }).toList();
    setState(() {
      this.findVehicle = findVehicle;
    });
  }

  void initState() {
    super.initState();
    driverFetchbystatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
                    onChanged: driversSearch,
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
            body: SingleChildScrollView(
                child: _isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 130),
                        child: Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          if (findVehicle == null || findVehicle.isEmpty)
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: screenHeight * 0.2,
                                ),
                                width: 300,
                                height: 300,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Lottie.asset(
                                    'assets/images/noapidatas.json', // Replace with your animation file path
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          else
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
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
                                            left: BorderSide(
                                                color: borderLeftColor,
                                                width: 6),
                                          ),
                                        ),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: screenWidth * 0.25,
                                                child: const Text(
                                                  "Drivers",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.2,
                                                child: const Text(
                                                  "License ",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.37,
                                                child: const Text(
                                                  "Phone Number",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                    children: findVehicle.map((driver) {
                                  Color borderLeftColor = Colors
                                      .red; // Define the default border color

                                  if (driver['status'] == "ASSIGNED") {
                                    borderLeftColor = Colors
                                        .green; // Update border color based on condition
                                  } else if (driver['status'] == "ONROUTE") {
                                    borderLeftColor = Colors
                                        .blue; // Update border color for the else case
                                  }
                                  return Container(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      height: screenHeight * 0.3,
                                      child: InkWell(
                                        onTap: (() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Driver_Detial(
                                                          id: driver['id'],
                                                        )),
                                          );
                                        }),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6.0),
                                              bottomLeft: Radius.circular(6.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color: borderLeftColor,
                                                      width: 6),
                                                ),
                                              ),
                                              child: Container(
                                                height: screenHeight * 0.03,
                                                width: screenHeight,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(3.3),
                                                    bottomLeft:
                                                        Radius.circular(3.3),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 5,
                                                      offset: Offset(0,
                                                          4), // Adjust the offset to control the shadow's position
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30, left: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            width: screenWidth *
                                                                0.25,
                                                            child: Text(
                                                              driver[
                                                                  'driverName'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.2,
                                                            child: Text(
                                                              driver[
                                                                  'licenseNumber'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: screenWidth *
                                                                0.37,
                                                            child: Text(
                                                              driver[
                                                                  'phoneNumber'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          driver['status'] ==
                                                                  "ASSIGNED"
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          screenWidth *
                                                                              0.2,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              20,
                                                                          top:
                                                                              10),
                                                                      child: Text(
                                                                          driver[
                                                                              'status'],
                                                                          style: TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: borderLeftColor,
                                                                              fontWeight: FontWeight.bold)),
                                                                    ),
                                                                    Container(
                                                                      width: screenWidth *
                                                                          0.25,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 20),
                                                                            child:
                                                                                MaterialButton(
                                                                              onPressed: () {
                                                                                // action to perform when button is pressed
                                                                              },
                                                                              child: Icon(Icons.local_shipping, color: borderLeftColor),
                                                                              color: Colors.white,

                                                                              shape: CircleBorder(), // set the shape of the button
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              margin: EdgeInsets.only(right: 15),
                                                                              child: Text(driver['plateNumber'] == null ? "__" : driver['plateNumber'])),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : driver['status'] ==
                                                                      "UNASSIGNED"
                                                                  ? Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                20,
                                                                            top:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          driver[
                                                                              'status'],
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 14,
                                                                              color: borderLeftColor,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : driver['status'] ==
                                                                          "PERMIT"
                                                                      ? Container(
                                                                          width:
                                                                              screenWidth * 0.25,
                                                                          margin: EdgeInsets.only(
                                                                              left: 10,
                                                                              top: 10),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Text(
                                                                                driver['status'],
                                                                                textAlign: TextAlign.center,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: borderLeftColor, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          margin: const EdgeInsets.only(
                                                                              top:
                                                                                  10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                child: Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(left: 15),
                                                                                      child: Text(
                                                                                        driver['status'],
                                                                                        textAlign: TextAlign.center,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: borderLeftColor, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 120,
                                                                                  ),
                                                                                  MaterialButton(
                                                                                    onPressed: () {
                                                                                      // action to perform when button is pressed
                                                                                    },
                                                                                    child: SizedBox(
                                                                                      child: Icon(
                                                                                        Icons.local_shipping,
                                                                                        color: borderLeftColor,
                                                                                      ),
                                                                                    ),
                                                                                    color: Colors.white,

                                                                                    shape: CircleBorder(), // set the shape of the button
                                                                                  ),
                                                                                  Container(child: Text(driver['plateNumber'] == null ? "__" : driver['plateNumber'])),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          )),
                                                        ]),
                                                    Visibility(
                                                      visible:
                                                          driver['status'] !=
                                                              "ONROUTE",
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ModifyDriverStatus(
                                                                driverLicense:
                                                                    driver[
                                                                        'licenseNumber'],
                                                                status: driver[
                                                                    'status'],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300, // Border color
                                                                width:
                                                                    2.0, // Border width
                                                              ),
                                                            ),
                                                            width: screenWidth,
                                                            height: 40,
                                                            child: const Center(
                                                              child: Text(
                                                                "Update Status",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                }).toList()),
                              ],
                            )
                        ],
                      ))));
  }
}
