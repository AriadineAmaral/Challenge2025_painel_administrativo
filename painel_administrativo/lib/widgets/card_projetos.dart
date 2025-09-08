import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/project.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class CardProjetos extends StatefulWidget {
  const CardProjetos({super.key});

  @override
  State<CardProjetos> createState() => _CardProjetosState();
}

class _CardProjetosState extends State<CardProjetos> {
  List<Project> projects = [
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
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
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppStyles.yellow,
                          radius: 14,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.name,
                                style: AppStyles.kufam(
                                  16,
                                  AppStyles.blue,
                                  AppStyles.semiBold,
                                ),
                              ),
                              Text(
                                "Status: ${project.status}",
                                style: AppStyles.kufam(
                                  14,
                                  Colors.black,
                                  AppStyles.regular,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Inscrição\n${project.date}",
                            style: AppStyles.kufam(
                              14,
                              Colors.black,
                              AppStyles.regular,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            "Colaborador\n${project.collaborator}",
                            style: AppStyles.kufam(
                              14,
                              AppStyles.blue,
                              AppStyles.medium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
