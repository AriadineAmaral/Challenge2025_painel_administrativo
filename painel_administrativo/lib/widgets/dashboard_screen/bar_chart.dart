import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class BarChartComponent extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double barWidth;
  final int touchedIndex;
  final void Function(int index)? onBarTouch;
  final bool showFixedTitles;

  const BarChartComponent({
    super.key,
    required this.data,
    required this.color,
    required this.barWidth,
    required this.touchedIndex,
    this.onBarTouch,
    this.showFixedTitles = false,
  });

  @override
  Widget build(BuildContext context) {
    final meses = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];

    Widget buildMonthTitle(double value, TitleMeta meta) {
      final int index = value.toInt();
      if (index < 0 || index >= meses.length) return const SizedBox.shrink();

      if (!showFixedTitles) {
        if (value.toInt() == touchedIndex &&
            value.toInt() >= 0 &&
            value.toInt() < meses.length) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 4,
            child: Text(
              meses[value.toInt()],
              style: const TextStyle(fontSize: 10),
            ),
          );
        }
        return const SizedBox.shrink();
      } else {
        if (index == touchedIndex) {
          return SideTitleWidget(
            axisSide: meta.axisSide,
            space: 4,
            child: Text(meses[index], style: const TextStyle(fontSize: 10)),
          );
        } else {
          return const SizedBox.shrink();
        }
      }
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        groupsSpace: 5,
        barGroups: data.asMap().entries.map((entry) {
          final isTouched = entry.key == touchedIndex;
          final barColor = isTouched ? Colors.yellow : color;

          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                color: barColor,
                width: barWidth,
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          );
        }).toList(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: AppStyles.blue.withOpacity(
              0.8,
            ), 
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final value = rod.toY.round(); 
              return BarTooltipItem(
                '$value', 
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
          touchCallback: (event, response) {
            if (response != null &&
                response.spot != null &&
                onBarTouch != null) {
              onBarTouch!(response.spot!.touchedBarGroupIndex);
            }
          },
        ),

        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                if (showFixedTitles) {
                  if (value.toInt() >= 0 && value.toInt() < meses.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(
                        meses[value.toInt()],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                } else {
                  if (value.toInt() == touchedIndex &&
                      value.toInt() >= 0 &&
                      value.toInt() < meses.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      space: 4,
                      child: Text(
                        meses[value.toInt()],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}
