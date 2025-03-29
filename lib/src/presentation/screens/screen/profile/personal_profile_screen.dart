import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/profile/personal_profile_viewmodel.dart';
import 'package:short_path/src/presentation/screens/widgets/home/session_expiration_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/education_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_header_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_info_widget.dart';

import '../../widgets/profile/personal_info_widget.dart';
import '../../widgets/profile/skills_widget.dart';
import '../../widgets/profile/work_experince_widget.dart';

class PersonalProfileScreen extends StatefulWidget {
  @override
  _PersonalProfileScreenState createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
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

  PersonalProfileCubit personalProfileCubit = getIt<PersonalProfileCubit>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

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
              controller: _tabController,
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: myTabs,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                if (tab.text == 'Personal Info') {
                  return const PersonalInfoWidget();
                }
                if (tab.text == 'Profile') {
                  return const ProfileInfoWidget();
                }
                if (tab.text == 'Work Experience') {
                  return const WorkExperienceWidget();
                }
                if (tab.text == 'Skills') {
                  return const SkillsWidget();
                }
                if (tab.text == 'Education') {
                  return const EducationWidget();
                } else {
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
    return Scaffold(
      // Drawer for the hamburger menu

      appBar: AppBar(
        title: Text('Profile'),
      ),

      body: BlocProvider(
        create: (context) {
          personalProfileCubit.getUser();
          personalProfileCubit.getProfile();
          personalProfileCubit.getAdditionalInfo();
          personalProfileCubit.getLanguages();
          personalProfileCubit.getSkills();
          personalProfileCubit.getCertification();
          personalProfileCubit.getEducation();
          personalProfileCubit.getWorkExperiences();
          personalProfileCubit.getProjects();

          return personalProfileCubit;
        },
        child: BlocConsumer<PersonalProfileCubit, PersonalProfileState>(
          listener: (context, state) {
            // TODO: implement listener
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
    );
  }
}
