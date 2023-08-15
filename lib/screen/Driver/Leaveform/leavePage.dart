import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../const/constant.dart';
class leavepremmissionPage extends StatefulWidget {
  leavepremmissionPage({required this.title});
  final String title;
  @override
  _leavepremmissionPageState createState() => _leavepremmissionPageState();
}

class _leavepremmissionPageState extends State {
  List findVehicle = [];
  String? selectedType;
  List<String> type = [
    "Vaction",
    "Quitting",
    "Sick",
    "Other",
  ];
    TextEditingController _endDate = TextEditingController();
  TextEditingController _startDate = TextEditingController();

  Future<void> endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _endDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    var currentTime = new DateTime(now.day, now.hour);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 1,
        leading: Container(
          margin: EdgeInsets.only(top: 5),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(178, 142, 22, 1),
        title: Container(
          margin: EdgeInsets.only(left: screenWidth * 0.15),
          child: const Text(
            "Leave Request For ",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: AppFonts.mediumFontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.35,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Color.fromRGBO(236, 240, 243, 1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          width: 2.5,
                        ),
                      ),
                      width: screenWidth * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text("Start Date")),
                            TextFormField(
                              controller: _startDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Select start date",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => startDate(context),
                                ),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text("End Date")),
                            TextFormField(
                              controller: _endDate,
                              readOnly: true,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Select end date",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.calendar_today),
                                  onPressed: () => endDate(context),
                                ),
                                labelStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.normal,
                                ),
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 1),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 10),
              padding: const EdgeInsets.all(9),
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3), // Shadow color
                      blurRadius: 5, // Spread radius
                      offset: Offset(0, 3), // Offset in (x,y) coordinates
                    ),
                  ],
                  color: Color.fromRGBO(236, 240, 243, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(
                        255, 255, 255, 1), // Set the border color
                    width: 2.5,
                  )),
              child: ListView.builder(
                itemCount: type.length,
                itemBuilder: (BuildContext context, int index) {
                  return RadioListTile(
                    title: Text(type[index]),
                    value: type[index],
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3), // Shadow color
                          blurRadius: 5, // Spread radius
                          offset: Offset(0, 3), // Offset in (x,y) coordinates
                        ),
                      ],
                      color: Color.fromRGBO(236, 240, 243, 1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromRGBO(
                            255, 255, 255, 1), // Set the border color
                        width: 2.5,
                      )),
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: const Text(
                            "Leave Request",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: AppFonts.smallFontSize,
                                color: Colors.black,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
