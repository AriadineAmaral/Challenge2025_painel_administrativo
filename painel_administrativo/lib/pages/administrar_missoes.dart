import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/cadastro_missao.dart';
import 'package:painel_administrativo/widgets/card_missoes.dart';
import 'package:painel_administrativo/widgets/header.dart';
import 'package:painel_administrativo/widgets/status_checkbox_list.dart';

class AdministrarMissoes extends StatefulWidget {
  const AdministrarMissoes({super.key});

  @override
  State<AdministrarMissoes> createState() => _AdministrarMissoesState();
}

class _AdministrarMissoesState extends State<AdministrarMissoes> {
  List<bool> checks = [false, false, false];
  List<String> statusMissao = ['Ativas', 'Programadas', 'Encerradas'];

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
                          CadastroMissao(),
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
                            titulo: "Administrar Missões",
                            status: statusMissao,
                            onChanged: (index, value) {
                              setState(() {
                                checks[index] = value;
                              });
                            },
                          ),
                          SizedBox(height: 10),
                          CardMissoes(),
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
