import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/additional_info/additional_info_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/additional_info/additional_info_viewmodel.dart';

import '../../../../shared_widgets/toast_dialoge.dart';

class HobbiesList extends StatelessWidget {
  const HobbiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalInfoViewmodel, AdditionalInfoState>(
      builder: (context, state) {
        final skills = context.read<AdditionalInfoViewmodel>().hobbiesList;
        if (skills.isEmpty) {
          return Text(
            context.localization.nothingAddedYet,
            style: const TextStyle(color: Colors.grey),
          );
        }
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) {
            return Chip(
              label: Text(skill),
              backgroundColor: AppColors.whiteColor,
              labelStyle: const TextStyle(color: AppColors.primaryColor),
              deleteIcon: const Icon(Icons.close, color: Colors.red),
              onDeleted: () {
                final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                if (scaffoldMessenger == null) {
                  debugPrint('ScaffoldMessenger not found in the widget tree.');
                  return;
                }

                scaffoldMessenger
                    .hideCurrentSnackBar(); // Dismiss any previous SnackBar
                context
                    .read<AdditionalInfoViewmodel>()
                    .removeHobbiesAndInterests(skill);
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('$skill '
                        '${context.localization.removedSuccessfully}'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: context.localization.undo,
                      onPressed: () {
                        Fluttertoast.cancel();
                        scaffoldMessenger
                            .hideCurrentSnackBar(); // Dismiss previous SnackBar
                        context
                            .read<AdditionalInfoViewmodel>()
                            .addHobbiesAndInterests(skill);

                        ToastDialog.show(
                            context.localization.addedBack, Colors.green);
                      },
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
