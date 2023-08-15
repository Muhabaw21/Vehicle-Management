import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import '../../../const/constant.dart';
import 'modifyVehicleStatus.dart';
import 'vehicleDetial.dart';

class getvehicleBystatus extends StatefulWidget {
  String? onroute;
  String? route;
  getvehicleBystatus({super.key, this.onroute, required this.route});

  @override
  State<getvehicleBystatus> createState() => _getvehicleBystatusState();
}

class _getvehicleBystatusState extends State<getvehicleBystatus> {
  TextEditingController _searchController = TextEditingController();
  bool valuefirst = false;
  String? plateNumber;
  String query = '';
  List books = [];
  Color borderLeftColor = Colors.red;
  List vehicleStatusList = [];
  List findVehicle = [];
  bool _isLoading = true;
  vehicleFetchbystatus() async {
    try {
      var client = http.Client();
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var response = await http.get(
          Uri.parse(
              'http://164.90.174.113:9090/Api/Vehicle/Owner/Status/${widget.route}'),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        var mapResponse = json.decode(response.body) as Map<String, dynamic>;

        vehicleStatusList = mapResponse['${widget.onroute}'];
        print(vehicleStatusList);
        if ('${widget.route}' == "ONROUTE") {
          borderLeftColor =
              Colors.green; // Update border color based on condition
        } else if ('${widget.route}' == "INSTOCK") {
          borderLeftColor =
              Colors.blue; // Update border color for the else case
        }
        setState(() {
          _isLoading = false;
          vehicleStatusList = vehicleStatusList;
          findVehicle = vehicleStatusList;
        });
        return vehicleStatusList;
      }
    } catch (error) {
      // Handle any errors that occur during the API request
      print('API Error: $error');
    }
  }

  void initState() {
    super.initState();
    vehicleFetchbystatus();
  }

  @override
  void driversSearch(String enterKeyboard) {
    setState(() {
      findVehicle = vehicleStatusList.where((driver) {
        final name = driver['vehicleName'].toLowerCase();

        final plateNumber = driver['plateNumber'].toLowerCase();
        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName) || plateNumber.contains(inputName);
      }).toList();
    });

    setState(() {
      findVehicle = findVehicle;
    });
  }

  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;

  String? phoneNumber;
  void buttonState() {
    setState(() {
      isPressed = !isPressed;
      // Navigator.of(context).pushNamed(AppRoutes.market);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back,
                    color: Colors.white), // Set the color of the icon
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Color.fromRGBO(178, 142, 22, 1),
              title: Container(
                margin: EdgeInsets.only(right: screenWidth * 0.12),
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    onChanged: driversSearch,
                    decoration: const InputDecoration(
                      hintText: 'Driver Name or Plate No.',
                      hintStyle: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: AppFonts.smallFontSize,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
                child: _isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 130),
                        child: Center(child: CircularProgressIndicator()))
                    : Column(
                        children: [
                          if (findVehicle == null || findVehicle.isEmpty)
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
                            Column(
                              children: [
                                Padding(
                                  padding: containerpaddingfordriverandowner,
                                  child: Container(
                                    width: screenWidth,
                                    height: screenHeight * 0.08,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.0),
                                        bottomLeft: Radius.circular(6.0),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                                color: borderLeftColor,
                                                width: 6),
                                          ),
                                        ),
                                        child: Container(
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: screenWidth * 0.25,
                                                child: const Text(
                                                  "Vehicles",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.2,
                                                child: const Text(
                                                  "Driver",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                width: screenWidth * 0.37,
                                                child: const Text(
                                                  " Plate Number",
                                                  textAlign: TextAlign.left,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Nunito',
                                                      fontSize: AppFonts
                                                          .smallFontSize,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                    children: findVehicle.map((vehicle) {
                                  // Define the default border color

                                  if (vehicle['status'] == "ONROUTE") {
                                    borderLeftColor = Colors
                                        .green; // Update border color based on condition
                                  } else if (vehicle['status'] == "INSTOCK") {
                                    borderLeftColor = Colors
                                        .blue; // Update border color for the else case
                                  }
                                  return Container(
                                      height: screenHeight * 0.30,
                                      padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        vehicleDetial(
                                                          id: vehicle['id'],
                                                        )),
                                          );
                                        },
                                        child: Padding(
                                          padding: commanpaddingforallapp,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6.0),
                                              bottomLeft: Radius.circular(6.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color: borderLeftColor,
                                                      width: 6),
                                                ),
                                              ),
                                              child: Container(
                                                height: screenHeight * 0.03,
                                                width: screenHeight,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(3.5),
                                                      bottomLeft:
                                                          Radius.circular(3.5),
                                                    ),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: Offset(0,
                                                            4), // Adjust the offset to control the shadow's position
                                                      ),
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          top: 30,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.25,
                                                              child: Text(
                                                                vehicle[
                                                                    'vehicleName'],
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
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.2,
                                                              child: Text(
                                                                  vehicle[
                                                                      'driverName'],
                                                                  textAlign: TextAlign
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
                                                                              .bold)),
                                                            ),
                                                            Container(
                                                              width:
                                                                  screenWidth *
                                                                      0.35,
                                                              child: Text(
                                                                vehicle[
                                                                    'plateNumber'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                        // fontWeight: FontWeight.bold,
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        fontSize:
                                                                            AppFonts
                                                                                .smallFontSize,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Container(
                                                          height: screenHeight *
                                                              0.03,
                                                          width: screenWidth *
                                                              0.03,
                                                          decoration: BoxDecoration(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      236,
                                                                      240,
                                                                      243,
                                                                      1),
                                                              shape: BoxShape
                                                                  .circle),
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: leftmargin,
                                                          ),
                                                          child: Icon(
                                                            Icons
                                                                .local_shipping,
                                                            color:
                                                                borderLeftColor,
                                                          ),
                                                        )),
                                                    vehicle['status'] ==
                                                            "ONROUTE"
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left:
                                                                      leftmargin,
                                                                ),
                                                                child: Text(
                                                                  vehicle[
                                                                      'status'],
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      fontSize:
                                                                          AppFonts
                                                                              .smallFontSize,
                                                                      color:
                                                                          borderLeftColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : vehicle['status'] ==
                                                                "PARKED"
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left:
                                                                          leftmargin,
                                                                    ),
                                                                    child: Text(
                                                                      vehicle[
                                                                          'status'],
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          fontSize: AppFonts
                                                                              .smallFontSize,
                                                                          color:
                                                                              borderLeftColor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : vehicle['status'] ==
                                                                    "INSTOCK"
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                20,
                                                                            top:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          vehicle[
                                                                              'status'],
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: AppFonts.smallFontSize,
                                                                              color: borderLeftColor,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                leftmargin),
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Text(
                                                                            vehicle['status'],
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: borderLeftColor,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ModifyVehileStatus(
                                                              plateNumber: vehicle[
                                                                  'plateNumber'],
                                                              sttatus: vehicle[
                                                                  'status'],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Container(
                                                          width: screenWidth,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                              color: Colors.grey
                                                                  .shade300, // Border color
                                                              width:
                                                                  2.0, // Border width
                                                            ),
                                                          ),
                                                          height: screenHeight *
                                                              0.04,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                          child: const Center(
                                                            child: Text(
                                                              "Update Status",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
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
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                                }).toList()),
                              ],
                            )
                        ],
                      ))));
    ;
  }
}
