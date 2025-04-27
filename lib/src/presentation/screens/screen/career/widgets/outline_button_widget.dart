import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget(
      {super.key,
      required this.jobDescription,
      required this.generateCoverSheet});
  final String jobDescription;
  final VoidCallback generateCoverSheet;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryColor,
        side: const BorderSide(color: AppColors.primaryColor, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (jobDescription.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Please add a job description.',
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          );
        } else {
          generateCoverSheet();
        }
      },
      icon: const Icon(Icons.note_add, size: 24),
      label: const Text(
        'Cover Sheet',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
