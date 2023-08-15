import 'dart:convert';
import 'dart:ui';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/config/APIService.dart';
import 'package:bazralogin/controller/Localization.dart';
import 'package:bazralogin/screen/Owner/Alert/Notification.dart';
import 'package:badges/badges.dart' as badges;
import 'package:bazralogin/screen/Owner/market/avilabelMarketforowner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import '../../../const/constant.dart';
import 'package:http/http.dart' as http;
import '../../../controller/apiController.dart';
import '../../../controller/driverimage.dart';
import '../../../controller/ownerinfocontroller.dart';

import '../Driver/driversPage.dart';
import '../TripManagement/setGuzo.dart';
import '../Vehicle/vehicleStatus.dart';
import '../report/ownerReportstatus.dart';

class OwenerHomepage extends StatefulWidget {
  const OwenerHomepage({
    super.key,
  });

  @override
  State<OwenerHomepage> createState() => _OwenerHomepageState();
}

class _OwenerHomepageState extends State<OwenerHomepage> {
  final ApiControllerforvehicle _controller =
      Get.put(ApiControllerforvehicle());
  bool _isMounted = false;
  DateTime pre_backprees = DateTime.now();
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  String Logoavtar = "";

  String ownerpic = "";
  String bazralogo = "";
  bool showExitSnackbar = false;
  String? phoneNumber;

  List Temp = [];
  int newItemCount = 0;
  List dataList = [];
  DateTime? currentBackPressTime;
  bool _isLoading = true;
  Map<String, dynamic>? Result;
  Map<String, dynamic>? findVehicle;
  double _padding = 6.0;
  String query = '';

  List<dynamic> addBoolValueToList(List<dynamic> Result) {
    return Result.map((item) {
      return {
        ...item,
        'isFlagged': false,
        'status': "new" // Add the boolean value to each item
      };
    }).toList();
  }

  Future<Map<String, dynamic>> fetchImage() async {
    var client = http.Client();
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response =
        await http.get(Uri.parse(ApIConfig.ownerlogo), headers: requestHeaders);
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON.
      var ownerinfo = json.decode(response.body);
      Map<String, dynamic> data = ownerinfo["ownerINF"];

      return data;
    } else {
      throw Exception('Failed to load image');
    }
  }

  void myAsyncMethod() {
    // Perform asynchronous operation
    Future.delayed(Duration(seconds: 2), () {
      if (_isMounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Async operation completed')),
        );
      }
    });
  }

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

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              Duration(seconds: 2)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        currentBackPressTime = DateTime.now();
        return true; // Stop the default back button event
      } else {
        // Close the app when back button is pressed again
        SystemNavigator.pop();
        return true;
        // Stop the default back button event
      }
    }

    return false;
  }

  Future<void> clearDataFromHiveBox() async {
    setState(() {
      Temp.clear();
    });
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
      final box = Hive.box('dataBox');
      // final String lastStoredId = box.get('lastId', defaultValue: 0);

      // Store only new data in Hive
      for (var data in items) {
        String id = data["id"]
            .toString(); // Assuming 'id' is the unique identifier in the API response
        print(data["id"]);
        // Check if the data already exists in Hive
        bool istrue = !box.containsKey(id);
        print(istrue);
        if (istrue == true) {
          box.put(id, data);

          setState(() {
            newItemCount++;
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

  Future<void> _handleRefresh() async {
    // Simulating a delay to fetch new data
    await Future.delayed(Duration(seconds: 2));

    // Updating the data used by the UI
  }

  void initState() {
    super.initState();
    // fetchData();
    fetchDataFromApiAndStoreInHive();

    _isMounted = true;

    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    _isMounted = false;
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final ApiController controller = Get.put(ApiController());
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      controller.fetchData();
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _controller.fetchData();
    });
    final DataController dataController = Get.put(DataController());

    final ApiControllerforowner _ownerinfo = Get.put(ApiControllerforowner());
    print(Temp.length);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: Container(
            height: screenHeight,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(178, 142, 22, 1),
                            Color.fromRGBO(226, 193, 121, 1),
                          ],
                          // stops: [0.4, 0.4],
                        ),
                      ),
                      padding: EdgeInsets.all(8.0),
                      height: screenHeight * 0.28,
                      child: Container(
                        margin: EdgeInsets.only(top: screenHeight * 0.04),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: SizedBox(
                                      height: screenHeight * 0.1,
                                      width: screenWidth - 120,
                                      child:
                                          FutureBuilder<Map<String, dynamic>>(
                                        future: _fetchLogo(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<Map<String, dynamic>>
                                                snapshot) {
                                          if (snapshot.connectionState !=
                                              ConnectionState.done)
                                            return Text("");
                                          return SizedBox(
                                              width: screenWidth * 0.28,
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: ClipOval(
                                                    child: SizedBox(
                                                      height:
                                                          screenHeight * 0.09,
                                                      width: screenWidth * 0.19,
                                                      child: Image.network(
                                                        snapshot.data!['pic']
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  )),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 30, left: 3),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: screenWidth *
                                                              0.29,
                                                          child: Text(
                                                            "Good mourning ",
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
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          width: screenWidth *
                                                              0.17,
                                                          child: SizedBox(
                                                            height: 20,
                                                            width: screenWidth *
                                                                0.3,
                                                            child: Center(
                                                              child: GetBuilder<
                                                                  ApiControllerforowner>(
                                                                builder:
                                                                    (_ownerinfo) =>
                                                                        ListView
                                                                            .builder(
                                                                  itemCount: 1,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Container(
                                                                      child:
                                                                          Center(
                                                                        child: _ownerinfo.dataList ==
                                                                                null
                                                                            ? Container()
                                                                            : Text(
                                                                                "${_ownerinfo.dataList!["firstName"]}",
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                  fontFamily: "Nunito",
                                                                                  color: Colors.black,
                                                                                  fontSize: AppFonts.smallFontSize,
                                                                                ),
                                                                              ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      // Clear the new items count after displaying it
                                      newItemCount = 0;
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                notificationPage()));
                                  },
                                  child: Container(
                                    height: screenHeight * 0.1,
                                    margin: EdgeInsets.only(right: 15, top: 0),
                                    width: screenWidth * 0.06,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: badges.Badge(
                                        badgeStyle: badges.BadgeStyle(
                                          badgeColor: Colors.black,
                                        ),
                                        position: badges.BadgePosition.topEnd(
                                            top: -10, end: -27),
                                        showBadge: true,
                                        ignorePointer: false,
                                        badgeContent: Text(
                                          '$newItemCount',
                                          style: TextStyle(
                                            fontFamily: "Nunito",
                                            color: Colors.white,
                                            fontSize: AppFonts.smallFontSize,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        notificationPage()));
                                          },
                                          child: Icon(
                                            Ionicons.notifications,
                                            size: 27,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.19, left: 35, right: 35),
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: screenWidth * 0.35,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 13,
                                            bottom: 13,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Color.fromRGBO(178, 142, 22, 1),
                                          ),
                                          child: SizedBox(
                                            height: 20,
                                            width: 30,
                                            child: Center(
                                              child: GetBuilder<ApiController>(
                                                builder: (controller) =>
                                                    ListView.builder(
                                                  itemCount: 1,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      child: Center(
                                                        child: controller
                                                                .dataList
                                                                .isEmpty
                                                            ? Container()
                                                            : Text(
                                                                "${controller.dataList.length}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Nunito",
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                ),
                                                              ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(11),
                                        ),
                                        Text(
                                          TranslationUtil.text('Driver'),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily: "Nunito",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppFonts.smallFontSize,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.35,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 13,
                                              bottom: 13,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(
                                                  178, 142, 22, 1),
                                            ),

                                            child: SizedBox(
                                              height: 20,
                                              width: 30,
                                              child: Center(
                                                child: FutureBuilder<dynamic>(
                                                  future:
                                                      _controller.fetchData(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Center(
                                                          child: Container());
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Center(
                                                          child: Text(
                                                              'Error: ${snapshot.error}'));
                                                    } else {
                                                      List<dynamic>? data =
                                                          snapshot.data;
                                                      int dataLength =
                                                          data?.length ?? 0;
                                                      return Center(
                                                          child: Text(
                                                        "$dataLength",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          color: Colors.white,
                                                          fontSize: AppFonts
                                                              .smallFontSize,
                                                        ),
                                                      ));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.all(11),
                                            //use this class Circleborder() for circle shape.
                                          ),
                                          Text(
                                            TranslationUtil.text("Vehicle"),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Nunito",
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: AppFonts.smallFontSize,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 25, right: 25, bottom: 25, top: 20),

                    // margin: EdgeInsets.only(top: 35),
                    child: GridView(
                      padding: EdgeInsets.zero,
                      // ignore: sort_child_properties_last
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkResponse(
                            onTap: (() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          communicate_screen()));
                            }),
                            child: Ink(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: isPressed
                                          ? [
                                              BoxShadow(
                                                color: Colors.grey.shade400,
                                                offset: Offset(4, 4),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                              const BoxShadow(
                                                color: Colors.white,
                                                offset: Offset(-4, -4),
                                                blurRadius: 25,
                                                spreadRadius: 1,
                                              ),
                                            ]
                                          : null),
                                  child: Column(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,

                                        margin: EdgeInsets.only(top: 12),
                                        //height: 70,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.asset(
                                          "assets/images/driver.png",
                                          color:
                                              Color.fromRGBO(178, 142, 22, 1),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          TranslationUtil.text("Driver"),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Nunito",
                                            color: Colors.black,
                                            fontSize: AppFonts.smallFontSize,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VehicleStatus()));
                            },
                            child: AnimatedContainer(
                                duration: Duration(milliseconds: 100),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: isPressed
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: Offset(4, 4),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(-4, -4),
                                              blurRadius: 25,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : null),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      // height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Icon(
                                        Icons.local_shipping,
                                        size: 50,
                                        color: Color.fromRGBO(178, 142, 22, 1),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        TranslationUtil.text("Vehicle"),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Nunito",
                                          color: Colors.black,
                                          fontSize: AppFonts.smallFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ownerReportstatus()));
                            },
                            child: AnimatedContainer(
                                //padding: EdgeInsets.only(bottom: _padding),
                                duration: Duration(milliseconds: 100),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: isPressed
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: Offset(4, 4),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(-4, -4),
                                              blurRadius: 25,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : null),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      margin: EdgeInsets.only(top: 12),
                                      //height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/profit-report.png",
                                        color: Color.fromRGBO(178, 142, 22, 1),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text(
                                        TranslationUtil.text("Report"),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Nunito",
                                          color: Colors.black,
                                          fontSize: AppFonts.smallFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: (() {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        availabelMarket()),
                              );
                            }),
                            child: AnimatedContainer(
                                //padding: EdgeInsets.only(bottom: _padding),
                                duration: Duration(milliseconds: 100),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: isPressed
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: Offset(4, 4),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(-4, -4),
                                              blurRadius: 25,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : null),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      margin: EdgeInsets.only(top: 6),
                                      //height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/available.png",
                                        color: Color.fromRGBO(178, 142, 22, 1),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      child: Text(
                                        TranslationUtil.text(
                                            "Available Market"),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: AppFonts.smallFontSize,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => tripHistory()));
                            },
                            child: AnimatedContainer(
                                //padding: EdgeInsets.only(bottom: _padding),
                                duration: Duration(milliseconds: 100),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: isPressed
                                        ? [
                                            BoxShadow(
                                              color: Colors.grey.shade400,
                                              offset: Offset(4, 4),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            const BoxShadow(
                                              color: Colors.white,
                                              offset: Offset(-4, -4),
                                              blurRadius: 25,
                                              spreadRadius: 1,
                                            ),
                                          ]
                                        : null),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      margin: EdgeInsets.only(top: 12),
                                      //height: 70,
                                      width: MediaQuery.of(context).size.width,
                                      child: Image.asset(
                                        "assets/images/travel.png",
                                        color: Color.fromRGBO(178, 142, 22, 1),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        TranslationUtil.text('Trip management'),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          color: Colors.black,
                                          fontSize: AppFonts.smallFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 3),
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      //scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
