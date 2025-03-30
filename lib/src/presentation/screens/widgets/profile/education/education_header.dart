import 'package:short_path/src/domain/entities/user_info/education_detail_entity.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class EducationHeaderSection extends StatelessWidget {
  final EducationDetailEntity education;

  const EducationHeaderSection({super.key, required this.education});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          child: Icon(Icons.school, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.degreeCertification ?? "Unknown Degree",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                education.institutionName ?? "Unknown Institution",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
