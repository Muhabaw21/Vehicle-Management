import 'package:flutter/material.dart';
import '../../../const/constant.dart';
import '../Vehicle/vehicleStatus.dart';
import 'toggelReport.dart';

class ownerReportstatus extends StatefulWidget {
  String? dailytotal;
  String? weeklytotal;
  String? monthlytotal;
  ownerReportstatus(
      {super.key, this.dailytotal, this.weeklytotal, this.monthlytotal});
  static bool isPressed = true;

  @override
  State<ownerReportstatus> createState() => _ownerReportstatusState();
}

class _ownerReportstatusState extends State<ownerReportstatus> {
  Offset distance = VehicleStatus.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = VehicleStatus.isPressed ? 5.0 : 30.0;

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
            MyScreen(
              time: "Daily",
            ),
            MyScreen(
              time: "Weekly",
            ),
            MyScreen(
              time: "Monthly",
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 4,
                  indicatorPadding: EdgeInsets.all(4),
                  labelColor: Colors.black,
                  indicatorColor: Color.fromRGBO(178, 142, 22, 1),
                  overlayColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
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
                    Container(
                      width: screenWidth * 0.23,
                      child: Tab(
                        icon: Container(
                          child: SizedBox(
                            height: screenHeight * 0.03,
                            width: screenWidth * 0.05,
                          ),
                        ),
                        text: "Daily Report",
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.23,
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
                      width: screenWidth * 0.26,
                      child: Tab(
                        icon: Container(
                          child: SizedBox(
                            height: screenHeight * 0.03,
                            width: screenWidth * 0.05,
                          ),
                        ),
                        text: "Monthly Report",
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
