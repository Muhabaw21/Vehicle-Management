import 'package:bazralogin/Model/tripManagement.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Theme/clippbox.dart';
import '../../../../const/constant.dart';

class alertComponentforowner extends StatefulWidget {
  final List<dynamic> data;

  final startdate;
  final enddate;
  
  alertComponentforowner({
    required this.data,
    required this.startdate,
    required this.enddate,
 
  });

  @override
  State<alertComponentforowner> createState() => _alertComponentforownerState();
}

class _alertComponentforownerState extends State<alertComponentforowner> {
  bool isVisible = true;
  void toggleVisibility1() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          isVisible
              ? GestureDetector(
                  onTap: toggleVisibility1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: screenHeight * 0.2,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0,
                                4), // Adjust the offset to control the shadow's position
                          ),
                        ],
                      ),
                      child: Center(
                          child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: screenWidth * 0.34),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Alert Report",
                                  ))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 20,
                                width: screenWidth * 0.08,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.trip_origin,
                                  color: Colors.green,
                                  size: 10,
                                ),
                              ),
                              CustomPaint(
                                size: Size(screenWidth * 0.2, 2),
                                painter: DashLinePainter(),
                              ),
                              Container(
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.07,
                                child: Icon(
                                  Icons.local_shipping,
                                  color: Colors.red,
                                  size: 23,
                                ),
                              ),
                              CustomPaint(
                                size: Size(screenWidth * 0.2, 2),
                                painter: DashLinePainter(),
                              ),
                              SizedBox(
                                  width: screenWidth * 0.2,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 2),
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.trip_origin,
                                          color: Colors.red,
                                          size: 10,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: screenWidth * 0.36,
                                  child: Text("12/2/220")),
                              SizedBox(
                                width: screenWidth * 0.15,
                              ),
                              SizedBox(
                                  width: screenWidth * 0.2,
                                  child: Text("1/22/2022",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: AppFonts.smallFontSize,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))),
                            ],
                          ),
                        ],
                      )),
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: toggleVisibility1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          height: screenHeight * 0.1,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Alert Report",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: AppFonts.smallFontSize,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                  CustomPaint(
                                    size: Size(screenWidth * 0.25, 2),
                                    painter: DashLinePainter(),
                                  ),
                                  CustomPaint(
                                    size: Size(screenWidth * 0.25, 2),
                                    painter: DashLinePainter(),
                                  ),
                                  SizedBox(
                                      child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        decoration: BoxDecoration(),
                                        child: Icon(
                                          Icons.calendar_month,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width: screenWidth * 0.37,
                                      child: Text("12/22/2050",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: AppFonts.smallFontSize,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal))),
                                  SizedBox(
                                      width: screenWidth * 0.37,
                                      child: Text("12/2/2050",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Nunito',
                                              fontSize: AppFonts.smallFontSize,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal))),
                                ],
                              ),
                            ],
                          )),
                        ),
                        Container(
                          height: screenHeight - 134,
                          child: Column(
                              children: widget.data.map((vehicle) {
                            return Container(
                                width: double.infinity,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          height: screenHeight * 0.2,
                                          margin: EdgeInsets.zero,
                                          width: screenWidth - 22,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(6.0),
                                              bottomLeft: Radius.circular(6.0),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                      color: Colors.blue,
                                                      width: 6),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text("Driver",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.08,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                vehicle[
                                                                    'driver'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)))
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                "Plate Number")),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.08,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                vehicle[
                                                                    'plateNumber'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)))
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                "Alert Type",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.08,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                vehicle[
                                                                    'alertType'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)))
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                "Start Time",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.08,
                                                        ),
                                                        Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(
                                                              vehicle[
                                                                  'alertstart'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                "End Time",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.08,
                                                        ),
                                                        Container(
                                                          width: screenWidth *
                                                              0.35,
                                                          child: Text(
                                                              vehicle[
                                                                  'alertfinish'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  fontSize: AppFonts
                                                                      .smallFontSize,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                "Alert Location",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal))),
                                                        SizedBox(
                                                          width: screenWidth *
                                                              0.08,
                                                        ),
                                                        Container(
                                                            width: screenWidth *
                                                                0.35,
                                                            child: Text(
                                                                vehicle[
                                                                    "alertocation"],
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    fontSize:
                                                                        AppFonts
                                                                            .smallFontSize,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )));
                          }).toList()),
                        ),
                      ],
                    ),
                  )),
          // Add more containers as needed
        ],
      ),
    );
  }
}
