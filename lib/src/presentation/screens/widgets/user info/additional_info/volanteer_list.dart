import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/additional_info/additional_info_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/additional_info/additional_info_viewmodel.dart';

class VolanteerList extends StatelessWidget {
  const VolanteerList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalInfoViewmodel, AdditionalInfoState>(
      builder: (context, state) {
        // Assuming volunteerWorkList is a list of objects with
        // description, year, and month properties.
        final volunteerWorks =
            context.read<AdditionalInfoViewmodel>().volunteerWorkList;

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: volunteerWorks.map((work) {
            // Create a label that shows the description, years, and months.
            final workLabel =
                '${work.description} - ${work.year} year${work.year != 1 ? 's' : ''}, ${work.month} month${work.month != 1 ? 's' : ''}';
            return Chip(
              label: Text(workLabel),
              backgroundColor: AppColors.whiteColor,
              labelStyle: const TextStyle(color: AppColors.primaryColor),
              deleteIcon: const Icon(Icons.close, color: Colors.red),
              onDeleted: () {
                // Use ScaffoldMessenger to manage SnackBars
                final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
                if (scaffoldMessenger == null) {
                  debugPrint('ScaffoldMessenger not found in the widget tree.');
                  return;
                }

                // Hide any existing SnackBar
                scaffoldMessenger.hideCurrentSnackBar();

                // Remove the volunteer work from the list.
                context
                    .read<AdditionalInfoViewmodel>()
                    .removeVolunteerWork(work);

                // Show a SnackBar with an Undo action.
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content:
                        Text('"${work.description}" removed successfully!'),
                    backgroundColor: Colors.red,
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        scaffoldMessenger.hideCurrentSnackBar();
                        context
                            .read<AdditionalInfoViewmodel>()
                            .addVolunteerWork(work);
                        scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('"${work.description}" added back!'),
                            backgroundColor: Colors.green,
                          ),
                        );
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
