import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/config/APIService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';

import '../../../../const/constant.dart';
import 'driverDetial.dart';
import 'modifyDriverStatus.dart';

class OwnersDriver extends StatefulWidget {
  OwnersDriver({super.key});

  @override
  State<OwnersDriver> createState() => _OwnersDriverState();
}

class _OwnersDriverState extends State<OwnersDriver> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String? plateNumber;
  String query = '';
  List books = [];
  List findVehicle = [];
  List drivers = [];
  bool _isLoading = true;

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  List Result = [];
  List totalVehicles = [];
  driverFetch() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(
            key: "totalDrivers", value: data["totalDrivers"].toString());

        setState(() {
          _isLoading = false;
          Result = data['drivers'];
          findVehicle = Result;
        });

        return Result;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
    }
  }
  // search  driver

  void driversSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['driverName'].toLowerCase();

        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName);
      }).toList();
    });
    setState(() {
      findVehicle = findVehicle;
    });
  }

  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;

  String? phoneNumber;
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  void initState() {
    super.initState();
    driverFetch();
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: kBackgroundColor,
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
                                            left: BorderSide(
                                                color: Colors.blue, width: 6),
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
                                                      fontSize: AppFonts
                                                          .smallFontSize,
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
                                                      fontSize: AppFonts
                                                          .smallFontSize,
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
                                                      fontSize: AppFonts
                                                          .smallFontSize,
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
                                      height: screenHeight * 0.29,
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
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
                                                          top: 30, left: 8),
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
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              15,
                                                                          top:
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                          width: screenWidth *
                                                                              0.2,
                                                                          child:
                                                                              Text(
                                                                            driver['status'],
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: 14,
                                                                                color: borderLeftColor,
                                                                                fontWeight: FontWeight.bold),
                                                                          )),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              screenWidth * 0.25,
                                                                          margin:
                                                                              EdgeInsets.only(),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: rightmarginfordrivermanage),
                                                                                child: MaterialButton(
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
                                                                              ),
                                                                              Container(
                                                                                margin: EdgeInsets.only(right: rightmarginfordrivermanage),
                                                                                child: Text(
                                                                                  driver['plateNumber'] == null ? "__" : driver['plateNumber'],
                                                                                  style: const TextStyle(fontFamily: 'Nunito', fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : driver['status'] ==
                                                                      "UNASSIGNED"
                                                                  ? Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              screenWidth * 0.25,
                                                                          margin: EdgeInsets.only(
                                                                              left: 18,
                                                                              top: 10),
                                                                          child:
                                                                              Text(
                                                                            driver['status'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: 14,
                                                                                color: borderLeftColor,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : driver['status'] ==
                                                                          "PERMIT"
                                                                      ? Container(
                                                                          margin: const EdgeInsets.only(
                                                                              left: leftmargin,
                                                                              top: 10),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                width: screenWidth * 0.25,
                                                                                child: Text(
                                                                                  driver['status'],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          margin: const EdgeInsets.only(
                                                                              left:
                                                                                  8,
                                                                              top:
                                                                                  15),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Column(
                                                                                children: [
                                                                                  Container(
                                                                                    width: screenWidth * 0.25,
                                                                                    margin: EdgeInsets.only(left: 8),
                                                                                    child: Text(
                                                                                      driver['status'],
                                                                                      textAlign: TextAlign.left,
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      style: TextStyle(fontFamily: 'Nunito', fontSize: 14, color: borderLeftColor, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 15,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Container(
                                                                                width: screenWidth * 0.2,
                                                                                child: Column(
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: Alignment.center,
                                                                                      child: Container(
                                                                                        margin: EdgeInsets.only(right: 30),
                                                                                        child: MaterialButton(
                                                                                          onPressed: () {
                                                                                            // action to perform when button is pressed
                                                                                          },
                                                                                          child: Icon(Icons.local_shipping, color: borderLeftColor),
                                                                                          color: Colors.white,

                                                                                          shape: CircleBorder(), // set the shape of the button
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                        margin: EdgeInsets.only(right: 30),
                                                                                        child: Text(
                                                                                          driver['plateNumber'] == null ? "__" : driver['plateNumber'],
                                                                                          textAlign: TextAlign.left,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: const TextStyle(fontFamily: 'Nunito', fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                        ]),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ModifyDriverStatus(
                                                              driverLicense: driver[
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
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
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
