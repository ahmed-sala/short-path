import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/education/education_viewmodel.dart';

import '../../../../shared_widgets/toast_dialoge.dart';

class EducationListWidget extends StatelessWidget {
  const EducationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EducationViewmodelNew, EducationState>(
      builder: (context, state) {
        final items = context.read<EducationViewmodelNew>().educationDetails;
        if (items.isEmpty) {
          return Center(
            child: Text(
              context.localization.nothingAddedYet,
              style: const TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: items.map((edu) {
              return Container(
                width: 220,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header row: Institution + delete button
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                edu.institutionName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _onDelete(context, edu),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        // Degree
                        if (edu.degreeCertification != null &&
                            edu.degreeCertification!.isNotEmpty)
                          Text(
                            edu.degreeCertification!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        // Years / Duration
                        if (edu.graduationDate != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              '${edu.graduationDate ?? ''}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _onDelete(BuildContext context, edu) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    context.read<EducationViewmodelNew>().removeEducation(edu);

    messenger.showSnackBar(
      SnackBar(
        content: Text(
          '${edu.institutionName} ${context.localization.removedSuccessfully}',
        ),
        backgroundColor: Colors.red[600],
        action: SnackBarAction(
          label: context.localization.undo,
          textColor: Colors.white,
          onPressed: () {
            Fluttertoast.cancel();
            messenger.hideCurrentSnackBar();
            context.read<EducationViewmodelNew>().addEducation();
            ToastDialog.show(
              '${edu.institutionName} ${context.localization.addedBack}',
              Colors.green,
            );
          },
        ),
      ),
    );
  }
}
