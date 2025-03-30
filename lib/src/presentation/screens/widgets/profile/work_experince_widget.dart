import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';

class WorkExperienceWidget extends StatelessWidget {
  const WorkExperienceWidget({Key? key}) : super(key: key);

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
        final workExperiences = cubit.workExperienceEntity;

        if (workExperiences == null || workExperiences.isEmpty) {
          return const Center(child: Text('No work experience available.'));
        }

        if (state is WorkExperienceLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: workExperiences.map((work) {
                final String duration = work.endDate != null
                    ? '${_formatDate(work.startDate)} - ${_formatDate(work.endDate!)}'
                    : '${_formatDate(work.startDate)} - Present';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Job Title and Company Name
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: const Icon(Icons.work, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                work.jobTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                work.companyName,
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
                    // Details row
                    Row(
                      children: [
                        const Icon(Icons.business,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            work.companyField,
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
                            work.jobLocation,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.work_outline,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            work.jobType,
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
                            duration,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24, thickness: 1),
                    // Summary
                    Text(
                      work.summary,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    // Tools & Technologies Used as Chips
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: work.toolsTechnologiesUsed
                          .map((tool) => _buildChip(tool))
                          .toList(),
                    ),
                    const SizedBox(height: 24), // Add spacing between items
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
