import 'package:bazralogin/controller/Localization.dart';

import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

import 'DriverStatus.dart';
import 'OwnersDriver.dart';
import 'UnassignedDrivers.dart';
import 'driversRegistrationForm.dart';

class communicate_screen extends StatelessWidget {
  const communicate_screen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(178, 142, 22, 1),
        title: Text(
          "Driver page",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.white), // Set the color of the icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => UnassignedDrivers()));
                  },
                  child: Container(
                    // Height of the border
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 255, 255, 1)
                              .withOpacity(0.8), // Shadow color
                          blurRadius: 10, // Spread radius
                          offset: Offset(0, -3), // Offset in (x,y) coordinates
                        ),
                      ],
                    ),

                    child: PhysicalModel(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      // elevation: 3,
                      child: Container(
                        height: screenHeight * 0.07,
                        width: screenWidth - 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(8),
                        )),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Assign driver",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => DriverStatus()));
                  },
                  child: Container(
                    height: screenHeight * 0.07,
                    width: screenWidth - 24,
                    // Height of the border

                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.8), // Shadow color
                          blurRadius: 12, // Spread radius
                          offset:
                              Offset(0, -1.7), // Offset in (x,y) coordinates
                        ),
                      ],
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: PhysicalModel(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      // elevation: 3,
                      child: Container(
                        padding: EdgeInsets.all(6.0),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Manage driver",
                              style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DriversFormOwner()));
                      },
                      child: PhysicalModel(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        // elevation: 3,
                        child: Container(
                          height: screenHeight * 0.07,
                          width: screenWidth - 24,
                          // Height of the border

                          child: Container(
                            padding: EdgeInsets.all(6.0),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Register driver",
                                  style: TextStyle(
                                    fontFamily: "Nunito",
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
