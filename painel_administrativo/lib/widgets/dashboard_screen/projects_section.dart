import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/horizontal_missions_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/reusable_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final String _periodoSelecionado = "semana";
  int _touchedMissionsIndex = -1;

  @override
  Widget build(BuildContext context) {

    return ReusableCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Missões concluídas',
                  style: AppStyles.kufam(
                    16,
                    AppStyles.textGrey,
                    AppStyles.semiBold,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 25),

            // Dropdowns comentados (podem ser ativados conforme necessário)
            Row(
              children: [
                // Exemplo de dropdown para período
                // DropdownButton<String>(
                //   value: _periodoSelecionado,
                //   items: const [
                //     DropdownMenuItem(
                //       value: "semana",
                //       child: Text("Essa semana"),
                //     ),
                //     DropdownMenuItem(
                //       value: "mes",
                //       child: Text("Esse mês"),
                //     ),
                //   ],
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() => _periodoSelecionado = value);
                //     }
                //   },
                // ),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              height: 350,
              width: 1200,
              child: HorizontalMissionsChart(
                data: _periodoSelecionado == "semana"
                    ? [50, 30, 70, 90, 60, 40, 80]
                    : [100, 80, 60, 40, 50, 30, 70, 90, 110, 85, 95, 60],
                periodo: _periodoSelecionado,
                touchedIndex: _touchedMissionsIndex,
                onBarTouch: (index) {
                  setState(() => _touchedMissionsIndex = index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
