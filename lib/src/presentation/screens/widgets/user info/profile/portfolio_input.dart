import 'package:flutter/material.dart';
import 'package:short_path/src/presentation/shared_widgets/snack_bar.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../mangers/infromation_gathering/profile/profile_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_text_feild.dart';

class PortfolioInput extends StatelessWidget {
  const PortfolioInput({super.key, required this.viewModel});
  final ProfileViewmodel viewModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: CustomTextFormField(
            hintText: 'Enter your portfolio URL (GitHub, etc.)',
            keyboardType: TextInputType.url,
            controller: viewModel.portfolioController,
            labelText: 'Portfolio',
            validator: (String? text) {
              return null;
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              if (!viewModel
                  .checkValidLink(viewModel.portfolioController.text)) {
                showSnackBar(context, 'Invalid link', Colors.red);
                viewModel.portfolioController.clear();
                return;
              }
              if (viewModel.portfolioController.text.isNotEmpty) {
                viewModel.addPortfolioLink(viewModel.portfolioController.text);
              }
              viewModel.portfolioController.clear();
            },
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
