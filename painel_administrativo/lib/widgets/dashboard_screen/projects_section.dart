import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/horizontal_missions_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/reusable_card.dart';

class ProjectsSection extends StatefulWidget {
  final List<Map<String, dynamic>> missoesMes;
  final List<Map<String, dynamic>> missoesSemana;

  const ProjectsSection({
    super.key,
    required this.missoesMes,
    required this.missoesSemana,
  });

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _periodoSelecionado = "semana";
  int _touchedMissionsIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dadosAtivos =
        _periodoSelecionado == "semana" ? widget.missoesSemana : widget.missoesMes;

    // AQUI ESTÁ A MUDANÇA: Troque 'pontos' por 'qtd_missoes'
    final List<double> missoesData = dadosAtivos
      .map<double>((e) => (e['qtd_missoes'] as num).toDouble())
      .toList();
    
    final List<String> labels = dadosAtivos.map<String>((e) {
      if (_periodoSelecionado == "semana") {
        return e['dia_semana'] as String;
      }
      return e['mes'] as String;
    }).toList();

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
                data: missoesData,
                labels: labels,
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