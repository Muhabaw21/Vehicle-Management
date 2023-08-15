import 'dart:convert';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/screen/Owner/Profile/profileEdit/updateOwnerprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import '../../../controller/apiController.dart';
import '../../Loging/Login.dart';
import '../../Loging/changePassword.dart';
import '../../../../const/constant.dart';
import '../Driver/assignDriver.dart';
import 'profileEdit/languageOptions.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Map<String, dynamic>? Result;
Map<String, dynamic>? Addressinfo;
String? driverstate;

String? namedriver;
bool _isLoading = true;

class _ProfileState extends State<Profile> {
  String ownerpic = "";
  DateTime? currentBackPressTime;
  bool _isLoading = true;
  Map<String, dynamic>? Result;
  Map<String, dynamic>? findVehicle;
  String? ownername;
  var datas;
  String? ownerphone;
  String? owneremail;

  Future<Map<String, dynamic>> _fetchLogo() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.ownerInfo);
    final response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      var ownerinfo = json.decode(response.body);
      Map<String, dynamic> data = ownerinfo["ownerINF"];

      return data;
    } else {
      throw Exception('Failed to load image');
    }
  }

// fetch owner info
  ownerinfo() async {
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.http(ApIConfig.urlAPI, ApIConfig.ownerInfo);
    var response = await http.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var mapResponse = json.decode(response.body) as Map<String, dynamic>;
      Map<String, dynamic> results = mapResponse['ownerINF'];

      Addressinfo = mapResponse['ownerINF'];
      setState(() {
        _isLoading = false;
        Result = results;
        findVehicle = Result;
      });
      return Result;
    } else {
      throw Exception('not loaded ');
    }
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              Duration(seconds: 2)) {
        // Show a Snackbar at the bottom indicating to press back again to exit

        currentBackPressTime = DateTime.now();
        return true; // Stop the default back button event
      } else {
        // Close the app when back button is pressed again
        SystemNavigator.pop();
        return true; // Stop the default back button event
      }
    } else {
      Navigator.pop(context); // Navigate back to the home page
      return true; // Stop the default back button event
    }
  }

  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);

    ownerinfo();
  }

  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TranslationController controller = Get.put(TranslationController());
    final ApiController _apiController = Get.put(ApiController());

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          margin: EdgeInsets.only(top: 28),
          child: SingleChildScrollView(
            child: Column(children: [
              _isLoading
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: screenWidth * 0.8),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ownerprofileUpadate(
                                            image: "${datas["driverPic"]}",
                                            email: Result!['email'].toString(),
                                            phone: Result!["phoneNumber"],
                                            datebirth: "12/4/000",
                                            name: Result!["firstName"],
                                            gender: "Male",
                                            woredas:
                                                Result!["companyAddressINF"]
                                                    ["woreda"],
                                            houseNumbers:
                                                Result!["companyAddressINF"]
                                                    ["houseNum"],
                                            notificationmedia:
                                                Result!["notificationMedium"],
                                          )));
                            },
                            icon: Icon(
                              Ionicons.pencil,
                              color: Color.fromRGBO(226, 193, 121, 1),
                            ),
                          ),
                        )
                      ],
                    ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: _fetchLogo(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Map<String, dynamic>> snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) return Text("");
                            datas = snapshot.data;

                            return SizedBox(
                                height: screenHeight * 0.12,
                                child: Row(
                                  children: [
                                    Container(
                                        child: ClipOval(
                                      child: SizedBox(
                                        height: screenHeight * 0.09,
                                        width: screenWidth * 0.19,
                                        child: Image.network(
                                          snapshot.data!['pic'].toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )),
                                  ],
                                ));
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Result?["firstName"] == null
                              ? Container()
                              : Text(
                                  Result!["firstName"],
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal),
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                height: screenHeight * 0.28,
                width: screenWidth,
                child: Column(children: [
                  SizedBox(
                      height: screenHeight * 0.28,
                      child: _isLoading
                          ? Container()
                          : Container(
                              height: screenHeight * 0.23,
                              child: ListView.builder(
                                itemCount: 1,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.3,
                                              ),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left:
                                                            screenWidth * 0.03),
                                                    width: screenWidth * 0.2,
                                                    child: Text(
                                                      TranslationUtil.text(
                                                          "Email"),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 24),
                                                      child: Result!['email'] ==
                                                              null
                                                          ? Container()
                                                          : Text(
                                                              Result!['email']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Nunito",
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                    ),
                                                    Icon(
                                                      Ionicons
                                                          .chevron_forward_outline,
                                                      color: Colors.black,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.2,
                                              ),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      TranslationUtil.text(
                                                          "Date of Birth"),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      child: Text(
                                                        "2022-12-2",
                                                        textAlign:
                                                            TextAlign.center,
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
                                                        child: Icon(Ionicons
                                                            .chevron_forward_outline))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: screenHeight * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 0.2,
                                              ),
                                            )),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      TranslationUtil.text(
                                                        "Gender",
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            right: 20),
                                                        child: Center(
                                                            child: Text(
                                                          "Male",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Nunito',
                                                              fontSize: AppFonts
                                                                  .smallFontSize,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ))),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                        child: Icon(Ionicons
                                                            .chevron_forward_outline))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => languageOption()));
                },
                child: Container(
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: screenWidth * 0.08,
                            width: screenWidth * 0.08,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(252, 221, 244, 1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Icon(Icons.language_sharp)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Text(
                            TranslationUtil.text("Language"),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: AppFonts.smallFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          )),
                        ),
                        Spacer(),
                        Container(
                            child: Icon(Ionicons.chevron_forward_outline)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                height: screenHeight * 0.3,
                width: screenWidth,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(201, 252, 248, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.lock_outline)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Text(
                              TranslationUtil.text('Change password'),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            )),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChangePassword()),
                                      );
                                    },
                                    child: Icon(
                                        Ionicons.chevron_forward_outline))),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 245, 210, 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Icon(Ionicons.help)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              TranslationUtil.text("Help"),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: Icon(Ionicons.chevron_forward_outline)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                              height: screenWidth * 0.08,
                              width: screenWidth * 0.08,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(201, 252, 248, 1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Ionicons.settings)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              TranslationUtil.text("Logout"),
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: AppFonts.smallFontSize,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: Icon(Ionicons.chevron_forward_outline)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: screenHeight * 0.06,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(0.3), // Shadow color
                                blurRadius: 3, // Spread radius
                                offset:
                                    Offset(0, 3), // Offset in (x,y) coordinates
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            )),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Logout",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: AppFonts.smallFontSize,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Login()),
                                      (route) => false,
                                    );
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      // decoration: BoxDecoration(
                                      //     color:
                                      //         Color.fromRGBO(226, 193, 121, 1),
                                      //     shape: BoxShape.circle),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Icon(
                                          Icons.logout,
                                          color:
                                              Color.fromRGBO(226, 193, 121, 1),
                                          size: 30,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
