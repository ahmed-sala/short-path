import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/profile_header_widget.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/states_section_widget.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/tab_widget.dart';
import 'package:short_path/src/short_path.dart';

import '../../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../../config/helpers/shared_pref/shared_pref_helper.dart';
import '../../../shared_widgets/custom_auth_button.dart';
import '../../../shared_widgets/session_expiration_widget.dart';
import 'widgets/locallization_widget.dart';

// ←– Import the PersonalInfoWidget
import 'widgets/personal_info/personal_info_widget.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({super.key});

  final PersonalProfileCubit _personalProfileCubit =
  getIt<PersonalProfileCubit>();

  @override
  Widget build(BuildContext context) {
    // Define all tabs
    final List<Tab> myTabs = <Tab>[
      Tab(text: context.localization.personalInfo),
      Tab(text: context.localization.profile),
      Tab(text: context.localization.workExperience),
      Tab(text: context.localization.skills),
      Tab(text: context.localization.education),
      Tab(text: context.localization.languages),
      Tab(text: context.localization.certifications),
      Tab(text: context.localization.projects),
      Tab(text: context.localization.additionalInfo),
    ];

    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.localization.profile,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          elevation: 2,
          centerTitle: false,
          actions: [
            const LocalizationIcon(),
            IconButton(
              onPressed: () {
                showCustomDialog(
                  context,
                  title: context.localization.logout,
                  message: context.localization.logoutConfirmation,
                  onConfirm: () {
                    _personalProfileCubit.logout();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.login,
                          (route) => false,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.redAccent,
                size: 24,
              ),
              tooltip: context.localization.logout,
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocProvider<PersonalProfileCubit>(
          create: (context) {
            final hasCv =
                getIt<SharedPreferences>().getBool(SharedPrefKeys.completeCv) ??
                    false;
            _personalProfileCubit.getUser();
            if (hasCv) {
              _personalProfileCubit
                ..getProfile()
                ..getWorkExperiences()
                ..getSkills()
                ..getEducation()
                ..getLanguages()
                ..getCertification()
                ..getProjects()
                ..getAdditionalInfo();
            }
            return _personalProfileCubit;
          },
          child: BlocConsumer<PersonalProfileCubit, PersonalProfileState>(
            listener: (context, state) {
              if (state is LogOutLoadingState) {
                // optional: show loading spinner or toast
              }
            },
            builder: (context, state) {
              if (state is PersonalProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PersonalProfileError) {
                return Center(child: Text(context.localization.errorOccurred));
              }
              if (state is SessionExpired) {
                return const SessionExpirationWidget();
              }

              // At this point, user data is loaded (or at least attempted).
              return FutureBuilder<bool>(
                future: SharedPrefsService.hasFilledCV(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final hasFilledCV = snapshot.data!;
                  if (hasFilledCV) {
                    // FULL CV – show header, states, and tabs
                    return const Column(
                      children: [
                        ProfileHeaderWidget(),
                        SizedBox(height: 12),
                        StatesSectionWidget(),
                        SizedBox(height: 16),
                        // TabBar
                        // Material(
                        //   color: Colors.white,
                        //   elevation: 1,
                        //   child: TabBar(
                        //     isScrollable: true,
                        //     indicatorColor: Theme.of(context).primaryColor,
                        //     labelColor: Theme.of(context).primaryColor,
                        //     unselectedLabelColor: Colors.grey.shade600,
                        //     tabs: myTabs,
                        //     labelStyle: const TextStyle(
                        //         fontSize: 14, fontWeight: FontWeight.w600),
                        //     unselectedLabelStyle: const TextStyle(fontSize: 14),
                        //   ),
                        // ),
                        // Tab content
                        TabWidget(),
                      ],
                    );
                  } else {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const ProfileHeaderWidget(),
                            const SizedBox(height: 20),
                            const Expanded(child: PersonalInfoWidget()),
                            const SizedBox(height: 30),
                            CustomAuthButton(
                              text: context.localization.fillInYourCV,
                              onPressed: () {
                                getIt<SharedPreferences>()
                                    .setBool(SharedPrefKeys.completeCv, true);
                                navKey.currentState?.pushNamedAndRemoveUntil(
                                  RoutesName.profile,
                                      (route) => false,
                                );
                              },
                              color: Theme
                                  .of(context)
                                  .primaryColor,
                              textColor: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
