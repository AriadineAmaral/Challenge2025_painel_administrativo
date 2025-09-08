import 'package:flutter/material.dart';
import 'package:painel_administrativo/styles/app_styles.dart';

class ProjectCard extends StatelessWidget {
  final String name;
  final String status;
  final String date;
  final String collaborator;
  final VoidCallback onDetails;

  const ProjectCard({
    super.key,
    required this.name,
    required this.status,
    required this.date,
    required this.collaborator,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    final styles = AppStyles();

    return Center(
      child: SizedBox(
        width: 800,
        height: 90,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ), 
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppStyles.yellow,
                    radius: 12,
                  ),
                  const SizedBox(width: 12), 
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: styles.kufam(
                            14,
                            AppStyles.blue,
                            AppStyles.semiBold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                         
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Status: $status",
                                style: styles.kufam(
                                  12,
                                  Colors.black,
                                  AppStyles.regular,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Inscrição",
                                    style: styles.kufam(
                                      12,
                                      Colors.black,
                                      AppStyles.regular,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    date,
                                    style: styles.kufam(
                                      12,
                                      Colors.blue,
                                      AppStyles.regular,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Colaborador:",
                                    style: styles.kufam(
                                      12,
                                      AppStyles.blue,
                                      AppStyles.medium,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    collaborator,
                                    style: styles.kufam(
                                      12,
                                      AppStyles.blue,
                                      AppStyles.medium,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ), 
                  GestureDetector(
                    onTap: onDetails,
                    child: Text(
                      "Ver detalhes",
                      style: styles.akatab(12, AppStyles.blue, AppStyles.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
