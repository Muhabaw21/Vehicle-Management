import 'dart:convert';

import 'package:bazralogin/const/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class communicationHistory extends StatefulWidget {
  const communicationHistory({super.key});

  @override
  State<communicationHistory> createState() => _communicationHistoryState();
}

class _communicationHistoryState extends State<communicationHistory> {
  bool _isLoading = true;
  List Result = [];
  void MessageHistory() async {
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

      List results = mapResponse['messages'];

      setState(() {
        _isLoading = false;
        Result = results;
      });

      print(results);
    } else {
      throw Exception('not loaded ');
    }
  }

  void initState() {
    super.initState();
    MessageHistory();
  }

  @override
  void dispose() {
    // timer.cancel();
    // timer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: screenHeight * 0.1),
          child: Column(children: [
            Row(
              children: [
                Container(
                  height: screenHeight * 0.08,
                  width: screenWidth * 0.55,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: TextField(
                      decoration: InputDecoration(
                    hintText: 'Search message history',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black!, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  )),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: screenHeight * 0.1,
                      child: Icon(
                        Icons.calendar_month,
                        size: 45,
                      )),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      " Message History",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.7,
              height: 20,
            ),
            Container(
              height: screenHeight,
              // margin: EdgeInsets.only(bottom: 200),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: Result.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHeight * 0.1,
                            width: screenWidth - 16.0,
                            child: _isLoading
                                ? Container(
                                    margin: EdgeInsets.only(top: 130),
                                    child: Center(
                                        child: CircularProgressIndicator()))
                                : Container(
                                    height: screenHeight * 0.1,
                                    width: screenWidth - 16.0,
                                    child: Container(
                                        child: Row(
                                      children: [
                                        Container(
                                          child: SizedBox(
                                            height: screenHeight * 0.06,
                                            width: screenWidth * 0.1,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: SizedBox(
                                                  height: screenHeight * 0.06,
                                                  child: Center(
                                                    child: Text(
                                                      Result[index]
                                                              ["recipientName"]
                                                          .substring(0, 1),
                                                      style:TextStyle(
                                                        color: kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: screenHeight * 0.06,
                                          width: screenWidth * 0.6,
                                          margin: EdgeInsets.only(
                                              top: screenHeight * 0.03,
                                              left: screenWidth * 0.03),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  Result[index]['message'],
                                                  style:TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                  ),
                          )),
                      Divider(
                        color: Colors.grey,
                        thickness: 0.7,
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
