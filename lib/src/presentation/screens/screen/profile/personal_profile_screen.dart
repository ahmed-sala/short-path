import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/home/session_expiration_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/states_section_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/tab_widget.dart';

import '../../widgets/profile/locallization_widget.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({Key? key}) : super(key: key);

  final PersonalProfileCubit personalProfileCubit =
      getIt<PersonalProfileCubit>();

  @override
  Widget build(BuildContext context) {
    List<Tab> myTabs = <Tab>[
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
          title: Text(context.localization.profile),
          actions: [
            const LocalizationIcon(),
            IconButton(
              onPressed: () {
                showCustomDialog(
                  context,
                  title: context.localization.location,
                  message: context.localization.logoutConfirmation,
                  onConfirm: () {
                    personalProfileCubit.logout();
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
                color: Colors.red,
              ),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) {
            personalProfileCubit.getUser();
            personalProfileCubit.getProfile();
            personalProfileCubit.getWorkExperiences();
            personalProfileCubit.getSkills();
            personalProfileCubit.getEducation();
            personalProfileCubit.getLanguages();
            personalProfileCubit.getCertification();
            personalProfileCubit.getProjects();
            personalProfileCubit.getAdditionalInfo();
            return personalProfileCubit;
          },
          child: BlocConsumer<PersonalProfileCubit, PersonalProfileState>(
            listener: (context, state) {
              if (state is LogOutLoadingState) {}
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
              return Column(
                children: [
                  const ProfileHeaderWidget(),
                  const StatesSectionWidget(),
                  const SizedBox(height: 16.0),
                  TabWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
