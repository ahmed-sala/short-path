import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/functions/flag_helper.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class LanguageProficiencyRow extends StatelessWidget {
  final String language;
  final String level;

  const LanguageProficiencyRow({
    Key? key,
    required this.language,
    required this.level,
  }) : super(key: key);

  /// Converts a proficiency level string to a corresponding progress value.
  double _getProficiencyValue(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return 0.3;
      case 'intermediate':
        return 0.6;
      case 'advanced':
        return 0.9;
      case 'native':
      case 'fluent':
        return 1.0;
      default:
        return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = _getProficiencyValue(level);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          // Display the flag for the language.
          FlagHelper.getFlag(language),
          const SizedBox(width: 10),
          // Expanded progress indicator.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[300],
                  valueColor:
                      const AlwaysStoppedAnimation(AppColors.primaryColor),
                  minHeight: 6,
                ),
                const SizedBox(height: 4),
                Text(
                  level,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
