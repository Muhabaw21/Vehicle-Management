import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import '../../../../Model/driverCount.dart';

import '../Communication/communicationPage.dart';
import '../Vehicle/TotalVehicles.dart';

import '../communication/Communication.dart';
import 'getAlertStatus.dart';

class AlertType extends StatelessWidget {
  AlertType({super.key});
  static bool isPressed = true;
  Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
  double blur = isPressed ? 5.0 : 30.0;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: TabBarView(
          children: [
            getAlertStatus(alertType: 'OFFROAD', alertList: 'alertTypes'),
            getAlertStatus(alertType: 'ACCIDENT', alertList: 'alerts'),
            getAlertStatus(alertType: 'DRIVER', alertList: 'alerts'),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Container(
            child: TabBar(
              isScrollable: false,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.all(4),
              indicatorColor: Colors.white,
              overlayColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.blue;
                }
                if (states.contains(MaterialState.focused)) {
                  return Colors.orange;
                } else if (states.contains(MaterialState.hovered)) {
                  return Colors.pinkAccent;
                }
                return Colors.transparent;
              }),
              tabs: [
                Tab(
                  text: "Driver",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.blue[400],
                    child: Text(
                      CountDrivers.totalAssigned.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: "Off Road ",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.blue[400],
                    child: Text(
                      CountDrivers.totalOnroute.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
                Tab(
                  text: "Accident",
                  icon: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.blue[400],
                    child: Text(
                      CountDrivers.totalAssigned.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), //Text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
