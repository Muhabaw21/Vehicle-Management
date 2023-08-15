import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import '../../Owner/Vehicle/vehicleStatus.dart';
import 'driverReport.dart';

class driverReportstatus extends StatefulWidget {
  driverReportstatus({super.key});
  static bool isPressed = true;

  @override
  State<driverReportstatus> createState() => _driverReportstatusState();
}

class _driverReportstatusState extends State<driverReportstatus> {
  Offset distance = VehicleStatus.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = VehicleStatus.isPressed ? 5.0 : 30.0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(178, 142, 22, 1),
          title: Center(
            child: Container(
                child: Text("Report ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: AppFonts.mediumFontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold))),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [driverReport(), driverReport(), driverReport()],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 15),
          height: screenHeight * 0.09,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorColor: Color.fromRGBO(226, 193, 121, 1),
                  labelPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  overlayColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Color.fromRGBO(226, 193, 121, 1);
                    }
                    if (states.contains(MaterialState.focused)) {
                      return Colors.orange;
                    } else if (states.contains(MaterialState.hovered)) {
                      return Colors.pinkAccent;
                    }

                    return Colors.transparent;
                  }),
                  tabs: [
                    Container(
                      width: screenWidth * 0.24,
                      child: Tab(
                        text: "Daily Report",
                        icon: Container(
                          child: SizedBox(
                            height: screenHeight * 0.03,
                            width: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.24,
                      child: Tab(
                        text: "Weekly Report ",
                        icon: Container(
                          child: SizedBox(
                            height: screenHeight * 0.03,
                            width: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.24,
                      child: Tab(
                        text: " Monthly Report",
                        icon: Container(
                          child: SizedBox(
                            height: screenHeight * 0.03,
                            width: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
