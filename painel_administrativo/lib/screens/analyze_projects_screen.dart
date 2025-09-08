import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/project.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/card_projetos.dart';
import 'package:painel_administrativo/widgets/header.dart';
import 'package:painel_administrativo/widgets/status_checkbox_list.dart';

class AnalyzeProjects extends StatefulWidget {
  const AnalyzeProjects({super.key});

  @override
  State<AnalyzeProjects> createState() => _AnalyzeProjectsState();
}

class _AnalyzeProjectsState extends State<AnalyzeProjects> {
  List<bool> checks = [false, false, false];
  List<String> statusProjeto = ['Análise', 'Desenvolvimento', 'Finalizado'];

  bool analysis = false;
  bool development = true;
  bool finished = false;

  

  List<Project> filteredProjects = [];

  // @override
  // void initState() {
  //   super.initState();
  //   applyFilter();
  // }

  // void applyFilter() {
  //   setState(() {
  //     filteredProjects = allProjects.where((p) {
  //       if (analysis && p.status == "análise") return true;
  //       if (development && p.status == "desenvolvimento") return true;
  //       if (finished && p.status == "finalizado") return true;
  //       return false;
  //     }).toList();
  //   });
  // }

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 60),
                  child: Text(
                    "Analisar projetos",
                    style: AppStyles.kufam(
                      30,
                      AppStyles.black,
                      AppStyles.semiBold,
                    ),
                  ),
                ),
                StatusCheckboxList(
                  checks: checks,
                  titulo: "Lista de projetos",
                  status: statusProjeto,
                  onChanged: (index, value) {
                    setState(() {
                      checks[index] = value;
                    });
                  },
                ),
                SizedBox(height: 12),
                CardProjetos(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
