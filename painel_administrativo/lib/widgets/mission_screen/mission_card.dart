import 'package:flutter/material.dart';
import 'package:painel_administrativo/data/repository/remotes/remote_mission_repository.dart';
import 'package:painel_administrativo/models/mission.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/mission_screen/edit_mission.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MissionCard extends StatefulWidget {
  final List<bool> checks;
  const MissionCard({super.key, required this.checks});

  @override
  State<MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<MissionCard> {
  final missaoRepo = RemoteMissionRepository(client: Supabase.instance.client);

  List<Mission> missoes = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => isLoading = true);
    try {
      await Future.wait([_findMissoes()]);
    } catch (e) {
      throw ("erro $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _findMissoes() async {
    final resultado = await missaoRepo.listMissoes();
    setState(() {
      missoes = resultado;
    });
  }

  String formatarData(DateTime data) {
    return "${data.day.toString().padLeft(2, '0')}/"
        "${data.month.toString().padLeft(2, '0')}/"
        "${data.year}";
  }

  @override
  Widget build(BuildContext context) {
    final statusSelecionados = <String>[];
    if (widget.checks[0]) statusSelecionados.add('Ativa');
    if (widget.checks[1]) statusSelecionados.add('Programada');
    if (widget.checks[2]) statusSelecionados.add('Encerrada');

    final bool nenhumFiltroAtivo = statusSelecionados.isEmpty;

    final missoesFiltradas = nenhumFiltroAtivo
        ? missoes
        : missoes.where((m) => statusSelecionados.contains(m.status)).toList();

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
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppStyles.blue),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: missoesFiltradas.length,
                    itemBuilder: (context, index) {
                      final missao = missoesFiltradas[index];

                      DateTime dataInicio = Mission.calcularDataInicio(
                        missao.dataVencimento,
                      );

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
                                      "Início\n${formatarData(dataInicio)}",
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
