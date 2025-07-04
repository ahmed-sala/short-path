import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/spacing.dart';

class EducationHeader extends StatelessWidget {
  const EducationHeader({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpace(10),
        Text(
          context.localization.fillInYourEducationDetails,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
