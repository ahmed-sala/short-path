import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/state_item_widget.dart';

import '../../../../../core/common/common_imports.dart';

class StatesSectionWidget extends StatelessWidget {
  const StatesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StateItemWidget(
            label: context.localization.projects,
            value: '12',
          ),
          StateItemWidget(
            label: context.localization.experience,
            value: '5 ${context.localization.yrs}',
          ),
        ],
      ),
    );
  }
}
