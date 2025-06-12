import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_text_feild.dart';
import 'package:short_path/src/presentation/shared_widgets/snack_bar.dart';

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
            hintText: context.localization.enterYourPortfolioUrl,
            keyboardType: TextInputType.url,
            controller: viewModel.portfolioController,
            labelText: context.localization.portfolio,
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
                showSnackBar(
                    context, context.localization.invalidLink, Colors.red);
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
