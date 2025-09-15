import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/mission.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/mission_screen/create_mission.dart';
import 'package:painel_administrativo/widgets/mission_screen/mission_card.dart';
import 'package:painel_administrativo/widgets/generic/header.dart';
import 'package:painel_administrativo/widgets/generic/status_checkbox_list.dart';

class ManageMissionsScreen extends StatefulWidget {
  const ManageMissionsScreen({super.key});

  @override
  State<ManageMissionsScreen> createState() => _ManageMissionsScreenState();
}

class _ManageMissionsScreenState extends State<ManageMissionsScreen> {
  List<bool> checks = [false, false, false];
  List<String> statusMissao = ['Ativa', 'Programada', 'Encerrada'];
  late Mission missao;

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const Header(),
      backgroundColor: AppStyles.white,
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: larguraTela,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 60),
                  child: Text(
                    "Administrar Missões",
                    style: AppStyles.kufam(
                      30,
                      AppStyles.black,
                      AppStyles.semiBold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text(
                            "Cadastrar nova missão",
                            style: AppStyles.kufam(
                              25,
                              AppStyles.black,
                              AppStyles.semiBold,
                            ),
                          ),
                          SizedBox(height: 10),
                          CreateMission(),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StatusCheckboxList(
                            checks: checks,
                            titulo: "Lista de Missões",
                            status: statusMissao,
                            onChanged: (index, value) {
                              setState(() {
                                checks[index] = value;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          MissionCard(checks: checks),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
