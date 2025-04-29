import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../config/routes/routes_name.dart';
import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../short_path.dart';

class RecentRowWidget extends StatelessWidget {
  const RecentRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              context.localization.recentJobList,
              style: const TextStyle(
                color: Color(0xFF150B3D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                navKey.currentState!.pushNamed(RoutesName.jobsScreen);
              },
              child: Text(
                context.localization.seeAll,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.underline,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
