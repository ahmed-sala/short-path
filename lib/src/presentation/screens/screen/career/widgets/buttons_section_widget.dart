import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/career/career_viewmodel.dart';
import 'icon_button_widget.dart';
import 'outline_button_widget.dart';

class ButtonsSectionWidget extends StatelessWidget {
  const ButtonsSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<CareerViewmodel>();
    return Row(
      children: [
        Expanded(
          child: IconButtonWidget(vm: vm),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlineButtonWidget(
            jobDescription: vm.jobDescribtion.text,
            generateCoverSheet: vm.generateCoverSheet,
          ),
        ),
      ],
    );
  }
}
