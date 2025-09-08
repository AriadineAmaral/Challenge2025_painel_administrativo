import 'package:flutter/material.dart';
import 'package:painel_administrativo/pages/administrar_missoes.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/button.dart';
import 'package:painel_administrativo/widgets/header.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const Header(),
      backgroundColor: AppStyles.white,
      body: Center( 
        child: SizedBox(
          width: larguraTela * 0.8,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Painel\nAdministrativo",
                      style: AppStyles.kronaOne(
                        40,
                        AppStyles.blue,
                        AppStyles.regular,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Button(text: "Administrar Missões", backgroundColor: AppStyles.blue, textStyle: AppStyles.kufam(24, AppStyles.white, AppStyles.semiBold),
                    width: larguraTela * 0.3,
                    height: 100,
                     onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdministrarMissoes()),
                        );
                     }
                    ),
                    SizedBox(height: 24),

                    Button(text: "Analisar projetos", backgroundColor:  AppStyles.blue, textStyle: AppStyles.kufam(24, AppStyles.white, AppStyles.semiBold),
                    width: larguraTela * 0.3,
                    height: 100,
                    onPressed: () {}),

                     SizedBox(height: 24),

                    Button(text: "Dashboard de Engajamento", backgroundColor:  AppStyles.blue, textStyle: AppStyles.kufam(24, AppStyles.white, AppStyles.semiBold),
                    width: larguraTela * 0.3,
                    height: 100,
                    onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

