import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../../../../../../../core/styles/colors/app_colore.dart';
import '../profile_shared_widgets.dart';

class EducationProjectWidget extends StatelessWidget {
  final dynamic project; // Replace dynamic with your actual project model

  const EducationProjectWidget({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.projectName ?? context.localization.untitledProject,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                // Implement URL launch logic here.
              },
              child: Text(
                project.projectLink!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
          const SizedBox(height: 8),
          if (project.toolsTechnologies != null &&
              project.toolsTechnologies.isNotEmpty)
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: project.toolsTechnologies
                  .map<Widget>((tool) => ReusableWidgets.buildChip(tool))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
