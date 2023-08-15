import 'dart:convert';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../Owner/Driver/assignDriver.dart';

// ignore: must_be_immutable
class ChatRome extends StatefulWidget {
  final String? message;
  final String? name;
  final String? times;
  final ApiData? apiData;
  ChatRome({
    super.key,
    this.apiData,
    this.message,
    this.name,
    this.times,
  });

  @override
  State<ChatRome> createState() => _ChatRomeState();
}

TextEditingController _searchController = TextEditingController();
final TextEditingController _controller = TextEditingController();

class _ChatRomeState extends State<ChatRome> {
  sendMessage() async {
    var value = await storage.read(key: 'jwt');
    Map data = {
      "message": _controller.text,
      "receipientPhone": ["0966666666"]
    };
    var response = await http.post(
        Uri.parse('http:164.90.174.113:9090/Api/Message/CreateMessage'),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $value",
        });

    if (response.statusCode == 200) {
      _controller.clear();
    } else {
      throw Exception('Failed ');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(95, 112, 247, 1),
              Color.fromRGBO(163, 163, 234, 1),
            ],
            // stops: [0.4, 0.4],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: screenHeight * 0.2,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(95, 112, 247, 1),
                          Color.fromRGBO(163, 163, 234, 1),
                        ],

                        // stops: [0.4, 0.4],
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.08,
                              right: screenWidth * 0.4),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Ionicons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.8,
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 45),
                                          child: SizedBox(
                                            height: screenHeight * 0.06,
                                            width: screenWidth * 0.1,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: SizedBox(
                                                  height: screenHeight * 0.09,
                                                  child: Center(
                                                    child: Text(
                                                      "A".substring(0, 1),
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth * 0.45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          topLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                          child: Text("${widget.message}")),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 45),
                                      child: Text(
                                        "2022/3/4",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: AppFonts.smallFontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: screenHeight * 0.11,
                              margin: EdgeInsets.only(top: screenHeight * 0.65),
                              width: screenWidth - 24,
                              child: TextFormField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: "Send message",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    hintStyle: TextStyle(
                                        fontFamily: 'Nunito',
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal),
                                    suffixIcon: Container(
                                      height: screenWidth * 0.03,
                                      width: screenWidth * 0.03,
                                      child: InkWell(
                                        onTap: () {
                                          sendMessage();
                                        },
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    // Specify border color and width
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ))
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

class ApiData {
  bool isLoading = false;
}
