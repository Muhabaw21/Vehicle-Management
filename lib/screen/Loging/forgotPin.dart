import 'dart:convert';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:http/http.dart' as http;
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ionicons/ionicons.dart';
import '../../../Theme/TextInput.dart';
import '../../config/APIService.dart';
import '../Owner/Driver/assignDriver.dart';

class forgotPin extends StatefulWidget {
  String? phone;
  String? newpin;
  forgotPin({super.key, this.phone, this.newpin});

  @override
  State<forgotPin> createState() => _forgotPinState();
}

class _forgotPinState extends State<forgotPin> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController Confirmpass = TextEditingController();
  TextEditingController resetpin = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic>? findVehicle;
  Map<String, dynamic>? Result;

  ownerinfo() async {
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.forgetpin);
    var response =
        await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      Map<String, dynamic> results = mapResponse['ownerINF'];

      setState(() {
        Result = results;
        findVehicle = Result;
      });
      return Result;
    } else {}
  }

  ChangePasswords() async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {
        "newpassword": "${newpass.text}",
        "confirmPassword": "${Confirmpass.text}",
        "username": "${widget.phone}",
        "pin": "${widget.newpin}",
      };
      var response = await http.post(
          Uri.parse('http://164.90.174.113:9090/Api/User/SetPin'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });
      setState(() {
        isLoading = true;
      });

      if (response.statusCode == 200) {
        var decodedResponse = json.decode(response.body);
        String alertContent = decodedResponse["message"];
        alertutilsforgetpin.showMyDialog(context, "Alert", alertContent);
      } else {
        print('noooo');
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();

    ownerinfo();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("${currentPassword.text}");

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: kBackgroundColor,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: screenHeight * 0.08),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.06,
                      ),
                      Text(
                        "Reset password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          color: Colors.black,
                          fontSize: AppFonts.mediumFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: screenHeight * 0.09,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Icon(
                            Ionicons.chatbox,
                            color: Color.fromRGBO(255, 194, 14, 1),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "OTP is alread send  to your phone\n ${widget.phone}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Nunito",
                            color: Colors.black,
                            fontSize: AppFonts.smallFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.09, left: screenWidth * 0.013),
                  child: Row(
                    children: [
                      Text(
                        "New Pin",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          color: Colors.black,
                          fontSize: AppFonts.smallFontSize,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        enabled: false,
                        controller:
                            TextEditingController(text: "${widget.newpin}"),
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.013),
                  child: Row(
                    children: [
                      Text(
                        "New Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          color: Colors.black,
                          fontSize: AppFonts.smallFontSize,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: newpass,
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  margin: EdgeInsets.only(
                      top: screenHeight * 0.03, left: screenWidth * 0.013),
                  child: Row(
                    children: [
                      Text(
                        "Confirm  Password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Nunito",
                          color: Colors.black,
                          fontSize: AppFonts.smallFontSize,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                      width: screenWidth - 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        controller: Confirmpass,
                        decoration: ThemeHelper().textInputDecoration(),
                      )),
                ],
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width - 30,
                        child: ElevatedButton(
                            onPressed: () {
                              ChangePasswords();
                            },
                            child: Container(
                              height: 55,
                              width: screenWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                  )
                                  // Empty SizedBox if not loading
                                  ,
                                  Text(
                                    'Reset password',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      color: Colors.white,
                                      fontSize: AppFonts.smallFontSize,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Color.fromRGBO(255, 148, 165, 223);
                                  }
                                  // 98, 172, 181
                                  return Colors.lightBlue;
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6))))),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
