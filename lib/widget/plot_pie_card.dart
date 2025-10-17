import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jawara_pintar_kel_5/constants/constant_colors.dart';
import 'package:jawara_pintar_kel_5/models/pie_card_model.dart';
import 'package:moon_design/moon_design.dart';

class PlotPieCard extends StatelessWidget {
  const PlotPieCard({super.key, this.titleTrailing, required this.data});

  final Widget? titleTrailing;

  final List<PieCardModel> data;

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: MoonTokens.light.typography.body.text14.copyWith(
            color: ConstantColors.foreground2,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pemasukan Berdasarkan Kategori',
              style: MoonTokens.light.typography.heading.text16.copyWith(
                color: ConstantColors.foreground2,
              ),
            ),
            titleTrailing ?? const SizedBox.shrink(),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sections: data.map((e) => e.data).toList(),
              centerSpaceRadius: 18,
              sectionsSpace: 4,
            ),
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data
              .map((e) => _buildLegendItem(e.color, e.label))
              .toList(),
        ),
      ],
    );
  }
}
