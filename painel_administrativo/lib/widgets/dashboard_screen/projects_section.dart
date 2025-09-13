import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/horizontal_missions_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/reusable_card.dart';

class ProjectsSection extends StatefulWidget {
  final List<Map<String, dynamic>> missoes; // NOVO
  const ProjectsSection({super.key, required this.missoes}); // NOVO

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _periodoSelecionado = "semana";
  int _touchedMissionsIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<double> missoesData = widget.missoes.map<double>((e) => (e['pontos'] as num).toDouble()).toList(); // NOVO

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
            Row(
              children: [
                DropdownButton<String>(
                  value: _periodoSelecionado,
                  items: const [
                    DropdownMenuItem(
                      value: "semana",
                      child: Text("Essa semana"),
                    ),
                    DropdownMenuItem(
                      value: "mes",
                      child: Text("Meses"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _periodoSelecionado = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 350,
              width: 1200,
              child: HorizontalMissionsChart(
                data: _periodoSelecionado == "semana"
                    ? [50, 30, 70, 90, 60, 40, 80] // Mock de dados de semana
                    : missoesData, // USANDO OS DADOS REAIS DO SUPABASE
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