import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/dialogs/show_hide_loading.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_state.dart';
import 'package:short_path/src/presentation/mangers/user_info/Language/language_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/language_input.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/language_list_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/user%20info/profile/suggestion_list.dart';
import 'package:short_path/src/presentation/shared_widgets/custom_auth_button.dart';
import 'package:short_path/src/short_path.dart';

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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: BlocConsumer<LanguageViewmodel, LanguageState>(
                  listener: (context, state) {
                    if (state is AddLanguageLoading) {
                      showLoading(context, 'Adding languages');
                    }
                    if (state is AddLanguageSuccess) {
                      navKey.currentState!.pushNamedAndRemoveUntil(
                          RoutesName.skillGathering, (route) => false);
                    }
                    if (state is AddLanguageError) {
                      showAwesomeDialog(context,
                          title: 'Error',
                          desc: state.message,
                          onOk: () {},
                          dialogType: DialogType.error);
                    }
                  },
                  listenWhen: (previous, current) {
                    if (previous is AddLanguageLoading ||
                        current is AddLanguageError) {
                      hideLoading();
                    }
                    return current is! LanguageInitial;
                  },
                  builder: (context, state) {
                    final viewModel = context.read<LanguageViewmodel>();

                    return Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LanguageInput(viewModel: viewModel),
                          verticalSpace(20),
                          if (viewModel
                                  .filteredLanguageSuggestions.isNotEmpty &&
                              viewModel.languageController.text.isNotEmpty)
                            SuggestionList(
                              suggestions:
                                  viewModel.filteredLanguageSuggestions,
                              onTap: viewModel.selectLanguage,
                            ),
                          if (viewModel.languages.isNotEmpty)
                            const LanguageListWidget(),
                          verticalSpace(30),
                          CustomAuthButton(
                              text: 'NEXT',
                              onPressed: () {
                                viewModel.next();
                              },
                              color: AppColors.primaryColor),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
