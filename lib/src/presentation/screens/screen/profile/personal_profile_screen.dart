import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/dialogs/awesome_dialoge.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/home/session_expiration_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/certification_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/education_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_info_widget.dart';

import '../../widgets/profile/additional_info_widget.dart';
import '../../widgets/profile/language_widget.dart';
import '../../widgets/profile/personal_info_widget.dart';
import '../../widgets/profile/project_widget.dart';
import '../../widgets/profile/skills_widget.dart';
import '../../widgets/profile/work_experince_widget.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({Key? key}) : super(key: key);

  final PersonalProfileCubit personalProfileCubit =
      getIt<PersonalProfileCubit>();

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Personal Info'),
    Tab(text: 'Profile'),
    Tab(text: 'Work Experience'),
    Tab(text: 'Skills'),
    Tab(text: 'Education'),
    Tab(text: 'Languages'),
    Tab(text: 'Certifications'),
    Tab(text: 'Projects'),
    Tab(text: 'Additional Info'),
  ];

  Widget _buildStatsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Projects', '12'),
          _buildStatItem('Experience', '5 yrs'),
          _buildStatItem('Clients', '8'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 14.0, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTabSection() {
    return Expanded(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TabBar(
              isScrollable: true,
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: myTabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: myTabs.map((Tab tab) {
                switch (tab.text) {
                  case 'Personal Info':
                    return const PersonalInfoWidget();
                  case 'Profile':
                    return const ProfileInfoWidget();
                  case 'Work Experience':
                    return const WorkExperienceWidget();
                  case 'Skills':
                    return const SkillsWidget();
                  case 'Education':
                    return const EducationWidget();
                  case 'Languages':
                    return const LanguagesWidget();
                  case 'Certifications':
                    return const CertificationsWidget();
                  case 'Projects':
                    return const ProjectsWidget();
                  case 'Additional Info':
                    return const AdditionalInfoWidget();
                  default:
                    return Center(child: Text('Content for ${tab.text}'));
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
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
                return Center(child: CircularProgressIndicator());
              }
              if (state is PersonalProfileError) {
                return Center(child: Text('Error'));
              }
              if (state is SessionExpired) {
                return const SessionExpirationWidget();
              }
              return Column(
                children: [
                  const ProfileHeaderWidget(),
                  _buildStatsSection(),
                  const SizedBox(height: 16.0),
                  _buildTabSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
