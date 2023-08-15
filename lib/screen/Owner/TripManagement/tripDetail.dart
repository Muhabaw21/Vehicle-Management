import 'dart:convert';
import 'package:bazralogin/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TripDetail extends StatefulWidget {
  final int? id;
  TripDetail({super.key, this.id});

  @override
  State<TripDetail> createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  Map<String, dynamic>? results;

  static final storage = FlutterSecureStorage();
  bool _isLoading = true;
  _getvehiclebyid() async {
    var value = await storage.read(key: 'jwt');
    try {
      var response = await http.get(
          Uri.parse('http://164.90.174.113:9090/Api/Admin/Trip/${widget.id}'),
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
            title: Text(
              "Active trip detial ",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: AppFonts.mediumFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromRGBO(178, 142, 22, 1)),
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
                            results!['plateNumber'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          title: const Text(
                            "Plate Number",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            MdiIcons.carBack,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "Current Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['currentLocation'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            MdiIcons.carBack,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Card(
                        elevation: 5,
                        child: ListTile(
                          title: const Text(
                            "Start Location",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['startLocation'].toString(),
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
                            "Destination",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          trailing: Text(
                            results!['destination'].toString(),
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
                          title: const Text("Trip type",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['tripType'].toString(),
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
                          title: const Text("Status",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 15)),
                          trailing: Text(
                            results!['status'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                          leading: const Icon(
                            Icons.info_rounded,
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
