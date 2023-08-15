import 'package:flutter/material.dart';

import '../../../../const/constant.dart';



class CarHistory extends StatelessWidget {
  const CarHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 0),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 70, top: 15, bottom: 6, right: 70),
                child: Text("History",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: kPrimaryColor,
                    )),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      // BoxShadow(
                      //     // blurRadius: 15,
                      //     // spreadRadius: 1,
                      //     // offset: Offset(-4, -4),
                      //     // color: Colors.grey[500]!,
                      //     )
                    ]),
                    height: MediaQuery.of(context).size.height * 0.20,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 8,
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      " Discription",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 100, right: 40),
                              child: Row(
                                children: [
                                  Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      child: Text(
                                        "VehicleID",
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Text(
                                      "1111",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 100, right: 40),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Text(
                                      "Vehicle owner",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      "Bazra motors",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 100, right: 40),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Text(
                                      "Plate number",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      "1113",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 100, right: 40),
                              child: Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.27,
                                    child: Text(
                                      "Vehicle type",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    child: Text(
                                      "Sinotrack",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height * 0.29,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Card(
                  elevation: 8,
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                " Current status",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 32,
                              color: Colors.lightBlue,
                              margin: EdgeInsets.only(
                                  left: 85, right: 70, top: 0, bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  " Onroute",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                " History",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80, right: 40),
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Text(
                                "Start Date",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                "1111",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80, right: 40),
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Text(
                                "Start from",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                "Addisa Ababa",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80, right: 40),
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Text(
                                "Total time travel",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                "1113",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80, right: 40),
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Text(
                                "Total  kilometer",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                "123km/hr",
                                style: TextStyle(fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 80, right: 40),
                              width: MediaQuery.of(context).size.width * 0.27,
                              child: Text(
                                "Current locations",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Text(
                                "Dire  Dawa",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
