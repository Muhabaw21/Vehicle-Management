import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../Theme/TextInput.dart';
import '../Bottom/Bottom.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController Confirmpass = TextEditingController();

  Future<void> _showMyDialog() async {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.07,
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(10),
              color: kPrimaryColor,
              child: Center(
                child: Container(
                  height: 20,
                  child: const Text(
                    "",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Change Successfully ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>BottomTabBarPageforowner()));
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ChangePasswords() async {
    try {
      final storage = new FlutterSecureStorage();
      var value = await storage.read(key: 'jwt');

      Map data = {
        "currentPin": "${currentPassword.text}",
        "newPin": "${newpass.text}",
        "confirmNewPin": "${Confirmpass.text}"
      };
      var response = await http.post(
          Uri.parse('http://64.226.104.50:9090/Api/User/ChangePassword'),
          body: jsonEncode(data) as String,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        _showMyDialog();
      } else {
        print('noooo');
      }
    } catch (e) {
      print(e);
      throw e;
    }
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
                margin: EdgeInsets.only(
                    top: screenHeight * 0.1, bottom: screenHeight * 0.07),
                child: Row(
                  children: [
                    Container(
                      // margin: EdgeInsets.only(bottom: screenHeight * 0.2),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.14),
                        child: Text(
                          "Change password",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: AppFonts.mediumFontSize,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: Row(
                    children: [
                      Text(
                        " Current  password",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: AppFonts.smallFontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenWidth,
                        child: TextField(
                          controller: currentPassword,
                          decoration: ThemeHelper().textInputDecoration(),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // margin: EdgeInsets.only(top: screenHeight * 0.09),
                  child: Row(
                    children: [
                      Text(
                        " New password",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: AppFonts.smallFontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenWidth,
                        child: TextField(
                          controller: newpass,
                          decoration: ThemeHelper().textInputDecoration(),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Text(
                        " Confirm  password",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: AppFonts.smallFontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: screenWidth,
                        child: TextField(
                          controller: Confirmpass,
                          decoration: ThemeHelper().textInputDecoration(),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width - 20,
                        child: ElevatedButton(
                          onPressed: () {
                            ChangePasswords();
                          },
                          child: const Text(
                            "Confrim",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: AppFonts.smallFontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                          style: ThemeHelper().buttonStyle(),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
