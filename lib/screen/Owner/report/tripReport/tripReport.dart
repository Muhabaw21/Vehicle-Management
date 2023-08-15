import 'package:bazralogin/Model/tripManagement.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../Theme/clippbox.dart';
import '../../../../const/constant.dart';

class tripComponentforowner extends StatefulWidget {
  @override
  State<tripComponentforowner> createState() => _tripComponentforownerState();
}

class _tripComponentforownerState extends State<tripComponentforowner> {
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
                                    "Trip Report",
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
                                    Text("Trip Report",
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
                                  width: screenWidth * 0.08,
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
                                      width: 20,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: screenWidth * 0.35,
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("12/22/2050",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: AppFonts.smallFontSize,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal))),
                                SizedBox(
                                    width: screenWidth * 0.35,
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
                        height: screenHeight - 30,
                        child: ListView.custom(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          childrenDelegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    width: double.infinity,
                                    child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(6.0),
                                                bottomLeft:
                                                    Radius.circular(6.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    left: BorderSide(
                                                        color: Colors.blue,
                                                        width: 6),
                                                  ),
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.8),
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset: Offset(0,
                                                              4), // Adjust the offset to control the shadow's position
                                                        ),
                                                      ]),
                                                  height: screenHeight * 0.23,
                                                  margin: EdgeInsets.zero,
                                                  width: screenWidth - 22,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          width: screenWidth,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
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
                                                                        child: Text(
                                                                            "Driver",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal))),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Alex",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal)))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.3,
                                                                        child: Text(
                                                                            "Plate Number",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal))),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Sodo (Wolaita Sodo)",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal)))
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.3,
                                                                        child: Text(
                                                                            "Alert Type",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal))),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Off Road",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal)))
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
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal))),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                      width: screenWidth *
                                                                          0.35,
                                                                      child: Text(
                                                                          "12/2/2022",
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: AppFonts.smallFontSize,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.normal)),
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
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal))),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                      width: screenWidth *
                                                                          0.35,
                                                                      child: Text(
                                                                          "12/2/2023",
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style: TextStyle(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: AppFonts.smallFontSize,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.normal)),
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
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal))),
                                                                    SizedBox(
                                                                      width: screenWidth *
                                                                          0.08,
                                                                    ),
                                                                    Container(
                                                                        width: screenWidth *
                                                                            0.35,
                                                                        child: Text(
                                                                            "Addisa Ababa",
                                                                            textAlign: TextAlign
                                                                                .left,
                                                                            style: TextStyle(
                                                                                fontFamily: 'Nunito',
                                                                                fontSize: AppFonts.smallFontSize,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal)))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))),
                              );
                            },
                            childCount: 2,
                          ),
                        ),
                      ),
                    ],
                  )),
          // Add more containers as needed
        ],
      ),
    );
  }
}
