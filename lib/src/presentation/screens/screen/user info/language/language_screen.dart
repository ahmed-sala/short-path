import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/core/styles/spacing.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/domain/usecases/user_info/user_info_usecase.dart';
import '../../../../../../core/dialogs/awesome_dialoge.dart';
import '../../../../../../core/dialogs/show_hide_loading.dart';
import '../../../../../short_path.dart';
import '../../../../mangers/auth/login/login_states.dart';
import '../../../../mangers/user_info/Language/language_viewmodel.dart';
import '../../../../shared_widgets/custom_auth_button.dart';
import '../../../widgets/user info/profile/language_input.dart';
import '../../../widgets/user info/profile/language_list_widget.dart';
import '../../../widgets/user info/profile/suggestion_list.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageViewModel viewModel = getIt.get<LanguageViewModel>();
    return BlocProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Language Details'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
            child: BlocConsumer<LanguageViewModel, LanguageState>(
              listener: (context, state) {
                switch (state) {
                  case LanguageLoading():
                    showLoading(context, 'Adding languages...');
                  case LanguageLoaded():
                    navKey.currentState!.pushReplacementNamed(RoutesName.education);
                  case LanguageError():
                    showAwesomeDialog(
                      context,
                      title: 'Error',
                      desc: state.message,
                      onOk: () {},
                      dialogType: DialogType.error,
                    );
                  default:
                }
              },
              buildWhen: (previous, current) {
                return current is LanguageInitial || current is ValidateColorButtonState;
              },
              listenWhen: (previous, current) {
                if (previous is LanguageLoading || current is LanguageError) {
                  hideLoading();
                }
                return current is! LanguageInitial;
              },
              builder: (context, state) {
                final viewModel = context.read<LanguageViewModel>();

                if (state is ValidateColorButtonState || state is LanguageInitial) {
                  return Form(
                    key: viewModel.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(20),
                        LanguageInput(viewModel: viewModel),
                        verticalSpace(20),
                        if (viewModel.filteredLanguageSuggestions.isNotEmpty && viewModel.languageController.text.isNotEmpty)
                          SuggestionList(
                            suggestions: viewModel.filteredLanguageSuggestions,
                            onTap: (int index) {
                              viewModel.selectLanguage(index);
                            },
                          ),
                        if (viewModel.languages.isNotEmpty)
                          const LanguageListWidget(),
                        verticalSpace(30),
                        CustomAuthButton(
                          text: 'NEXT',
                          onPressed: viewModel.next,
                          color: AppColors.primaryColor ,
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
