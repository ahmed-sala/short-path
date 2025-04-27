import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/src/presentation/mangers/career/career_viewmodel.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import '../cv_screen.dart';
import 'create_cv_handle.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({super.key, required this.vm});
  final CareerViewmodel vm;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (vm.jobDescribtion.text.isEmpty) {
          Fluttertoast.showToast(
            msg: 'Please add a job description.',
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
          );
        } else {
          handleCreateCV(context, vm);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CvScreen(),
            ),
          );
        }
      },
      icon: const Icon(Icons.description, size: 24, color: Colors.white),
      label: const Text(
        'Generate CV',
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
