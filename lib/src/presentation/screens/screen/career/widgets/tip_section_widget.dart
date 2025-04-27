import 'package:short_path/core/styles/colors/app_colore.dart';

import '../../../../../../core/common/common_imports.dart';

class TipSectionWidget extends StatelessWidget {
  const TipSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Tip: Provide specific details about the job role for the best results!',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
