import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../Model/tripManagement.dart';



List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final isTouched = index == touchedIndex;
      final double fontSize = 12;
      final double radius = isTouched ? 35 : 35;

      final value = PieChartSectionData(
        color: data.color,
        value: data.hour,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      return MapEntry(index, value);
    })
    .values
    .toList();
