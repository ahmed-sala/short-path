import '../../../../../../../core/common/common_imports.dart';
import '../../../../../../../core/styles/colors/app_colore.dart';

class TechnicalSkillWidget extends StatelessWidget {
  final String skill;
  final String proficiency;

  const TechnicalSkillWidget({
    Key? key,
    required this.skill,
    required this.proficiency,
  }) : super(key: key);

  double _getProficiencyLevel(String proficiency) {
    switch (proficiency.toLowerCase()) {
      case 'beginner':
        return 0.3;
      case 'intermediate':
        return 0.6;
      case 'advanced':
        return 0.9;
      case 'expert':
        return 1.0;
      default:
        return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _getProficiencyLevel(proficiency);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation(AppColors.primaryColor),
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}
