import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../config/routes/routes_name.dart';
import '../../../../../core/common/common_imports.dart';
import '../../../../../core/styles/colors/app_colore.dart';
import '../../../../short_path.dart';
import '../../../shared_widgets/custom_auth_button.dart';

class SessionExpirationWidget extends StatelessWidget {
  const SessionExpirationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.localization.sessionExpired,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CustomAuthButton(
          text: context.localization.goToLogin,
          onPressed: () {
            navKey.currentState!
                .pushNamedAndRemoveUntil(RoutesName.login, (route) => false);
          },
          color: AppColors.primaryColor,
        ),
      ],
    );
  }
}
