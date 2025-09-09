import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/mission.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/mission_screen/edit_mission.dart';

class MissionCard extends StatefulWidget {
  const MissionCard({super.key});

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard> {
  List<Mission> missoes = [
    Mission(
      idMissao: 1,
      titulo: "Participe do fórum de ideias",
      status: "Ativa",
      dataInicio: Mission.calcularDataInicio(DateTime(2025, 9, 30)),
      dataVencimento: DateTime(2025, 9, 30),
      pontos: 8,
    ),
    Mission(
      idMissao: 2,
      titulo: "Leia o artigo sobre inteligência emocional",
      status: "Programada",
      dataInicio: Mission.calcularDataInicio(DateTime(2025, 10, 31)),
      dataVencimento: DateTime(2025, 10, 31),
      pontos: 5,
    ),
    Mission(
      idMissao: 3,
      titulo: "Assista ao vídeo sobre trabalho em equipe",
      status: "Encerrada",
      dataInicio: Mission.calcularDataInicio(DateTime(2025, 8, 31)),
      dataVencimento: DateTime(2025, 8, 31),
      pontos: 10,
    ),
    Mission(
      idMissao: 4,
      titulo: "Complete o quiz sobre valores da empresa",
      status: "Encerrada",
      dataInicio: Mission.calcularDataInicio(DateTime(2025, 8, 31)),
      dataVencimento: DateTime(2025, 8, 31),
      pontos: 25,
    ),
    Mission(
      idMissao: 5,
      titulo: "Responda à pesquisa de engajamento",
      status: "Encerrada",
      dataInicio: Mission.calcularDataInicio(DateTime(2025, 7, 31)),
      dataVencimento: DateTime(2025, 7, 31),
      pontos: 18,
    ),
  ];

  String formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/"
        "${data.month.toString().padLeft(2, '0')}/"
        "${data.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      height: 400,
      decoration: BoxDecoration(
        color: AppStyles.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppStyles.grey.withValues(alpha: 0.2),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: missoes.length,
              itemBuilder: (context, index) {
                final missao = missoes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                missao.titulo,
                                style: AppStyles.kufam(
                                  16,
                                  AppStyles.blue,
                                  AppStyles.semiBold,
                                ),
                              ),
                              Text(
                                "Status: ${missao.status}",
                                style: AppStyles.kufam(
                                  14,
                                  AppStyles.black,
                                  AppStyles.regular,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Início\n${formatarData(missao.dataInicio)}",
                                style: AppStyles.kufam(
                                  14,
                                  AppStyles.black,
                                  AppStyles.regular,
                                ),
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(width: 20),
                              Text(
                                "Fim\n${formatarData(missao.dataVencimento)}",
                                style: AppStyles.kufam(
                                  14,
                                  AppStyles.black,
                                  AppStyles.regular,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "${missao.pontos}\nPontos",
                                style: AppStyles.kufam(
                                  14,
                                  AppStyles.blue,
                                  AppStyles.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 10),
                              EditMission(
                                missao: missao,
                                formatarData: formatarData,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
