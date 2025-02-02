import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/colors/app_colore.dart';
import '../../../../../../core/styles/spacing.dart';
import '../../../../../../dependency_injection/di.dart';
import '../../../../../data/static_data/demo_data_list.dart';
import '../../../../mangers/user_info/Language/language_state.dart';
import '../../../../mangers/user_info/Language/language_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../widgets/user info/profile/language_input.dart';
import '../../../widgets/user info/profile/language_list_widget.dart';
import '../../../widgets/user info/profile/suggestion_list.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageViewmodel viewModel = getIt.get<LanguageViewmodel>();
    return BlocProvider<LanguageViewmodel>(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Details',
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocBuilder<LanguageViewmodel, LanguageState>(
              builder: (context, state) {
                final viewModel = context.read<LanguageViewmodel>();

                  return Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LanguageInput(viewModel: viewModel),
                        verticalSpace(20),
                        if (viewModel.filteredLanguageSuggestions.isNotEmpty &&
                            viewModel.languageController.text.isNotEmpty)
                          SuggestionList(
                            suggestions: viewModel.filteredLanguageSuggestions,
                            onTap: viewModel.selectLanguage,
                          ),
                        if (viewModel.languages.isNotEmpty)
                          const LanguageListWidget(),
                        verticalSpace(30),
                        CustomAuthButton(
                          text: 'NEXT',
                          onPressed: () {},
                          color: viewModel.validate
                              ? AppColors.primaryColor
                              : const Color(0xFF5C6673),
                        ),
                      ],
                    ),
                  );
                },
            ),
          ),
        ),
      ),
    );
  }
}
