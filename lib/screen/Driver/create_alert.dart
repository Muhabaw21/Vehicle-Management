import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/APIService.dart';
import '../../../const/constant.dart';

class CreateAlert extends StatefulWidget {
  CreateAlert({required this.title});
  final String title;
  @override
  _CreateAlertState createState() => _CreateAlertState();
}

class _CreateAlertState extends State {
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController locations = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? Resultsm;
  bool isalert = true;
  bool _value = true;
  String? alertType;
  String? Results;
  List findVehicle = [];
  List alertList = [];

  List<bool> _checkedItems = [false, false, false, false, false];
  List<String> type = [
    "OFFROAD",
    "CAR CRASH",
    "ROAD ACCIDENT",
    "CAR TIRE FAILURE",
    "ACCIDENT"
  ];
  Timer? _timer;
  String? timecounter;
  int selectedIndex = -1;

  void Create_Alert() async {
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');
    Map data = {
      "alertType": "${alertType}",
      "location": "ADDIS ABABA",
    };
    final url = Uri.parse("http://164.90.174.113:9090/Api/Driver/CreateAlert");
    final response = await http.post(url, body: json.encode(data), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    });
    final Map jsonResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      String alertContent = jsonResponse["message"];

      alertforscuccess().showCustomToast(alertContent);
    } else {
      String alertContent = jsonResponse["message"];
      alertforscuccess().showCustomToast(alertContent);
    }
  }

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
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.getalert);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        final Result = data['activeAlerts'];
        setState(() {
          final Result = data["activeAlerts"];
          Resultsm = data["activeAlerts"][0]['id'];
          print(Resultsm);
        });

        return Result;
      } else {
        throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
    }
  }

// finish alert
  void finishAlert() async {
    driverFetch();
    final storage = new FlutterSecureStorage();
    var value = await storage.read(key: 'jwt');
    Map data = {
      "alertType": alertType,
      "location": "ADDIS ABABA",
    };
    final url = Uri.parse(
        "http://164.90.174.113:9090/Api/Driver/FinishAlert/$Resultsm ");
    http.post(url, body: json.encode(data), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $value",
    }).then((response) {
      String alertContent = "Alert finished !";

      alertforscuccess().showCustomToast(alertContent);
    }).catchError((error) {});
  }

  DateTime greeting() {
    var hour = DateTime.now();

    return hour;
  }

  Stream<List<dynamic>> fetchData() async* {
    while (true) {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      var client = http.Client();
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var url = Uri.http(ApIConfig.urlAPI, "/Api/Driver/Alerts/ByStatus");
      var response = await client.get(url, headers: requestHeaders);
      if (response.statusCode == 200) {
        final fianldata = jsonDecode(response.body);
        final List<dynamic> data = fianldata["activeAlerts"];

        alertList = data;
        yield data;
      } else {
        throw Exception('Failed to fetch data');
      }
      await Future.delayed(
          Duration(seconds: 5)); // Delay for 5 seconds before fetching again
    }
  }

  @override
  void initState() {
    super.initState();

    driverFetch();
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var currentTime = new DateTime(now.day, now.hour);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 1,
        leading: Container(
          margin: EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(178, 142, 22, 1),
        title: Center(
          child: Container(
            child: Text(
              "Create Alert ",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: AppFonts.mediumFontSize,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 12,
            ),
            Container(
                height: 30,
                child: Center(
                  child: StreamBuilder<List<dynamic>>(
                    stream: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<dynamic> data = snapshot.data!;

                        alertList = data;

                        // driverworkstatus =
                        //     data[
                        //         "workStatus"];
                        // Render your UI with the data
                        return Text(
                          "Alert",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: AppFonts.smallFontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Container();
                      }
                    },
                  ),
                )),
            alertList.isEmpty
                ? ListTile(
                    title: Container(
                      margin: EdgeInsets.only(
                        bottom: 70,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: screenHeight * 0.4,
                            child: ListView.builder(
                              itemCount: type.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: screenHeight * 0.01,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Column(children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3), // Shadow color
                                                            blurRadius:
                                                                5, // Spread radius
                                                            offset: Offset(0,
                                                                3), // Offset in (x,y) coordinates
                                                          ),
                                                        ],
                                                        color: Color.fromRGBO(
                                                            236, 240, 243, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              1), // Set the border color
                                                          width: 2.5,
                                                        )),
                                                    height: screenHeight * 0.07,
                                                    width: screenWidth * 0.9,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              9.0),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.02,
                                                            width: screenWidth *
                                                                0.04,
                                                            child:
                                                                Transform.scale(
                                                              scale: 1.1,
                                                              child: Radio(
                                                                value: index,
                                                                groupValue:
                                                                    selectedIndex,
                                                                onChanged:
                                                                    (value) {
                                                                  setState(() {
                                                                    selectedIndex =
                                                                        value!;
                                                                    alertType =
                                                                        type[
                                                                            index];
                                                                    isalert =
                                                                        false;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            height:
                                                                screenHeight *
                                                                    0.03,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Text(
                                                              type[index],
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
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: StreamBuilder<List<dynamic>>(
                      stream: fetchData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<dynamic> data = snapshot.data!;
                          alertList = data;
                          // driverworkstatus =
                          //     data[
                          //         "workStatus"];
                          // Render your UI with the data
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Shadow color
                                      blurRadius: 3, // Spread radius
                                      offset: Offset(
                                          0, 3), // Offset in (x,y) coordinates
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: screenHeight * 0.15,
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Alertocation",
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
                                            Spacer(),
                                            Text(
                                              data[index]["alertocation"],
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
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
            SizedBox(
              height: screenHeight * 0.06,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.3), // Shadow color
                            blurRadius: 5, // Spread radius
                            offset: Offset(0, 3), // Offset in (x,y) coordinates
                          ),
                        ],
                        color: Color.fromRGBO(236, 240, 243, 1),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Color.fromRGBO(
                              255, 255, 255, 1), // Set the border color
                          width: 2.5,
                        )),
                    width: MediaQuery.of(context).size.width * 0.525,
                    height: MediaQuery.of(context).size.height * 0.15,
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      tileColor: Colors.white,
                      title: Column(
                        children: [
                          Container(
                              child: isalert
                                  ? Text('')
                                  : Text(
                                      '${alertType}',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: AppFonts.smallFontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              alertList.isEmpty
                                  ? Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: ElevatedButton(
                                        onPressed: () => {},
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Color.fromRGBO(
                                                    255, 148, 165, 223);
                                              }
                                              // 98, 172, 181
                                              return Colors.white;
                                            }),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)))),
                                        child: GestureDetector(
                                          onTap: () {
                                            Create_Alert();
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.265,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            child: Center(
                                              child: Text(
                                                " Create Alert",
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
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: ElevatedButton(
                                        onPressed: () => {},
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return Color.fromRGBO(
                                                    255, 148, 165, 223);
                                              }
                                              // 98, 172, 181
                                              return Colors.white;
                                            }),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)))),
                                        child: GestureDetector(
                                          onTap: () {
                                            finishAlert();
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.265,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.06,
                                            child: const Center(
                                              child: Text(
                                                " Finish Alert",
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
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
