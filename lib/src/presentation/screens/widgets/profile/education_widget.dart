import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

class EducationWidget extends StatelessWidget {
  const EducationWidget({Key? key}) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat.yMMM().format(date);
  }

  Widget _buildChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
      labelStyle: TextStyle(color: AppColors.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final educationDetails = cubit.educationEntity?.educationDetails;

        if (educationDetails == null || educationDetails.isEmpty) {
          return const Center(child: Text('No education details available.'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: educationDetails.map((education) {
              final String graduation = education.graduationDate != null
                  ? _formatDate(education.graduationDate!)
                  : "Ongoing";

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header: Degree & Institution Name
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: const Icon(Icons.school, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              education.degreeCertification ?? "Unknown Degree",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              education.institutionName ??
                                  "Unknown Institution",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Education Details
                  Row(
                    children: [
                      const Icon(Icons.book, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          education.fieldOfStudy ?? "Field not specified",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          education.location ?? "Location not specified",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.date_range,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "Graduation: $graduation",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, thickness: 1),

                  // Projects for this education
                  if (education.projects.isNotEmpty) ...[
                    const Text(
                      "Projects:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: education.projects.map((project) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.projectName ?? "Untitled Project",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (project.projectDescription != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  project.projectDescription!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                              if (project.projectLink != null) ...[
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    // Implement URL launch logic
                                  },
                                  child: Text(
                                    project.projectLink!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 8),
                              // Tools & Technologies Used as Chips
                              if (project.toolsTechnologies != null &&
                                  project.toolsTechnologies!.isNotEmpty)
                                Wrap(
                                  spacing: 8.0,
                                  runSpacing: 4.0,
                                  children: project.toolsTechnologies!
                                      .map((tool) => _buildChip(tool))
                                      .toList(),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 24), // Add spacing between items
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
