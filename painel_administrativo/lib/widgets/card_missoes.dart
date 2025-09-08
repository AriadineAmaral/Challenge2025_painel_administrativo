import 'package:flutter/material.dart';
import 'package:painel_administrativo/data/model/missao.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/editar_missao.dart';

class CardMissoes extends StatefulWidget {
  const CardMissoes({super.key});

  @override
  State<CardMissoes> createState() => _CardMissoesState();
}

class _CardMissoesState extends State<CardMissoes> {
  List<Missao> missoes = [
    Missao(
      idMissao: 1,
      titulo: "Participe do fórum de ideias",
      status: "Ativa",
      dataInicio: Missao.calcularDataInicio(DateTime(2025, 9, 30)),
      dataVencimento: DateTime(2025, 9, 30),
      pontos: 8,
    ),
    Missao(
      idMissao: 2,
      titulo: "Leia o artigo sobre inteligência emocional",
      status: "Programada",
      dataInicio: Missao.calcularDataInicio(DateTime(2025, 10, 31)),
      dataVencimento: DateTime(2025, 10, 31),
      pontos: 5,
    ),
    Missao(
      idMissao: 3,
      titulo: "Assista ao vídeo sobre trabalho em equipe",
      status: "Encerrada",
      dataInicio: Missao.calcularDataInicio(DateTime(2025, 8, 31)),
      dataVencimento: DateTime(2025, 8, 31),
      pontos: 10,
    ),
    Missao(
      idMissao: 4,
      titulo: "Complete o quiz sobre valores da empresa",
      status: "Encerrada",
      dataInicio: Missao.calcularDataInicio(DateTime(2025, 8, 31)),
      dataVencimento: DateTime(2025, 8, 31),
      pontos: 25,
    ),
    Missao(
      idMissao: 5,
      titulo: "Responda à pesquisa de engajamento",
      status: "Encerrada",
      dataInicio: Missao.calcularDataInicio(DateTime(2025, 7, 31)),
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
                              EditarMissao(
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
