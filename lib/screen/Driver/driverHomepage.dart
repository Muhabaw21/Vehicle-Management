import 'dart:convert';
import 'dart:ui';
import 'dart:async';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/screen/Driver/avilablelMarket_Fordriver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';

import '../../../config/APIService.dart';
import '../../../controller/Localization.dart';
import '../../../const/constant.dart';
import 'package:http/http.dart' as http;
import '../../Theme/clippbox.dart';
import '../../controller/driverimage.dart';
import '../Owner/Driver/assignDriver.dart';
import 'Notification/driverNotification.dart';
import 'Reportfordriver/driverReportstatus.dart';
import 'activeWork.dart';
import 'create_alert.dart';
import 'package:badges/badges.dart' as badges;

class Driver_Hompage extends StatefulWidget {
  const Driver_Hompage({
    super.key,
  });

  @override
  State<Driver_Hompage> createState() => _Driver_HompageState();
}

class _Driver_HompageState extends State<Driver_Hompage> {
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = isPressed ? 5.0 : 30.0;
  String Logoavtar = "";
  String? plateNumber;
  DateTime? currentBackPressTime;
  String ownerpic = "";
  Map<String, dynamic>? Result;
  String? driverstate;
  String? driverstatus;
  String? startpalce;
  String? endplace;
  String? namedriver;
  int newItemCount = 0;
  bool _isLoading = true;
  List<dynamic> newalert = [];
  String? driverworkstatus;
  List Listactivework = [];
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  // fetch  alert notifaction

  Future<Map<String, dynamic>> fetchDriverinfo() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.drverInfo);
    var response = await client.get(url, headers: requestHeaders);
    final Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  //fetch driver status

  Future<String> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response =
        await http.get(Uri.parse(ApIConfig.logo), headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      Map<String, dynamic> data = json.decode(response.body);

      // await storage.write(key: "ownerpic", value: data["driverPic"].toString());

      ownerpic = (await storage.read(key: 'ownerpic'))!;
      return data["avatar"];
    } else {
      throw Exception('Failed to load image');
    }
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              Duration(seconds: 2)) {
        // Show a Snackbar at the bottom indicating to press back again to exit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        currentBackPressTime = DateTime.now();
        return true; // Stop the default back button event
      } else {
        // Close the app when back button is pressed again
        SystemNavigator.pop();
        return true; // Stop the default back button event
      }
    }
    return false;
    // Return true to stop the default back button event
  }

  Stream<List<dynamic>>? fetchDataStream() async* {
    // Open Hive box here

    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Fetch data every 10 seconds
      final Box<dynamic> box = await Hive.openBox<dynamic>('your_data_box');
      // Replace with the URL of your API

      try {
        var token = await storage.read(key: 'jwt');
        var client = http.Client();
        Map<String, String> requestHeaders = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var url = Uri.http(ApIConfig.urlAPI, ApIConfig.getalert);
        var response = await client.get(url, headers: requestHeaders);
        if (response.statusCode == 200) {
          var alert = jsonDecode(response.body);

          List<dynamic> newData = alert["activeAlerts"];
          var box = Hive.box('your_data_box');

          // Update the local data in Hive only with new or updated data
          final storedData = box.values.toList();

          print(storedData);

          for (int i = 0; i < storedData.length; i++) {
            if (storedData == null || storedData[i]['id'] != newData[0]['id']) {
              setState(() {
                newalert = newData;
              });
            } else {
              setState(() {
                newalert.clear();
              });
            }
          }

          // Save the current time as the last update time

          yield newData; // Emit the new data to the Stream
        } else {
          // Handle API error
          print(
              'Failed to fetch data from API. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle other errors
        print('Error fetching data from API: $error');
      }
    }
  }

  Future<void> fetchDataFromApiAndStoreInHive() async {
    // Fetch data from the API
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.getalert);
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List items = responseData["activeAlerts"];
      // Get the Hive box
      final box = Hive.box('dataBox');
      // final String lastStoredId = box.get('lastId', defaultValue: 0);

      // Store only new data in Hive
      for (var data in items) {
        String id = data["id"]
            .toString(); // Assuming 'id' is the unique identifier in the API response
        print(data["id"]);
        // Check if the data already exists in Hive
        bool istrue = !box.containsKey(id);
        print(istrue);
        if (istrue == true) {
          box.put(id, data);
          setState(() {
            newItemCount++;
          });
        }
      }
      if (items.isNotEmpty) {
        final lastItem = items.last;
        final String lastItemId = lastItem['alertstart'];
        box.put('lastId', lastItemId);
      }
    }
  }

  Stream<Map<String, dynamic>> fetchData() async* {
    while (true) {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.drverInfo);
      var response = await client.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        yield data;
      } else {
        throw Exception('Failed to fetch data');
      }
      await Future.delayed(
          Duration(seconds: 5)); // Delay for 5 seconds before fetching again
    }
  }

  Future<void> _handleRefresh() async {
    // Simulating a delay to fetch new data
    await Future.delayed(Duration(seconds: 2));

    // Updating the data used by the UI
    fetchData();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);

    fetchDriverinfo();
    fetchDataFromApiAndStoreInHive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final ApiControllerdriverimage controller =
        Get.put(ApiControllerdriverimage());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetchData();
    });

    String tdata;
    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 240, 243, 1),

        //ScrollConfiguration to remove glow effect
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Container(
            decoration: const BoxDecoration(
              color: kBackgroundColor,
            ),
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                height: screenHeight,
                child: Column(
                  children: [
                    // fetch driver info

                    Container(
                      child: Stack(children: [
                        Container(
                          height: screenHeight * 0.25,
                          // margin: EdgeInsets.only(bottom: 40),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(178, 142, 22, 1),
                                  Color.fromRGBO(226, 193, 121, 1),
                                ],
                                // stops: [0.4, 0.4],
                              ),
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              )),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                top: 30,
                                                left: screenWidth * 0.06),
                                            child: SizedBox(
                                              height: screenHeight * 0.1,
                                              child: FutureBuilder<
                                                  Map<String, dynamic>>(
                                                future: fetchDriverinfo(),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot<
                                                            Map<String,
                                                                dynamic>>
                                                        snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Container(); // Show a loading indicator while data is being fetched
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        'Error: ${snapshot.error}'); // Show an error message if an error occurs
                                                  } else {
                                                    // Access the fetched data using snapshot.data and display it
                                                    final data = snapshot.data;

                                                    // Display the data in your desired format
                                                    return Container(
                                                      height:
                                                          screenHeight * 0.034,
                                                      width: screenWidth * 0.24,
                                                      child: ClipOval(
                                                        child: SizedBox(
                                                          height: screenHeight *
                                                              0.034,
                                                          width: screenWidth *
                                                              0.24,
                                                          child: Image.network(
                                                            data!["driverPic"],
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * 0.3,
                                          margin: EdgeInsets.only(left: 23),
                                          child: FutureBuilder<
                                              Map<String, dynamic>>(
                                            future: fetchDriverinfo(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<
                                                        Map<String, dynamic>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Container(); // Show a loading indicator while data is being fetched
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                    'Error: ${snapshot.error}'); // Show an error message if an error occurs
                                              } else {
                                                // Access the fetched data using snapshot.data and display it
                                                final data = snapshot.data;

                                                // Display the data in your desired format
                                                return SizedBox(
                                                  height: 30,
                                                  child: Text(
                                                    "${data!["driverName"]}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Nunito",
                                                      color: Colors.black,
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          // Clear the new items count after displaying it
                                          newItemCount = 0;
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    drivernotificationPage()));
                                      },
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        margin:
                                            EdgeInsets.only(right: 35, top: 0),
                                        width: screenWidth * 0.06,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: badges.Badge(
                                            badgeStyle: badges.BadgeStyle(
                                              badgeColor: Colors.black,
                                            ),
                                            position:
                                                badges.BadgePosition.topEnd(
                                                    top: -10, end: -29),
                                            showBadge: true,
                                            ignorePointer: false,
                                            badgeContent: Text(
                                              "$newItemCount",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            drivernotificationPage()));
                                              },
                                              child: Icon(
                                                Ionicons.notifications,
                                                size: 27,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: screenHeight * 0.32,
                                margin: EdgeInsets.only(top: 130),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        height: screenHeight * 0.32,
                                        width: screenWidth - 42,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            top: screenWidth * 0.05,
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Driver Status",
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        "Work Status",
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: AppFonts
                                                                .smallFontSize,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Container(
                                                          height: 15,
                                                          child: Center(
                                                            child: StreamBuilder<
                                                                Map<String,
                                                                    dynamic>>(
                                                              stream:
                                                                  fetchData(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  final Map<
                                                                          String,
                                                                          dynamic>
                                                                      data =
                                                                      snapshot
                                                                          .data!;
                                                                  driverworkstatus =
                                                                      data[
                                                                          "workStatus"];
                                                                  // Render your UI with the data
                                                                  return Text(
                                                                    data[
                                                                        "status"],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            AppFonts
                                                                                .smallFontSize,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  );
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Container();
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                      child: Container(
                                                          height: 15,
                                                          child: Center(
                                                            child: StreamBuilder<
                                                                Map<String,
                                                                    dynamic>>(
                                                              stream:
                                                                  fetchData(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  final Map<
                                                                          String,
                                                                          dynamic>
                                                                      data =
                                                                      snapshot
                                                                          .data!;
                                                                  driverworkstatus =
                                                                      data[
                                                                          "workStatus"];
                                                                  // Render your UI with the data
                                                                  return Text(
                                                                    data[
                                                                        "workStatus"],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            AppFonts
                                                                                .smallFontSize,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  );
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Container();
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.trip_origin,
                                                    color: Colors.green,
                                                  ),
                                                  CustomPaint(
                                                    size: Size(
                                                        screenWidth * 0.14, 2),
                                                    painter: DashLinePainter(),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height:
                                                          screenHeight * 0.09,
                                                      width: screenWidth * 0.09,
                                                      child: Container(
                                                        child: Icon(
                                                          Icons.local_shipping,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  CustomPaint(
                                                    size: Size(
                                                        screenWidth * 0.14, 2),
                                                    painter: DashLinePainter(),
                                                  ),
                                                  Icon(
                                                    Icons.trip_origin,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: screenWidth * 0.25,
                                                      color: Color.fromRGBO(
                                                          178, 142, 22, 1),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Text(
                                                              "Platenumber",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: StreamBuilder<
                                                                Map<String,
                                                                    dynamic>>(
                                                              stream:
                                                                  fetchData(),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  final Map<
                                                                          String,
                                                                          dynamic>
                                                                      data =
                                                                      snapshot
                                                                          .data!;
                                                                  driverworkstatus =
                                                                      data[
                                                                          "workStatus"];
                                                                  // Render your UI with the data
                                                                  return Text(
                                                                    data[
                                                                        "plateNumber"],
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            AppFonts
                                                                                .smallFontSize,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  );
                                                                } else if (snapshot
                                                                    .hasError) {
                                                                  return Container();
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
                      ]),
                    ),

                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: GridView(
                          // ignore: sort_child_properties_last
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkResponse(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              availabelMarketfordriver()));
                                }),
                                child: Ink(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: isPressed
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.grey.shade400,
                                                    offset: Offset(4, 4),
                                                    blurRadius: 15,
                                                    spreadRadius: 1,
                                                  ),
                                                  const BoxShadow(
                                                    color: Colors.white,
                                                    offset: Offset(-4, -4),
                                                    blurRadius: 25,
                                                    spreadRadius: 1,
                                                  ),
                                                ]
                                              : null),
                                      child: Align(
                                        child: Container(
                                          height: screenHeight * 0.1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                margin:
                                                    EdgeInsets.only(top: 12),
                                                //height: 70,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Icon(
                                                  Icons.work,
                                                  size: 35,
                                                  color: Color.fromRGBO(
                                                      178, 142, 22, 1),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  TranslationUtil.text(
                                                      "Available Market"),
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  if (driverworkstatus == "ACCEPTED") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                activeWork()));
                                  } else {
                                    alertforeror().showCustomToast(
                                        "Driver not accept job !");
                                  }
                                },
                                child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: isPressed
                                            ? [
                                                BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  offset: Offset(4, 4),
                                                  blurRadius: 15,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(-4, -4),
                                                  blurRadius: 25,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                            : null),
                                    child: Align(
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              // height: 70,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Icon(
                                                Icons.work,
                                                size: 35,
                                                color: Color.fromRGBO(
                                                    178, 142, 22, 1),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 6),
                                              child: Text(
                                                "Active work",
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize:
                                                        AppFonts.smallFontSize,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              driverReportstatus()));
                                },
                                child: AnimatedContainer(
                                    duration: Duration(milliseconds: 100),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: isPressed
                                            ? [
                                                BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  offset: Offset(4, 4),
                                                  blurRadius: 15,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(-4, -4),
                                                  blurRadius: 25,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                            : null),
                                    child: Align(
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              // height: 70,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Icon(
                                                Icons.insert_drive_file_rounded,
                                                size: 35,
                                                color: Color.fromRGBO(
                                                    178, 142, 22, 1),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text(
                                                TranslationUtil.text("Report"),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize:
                                                        AppFonts.smallFontSize,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: (() {
                                  if (driverstatus == "ONROUTE") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateAlert(
                                                  title: '',
                                                )));
                                  } else {
                                    alertforeror().showCustomToast(
                                        "Driver not Onroute !");
                                  }
                                }),
                                child: AnimatedContainer(
                                    //padding: EdgeInsets.only(bottom: _padding),
                                    duration: Duration(milliseconds: 100),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: isPressed
                                            ? [
                                                BoxShadow(
                                                  color: Colors.grey.shade400,
                                                  offset: Offset(4, 4),
                                                  blurRadius: 15,
                                                  spreadRadius: 1,
                                                ),
                                                const BoxShadow(
                                                  color: Colors.white,
                                                  offset: Offset(-4, -4),
                                                  blurRadius: 25,
                                                  spreadRadius: 1,
                                                ),
                                              ]
                                            : null),
                                    child: Align(
                                      child: Container(
                                        height: screenHeight * 0.1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // height: 70,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Icon(
                                                Ionicons.alert,
                                                size: 35,
                                                color: Color.fromRGBO(
                                                    178, 142, 22, 1),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text(
                                                TranslationUtil.text(
                                                    "Create Alert"),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize:
                                                        AppFonts.smallFontSize,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            childAspectRatio:
                                screenHeight / (screenWidth * 1.4),
                            maxCrossAxisExtent: 260,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          //scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

// fetch  all driver info

