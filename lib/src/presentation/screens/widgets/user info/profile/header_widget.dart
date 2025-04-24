import 'package:flutter/material.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/spacing.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.localization.createYourCV,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        verticalSpace(15),
      ],
    );
  }
}
