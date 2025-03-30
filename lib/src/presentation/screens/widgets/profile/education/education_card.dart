import 'package:intl/intl.dart';

import '../../../../../../core/common/common_imports.dart';
import '../profile_shared_widgets.dart';
import 'education_header.dart';
import 'education_info_row.dart';
import 'education_project_section.dart';

class EducationCard extends StatelessWidget {
  final dynamic education;

  const EducationCard({Key? key, required this.education}) : super(key: key);

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
            text: education.fieldOfStudy ?? "Field not specified",
          ),
          const SizedBox(height: 8),
          EducationInfoRow(
            icon: Icons.location_on,
            text: education.location ?? "Location not specified",
          ),
          const SizedBox(height: 8),
          EducationInfoRow(
            icon: Icons.date_range,
            text: "Graduation: $graduation",
          ),
          const Divider(height: 24, thickness: 1),
          if (education.projects != null && education.projects.isNotEmpty)
            EducationProjectsSection(projects: education.projects),
        ],
      ),
    );
  }
}
