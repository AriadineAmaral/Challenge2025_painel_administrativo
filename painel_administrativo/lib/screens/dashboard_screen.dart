import 'package:flutter/material.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/bar_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/engagement_chart.dart';
import 'package:painel_administrativo/widgets/generic/header.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/reusable_card.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/horizontal_missions_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> _colaboradores = [
    'Colaborador 1',
    'Colaborador 2',
    'Colaborador 3',
  ];

  // Estados gerais
  String? _colaboradorSelecionado;
  int _mesSelecionadoIndex = 8; // grafico de meses
  int _projetoSelecionadoIndex = -1; // grafco de projetos
  int _engajamentoGeralIndex = -1; // grafico geral
  String _periodoSelecionado = "semana"; //semana ou mês
  int _touchedMissionsIndex = -1; // grafico horizontal de missoes

  @override
  Widget build(BuildContext context) {
    final AppStyles appStyles = AppStyles();
    double larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyles.white,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: larguraTela * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 60),
                  child: Text(
                    "Dashboard de Engajamento",
                    style: AppStyles.kufam(
                      30,
                      AppStyles.black,
                      AppStyles.semiBold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Filtrar", style: AppStyles.kufam(18, AppStyles.black, AppStyles.semiBold),),
                      const SizedBox(width: 10),
                    SizedBox(
                      width: larguraTela * 0.2, 
                      child: DropdownButton<String>(
                        value: _colaboradorSelecionado,
                        isExpanded: true,
                        hint: const Text("Colaborador"),
                        items: _colaboradores.map((colab) {
                          return DropdownMenuItem(value: colab, child: Text(colab));
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _colaboradorSelecionado = value);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                _buildEngagementSection(appStyles),
                const SizedBox(height: 40),
                _buildProjectsSection(appStyles),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEngagementSection(AppStyles appStyles) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: ReusableCard(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16.0,
                    ), // espaçamento interno do card
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
                                  //const SizedBox(height: 10),
                                  // DropdownButtonHideUnderline(
                                  //   child: DropdownButton<String>(
                                  //     value: _colaboradorSelecionado,
                                  //     hint: Text(
                                  //       'Colaborador',
                                  //       style: AppStyles.kufam(
                                  //         14,
                                  //         AppStyles.textGrey,
                                  //         AppStyles.regular,
                                  //       ),
                                  //     ),
                                  //     icon: const Icon(
                                  //       Icons.arrow_drop_down,
                                  //       color: AppStyles.textGrey,
                                  //     ),
                                  //     style: AppStyles.kufam(
                                  //       14,
                                  //       AppStyles.textGrey,
                                  //       AppStyles.regular,
                                  //     ),
                                  //     onChanged: (String? newValue) {
                                  //       setState(() {
                                  //         _colaboradorSelecionado = newValue;
                                  //       });
                                  //     },
                                  //     items: _colaboradores
                                  //         .map<DropdownMenuItem<String>>((
                                  //           String value,
                                  //         ) {
                                  //           return DropdownMenuItem<String>(
                                  //             value: value,
                                  //             child: Text(value),
                                  //           );
                                  //         })
                                  //         .toList(),
                                  //   ),
                                  // ),
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

            // Segundo card
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
                        // const SizedBox(height: 10),
                        // DropdownButtonHideUnderline(
                        //   child: DropdownButton<String>(
                        //     value: _colaboradorSelecionado,
                        //     hint: Text(
                        //       'Colaborador',
                        //       style: AppStyles.kufam(
                        //         14,
                        //         AppStyles.textGrey,
                        //         AppStyles.regular,
                        //       ),
                        //     ),
                        //     icon: const Icon(
                        //       Icons.arrow_drop_down,
                        //       color: AppStyles.textGrey,
                        //     ),
                        //     style: AppStyles.kufam(
                        //       14,
                        //       AppStyles.textGrey,
                        //       AppStyles.regular,
                        //     ),
                        //     onChanged: (String? newValue) {
                        //       setState(() {
                        //         _colaboradorSelecionado = newValue;
                        //       });
                        //     },
                        //     items: _colaboradores.map<DropdownMenuItem<String>>(
                        //       (String value) {
                        //         return DropdownMenuItem<String>(
                        //           value: value,
                        //           child: Text(value),
                        //         );
                        //       },
                        //     ).toList(),
                        //   ),
                        // ),
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

            // Terceiro card
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

  Widget _buildProjectsSection(AppStyles appStyles) {
    return ReusableCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // espaçamento interno
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

            // dropdowns periodo - colaborador
            Row(
              children: [
                // DropdownButton<String>(
                //   value: _periodoSelecionado,
                //   items: const [
                //     DropdownMenuItem(
                //       value: "semana",
                //       child: Text("Essa semana"),
                //     ),
                //     DropdownMenuItem(value: "mes", child: Text("Esse mês")),
                //   ],
                //   onChanged: (value) {
                //     if (value != null) {
                //       setState(() => _periodoSelecionado = value);
                //     }
                //   },
                // ),
                // const SizedBox(width: 15),
                // DropdownButton<String>(
                //   value: _colaboradorSelecionado,
                //   hint: const Text("Colaborador"),
                //   items: _colaboradores.map((colab) {
                //     return DropdownMenuItem(value: colab, child: Text(colab));
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() => _colaboradorSelecionado = value);
                //   },
                // ),
              ],
            ),

            const SizedBox(height: 40),

            SizedBox(
              height: 350,
              width: 1200, // tamanho do grafico missoes
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
