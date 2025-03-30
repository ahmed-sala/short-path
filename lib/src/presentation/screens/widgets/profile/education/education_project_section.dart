import 'package:short_path/src/domain/entities/user_info/education_projects_entity.dart';

import '../../../../../../core/common/common_imports.dart';
import 'education_project_widget.dart';

class EducationProjectsSection extends StatelessWidget {
  final List<EducationProjectsEntity>
      projects; // Replace dynamic with your actual project model

  const EducationProjectsSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Projects:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Column(
          children: projects
              .map((project) => EducationProjectWidget(project: project))
              .toList(),
        ),
      ],
    );
  }
}
