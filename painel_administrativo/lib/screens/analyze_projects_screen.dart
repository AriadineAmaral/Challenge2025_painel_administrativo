import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/projects_screen/project_card.dart';
import 'package:painel_administrativo/widgets/generic/header.dart';
import 'package:painel_administrativo/widgets/generic/status_checkbox_list_with_search.dart';
import 'package:painel_administrativo/data/service/project_service.dart';
import 'package:painel_administrativo/models/project.dart';

class AnalyzeProjects extends StatefulWidget {
  const AnalyzeProjects({super.key});

  @override
  State<AnalyzeProjects> createState() => _AnalyzeProjectsState();
}

class _AnalyzeProjectsState extends State<AnalyzeProjects> {
  // status checkboxes
  final List<bool> checks = [false, false, false];
  final List<String> statusProjeto = ['análise e seleção', 'desenvolvimento', 'finalizado'];
  
  late Future<List<ProjectView>> futureProjects;
  
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureProjects = ProjectService().fetchProjects();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _searchProjects();
  }
  
  void _searchProjects() {
    String? selectedStatus;
    for (int i = 0; i < checks.length; i++) {
      if (checks[i]) {
        selectedStatus = statusProjeto[i];
        break;
      }
    }
    
    setState(() {
      futureProjects = ProjectService().fetchProjects(
        searchTerm: _searchController.text,
        status: selectedStatus,
      );
    });
  }

  void _reloadProjects() {
    _searchProjects();
  }

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
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 60),
                  child: Text(
                    "Analisar projetos",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppStyles.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                StatusCheckboxListWithSearch(
                  checks: checks,
                  titulo: "Lista de projetos",
                  status: statusProjeto,
                  onChanged: (index, value) {
                    setState(() {
                      for (int i = 0; i < checks.length; i++) {
                        checks[i] = false; 
                      }
                      checks[index] = value; 
                      
                      _searchProjects();
                    });
                  },
                  searchController: _searchController,
                  onSearchChanged: (value) {
                    _onSearchChanged();
                  },
                ),
                
                const SizedBox(height: 12),

                FutureBuilder<List<ProjectView>>(
                  future: futureProjects,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Erro ao carregar projetos: ${snapshot.error}',
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Nenhum projeto encontrado.'),
                      );
                    } else {
                      return ProjectCard(
                        projects: snapshot.data!,
                        onStatusUpdated: _reloadProjects,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}