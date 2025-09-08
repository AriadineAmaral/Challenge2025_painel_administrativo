import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:fl_chart/fl_chart.dart'; // Importe para usar o PieChart

class EngagementChart extends StatelessWidget {
  final int percentage;
  final Color color; 
  final Color
  textColor; 

  const EngagementChart({
    super.key,
    required this.percentage,
    required this.color,
    this.textColor = AppStyles.white
  });

  @override
  Widget build(BuildContext context) {
    final AppStyles appStyles = AppStyles();
    return SizedBox(
      width: 100, // tamanho circulo
      height: 100, // tananho circulo
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 50, // Tamanho do "buraco" central
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: color, // Cor do progresso 
                  value: percentage.toDouble(),
                  radius: 12, // Espessura da fatia
                  title: '',
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ), 
                ),
                PieChartSectionData(
                  color: AppStyles.grey2, 
                  value: 100 - percentage.toDouble(),
                  radius: 12, 
                  title: '',
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$percentage%',
            style: appStyles.kronaOne(
              24,
              textColor,
              AppStyles.bold,
            ), 
          ),
        ],
      ),
    );
  }
}
