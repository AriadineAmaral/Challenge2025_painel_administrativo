import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/project.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:painel_administrativo/widgets/button.dart';
import 'package:painel_administrativo/widgets/project_card.dart';

class AnalyzeProjects extends StatefulWidget {
  const AnalyzeProjects({super.key});

  @override
  State<AnalyzeProjects> createState() => _AnalyzeProjectsState();
}

class _AnalyzeProjectsState extends State<AnalyzeProjects> {
  bool analysis = false;
  bool development = true;
  bool finished = false;

  List<Project> allProjects = [
    Project(
      name: "Projeto Kaizen",
      status: "desenvolvimento",
      date: "06/09/2025",
      collaborator: "Camila Antunes",
    ),
    Project(
      name: "Projeto Clic",
      status: "desenvolvimento",
      date: "06/09/2025",
      collaborator: "Felipe Moura",
    ),
    Project(
      name: "Projeto Kaizen",
      status: "desenvolvimento",
      date: "06/09/2025",
      collaborator: "Ricardo Oliveira",
    ),
     Project(
      name: "Projeto Kaizen",
      status: "desenvolvimento",
      date: "06/09/2025",
      collaborator: "Ricardo Oliveira",
    ),
     Project(
      name: "Projeto Kaizen",
      status: "desenvolvimento",
      date: "06/09/2025",
      collaborator: "Ricardo Oliveira",
    ),
    
  ];

  List<Project> filteredProjects = [];

  @override
  void initState() {
    super.initState();
    applyFilter();
  }

  void applyFilter() {
    setState(() {
      filteredProjects = allProjects.where((p) {
        if (analysis && p.status == "análise") return true;
        if (development && p.status == "desenvolvimento") return true;
        if (finished && p.status == "finalizado") return true;
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppStyles();

    return Scaffold(
      backgroundColor: AppStyles.white, 
      body: Column(
        children: [
        
          Container(
            color: AppStyles.blue, 
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft, 
              child: Text(
                "EuroPro",
                style: styles.kronaOne(
                  25,
                  AppStyles.white,
                  AppStyles.bold,
                ), 
              ),
              
            ),
            
            
          ),
        

      
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Center(
              child: Text(
                "Analisar projetos",
                style: styles.kufam(30,Colors.black, AppStyles.bold),
              ),
            ),
          ),


Padding(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, 
    children: [
     
      const SizedBox(height: 8), 
      Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
           // Novo título "Lista de projetos"
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          "Lista de projetos",
          style: styles.kufam(16, Colors.black, AppStyles.bold),
        ),
      ),
          Checkbox(
            value: analysis,
            onChanged: (val) {
              setState(() {
                analysis = val!;
                if (analysis) {
                  development = false;
                  finished = false;
                }
                applyFilter();
              });
            },
          ),
          
          const Text("Análise"),
          Checkbox(
            value: development,
            onChanged: (val) {
              setState(() {
                development = val!;
                if (development) {
                  analysis = false;
                  finished = false;
                }
                applyFilter();
              });
            },
          ),
          
          const Text("Desenvolvimento"),
          Checkbox(
            value: finished,
            onChanged: (val) {
              setState(() {
                finished = val!;
                if (finished) {
                  analysis = false;
                  development = false;
                }
                applyFilter();
              });
            },
          ),
          const Text("Finalizado"), 
          
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

           child: Button(
              text: "Pesquisar",
              backgroundColor: AppStyles.yellow,
              onPressed: applyFilter,
              textStyle: styles.akatab(13, Colors.black, AppStyles.semiBold),
              width: 88,
              height: 32,
              elevation: 4,
              
            )
          ),
        ],
      ),
    ],
  ),
),

          // lista de projetos
       
          Expanded(
            child: Center(
              child: Container(
                width: 800, 
                height: 500, // Largura do quadrado maior
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: filteredProjects.length,
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];
                      
                      return ProjectCard(
                        name: project.name,
                        status: project.status,
                        date: project.date,
                        collaborator: project.collaborator,
                        onDetails: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Detalhes de ${project.name}")),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}