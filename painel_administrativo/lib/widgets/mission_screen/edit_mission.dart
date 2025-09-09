import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/mission.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/generic/calendar.dart';

class EditMission extends StatelessWidget {
  final Mission missao;
  final String Function(DateTime) formatarData;

  const EditMission({
    super.key,
    required this.missao,
    required this.formatarData,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      iconSize: 16,
      color: AppStyles.textGrey,
      onPressed: () {
        final tituloController = TextEditingController(text: missao.titulo);
        final pontosController = TextEditingController(text: missao.pontos.toString());
        final linkController = TextEditingController(text: missao.link);
        DateTime dataInicio = missao.dataInicio;
        DateTime dataVencimento = missao.dataVencimento;

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
                              controller: tituloController,
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
                              controller: pontosController,
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
                              controller: linkController,
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

                            // DropdownButtonFormField<String>(
                            //   value: statusSelecionado,
                            //   items: ["Ativa", "Programada", "Encerrada"]
                            //       .map(
                            //         (status) => DropdownMenuItem(
                            //           value: status,
                            //           child: Text(status),
                            //         ),
                            //       )
                            //       .toList(),
                            //   onChanged: (value) {
                            //     if (value != null) {
                            //       setState(() => statusSelecionado = value);
                            //     }
                            //   },
                            //   decoration: InputDecoration(labelText: "Status"),
                            // ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Início: ${formatarData(dataInicio)}",
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
                                          dataInicial: dataInicio,
                                        );
                                    if (picked != null) {
                                      setState(() => dataInicio = picked);
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
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Fim: ${formatarData(dataVencimento)}",
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
                        onPressed: () {
                          // Aqui você pode salvar as alterações
                          Navigator.pop(context);
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
