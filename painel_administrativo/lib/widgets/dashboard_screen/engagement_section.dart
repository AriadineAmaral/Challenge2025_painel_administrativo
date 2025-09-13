import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/bar_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/engagement_chart.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/reusable_card.dart';

class EngagementSection extends StatefulWidget {
  final List<Map<String, dynamic>> engajamento;
  final List<Map<String, dynamic>> projetos;
  final List<Map<String, dynamic>> engajamentoGeral;

  const EngagementSection({
    super.key,
    required this.engajamento,
    required this.projetos,
    required this.engajamentoGeral,
  });

  @override
  State<EngagementSection> createState() => _EngagementSectionState();
}

class _EngagementSectionState extends State<EngagementSection> {
  int _mesSelecionadoIndex = -1;
  int _projetoSelecionadoIndex = -1;
  int _engajamentoGeralIndex = -1;

  int _monthIndexFromName(String? name) {
    if (name == null) return -1;
    final n = name.toLowerCase().trim();
    switch (n) {
      case 'janeiro':
      case 'jan':
        return 0;
      case 'fevereiro':
      case 'fev':
        return 1;
      case 'março':
      case 'marco':
      case 'mar':
        return 2;
      case 'abril':
      case 'abr':
        return 3;
      case 'maio':
      case 'mai':
        return 4;
      case 'junho':
      case 'jun':
        return 5;
      case 'julho':
      case 'jul':
        return 6;
      case 'agosto':
      case 'ago':
        return 7;
      case 'setembro':
      case 'set':
        return 8;
      case 'outubro':
      case 'out':
        return 9;
      case 'novembro':
      case 'nov':
        return 10;
      case 'dezembro':
      case 'dez':
        return 11;
      default:
        return -1;
    }
  }

  int _computePercentageToShow() {
    if (widget.engajamento.isEmpty) return 0;
    if (_mesSelecionadoIndex >= 0) {
      final found = widget.engajamento.firstWhere(
        (e) => _monthIndexFromName(e['mes'] as String) == _mesSelecionadoIndex,
        orElse: () => {},
      );
      if (found.isNotEmpty && found['porcentagem_total'] != null) {
        final raw = (found['porcentagem_total'] as String)
            .replaceAll('%', '')
            .replaceAll(',', '.');
        final val = double.tryParse(raw);
        if (val != null) return val.round();
      }
    }

    double sum = 0;
    int count = 0;
    for (final e in widget.engajamento) {
      final p = e['porcentagem_total'];
      if (p != null) {
        final raw = (p as String).replaceAll('%', '').replaceAll(',', '.');
        final v = double.tryParse(raw);
        if (v != null) {
          sum += v;
          count++;
        }
      }
    }
    if (count == 0) return 0;
    return (sum / count).round();
  }

  @override
  void didUpdateWidget(covariant EngagementSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.engajamento.isNotEmpty) {
      final firstMonthIndex = widget.engajamento
          .map((e) => _monthIndexFromName(e['mes'] as String))
          .firstWhere((idx) => idx >= 0, orElse: () => -1);
      if (firstMonthIndex != -1 && firstMonthIndex != _mesSelecionadoIndex) {
        setState(() {
          _mesSelecionadoIndex = firstMonthIndex;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<double> monthsData = List<double>.filled(12, 0.0);
    for (final e in widget.engajamento) {
      final mesName = e['mes'] as String?;
      final idx = _monthIndexFromName(mesName);
      if (idx >= 0) {
        final pontos = e['total_pontos'];
        monthsData[idx] = (pontos is num)
            ? pontos.toDouble()
            : double.tryParse('$pontos') ?? 0.0;
      }
    }

    final mesAtual = DateTime.now().month;
    final List<double> projetosData = List<double>.filled(mesAtual, 0.0);
    for (final e in widget.projetos) {
      final mesNum = e['mes_num'] is int
          ? e['mes_num'] as int
          : int.tryParse('${e['mes_num']}') ?? 0;

      if (mesNum >= 1 && mesNum <= 12) {
        final qtdRaw = e['total_projetos'];
        final qtd = (qtdRaw is num)
            ? qtdRaw.toDouble()
            : double.tryParse('$qtdRaw') ?? 0.0;
        projetosData[mesNum - 1] = qtd;
      }
    }

    final List<double> engajamentoGeralData = List<double>.filled(12, 0.0);
    for (final e in widget.engajamentoGeral) {
      final mesName = e['mes'] as String?;
      final idx = _monthIndexFromName(mesName);
      if (idx >= 0) {
        final pontos = e['engajamento'];
        engajamentoGeralData[idx] = (pontos is num)
            ? pontos.toDouble()
            : double.tryParse('$pontos') ?? 0.0;
      }
    }
    
    int generalEngagementPercentage = 0;
    if (widget.engajamentoGeral.isNotEmpty) {
      Map<String, dynamic> dataToUse;
      if (_engajamentoGeralIndex >= 0 &&
          _engajamentoGeralIndex < widget.engajamentoGeral.length) {
        dataToUse = widget.engajamentoGeral[_engajamentoGeralIndex];
      } else {
        dataToUse = widget.engajamentoGeral.last;
      }

      final percentualRaw = dataToUse['percentual_total'];
      if (percentualRaw != null) {
        final percentual = (percentualRaw is num)
            ? percentualRaw.toDouble()
            : double.tryParse('$percentualRaw') ?? 0.0;
        generalEngagementPercentage = percentual.round();
      }
    }

    final percentageForCircle = _computePercentageToShow();

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primeiro Card - Engajamento por colaborador
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
                              child: EngagementChart(
                                percentage: percentageForCircle,
                                color: AppStyles.blue,
                                textColor: AppStyles.blue,
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
                                  data: monthsData,
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
                            data: projetosData,
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

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: ReusableCard(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        EngagementChart(
                          percentage: generalEngagementPercentage,
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
                            data: engajamentoGeralData,
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
