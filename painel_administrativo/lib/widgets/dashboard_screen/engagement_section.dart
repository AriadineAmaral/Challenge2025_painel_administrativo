import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/bar_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/engagement_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/reusable_card.dart';

class EngagementSection extends StatefulWidget {
  const EngagementSection({super.key});

  @override
  State<EngagementSection> createState() => _EngagementSectionState();
}

class _EngagementSectionState extends State<EngagementSection> {
  int _mesSelecionadoIndex = -1;
  int _projetoSelecionadoIndex = -1;
  int _engajamentoGeralIndex = -1;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primeiro Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ReusableCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Engajamento geral\npor colaborador',
                          style: AppStyles.kufam(
                            14,
                            AppStyles.textGrey,
                            AppStyles.medium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  EngagementChart(
                                    percentage: 65,
                                    color: AppStyles.blue,
                                    textColor: AppStyles.blue,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 1,
                                ),
                                child: BarChartComponent(
                                  data: [5, 6, 8, 7, 9, 10, 8, 7, 9, 8, 7, 9],
                                  color: AppStyles.blue,
                                  barWidth: 6,
                                  touchedIndex: _mesSelecionadoIndex,
                                  onBarTouch: (index) {
                                    setState(() {
                                      _mesSelecionadoIndex = index;
                                    });
                                  },
                                  showFixedTitles: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Segundo Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ReusableCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Inscrições em projetos',
                          style: AppStyles.kufam(
                            14,
                            AppStyles.textGrey,
                            AppStyles.medium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: BarChartComponent(
                            data: [5, 6, 8, 7, 9, 10, 8, 7, 9, 8, 8, 7],
                            color: AppStyles.grey,
                            barWidth: 21,
                            touchedIndex: _projetoSelecionadoIndex,
                            onBarTouch: (index) {
                              setState(() {
                                _projetoSelecionadoIndex = index;
                              });
                            },
                            showFixedTitles: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Terceiro Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ReusableCard(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        EngagementChart(
                          percentage: 85,
                          color: AppStyles.yellow,
                          textColor: Colors.black,
                        ),
                        const SizedBox(height: 28),
                        Text(
                          'Engajamento geral\nde colaboradores',
                          style: AppStyles.kufam(
                            14,
                            Colors.black,
                            AppStyles.medium,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 150,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: BarChartComponent(
                            data: [5, 6, 8, 7, 9, 10, 8, 7, 9, 8, 9, 8],
                            color: AppStyles.blue,
                            barWidth: 8,
                            touchedIndex: _engajamentoGeralIndex,
                            onBarTouch: (index) {
                              setState(() {
                                _engajamentoGeralIndex = index;
                              });
                            },
                            showFixedTitles: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
