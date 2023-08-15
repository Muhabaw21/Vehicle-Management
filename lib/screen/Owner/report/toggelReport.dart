import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../const/constant.dart';
import 'alertComponet/alertComponetforowner.dart';
import 'tripReport/tripReport.dart';
import 'workComponent/workComponent.dart';

class MyScreen extends StatefulWidget {
  String? time;
  MyScreen({this.time});
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool showList = false;
  bool showList1 = false;
  bool showList2 = false;
  dynamic fetchedData;
  String? endDate;
  String? startdate;

  final ScrollController _scrollController = ScrollController();
  List<String> yourList = [];
  // Your initial list of data
  List filteredDataList = [];
  dynamic workData;
  bool _isLoading = true;
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
      // workComponentforowner(
      //   data: mydata,
      // );
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
          'http://164.90.174.113:9090/Api/Vehicle/Alerts/ByStatus',
        ),
        headers: requestHeaders);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final mydata = data["inactiveAlerts"];
      List results = [];
      String? Daily = "Daily";
      String? Weekly = "Weekly";
      if (Daily == "${widget.time}") {
        var output = <String>[];
        DateTime startDate =
            DateTime.parse(DateFormat('yyyy-MM-dd HH').format(DateTime.now()));
        DateTime endDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 24))));
        for (var i = 0; i < mydata.length; i += 1) {
          DateTime date = DateTime.parse(mydata[i]["alertstart"]);
          int filteredData = date.compareTo(endDate);
          if (filteredData > 0) {
            filteredDataList.add(mydata[i]);
            print(mydata[i]["alertstart"]);
          }
        }

        setState(() {
          fetchedData = filteredDataList;
          _isLoading = false;
        });
        alertComponentforowner(
          data: filteredDataList,
          startdate: endDate,
          enddate: startDate,
        );
      } else if (Weekly == "${widget.time}") {
        var output = <String>[];
        DateTime startDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 24))));
        DateTime endDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 168))));
        for (var i = 0; i < mydata.length; i += 1) {
          DateTime date = DateTime.parse(mydata[i]["alertstart"]);
          int filteredData = date.compareTo(endDate);
          int filteredData1 = date.compareTo(startDate);
          if (filteredData > 0 && filteredData1 < 0) {
            filteredDataList.add(mydata[i]);

            print(mydata[i]["alertstart"]);
          }
        }

        setState(() {
          fetchedData = filteredDataList;
          _isLoading = false;
        });
        alertComponentforowner(
          data: filteredDataList,
          enddate: startDate,
          startdate: endDate,
        );
      } else {
        var output = <String>[];
        DateTime startDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 720))));
        DateTime endDate = DateTime.parse(DateFormat('yyyy-MM-dd HH')
            .format(DateTime.now().subtract(Duration(hours: 169))));
        for (var i = 0; i < mydata.length; i += 1) {
          DateTime date = DateTime.parse(mydata[i]["alertstart"]);
          int filteredData = date.compareTo(endDate);
          int filteredData1 = date.compareTo(startDate);
          if (filteredData1 > 0 && filteredData < 0) {
            filteredDataList.add(mydata[i]);
            print(mydata[i]["alertstart"]);
          }
        }

        setState(() {
          fetchedData = filteredDataList;
          _isLoading = false;
        });
        alertComponentforowner(
          data: filteredDataList,
          enddate: startDate,
          startdate: endDate,
        );
      }
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
      showList1 = !showList1;
    });
  }

  void toggleVisibility2() {
    setState(() {
      showList2 = !showList2;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      fetchData();
    }
  }

  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchData();
    workReport();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
        title: Container(
          child: Text(
            "Report",
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: AppFonts.mediumFontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                          : workComponentforowner(
                              data: workData,
                            )),
                  //work report
                  Container(
                      height: screenHeight,
                      child: fetchedData == null
                          ? Container()
                          : alertComponentforowner(
                              data: fetchedData,
                              enddate: endDate,
                              startdate: startdate,
                            )

                      //
                      )
                ],
              ),
      ),
    );
  }
}
