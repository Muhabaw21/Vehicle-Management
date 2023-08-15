import 'package:bazralogin/const/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


import '../../../../Model/tripManagement.dart';
import 'indicator.dart';
import 'lineCharTitleReport.dart';
import 'pie_chart_section.dart';

class TripChart extends StatefulWidget {
  const TripChart({super.key});

  @override
  State<TripChart> createState() => _TripChartState();
}

class _TripChartState extends State<TripChart> {
  static List<Data> data = [
    Data(status: 'Off Road', hour: 10, color: Color.fromRGBO(238, 2, 2, 1)),
    Data(status: 'On Road', hour: 36, color: Colors.green),
    Data(status: 'Park', hour: 14, color: Colors.blueGrey),
  ];
  int touchedIndex = 0;
  double totalhour = 0;
  List<Data> hours = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            // color: kBackgroundColor,
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        )),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  // color: Color(0xff333333),
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 255, 253, 253),
                      Color.fromARGB(255, 242, 242, 242),
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff515151),
                      offset: Offset(-5.0, 5.0),
                      blurRadius: 1,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: kBackgroundColor,
                      offset: Offset(5.0, -5),
                      blurRadius: 1,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Travel Time",
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            data.isNotEmpty
                                ? "${data.map((e) => e.hour).reduce((value, element) => value + element).toString()}  HOUR"
                                : "0 HOUR",
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          margin: EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text("IN HOUR"),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: IndicatorsWidget(),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.2,
                            margin:
                                EdgeInsets.only(bottom: 15, top: 45, right: 10),
                            child: PieChart(
                              PieChartData(
                                // animationDuration: const Duration(milliseconds: 800),
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,
                                centerSpaceRadius: 45,
                                sections: getSections(touchedIndex),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //line chart
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: App()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
