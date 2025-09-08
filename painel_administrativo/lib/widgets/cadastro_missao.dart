import 'package:flutter/material.dart';
import 'package:painel_administrativo/pages/home.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/button.dart';
import 'package:painel_administrativo/widgets/custom_date_field.dart';
import 'package:painel_administrativo/widgets/custom_text_field%20.dart';

class CadastroMissao extends StatefulWidget {
  const CadastroMissao({super.key});

  @override
  State<CadastroMissao> createState() => _CadastroMissaoState();
}

class _CadastroMissaoState extends State<CadastroMissao> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController pontosController = TextEditingController();

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
              controller: tituloController,
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
              controller: linkController,
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
                        controller: pontosController,
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
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
