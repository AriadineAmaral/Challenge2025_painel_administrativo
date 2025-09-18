import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class HorizontalMissionsChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final String periodo;
  final int touchedIndex;
  final void Function(int index)? onBarTouch;

  const HorizontalMissionsChart({
    super.key,
    required this.data,
    required this.labels,
    required this.periodo,
    required this.touchedIndex,
    this.onBarTouch,
  });

  @override
  Widget build(BuildContext context) {
    // CORREÇÃO: Verifica se a lista de dados está vazia
    if (data.isEmpty) {
      return const Center(
        child: Text(
          "Nenhum dado de missões concluídas encontrado para este período.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppStyles.textGrey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    final maxValue = (data.reduce((a, b) => a > b ? a : b) * 1.2);

    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: maxValue,
          barGroups: data.asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value;
            final isTouched = index == touchedIndex;
            final barColor = isTouched ? AppStyles.yellow : AppStyles.blue;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: barColor,
                  width: 15,
                  borderRadius: BorderRadius.circular(8),
                ),
              ],
            );
          }).toList(),
          barTouchData: BarTouchData(
            enabled: true,
            touchCallback: (event, response) {
              if (response != null &&
                  response.spot != null &&
                  onBarTouch != null) {
                onBarTouch!(response.spot!.touchedBarGroupIndex);
              }
            },
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: AppStyles.textPurple,
              tooltipRoundedRadius: 8,
              tooltipPadding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 8,
              ),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                if (group.x != touchedIndex) {
                  return null;
                }
                return BarTooltipItem(
                  '${data[groupIndex].toInt()}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                interval: 1.0,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx >= 0 && idx < labels.length) {
                    return RotatedBox(
                      quarterTurns: -1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          labels[idx],
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: maxValue / 5,
                getTitlesWidget: (value, meta) {
                  if (value < 0) return const SizedBox.shrink();
                  return RotatedBox(
                    quarterTurns: -1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(
            show: false,
            drawHorizontalLine: true,
            horizontalInterval: maxValue / 3,
            getDrawingHorizontalLine: (value) =>
                FlLine(color: Colors.grey, strokeWidth: 1),
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: false),
        ),
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }
}