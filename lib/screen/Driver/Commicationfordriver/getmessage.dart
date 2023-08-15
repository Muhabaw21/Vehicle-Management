import 'dart:convert';

import 'package:bazralogin/const/constant.dart';
import 'package:bazralogin/screen/Driver/Commicationfordriver/chatRome.dart';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class getMessage extends StatefulWidget {
  const getMessage({super.key});

  @override
  State<getMessage> createState() => _getMessageState();
}

class _getMessageState extends State<getMessage> {
  bool _isLoading = true;
  List Result = [];

  void initState() {
    super.initState();
    MessageHistory();
  }

  MessageHistory() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://164.90.174.113:9090/Api/Message/All'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;

      setState(() {
        _isLoading = false;
        List results = mapResponse['messages'];
        Result = results;
      });
      return Result;
    } else {
      // throw Exception('not loaded ');
    }
  }

  @override
  void dispose() {
    // timer.cancel();
    // timer;
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        margin: EdgeInsets.only(top: 60),
        child: _isLoading
            ? Container(
                margin: EdgeInsets.only(top: 130),
                child: Center(child: CircularProgressIndicator()))
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Message",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: AppFonts.largeFontSize,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                        ),
                      ],
                    ),
                    if (Result == null || Result.isEmpty)
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.2,
                          ),
                          width: 300,
                          height: 300,
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              'assets/images/21559-no-message.json', // Replace with your animation file path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    else
                      Column(
                          children: Result.map((vehicle) {
                        return Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => ChatRome(
                                                  message: vehicle['message'],
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade400
                                              .withOpacity(0.2),
                                          spreadRadius: -1,
                                          blurRadius: 1,
                                          offset: Offset(0,
                                              -3), // horizontal, vertical offset
                                        ),
                                      ],
                                    ),
                                    height: screenHeight * 0.1,
                                    width: screenWidth - 16.0,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SizedBox(
                                            height: screenHeight * 0.09,
                                            width: screenWidth * 0.1,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: SizedBox(
                                                  height: screenHeight * 0.09,
                                                  child: Center(
                                                    child: Text(
                                                      vehicle["recipientName"]
                                                          .substring(0, 1),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: screenHeight * 0.055,
                                              width: screenWidth * 0.4,
                                              child: Text(
                                                vehicle['message'],
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontFamily: 'Nunito',
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: screenHeight * 0.055,
                                              width: screenWidth * 0.2,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "2022/2/21",
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        );
                      }).toList()),
                  ],
                ),
              ),
      ),
    );
  }
}
