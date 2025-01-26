import 'package:flutter/material.dart';

import '../../../../../../core/styles/spacing.dart';

class EducationHeader extends StatelessWidget {
  const EducationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Add Your Education',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        verticalSpace(10),
        Text(
          'Fill in your education details',
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
