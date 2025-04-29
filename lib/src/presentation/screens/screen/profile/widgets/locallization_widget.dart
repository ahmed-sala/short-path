import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/functions/flag_helper.dart';
import '../../../../mangers/localization/localization_viewmodel.dart';

class LocalizationIcon extends StatelessWidget {
  const LocalizationIcon({super.key});

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.localization.selectLanguage),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // English Option
              GestureDetector(
                onTap: () {
                  BlocProvider.of<LocalizationViewmodel>(context)
                      .cachingLanguageCode(languageCode: "en");
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlagHelper.getFlag('english'),
                    const SizedBox(height: 8),
                    Text(context.localization.english),
                  ],
                ),
              ),
              // Arabic Option
              GestureDetector(
                onTap: () {
                  BlocProvider.of<LocalizationViewmodel>(context)
                      .cachingLanguageCode(languageCode: "ar");
                  Navigator.of(context).pop();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlagHelper.getFlag('arabic'),
                    const SizedBox(height: 8),
                    Text(
                      context.localization.arabic,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.language),
      onPressed: () => _showLanguageDialog(context),
    );
  }
}
