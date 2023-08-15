import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bazralogin/const/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Communication.dart';
import 'communicationHistory.dart';

class Communication extends StatefulWidget {
  Communication({super.key});
  static bool isPressed = true;

  @override
  State<Communication> createState() => _CommunicationState();
}

class _CommunicationState extends State<Communication> {
  DateTime? currentBackPressTime;

  Offset distance = Communication.isPressed ? Offset(10, 10) : Offset(28, 28);

  double blur = Communication.isPressed ? 5.0 : 30.0;

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              Duration(seconds: 2)) {
        // Show a Snackbar at the bottom indicating to press back again to exit

        currentBackPressTime = DateTime.now();
        return true; // Stop the default back button event
      } else {
        // Close the app when back button is pressed again
        SystemNavigator.pop();
        return true; // Stop the default back button event
      }
    } else {
      Navigator.pop(context); // Navigate back to the home page
      return true; // Stop the default back button event
    }
  }

  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            CommunicationPage(),
            communicationHistory(),
          ],
        ),
        bottomNavigationBar: Container(
          height: screenHeight * 0.08,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Container(
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.only(bottom: 10),
              tabs: const [
                Tab(
                  child: Text(
                    "Communicate Driver",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Tab(
                  child: Text(
                    "Communication History",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
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
