import 'package:short_path/src/presentation/screens/widgets/profile/personal_info/personal_info_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/profile_info/profile_info_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/project/project_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/skills/skills_widget.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/work_experince/work_experince_widget.dart';

import '../../../../../core/common/common_imports.dart';
import '../../../../../core/styles/colors/app_colore.dart';
import 'additional_info/additional_info_widget.dart';
import 'certification/certification_widget.dart';
import 'education/education_widget.dart';
import 'languages/language_widget.dart';

class TabWidget extends StatelessWidget {
  TabWidget({super.key});
  static const List<Tab> myTabs = <Tab>[
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
  @override
  Widget build(BuildContext context) {
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
}
