import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/home/session_expiration_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/states_section_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/tab_widget.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({super.key});

  final PersonalProfileCubit personalProfileCubit =
      getIt<PersonalProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabWidget.myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
                onPressed: () {
                  showCustomDialog(
                    context,
                    title: "Logout",
                    message: "Are you sure you want to log out?",
                    onConfirm: () {
                      personalProfileCubit.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.login, (route) => false);
                    },
                  );
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.red,
                ))
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
                return const Center(child: Text('Error'));
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
