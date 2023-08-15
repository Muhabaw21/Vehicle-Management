import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Driver_Detial extends StatefulWidget {
  final int? id;
  Driver_Detial({super.key, this.id});

  @override
  State<Driver_Detial> createState() => _Driver_DetialState();
}

class _Driver_DetialState extends State<Driver_Detial> {
  Map<String, dynamic>? results;
  bool _isLoading = true;
  static final storage = FlutterSecureStorage();

  _getvehiclebyid() async {
    var value = await storage.read(key: 'jwt');
    try {
      var response = await http.get(
          Uri.parse(
              'http://164.90.174.113:9090/Api/Vehicle/Owner/Drivers/All/${widget.id}'),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $value",
          });

      if (response.statusCode == 200) {
        Map<String, dynamic> result = json.decode(response.body);

        print(widget.id);
        setState(() {
          _isLoading = false;
          results = result;
        });
        return results;
      } else {
        print(response.statusCode.toString());
        throw Exception(
            'Failed load data with status code ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    _getvehiclebyid();
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
          title: Text(
            "Driver Detail Information",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
            child: SizedBox(
          child: _isLoading
              ? Container(
                  margin: EdgeInsets.only(top: 130),
                  child: Center(child: CircularProgressIndicator()))
              : Container(
                  height: MediaQuery.of(context).size.height,
                  margin: EdgeInsets.only(top: 10),
                  //height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView(
                    //  physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(8.0),
                    children: <Widget>[
                      Card(
                        elevation: 5,
                        child: ListTile(
                          trailing: Text(
                            results!['driverName'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          title: const Text(
                            "Driver Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.person,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "License Number",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['licenseNumber'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.numbers,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "Vehicle Owner",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['vehicleOwner'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.info,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "License Grade",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['licenseGrade'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.numbers,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text("Gender",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['gender'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text("License Issue Date",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['licenseIssueDate'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text("Plate Number",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!["plateNumber"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text("Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['status'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.info,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "licenseExpireDate",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['licenseExpireDate'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "Capcity",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['capacity'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.calendar_month,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        )));
  }
}
