import 'package:fl_chart/fl_chart.dart' show PieChartSectionData;
import 'package:flutter/material.dart' show Color, Colors;

class PieCardModel {
  final PieChartSectionData data;
  final String label;
  Color color;
  PieCardModel({
    required this.data,
    required this.label,
    this.color = Colors.green,
  });
}
