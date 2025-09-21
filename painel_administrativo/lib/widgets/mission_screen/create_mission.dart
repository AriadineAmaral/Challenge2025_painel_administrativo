import 'package:flutter/material.dart';
import 'package:painel_administrativo/data/controller/mission_controller.dart';
import 'package:painel_administrativo/data/repository/remotes/remote_mission_repository.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/generic/button.dart';
import 'package:painel_administrativo/widgets/generic/custom_date_field.dart';
import 'package:painel_administrativo/widgets/generic/custom_text_field%20.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateMission extends StatefulWidget {
  const CreateMission({super.key});

  @override
  State<CreateMission> createState() => _CreateMissionState();
}

class _CreateMissionState extends State<CreateMission> {
  final MissionController _controllers = MissionController();
  final missaoRepo = RemoteMissionRepository(client: Supabase.instance.client);
  bool isLoading = true;

  DateTime? dataSelecionada;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
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
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Título",
                style: AppStyles.akatab(
                  20,
                  AppStyles.textGrey,
                  AppStyles.medium,
                ),
              ),
            ),
            CustomTextField(
              label: "Digite o título da missão",
              controller: _controllers.tituloController,
              obscureText: false,
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Link",
                style: AppStyles.akatab(
                  20,
                  AppStyles.textGrey,
                  AppStyles.medium,
                ),
              ),
            ),
            CustomTextField(
              label: "Link para direcionar o usuário",
              controller: _controllers.linkController,
              obscureText: false,
            ),

            SizedBox(height: 16),

            Row(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pontos",
                        style: AppStyles.akatab(
                          20,
                          AppStyles.textGrey,
                          AppStyles.medium,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 72,
                      child: CustomTextField(
                        label: "",
                        controller: _controllers.pontosController,
                        obscureText: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16), // espaçamento entre os campos
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Data de vencimento",
                          style: AppStyles.akatab(
                            20,
                            AppStyles.textGrey,
                            AppStyles.medium,
                          ),
                        ),
                      ),
                      CustomDateField(
                        label: "Data da missão",
                        selectedDate: dataSelecionada,
                        onDateSelected: (novaData) {
                          setState(() {
                            dataSelecionada = novaData;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            Button(
              text: "Cadastrar",
              height: 40,
              backgroundColor: AppStyles.yellow,
              textStyle: AppStyles.akatab(
                20,
                AppStyles.black,
                AppStyles.semiBold,
              ).copyWith(height: 0.5),
              onPressed: () async {
                try {
                  await missaoRepo.insertMissao(
                    _controllers.tituloController.text,
                    _controllers.linkController.text,
                    int.tryParse(_controllers.pontosController.text) ?? 0,
                    dataSelecionada!,
                  );

                  _controllers.tituloController.clear();
                  _controllers.linkController.clear();
                  _controllers.pontosController.clear();
                  _controllers.dataVencimentoController.clear(); // opcional

                  setState(() {
                    dataSelecionada = null;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppStyles.green,
                      content: Text(
                        "Missão cadastrada com sucesso!",

                        style: TextStyle(
                          color: Colors.white, // cor do texto
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } catch (e) {
                  print("Erro ao atualizar missão: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Erro ao atualizar: $e")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
