import 'package:flutter/material.dart';
import 'package:painel_administrativo/screens/manage_missions_screen.dart';
import 'package:painel_administrativo/screens/analyze_projects_screen.dart';
import 'package:painel_administrativo/screens/dashboard_screen.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/generic/button.dart';
import 'package:painel_administrativo/widgets/generic/header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // simulação de carregamento
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const Header(),
      backgroundColor: AppStyles.white,
      body: Center(
        child: SizedBox(
          width: larguraTela * 0.8,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppStyles.blue),
                )
              : Row(
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
                          Button(
                            text: "Administrar Missões",
                            backgroundColor: AppStyles.blue,
                            textStyle: AppStyles.kufam(
                              24,
                              AppStyles.white,
                              AppStyles.semiBold,
                            ),
                            width: larguraTela * 0.3,
                            height: 100,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ManageMissionsScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Button(
                            text: "Analisar projetos",
                            backgroundColor: AppStyles.blue,
                            textStyle: AppStyles.kufam(
                              24,
                              AppStyles.white,
                              AppStyles.semiBold,
                            ),
                            width: larguraTela * 0.3,
                            height: 100,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnalyzeProjects(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          Button(
                            text: "Dashboard de Engajamento",
                            backgroundColor: AppStyles.blue,
                            textStyle: AppStyles.kufam(
                              24,
                              AppStyles.white,
                              AppStyles.semiBold,
                            ),
                            width: larguraTela * 0.3,
                            height: 100,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardPage(),
                                ),
                              );
                            },
                          ),
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
