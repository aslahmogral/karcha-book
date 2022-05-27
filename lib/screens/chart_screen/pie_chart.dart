import 'package:fl_chart/fl_chart.dart';
import 'package:money_manager_app/data/piedata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getSection() => PieData.data 
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final value = PieChartSectionData(
        
        color:  data.color,
        value:  data.percent,
        title: '${data.percent}'
      );
      return MapEntry(index, value);
    })
    .values
    .toList();
