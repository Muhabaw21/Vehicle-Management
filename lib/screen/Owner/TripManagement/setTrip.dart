import 'dart:convert';
import 'package:bazralogin/Theme/Alert.dart';
import 'package:bazralogin/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import '../../../../Theme/TextInput.dart';
import '../../../../config/APIService.dart';

class Settrips extends StatefulWidget {
  String? drivername;
  String? platenumber;

  String? startLocation;
  String? destination;
  String? startDate;
  String? tripType;
  Settrips(
      {super.key,
      this.drivername,
      this.platenumber,
      this.startLocation,
      this.destination,
      this.startDate,
      this.tripType});

  @override
  State<Settrips> createState() => _SettripsState();
}

class _SettripsState extends State<Settrips> {
  TextEditingController dateStart = TextEditingController();
  TextEditingController vehicleplate = TextEditingController();
  TextEditingController driver = TextEditingController();
  TextEditingController Startlocation = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController tripType = TextEditingController();

  TextEditingController triptype = TextEditingController();

  String? selectedItem = 'Single Trip';
  String? startPlace;
  String? endPlace;
  List Result = [];
  String? trip;
  bool isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void performAction() {
    setState(() {
      isLoading = true;
    });

    // Simulate an asynchronous action
    Future.delayed(Duration(seconds: 15), () async {
      try {
        final storage = new FlutterSecureStorage();
        var value = await storage.read(key: 'jwt');

        Map data = {
          "vehicle": "${widget.platenumber}",
          "startLocation": "Addisa Ababa",
          "destination": "jimma",
          "startDate": "${dateStart.text}",
          "tripType": "$trip"
        };

        var response = await http.post(Uri.parse(ApIConfig.creatTrip),
            body: jsonEncode(data) as String,
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
              "Authorization": "Bearer $value",
            });

        if (response.statusCode == 200) {
          var decodedResponse = json.decode(response.body);
          String alertContent = decodedResponse["message"];
          alertutils.showMyDialog(context, "Alert", alertContent);
        } else {
          var decodedResponse = json.decode(response.body);
          String alertContent = decodedResponse["message"];

          alertutils.showMyDialog(context, "Alert", alertContent);
          setState(() {
            isLoading = true;
          });
        }
      } catch (e) {
        print(e);
        throw e;
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  void initState() {
    // super.initState();
    String apikey = "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc";
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    String? selectedItem = 'Select trip';
    List<String> items = ['SHORT', 'LONG', "Select trip"];
    print("${dateStart.text}");
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
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
          title: const Text(
            " Set Trip",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: AppFonts.mediumFontSize,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.9,
                  margin: EdgeInsets.only(top: screenHeight * 0.04),
                  child: Column(children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: screenWidth * 0.04),
                            child: Text(
                              "Select trip",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth - 36,
                                child: DropdownButtonFormField<String>(
                                  decoration:
                                      ThemeHelper().textInputDecoration(),
                                  value: selectedItem,
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          )))
                                      .toList(),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter  Plate Number';
                                    }
                                  },
                                  onChanged: (item) {
                                    setState(() {
                                      selectedItem = item;
                                      tripType.text = selectedItem.toString();
                                      trip = tripType.text;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          "Driver name",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: screenWidth,
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(
                              text: "${widget.drivername} "),
                          decoration: ThemeHelper().textInputDecoration(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          "Plate Number",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: screenWidth,
                          child: TextField(
                            enabled: false,
                            controller: TextEditingController(
                              text: "${widget.platenumber}",
                            ),
                            decoration: ThemeHelper().textInputDecoration(),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          "Start Date",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          width: screenWidth,
                          child: TextField(
                            controller: dateStart,
                            onTap: () async {
                              DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime(2101));
                              if (pickDate != null) {
                                dateStart.text =
                                    DateFormat('yyyy-MM-dd').format(pickDate);
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Choose Start Date',
                              suffixIcon: Icon(
                                Icons.calendar_month,
                                color: Colors.black,
                              ),
                              hintStyle: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2, color: Colors.grey.shade400),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey.shade400,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              fillColor: Colors.white,
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          "Start Locations",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: placesAutoCompleteTextField(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.04),
                        child: Text(
                          "End Location",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      child: endAutoCompleteTextField(),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(screenWidth * 0.53, 20, 0, 0),
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                          onPressed: isLoading ? null : performAction,
                          child: Container(
                            height: 55,
                            width: screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                isLoading
                                    ? SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      )
                                    : SizedBox(), // Empty SizedBox if not loading
                                SizedBox(width: 8),
                                Text(
                                  isLoading ? 'Please Wait' : 'Set Trip',
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Color.fromRGBO(255, 148, 165, 223);
                                }
                                // 98, 172, 181
                                return Color.fromRGBO(178, 142, 22, 1);
                              }),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(6))))),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ));
  }

  placesAutoCompleteTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width - 32,
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: startController,
          googleAPIKey: "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc",
          debounceTime: 800,
          inputDecoration: ThemeHelper().textInputDecoration('Start Location'),
          countries: ["er", "et"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
          },
          itmClick: (Prediction prediction) {
            setState(() {
              startController.text = prediction.description!;

              startController.selection = TextSelection.fromPosition(
                  TextPosition(offset: prediction.description!.length));
              startPlace = startController.text;
            });
          }
          // default 600 ms ,
          ),
    );
  }

  endAutoCompleteTextField() {
    return Container(
      // margin: EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width - 32,

      child: GooglePlaceAutoCompleteTextField(
          textEditingController: endController,
          googleAPIKey: "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc",
          debounceTime: 800,
          inputDecoration: ThemeHelper().textInputDecoration('End Location'),
          countries: ["er", "et"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
          },
          itmClick: (Prediction prediction) {
            endController.text = prediction.description!;

            endController.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description!.length));
            endPlace = endController.text;
          }
          // default 600 ms ,
          ),
    );
  }
}
