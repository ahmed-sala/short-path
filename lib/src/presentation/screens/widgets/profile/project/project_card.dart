import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import '../profile_shared_widgets.dart';

class ProjectCard extends StatelessWidget {
  final dynamic project; // Replace with your project model type

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableWidgets.cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Role
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
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      project.role,
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            project.description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          // Link
          GestureDetector(
            onTap: () {},
            child: Text(
              project.projectLink,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Technologies Used
          if (project.technologiesUsed != null &&
              project.technologiesUsed.isNotEmpty) ...[
            Text(
              context.localization.technologies,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: project.technologiesUsed
                  .map<Widget>((tech) => ReusableWidgets.buildChip(tech))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
