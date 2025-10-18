import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jawara_pintar_kel_5/constants/constant_colors.dart';
import 'package:moon_design/moon_design.dart';

class PlotBarChart extends StatelessWidget {
  final String title;
  final List<BarChartGroupData> barGroups;
  final Widget Function(double value, TitleMeta meta) getTitlesWidget;
  final Widget? titleTrailing;

  const PlotBarChart({
    super.key,
    required this.title,
    required this.barGroups,
    required this.getTitlesWidget,
    this.titleTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.surface,
        shape: MoonSquircleBorder(
          borderRadius: BorderRadius.circular(12).squircleBorderRadius(context),
        ),
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: MoonTokens.light.typography.heading.text16.copyWith(
                  color: ConstantColors.foreground2,
                ),
              ),
              titleTrailing ?? const SizedBox.shrink(),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 260,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getTitlesWidget,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}K',
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: barGroups,
              ),
              duration: Duration(milliseconds: 150),
              curve: Curves.linear,
            ),
          ),
        ],
      ),
    );
  }
}
