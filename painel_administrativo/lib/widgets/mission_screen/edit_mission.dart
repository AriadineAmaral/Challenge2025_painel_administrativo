import 'package:flutter/material.dart';
import 'package:painel_administrativo/data/controller/mission_controller.dart';
import 'package:painel_administrativo/data/repository/remotes/remote_mission_repository.dart';
import 'package:painel_administrativo/models/mission.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/generic/calendar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditMission extends StatefulWidget {
  final Mission missao;
  final String Function(DateTime) formatarData;

  const EditMission({
    super.key,
    required this.missao,
    required this.formatarData,
  });

  @override
  State<EditMission> createState() => _EditMissionState();
}

class _EditMissionState extends State<EditMission> {
  final MissionController _controllers = MissionController();
  final missaoRepo = RemoteMissionRepository(client: Supabase.instance.client);
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      iconSize: 16,
      color: AppStyles.textGrey,
      onPressed: () {
        DateTime dataVencimento = widget.missao.dataVencimento;
        DateTime dataInicio = Mission.calcularDataInicio(dataVencimento);
        _controllers.tituloController.text = widget.missao.titulo;
        _controllers.pontosController.text = widget.missao.pontos.toString();
        _controllers.linkController.text = widget.missao.link ?? '';

        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppStyles.yellow, // cor dos botões e cabeçalho
                      onPrimary: Colors.black, // texto nos botões
                      onSurface: AppStyles.textGrey, // texto padrão
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor:
                            AppStyles.blue, // cor dos botões Cancelar/Concluir
                      ),
                    ),
                    scaffoldBackgroundColor: AppStyles.white,
                  ),
                  child: AlertDialog(
                    title: Text(
                      "Editar Missão",
                      style: AppStyles.kufam(
                        22,
                        AppStyles.blue,
                        AppStyles.bold,
                      ),
                    ),
                    content: SizedBox(
                      width: 500,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextField(
                              controller: _controllers.tituloController,
                              decoration: InputDecoration(
                                labelText: "Título",
                                labelStyle: AppStyles.kufam(
                                  20,
                                  AppStyles.textGrey,
                                  AppStyles.bold,
                                ),
                              ),
                              autofocus: true,
                              style: AppStyles.kufam(
                                16,
                                AppStyles.black,
                                AppStyles.regular,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _controllers.pontosController,
                              decoration: InputDecoration(
                                labelText: "Pontos",
                                labelStyle: AppStyles.kufam(
                                  20,
                                  AppStyles.textGrey,
                                  AppStyles.bold,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              style: AppStyles.kufam(
                                16,
                                AppStyles.black,
                                AppStyles.regular,
                              ),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _controllers.linkController,
                              decoration: InputDecoration(
                                labelText: "Link",
                                labelStyle: AppStyles.kufam(
                                  16,
                                  AppStyles.textGrey,
                                  AppStyles.bold,
                                ),
                              ),
                              autofocus: true,
                              style: AppStyles.kufam(
                                16,
                                AppStyles.black,
                                AppStyles.regular,
                              ),
                            ),

                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Início: ${widget.formatarData(dataInicio)}",
                                    style: AppStyles.kufam(
                                      16,
                                      AppStyles.textGrey,
                                      AppStyles.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Fim: ${widget.formatarData(dataVencimento)}",
                                    style: AppStyles.kufam(
                                      16,
                                      AppStyles.textGrey,
                                      AppStyles.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final picked =
                                        await Calendar.selecionarData(
                                          context: context,
                                          dataInicial: dataVencimento,
                                        );
                                    if (picked != null) {
                                      setState(() => dataVencimento = picked);
                                    }
                                  },
                                  child: Text(
                                    "Alterar",
                                    style: AppStyles.kufam(
                                      16,
                                      AppStyles.blue,
                                      AppStyles.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "Cancelar",
                          style: AppStyles.kufam(
                            16,
                            AppStyles.blue,
                            AppStyles.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print(
                            "Atualizando missão ID: ${widget.missao.idMissao}",
                          );
                          try {
                            await missaoRepo.updateMissao(
                              widget.missao.idMissao,
                              _controllers.tituloController.text,
                              _controllers.linkController.text,
                              int.tryParse(
                                    _controllers.pontosController.text,
                                  ) ??
                                  0,
                              dataVencimento,
                            );
                            if (mounted) {
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            print("Erro ao atualizar missão: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Erro ao atualizar: $e")),
                            );
                          }
                        },
                        child: Text(
                          "Concluir",
                          style: AppStyles.kufam(
                            16,
                            AppStyles.blue,
                            AppStyles.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
