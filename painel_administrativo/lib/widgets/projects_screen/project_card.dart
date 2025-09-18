import 'package:flutter/material.dart';
import 'package:painel_administrativo/models/project.dart';
import 'package:painel_administrativo/data/service/project_service.dart';
import 'package:painel_administrativo/styles/app_styles.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final List<ProjectView> projects;
  final VoidCallback onStatusUpdated;

  const ProjectCard({
    super.key,
    required this.projects,
    required this.onStatusUpdated,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final ProjectService _projectService = ProjectService();

  final Map<String, int> statusMap = {
    'Análise': 1,
    'Desenvolvimento': 2,
    'Finalizado': 3,
  };

  void _showEditDialog(BuildContext context, ProjectView project) {
    final nameController = TextEditingController(text: project.titulo);
    final dateController =
        TextEditingController(text: DateFormat('dd/MM/yyyy').format(project.dataInicio));
    final descricaoController =
        TextEditingController(text: project.descricao);
    final colaboradorController =
        TextEditingController(text: project.nomeColaborador);

    final formKey = GlobalKey<FormState>();

    String selectedStatus = project.status;
    if (!statusMap.containsKey(selectedStatus)) {
      selectedStatus = 'Análise';
    }

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
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
                    style: AppStyles.kufam(
                        20, AppStyles.blue, AppStyles.semiBold),
                  ),
                ],
              ),
              content: SizedBox(
                width: 700,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: nameController,
                          enabled: false,
                          decoration: AppStyles.customInputDecoration(
                            labelText: 'Nome do Projeto',
                          ),
                          style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: descricaoController,
                          enabled: false,
                          decoration: AppStyles.customInputDecoration(
                            labelText: 'Descrição',
                          ),
                          style: AppStyles.kufam(14, AppStyles.black, AppStyles.medium),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: colaboradorController,
                          enabled: false,
                          decoration: AppStyles.customInputDecoration(
                            labelText: 'Colaborador',
                          ),
                          style: AppStyles.kufam(14, AppStyles.blue, AppStyles.medium),
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: selectedStatus,
                          decoration: AppStyles.customInputDecoration(
                            labelText: 'Status',
                          ),
                          style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                          items: statusMap.keys.map((String statusName) {
                            return DropdownMenuItem<String>(
                              value: statusName,
                              child: Text(statusName),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedStatus = value!;
                            });
                          },
                          validator: (value) {
                            if (value == null || !statusMap.keys.contains(value)) {
                              return 'Por favor, selecione um status válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: dateController,
                          enabled: false,
                          decoration: AppStyles.customInputDecoration(
                            labelText: 'Data de Início',
                          ),
                          style: AppStyles.kufam(14, Colors.black, AppStyles.regular),
                        ),
                        
                        // CÓDIGO DO BOTÃO "ABRIR ARQUIVO"
                        if (project.caminhoArquivo != null &&
                            project.caminhoArquivo!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                "Arquivos:",
                                style: AppStyles.kufam(14, AppStyles.black, AppStyles.medium),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () => _abrirArquivo(project.caminhoArquivo!),
                                child: Text(
                                  project.nomeArquivo, // Se sua view tiver o nome do arquivo
                                  style: AppStyles.kufam(14, AppStyles.blue, AppStyles.medium),
                                ),
                              ),
                              const Icon(Icons.file_present, size: 20, color: AppStyles.blue),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancelar',
                    style: AppStyles.kufam(14, AppStyles.black, AppStyles.medium),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      final newStatusId = statusMap[selectedStatus];
                      if (newStatusId != null) {
                        await _projectService.updateProjectStatus(
                            project.idProjeto, newStatusId);
                        Navigator.of(context).pop();
                        widget.onStatusUpdated();
                      }
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
                    style: AppStyles.kufam(14, AppStyles.white, AppStyles.medium),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _abrirArquivo(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Não foi possível abrir o arquivo: $url");
    }
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
            color: AppStyles.grey.withOpacity(0.2),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.projects.length,
              itemBuilder: (context, index) {
                final project = widget.projects[index];
                Color circleColor;

                switch (project.status.toLowerCase()) {
                  case 'desenvolvimento':
                    circleColor = Colors.yellow;
                    break;
                  case 'finalizado':
                    circleColor = Colors.green;
                    break;
                  case 'análise':
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: circleColor,
                          radius: 14,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.titulo,
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
                              if (project.nomeProjetoTipo.isNotEmpty)
                                Text(
                                  "Tipo: ${project.nomeProjetoTipo}",
                                  style: AppStyles.kufam(
                                    12,
                                    Colors.grey[700]!,
                                    AppStyles.regular,
                                  ),
                                ),
                              
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Início\n${DateFormat('dd/MM/yyyy').format(project.dataInicio)}",
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
                            "Colaborador\n${project.nomeColaborador}",
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
                            _showEditDialog(context, project);
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