import 'package:lottie/lottie.dart';
import 'package:short_path/core/styles/animations/app_animation.dart';

import '../../../../../core/common/common_imports.dart';

class NoJobsWidget extends StatelessWidget {
  const NoJobsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // You can use a local asset or network Lottie animation
          Lottie.asset(
            AppAnimation.emptyListAnim, // replace with your Lottie file path
            width: 250,
            height: 250,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          const Text(
            'No Jobs Available',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please check back later.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
