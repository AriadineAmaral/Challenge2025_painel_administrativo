import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/engagement_section.dart';
import 'package:painel_administrativo/widgets/dashboard_screen/projects_section.dart';
import 'package:painel_administrativo/widgets/generic/header.dart';


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> _colaboradores = [
    'Colaborador 1',
    'Colaborador 2',
    'Colaborador 3',
  ];

  // Estados gerais
  String? _colaboradorSelecionado;
  // int _mesSelecionadoIndex = 8; // grafico de meses
  // int _projetoSelecionadoIndex = -1; // grafco de projetos
  // int _engajamentoGeralIndex = -1; // grafico geral
  // String _periodoSelecionado = "semana"; //semana ou mês
  // int _touchedMissionsIndex = -1; // grafico horizontal de missoes

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppStyles.white,
      appBar: const Header(),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: larguraTela * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 60),
                  child: Text(
                    "Dashboard de Engajamento",
                    style: AppStyles.kufam(
                      30,
                      AppStyles.black,
                      AppStyles.semiBold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Filtrar",
                      style: AppStyles.kufam(
                        18,
                        AppStyles.black,
                        AppStyles.semiBold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: larguraTela * 0.2,
                      child: DropdownButton<String>(
                        value: _colaboradorSelecionado,
                        isExpanded: true,
                        hint: const Text("Colaborador"),
                        items: _colaboradores.map((colab) {
                          return DropdownMenuItem(
                            value: colab,
                            child: Text(colab),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() => _colaboradorSelecionado = value);
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                EngagementSection(),
                const SizedBox(height: 40),
                ProjectsSection(),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
