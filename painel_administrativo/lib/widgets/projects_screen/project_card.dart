import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/project.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
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

  void _showEditDialog(BuildContext context, int index) {
    final project = projects[index];
    final nameController = TextEditingController(text: project.name);
    final dateController = TextEditingController(text: project.date);
    final collaboratorController = TextEditingController(
      text: project.collaborator,
    );
    final formKey = GlobalKey<FormState>();
    String? selectedStatus = project.status; // Store the selected status

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppStyles.white,
          contentPadding: const EdgeInsets.all(24),
          title: Row(
            children: [
              const Icon(Icons.edit, color: AppStyles.blue, size: 24),
              const SizedBox(width: 8),
              Text(
                'Editar Projeto',
                style: AppStyles.kufam(20, AppStyles.blue, AppStyles.semiBold),
              ),
            ],
          ),
          content: SizedBox(
            width: 700,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    enabled: false, // Read-only
                    decoration: InputDecoration(
                      labelText: 'Nome do Projeto',
                      labelStyle: AppStyles.kufam(
                        14,
                        AppStyles.black,
                        AppStyles.regular,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppStyles.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: InputDecoration(
                      labelText: 'Status',
                      labelStyle: AppStyles.kufam(
                        14,
                        AppStyles.black,
                        AppStyles.regular,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppStyles.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                    items: const [
                      DropdownMenuItem(
                        value: 'finalizado',
                        child: Text('Finalizado'),
                      ),
                      DropdownMenuItem(
                        value: 'desenvolvimento',
                        child: Text('Desenvolvimento'),
                      ),
                      DropdownMenuItem(
                        value: 'análise', // Added as a third option
                        child: Text('Análise'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, selecione o status';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: dateController,
                    enabled: false, // Read-only
                    decoration: InputDecoration(
                      labelText: 'Data',
                      labelStyle: AppStyles.kufam(
                        14,
                        AppStyles.black,
                        AppStyles.regular,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppStyles.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: collaboratorController,
                    enabled: false, // Read-only
                    decoration: InputDecoration(
                      labelText: 'Colaborador',
                      labelStyle: AppStyles.kufam(
                        14,
                        AppStyles.black,
                        AppStyles.regular,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppStyles.blue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text(
                    'Cancelar',
                    style: AppStyles.kufam(
                      14,
                      AppStyles.black,
                      AppStyles.medium,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        projects[index] = Project(
                          name: project.name, // Keep original name
                          status:
                              selectedStatus!, // Update with selected status
                          date: project.date, // Keep original date
                          collaborator: project
                              .collaborator, // Keep original collaborator
                        );
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: Text(
                    'Salvar',
                    style: AppStyles.kufam(
                      14,
                      AppStyles.white,
                      AppStyles.medium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

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
                Color circleColor;
                switch (project.status.toLowerCase()) {
                  case 'desenvolvimento':
                    circleColor = Colors.yellow;
                    break;
                  case 'finalizado':
                    circleColor = Colors.green;
                    break;
                  default:
                    circleColor = Colors.red;
                    break;
                }
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
                        CircleAvatar(backgroundColor: circleColor, radius: 14),
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
                        IconButton(
                          onPressed: () {
                            _showEditDialog(context, index);
                          },
                          icon: const Icon(Icons.edit),
                          iconSize: 20,
                          
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
