

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import '../../../Model/communicationList.dart';
import '../../../Theme/verticalDash.dart';
import '../../../const/constant.dart';

class TotalTrips extends StatefulWidget {
  int? id;
  TotalTrips({super.key, this.id});
  @override
  State<TotalTrips> createState() => _TotalTripsState();
}

class _TotalTripsState extends State<TotalTrips> {
  TextEditingController _searchController = TextEditingController();

  List<Communicationlist> find = [];
  List Result = [];
  List<Communicationlist> profiles = [
    Communicationlist(
      value: false,
      name: " Addisa Ababa",
      Status: "Assigned",
    ),
    Communicationlist(Status: "Assigned", name: " Addisa Ababa ", value: false),
    Communicationlist(Status: "Assigned", name: "Gonder", value: false),
    Communicationlist(Status: "Assigned", name: "Jimmma", value: false),
  ];

  final allchecked = Communicationlist(value: false, name: '', Status: "");
  void initState() {
    super.initState();
    find = profiles;
  }

  OnclickedAll(Communicationlist item) {
    setState(() {
      item.value = !item.value;
    });
  }

  Onclicked(Communicationlist item) {
    final newvalue = !item.value;
    setState(() {
      item.value = !item.value;
      profiles.forEach((element) {
        element.value = newvalue;
      });
    });
  }

  void driversSearch(String enterKeyboard) {
    setState(() {
      this.profiles = find;
    });
    if (enterKeyboard.isEmpty) {
      find = profiles;
    } else {
      final find = profiles.where((driver) {
        final name = driver.name.toLowerCase();

        final inputName = enterKeyboard.toLowerCase();
        final inputLicense = enterKeyboard.toLowerCase();
        return name.contains(inputName);
      }).toList();
      setState(() {
        this.profiles = find;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: kPrimaryColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 5),
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: const Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Driver Name or Plate No.',
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
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10),
              child: IconButton(
                icon: const Icon(
                  Icons.calendar_month,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  children: [],
                ),
                Column(
                  children: Result.map((driver) {
                    return Container(
                      height: screenHeight * 0.22,
                      child: InkWell(
                        onTap: (() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    content: Column(children: [
                                      SizedBox(
                                          width: 300,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('OK')))
                                    ]),
                                  ));
                        }),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.only(left: 0, right: 00),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                            )),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 9),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.trip_origin,
                                              color: kPrimaryColor,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.4,
                                              child: Text(
                                                "From   \n ${driver['startLocation']}",
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: screenWidth * 0.15),
                                      child: SizedBox(
                                        width: screenWidth * 0.27,
                                        child: Text(
                                          "Start date   \n12/2/2022",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 25,
                                    margin: EdgeInsets.only(
                                        right: screenWidth * 0.87, top: 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          child: CustomPaint(
                                              painter:
                                                  DashedLineVerticalPainter(),
                                              size: Size(1, double.infinity)),
                                        ),
                                      ],
                                    )),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              color: kPrimaryColor,
                                            ),
                                            SizedBox(
                                              width: screenWidth * 0.4,
                                              child: Text(
                                                "To \n ${driver['destination']}",
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: screenWidth * 0.15),
                                      child: SizedBox(
                                        width: screenWidth * 0.27,
                                        child: Text(
                                          "End date   \n12/3/2022",
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(left: 5, right: 9),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Container(
                                      height: 1.0,
                                      width: screenWidth * 0.8,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15, bottom: 9),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        // width: screenWidth * 0.4,
                                        child: Icon(
                                          Icons.speed,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenWidth * 0.3,
                                          child: Text(
                                            " 56KM/hr",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: screenWidth * 0.25),
                                        child: Icon(
                                          Icons.timer_sharp,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                          width: screenWidth * 0.20,
                                          child: Text(
                                            " 56hr",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
