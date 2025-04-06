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
            label: 'Projects',
            value: '12',
          ),
          StateItemWidget(
            label: 'Experience',
            value: '5 yrs',
          ),
          StateItemWidget(
            label: 'Clients',
            value: '8',
          ),
        ],
      ),
    );
  }
}
