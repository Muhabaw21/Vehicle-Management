import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../const/constant.dart';


class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 60),
      ChartData(2, 70),
      ChartData(3, 75),
      ChartData(4, 80),
      ChartData(5, 85),
      ChartData(6, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(7, 90),
      ChartData(8, 92),
      ChartData(9, 94),
      ChartData(10, 96),
      ChartData(11, 98),
      ChartData(12, 100),
      ChartData(14, 99),
    ];
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff333333),
                  borderRadius: BorderRadius.circular(20),
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
                child: SfCartesianChart(series: <CartesianSeries>[
                  AreaSeries<ChartData, int>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.hr,
                    yValueMapper: (ChartData data, _) => data.kilometerPerHour,
                    borderWidth: 4,
                    xAxisName: 'In Time',
                    yAxisName: "In Kilometer",
                    color: Color.fromRGBO(244, 244, 244, 1),
                    borderGradient: const LinearGradient(colors: <Color>[
                      Color.fromRGBO(230, 0, 180, 1),
                      Color.fromRGBO(255, 200, 0, 1)
                    ], stops: <double>[
                      0.1,
                      0.4
                    ]),
                  )
                ]))));
  }
}

class ChartData {
  ChartData(this.hr, this.kilometerPerHour);
  final int hr;
  final int kilometerPerHour;
}
