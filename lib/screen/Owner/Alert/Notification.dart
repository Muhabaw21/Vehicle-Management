import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../../const/constant.dart';
import '../../../config/APIService.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({super.key});

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  bool _isLoading = true;
  List Result = [];
  List existingData = [];
  List newData = [];
  List oldData = [];
  List results = [];
  List Temp = [];
  List dataLists = [];
  List<Color> colors = [
    Colors.white,
    Color.fromRGBO(195, 215, 233, 1),
  ];

  List<dynamic> addBoolValueToList(List<dynamic> Result) {
    return Result.map((item) {
      return {
        ...item,
        'isFlagged': false, // Add the boolean value to each item
      };
    }).toList();
  }

  void updateDataInHive(int index) async {
    // Open the Hive box
    final box = Hive.box('dataBox');
    final dataList = box.get('dataBox'); // Retrieve the data list from Hive

    if (dataList != null) {}
  }

  Future<void> fetchDataFromApiAndStoreInHive() async {
    // Fetch data from the API
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(Uri.parse(ApIConfig.alertforowner),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List items = responseData["activeAlerts"];
      // Get the Hive box

      setState(() {
        dataLists = items;
      });
      final box = Hive.box('dataBox');
      final String lastStoredId = box.get('lastId', defaultValue: 0);

      // Store only new data in Hive
      for (var data in items) {
        String id = data["id"]
            .toString(); // Assuming 'id' is the unique identifier in the API response
        print(data["id"]);
        // Check if the data already exists in Hive
        bool istrue = !box.containsKey(id);
        print(istrue);
        if (istrue == true) {
          setState(() {
            newData.add(data);
            final modifydata = addBoolValueToList(data);
            box.put(id, modifydata);
          });
        } else {
          setState(() {
            dataLists = items;
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

  void initState() {
    super.initState();
    fetchDataFromApiAndStoreInHive();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("nee");
    print(dataLists);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.05,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    "Alerts",
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
            Container(

                // margin: EdgeInsets.only(bottom: 200),
                child: Column(
              children: [
                if (dataLists == null || dataLists.isEmpty)
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: screenHeight,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: dataLists.length,
                        itemBuilder: (context, index) {
                          bool doesNotExist = dataLists
                                  .contains(dataLists[index]['isFlagged']) ==
                              true;
                          return Column(
                            children: [
                              Column(
                                children: [
                                  doesNotExist == false
                                      ? GestureDetector(
                                          onTap: () {
                                            print(doesNotExist);
                                            if (doesNotExist == false) {
                                              final box = Hive.box('dataBox');

                                              setState(() {
                                                box.put(
                                                    'dataBox',
                                                    dataLists[index]
                                                        ['isFlagged'] = true);
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: screenHeight * 0.1,
                                            width: screenWidth,
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  212, 233, 253, 1),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.shade400
                                                      .withOpacity(0.3),
                                                  spreadRadius: -1,
                                                  blurRadius: 1,
                                                  offset: Offset(0,
                                                      -4), // horizontal, vertical offset
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                                child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: SizedBox(
                                                      height:
                                                          screenHeight * 0.08,
                                                      width: screenWidth * 0.1,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.06,
                                                            child: Center(
                                                              child: Text(
                                                                dataLists[index]
                                                                        [
                                                                        "driver"]
                                                                    .substring(
                                                                        0, 1),
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
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: screenHeight * 0.08,
                                                  width: screenWidth * 0.4,
                                                  margin: EdgeInsets.only(
                                                    top: screenHeight * 0.03,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              dataLists[index][
                                                                  'alertocation'],
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
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                right:
                                                                    screenWidth *
                                                                        0.07),
                                                            child: Text(
                                                              dataLists[index]
                                                                  ['alertType'],
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
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: screenWidth * 0.22,
                                                  margin: EdgeInsets.only(
                                                      left: screenWidth * 0.15),
                                                  child: Text(
                                                    dataLists[index]
                                                        ['alertstart'],
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
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Container(
                                                  width: 10,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      shape: BoxShape.circle),
                                                )
                                              ],
                                            )),
                                          ),
                                        )
                                      : Container(),
                                  dataLists.isEmpty
                                      ? Container()
                                      : Container(
                                          height: screenHeight * 0.1,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                            color: kBackgroundColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade400
                                                    .withOpacity(0.3),
                                                spreadRadius: -1,
                                                blurRadius: 1,
                                                offset: Offset(0,
                                                    -4), // horizontal, vertical offset
                                              ),
                                            ],
                                          ),
                                          child: Container(
                                              child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: SizedBox(
                                                    height: screenHeight * 0.08,
                                                    width: screenWidth * 0.1,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: SizedBox(
                                                          height: screenHeight *
                                                              0.06,
                                                          child: Center(
                                                            child: Text(
                                                              dataLists[index]
                                                                      ["driver"]
                                                                  .substring(
                                                                      0, 1),
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
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.4,
                                                margin: EdgeInsets.only(
                                                  top: screenHeight * 0.03,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            dataLists[index][
                                                                'alertocation'],
                                                            textAlign:
                                                                TextAlign.left,
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
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              right:
                                                                  screenWidth *
                                                                      0.07),
                                                          child: Text(
                                                            dataLists[index]
                                                                ['alertType'],
                                                            textAlign:
                                                                TextAlign.left,
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
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.22,
                                                margin: EdgeInsets.only(
                                                    left: screenWidth * 0.15),
                                                child: Text(
                                                  dataLists[index]
                                                      ['alertstart'],
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
                                              )
                                            ],
                                          )),
                                        )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
