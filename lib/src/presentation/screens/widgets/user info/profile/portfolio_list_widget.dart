import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/profile/profile_viewmodel.dart';
import 'package:short_path/src/presentation/shared_widgets/snack_bar.dart';

import '../../../../shared_widgets/toast_dialoge.dart';

class PortfolioListWidget extends StatelessWidget {
  const PortfolioListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewmodel, ProfileState>(
      listener: (context, state) {
        if (state is PortfolioLinkRemoved) {
          showSnackBar(
            context,
            '${state.link} ${context.localization.removedSuccessfully}',
            Colors.red,
            actionLabel: context.localization.undo,
            onActionPressed: () {
              context.read<ProfileViewmodel>().addPortfolioLink(state.link);
              ToastDialog.show(
                  context.localization.addedSuccessfully, Colors.green);
            },
          );
        }
      },
      builder: (context, state) {
        final portfolioLinks = context.read<ProfileViewmodel>().portfolioLinks;

        if (portfolioLinks.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              context.localization.nothingAddedYet,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: portfolioLinks.map((link) {
              final displayText = Uri.tryParse(link)?.host ?? link;
              var isValidEmail =
                  context.read<ProfileViewmodel>().checkValidLink(link);
              if (!isValidEmail) {
                return Container();
              }
              return _buildPortfolioChip(context, link, displayText);
            }).toList(),
          ),
        );
      },
    );
  }

  // Function to build a single portfolio chip
  Widget _buildPortfolioChip(
      BuildContext context, String link, String displayText) {
    // Extract the host (e.g., "example.com") from the link

    return Chip(
      label: Text(
        displayText, // Show only the host part of the link
        style: const TextStyle(fontSize: 16),
      ),
      backgroundColor: AppColors.whiteColor,
      labelStyle: const TextStyle(color: AppColors.primaryColor),
      deleteIcon: const Icon(Icons.close, color: Colors.red),
      onDeleted: () {
        context.read<ProfileViewmodel>().removePortfolioLink(link);
      },
    );
  }
}
