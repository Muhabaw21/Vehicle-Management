import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../const/constant.dart';
import 'alertComponent/alertcomponent.dart';

import 'workComponent/workComponent.dart';

class driverReport extends StatefulWidget {
  @override
  _driverReportState createState() => _driverReportState();
}

class _driverReportState extends State<driverReport> {
  bool showList = false;
  bool _isLoading = true;
  bool showList1 = true;
  bool showList2 = false;
  dynamic fetchedData;
  dynamic workData;

  //  fetch work report
  workReport() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
          'http://164.90.174.113:9090/Api/Driver/All/Cargos/FINISHED',
        ),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mydata = data["cargos"];
      setState(() {
        workData = mydata;
        _isLoading = false;
      });
      workComponentfordriver(
        data: mydata,
      );
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  fetchData() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
        Uri.parse(
          'http://164.90.174.113:9090/Api/Driver/Alerts/ByStatus',
        ),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mydata = data["inactiveAlerts"];
      setState(() {
        fetchedData = mydata;
        _isLoading = false;
      });
      alertComponent(
        data: mydata,
      );
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  void toggleVisibility() {
    setState(() {
      showList = !showList;
    });
  }

  void toggleVisibility1() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void toggleVisibility2() {
    setState(() {
      showList2 = !showList2;
    });
  }

  bool isVisible = false;

  void initState() {
    super.initState();
    fetchData();
    workReport();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: _isLoading
            ? Center(
                child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.2),
                child: LoadingAnimationWidget.hexagonDots(
                  size: 100,
                  color: Color.fromRGBO(178, 142, 22, 1),
                ),
              ))
            : Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),

                  // alert report
                  Container(
                      child: workData == null
                          ? Container()
                          : workComponentfordriver(
                              data: workData,
                            )),
                  //work report
                  Container(
                      height: screenHeight,
                      child: fetchedData == null
                          ? Container()
                          : alertComponent(
                              data: fetchedData,
                            )

                      //
                      )
                ],
              ),
      ),
    );
  }
}
