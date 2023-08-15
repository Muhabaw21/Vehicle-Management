import 'dart:convert';

import 'package:bazralogin/Route/Routes.dart';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../../../../Theme/TextInput.dart';
import '../../../../config/APIService.dart';
import '../../Bottom/Bottom.dart';

class assignDriver extends StatefulWidget {
  final String? licenseNumber;
  final String? plateNumber;
  assignDriver({super.key, this.licenseNumber, this.plateNumber});

  @override
  State<assignDriver> createState() => _assignDriverState();
}

TextEditingController textEditingController = TextEditingController();
final storage = new FlutterSecureStorage();

class _assignDriverState extends State<assignDriver> {
  bool isLoading = false;

  void performAction() {
    setState(() {
      isLoading = true;
    });

    // Simulate an asynchronous action
    Future.delayed(Duration(seconds: 15), () async {
      var value = await storage.read(key: 'jwt');
      Map data = {
        "driver": "${widget.licenseNumber}",
        "plateNumber": "${widget.plateNumber}",
      };
      var response = await http.post(Uri.parse(ApIConfig.assignDriverApi),
          body: json.encode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        String alertContent = decodedResponse["message"];
        alertutils.showMyDialog(context, "Alert", alertContent);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String? selectedItem = 'Single Trip';
    List<String> items = ['Single Trip', 'Round Trip'];
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
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
          title: const Text(
            " Assign driver",
            style: TextStyle(
                fontFamily: "Nunito",
                fontSize: 23,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenWidth * 0.24,
                width: screenWidth,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        blurRadius: 5, // Spread radius
                        offset: Offset(0, 3), // Offset in (x,y) coordinates
                      ),
                    ],
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.white, // Set the border color
                      width: 2.5,
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Driver Status",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Nunito",
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.licenseNumber}",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      blurRadius: 5, // Spread radius
                      offset: Offset(0, 3), // Offset in (x,y) coordinates
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          blurRadius: 5, // Spread radius
                          offset: Offset(0, 3), // Offset in (x,y) coordinates
                        ),
                      ],
                      color: Color.fromRGBO(236, 240, 243, 1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color.fromRGBO(
                            236, 240, 243, 1), // Set the border color
                        width: 2.5,
                      )),
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    width: screenWidth * 0.5,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(" Assign Driver",
                                  style: TextStyle(
                                    fontFamily: "Nuinto",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 17,
                                  ))),
                        ],
                      ),
                      Container(
                        height: screenHeight * 0.35,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Driver License",
                                      style: TextStyle(
                                        fontFamily: "Nuinto",
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: screenHeight * 0.09,
                                  child: TextFormField(
                                    enabled: false,
                                    controller: TextEditingController(
                                        text: "${widget.licenseNumber}"),
                                    decoration:
                                        ThemeHelper().textInputDecoration(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Vehicle plate Number",
                                  style: TextStyle(
                                    fontFamily: "Nuinto",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                height: screenHeight * 0.09,
                                child: TextField(
                                  enabled: false,
                                  controller: TextEditingController(
                                      text: "${widget.plateNumber}"),
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                )),
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                  screenWidth * 0.4, 20, 0, 0),
                              width: screenWidth * 0.4,
                              height: screenHeight * 0.05,
                              child: ElevatedButton(
                                  onPressed: isLoading ? null : performAction,
                                  child: Container(
                                    height: 55,
                                    width: screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        isLoading
                                            ? SizedBox(
                                                height: 24,
                                                width: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              )
                                            : SizedBox(), // Empty SizedBox if not loading
                                        SizedBox(width: 8),
                                        Text(
                                          isLoading
                                              ? 'Please Wait'
                                              : 'Assign Driver',
                                          style: TextStyle(
                                              fontFamily: "Nunito",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Color.fromRGBO(
                                              255, 148, 165, 223);
                                        }
                                        // 98, 172, 181
                                        return Color.fromRGBO(178, 142, 22, 1);
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6))))),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
