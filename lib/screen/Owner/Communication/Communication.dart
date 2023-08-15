import 'dart:async';
import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config/APIService.dart';
import '../../../controller/Localization.dart';
import '../../Bottom/Bottom.dart';
import '../Driver/assignDriver.dart';

class CommunicationPage extends StatefulWidget {
  CommunicationPage({
    super.key,
  });
  @override
  State<CommunicationPage> createState() => _CommunicationPageState();
}

class _CommunicationPageState extends State<CommunicationPage> {
  TextEditingController _searchController = TextEditingController();
  final TextEditingController _controller = TextEditingController();
  List Result = [];
  List findVehicle = [];
  String query = '';
  List listDriver = [];
  List drivers = [];
  bool ischeckValue = false;
  bool _isLoading = true;

  // success  alert
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: const Text('')),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Center(child: Text('Message sent successfully ')),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomTabBarPageforowner()));
              },
            ),
          ],
        );
      },
    );
  }
  // fetch all deriver

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
      var url = Uri.http(ApIConfig.urlAPI, ApIConfig.driverApi);
      var response = await client.get(url, headers: requestHeaders);

      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        await storage.write(
            key: "totalDrivers", value: data["totalDrivers"].toString());

        Result = data['drivers'];
        setState(() {
          _isLoading = false;
          findVehicle = Result;
        });

        return Result;
      } else {
        // throw Exception("not Loaded");
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  //  deriver search
  void vehicleSearch(String enterKeyboard) {
    setState(() {
      findVehicle = Result.where((driver) {
        final name = driver['driverName'].toLowerCase();

        final plateNumber = driver['phoneNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || plateNumber.contains(inputName);
      }).toList();
    });
    setState(() {
      findVehicle = findVehicle;
    });
  }

// send message
  sendMessage() async {
    var value = await storage.read(key: 'jwt');
    Map data = {"message": _controller.text, "receipientPhone": listDriver};
    var response = await http.post(
        Uri.parse('http://164.90.174.113:9090/Api/Message/CreateMessage'),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $value",
        });

    if (response.statusCode == 200) {
      _showMyDialog();
    } else {
      throw Exception('Failed ');
    }
  }

// select all checkbox
  OnclickedAll() {
    List newmessage = [];
    bool newvalue = false;

    setState(() {
      newvalue = false;
      listDriver.clear();
      Result.forEach((element) {
        element['statMessage'] = !newvalue;
        newmessage.add(element['phoneNumber']);
      });
    });
    setState(() {
      listDriver = newmessage;
      newvalue = true;
    });
  }

  void initState() {
    super.initState();

    driverFetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print(listDriver);

    return SingleChildScrollView(
      child: Container(
        height: screenHeight,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 30, right: 60, top: 35, bottom: 10),
                    child: Text(
                      TranslationUtil.text('Message'),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 0),
                    height: screenHeight * 0.2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: SizedBox(
                                  height: screenHeight * 0.125,
                                  width: screenWidth - 25.0,
                                  child: TextFormField(
                                    minLines: 5,
                                    maxLines: 6,
                                    controller: _controller,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      hintText: " write message",
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: Colors.black!, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: screenWidth * 0.7),
                          child: Row(
                            children: [
                              Container(
                                height: 35,
                                width: screenWidth * 0.26,
                                child: ElevatedButton(
                                  onPressed: (() {
                                    sendMessage();
                                  }),
                                  child: Text(
                                    "send",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors.white;
                                        }
                                        return Color.fromRGBO(178, 142, 22, 1);
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6)))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                      height: 65,
                      width: screenWidth * 0.5,
                      decoration: const BoxDecoration(

                          // color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                      child: Container(
                        height: screenHeight * 0.01,
                        width: screenWidth,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: TextField(
                            onChanged: vehicleSearch,
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search driver',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    BorderSide(color: Colors.black!, width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ]),
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.21),
                      child: ElevatedButton(
                        onPressed: (() {
                          OnclickedAll();
                        }),
                        child: Text(
                          'Select all',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;
                              }
                              return Color.fromRGBO(178, 142, 22, 1);
                            }),
                            shape: MaterialStateProperty
                                .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                    // side: const BorderSide(
                                    //     color:
                                    //         Color.fromRGBO(162, 184, 212, 1)),
                                    borderRadius: BorderRadius.circular(6)))),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: _isLoading
                      ? Container(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: findVehicle.map((driver) {
                          return Card(
                            shadowColor: Colors.black,
                            color: Colors.white,
                            child: Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: screenWidth - 29,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Container(
                                              width: screenWidth * 0.35,
                                              margin: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Text(
                                                " " + driver['driverName'],
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
                                          Container(
                                            width: screenWidth * 0.27,
                                            child: Text(
                                              " " +
                                                  driver['phoneNumber']
                                                      .toString(),
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8.0,
                                            ),
                                            child: SizedBox(
                                              width: screenWidth * 0.17,
                                              height: 10,
                                              child: Transform.scale(
                                                scale: 0.9,
                                                child: GestureDetector(
                                                    onTap: () {},
                                                    child: Checkbox(
                                                        activeColor:
                                                            Colors.green,
                                                        value: driver[
                                                            'statMessage'],
                                                        onChanged: (value) {
                                                          var item = driver[
                                                              'phoneNumber'];
                                                          setState(() {
                                                            driver['statMessage'] =
                                                                value!;
                                                            if (value == true) {
                                                              listDriver
                                                                  .add(item);
                                                            } else if (value ==
                                                                false) {
                                                              listDriver.removeWhere(
                                                                  (item) =>
                                                                      item ==
                                                                      driver[
                                                                          'phoneNumber']);
                                                            }
                                                          });
                                                        })),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }).toList()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
