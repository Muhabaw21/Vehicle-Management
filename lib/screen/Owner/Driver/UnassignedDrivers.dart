import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../const/constant.dart';
import 'vehicleOnStock.dart';

class UnassignedDrivers extends StatefulWidget {
  const UnassignedDrivers({super.key});
  @override
  State<UnassignedDrivers> createState() => _UnassignedDriversState();
}

class _UnassignedDriversState extends State<UnassignedDrivers> {
  TextEditingController _searchController = TextEditingController();

  bool closeTopContainer = false;
  double topContainer = 0;
  String query = '';
  List Result = [];
  List findVehicle = [];
  late var timer;
  List totalVehicles = [];
  bool _isLoading = true;
// fetch unassigndriver
  unassigned() async {
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

      setState(() {
        _isLoading = false;
        Result = results;
        findVehicle = Result;
      });
      return Result;
    }
  }

//  search unassign driver
  void driversSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['driverName'].toLowerCase();
        final plateNumber = driver['phoneNumber'].toLowerCase();
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
    unassigned();
    timer = Duration(seconds: 5);
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
    final double categoryHeight = screenHeight * 0.30;
    print(findVehicle.length);
    print('yee');
    print(Result);
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
            backgroundColor: kBackgroundColor,
            body: _isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
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
                          Container(
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
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.3,
                                                child: const Text(
                                                  "Phone Number ",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                Container(
                                  child: Column(
                                      children: findVehicle.map((driver) {
                                    int index = findVehicle.indexOf(driver);
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
                                      margin: EdgeInsets.only(),
                                      child: GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        VehicleOnstock(
                                                          licenseNumber: driver[
                                                              'licenseNumber'],
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
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            screenWidth * 0.25,
                                                        margin:
                                                            EdgeInsets.only(),
                                                        child: Text(
                                                          " " +
                                                              driver['driverName']
                                                                  .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 14,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                      driver['phoneNumber'] !=
                                                              null
                                                          ? Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.3,
                                                              child: Text(
                                                                driver[
                                                                    'phoneNumber'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ))
                                                          : Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.25,
                                                              child: const Text(
                                                                "Unknown",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                      driver['status'] != null
                                                          ? Container(
                                                              height: screenHeight *
                                                                  0.038,
                                                              width:
                                                                  screenWidth *
                                                                      0.28,

                                                              // decoration: BoxDecoration(
                                                              //   borderRadius:
                                                              //       BorderRadius.circular(6),
                                                              //   color: kPrimaryColor,
                                                              // ),
                                                              child: Center(
                                                                child: Text(
                                                                  " " +
                                                                      driver[
                                                                          'status'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ))
                                                          : Container(
                                                              height:
                                                                  screenHeight *
                                                                      0.038,
                                                              width:
                                                                  screenWidth *
                                                                      0.28,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6),
                                                                color:
                                                                    kPrimaryColor,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "UnAssigned",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ))
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  )));
  }
}
