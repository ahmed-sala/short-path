import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/domain/entities/user_info/work_experience_entity.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../../../core/styles/colors/app_colore.dart';
import '../profile_shared_widgets.dart';

class WorkExperienceCard extends StatelessWidget {
  final WorkExperienceEntity work;
  final String duration;

  const WorkExperienceCard({
    Key? key,
    required this.work,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableWidgets.cardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Job Title and Company Name
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.work, color: Colors.white),
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
              // Work details using the reusable listTile widget
              ReusableWidgets.listTile(
                context: context,
                title: context.localization.companyField,
                subtitle: work.companyField,
                leadingIcon: Icons.business,
              ),
              const SizedBox(height: 8),
              ReusableWidgets.listTile(
                context: context,
                title: context.localization.location,
                subtitle: work.jobLocation,
                leadingIcon: Icons.location_on,
              ),
              const SizedBox(height: 8),
              ReusableWidgets.listTile(
                context: context,
                title: context.localization.jobType,
                subtitle: work.jobType,
                leadingIcon: Icons.work_outline,
              ),
              const SizedBox(height: 8),
              ReusableWidgets.listTile(
                context: context,
                title: context.localization.duration,
                subtitle: duration,
                leadingIcon: Icons.date_range,
              ),
              const Divider(height: 24, thickness: 1),
              // Summary of the work experience
              Text(
                work.summary,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 12),
              // Tools & Technologies used as chips
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: work.toolsTechnologiesUsed
                    .map((tool) => ReusableWidgets.buildChip(tool))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
