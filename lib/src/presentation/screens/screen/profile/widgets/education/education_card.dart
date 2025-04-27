import 'package:intl/intl.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../../core/common/common_imports.dart';
import '../profile_shared_widgets.dart';
import 'education_header.dart';
import 'education_info_row.dart';
import 'education_project_section.dart';

class EducationCard extends StatelessWidget {
  final dynamic education;

  const EducationCard({super.key, required this.education});

  String _formatDate(DateTime date) => DateFormat.yMMM().format(date);

  @override
  Widget build(BuildContext context) {
    final graduation = education.graduationDate != null
        ? _formatDate(education.graduationDate!)
        : "Ongoing";

    return ReusableWidgets.cardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EducationHeaderSection(education: education),
          const SizedBox(height: 12),
          EducationInfoRow(
            icon: Icons.book,
            text: education.fieldOfStudy ??
                context.localization.fieldNotSpecified,
          ),
          const SizedBox(height: 8),
          EducationInfoRow(
            icon: Icons.location_on,
            text:
                education.location ?? context.localization.locationNotSpecified,
          ),
          const SizedBox(height: 8),
          EducationInfoRow(
            icon: Icons.date_range,
            text: "${context.localization.graduation}: $graduation",
          ),
          const Divider(height: 24, thickness: 1),
          if (education.projects != null && education.projects.isNotEmpty)
            EducationProjectsSection(projects: education.projects),
        ],
      ),
    );
  }
}
