import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({Key? key}) : super(key: key);

  Widget _buildTechnologyChip(String label) {
    return Chip(
      label: Text(label, style: TextStyle(color: AppColors.primaryColor)),
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final projects = cubit.projectsEntity?.projects;

        if (projects == null || projects.isEmpty) {
          return const Center(child: Text('No projects available.'));
        }

        if (state is ProjectsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              ...projects.map((project) {
                return Card(
                  elevation: 4,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Project Title and Role
                        Row(
                          children: [
                            const Icon(Icons.work_history_outlined,
                                size: 30, color: AppColors.primaryColor),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.projectTitle,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    project.role,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Project Description
                        Text(
                          project.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 12),

                        // Project Link
                        GestureDetector(
                          onTap: () {
                            // TODO: Implement URL launch logic here.
                          },
                          child: Text(
                            project.projectLink,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Technologies Used
                        if (project.technologiesUsed.isNotEmpty) ...[
                          const Text(
                            "Technologies:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: project.technologiesUsed
                                .map((tech) => _buildTechnologyChip(tech))
                                .toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}
