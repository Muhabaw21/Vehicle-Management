import 'package:bazralogin/const/constant.dart';

import 'package:flutter/material.dart';
import '../report/toggelReport.dart';
import 'activeTrip.dart';
import 'avilabelVehiclefortrip.dart';

class tripHistory extends StatelessWidget {
  tripHistory({super.key});
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            AvailableVehicle(),
            ActiveTrip(),
            MyScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20),
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color.fromRGBO(178, 142, 22, 1),
              labelPadding: EdgeInsets.only(bottom: 0),
              tabs: const [
                Tab(
                  child: Text(
                    "Set Trip",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    "Active Trip",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text('Trip History',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
