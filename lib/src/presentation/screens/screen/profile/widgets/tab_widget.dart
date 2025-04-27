import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/personal_info/personal_info_widget.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/profile_info/profile_info_widget.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/project/project_widget.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/skills/skills_widget.dart';
import 'package:short_path/src/presentation/screens/screen/profile/widgets/work_experince/work_experince_widget.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/styles/colors/app_colore.dart';
import 'additional_info/additional_info_widget.dart';
import 'certification/certification_widget.dart';
import 'education/education_widget.dart';
import 'languages/language_widget.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({super.key});

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
    return Expanded(
      child: Directionality(
        textDirection: TextDirection.ltr,
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
                  final text = tab.text;
                  if (text == context.localization.personalInfo) {
                    return const PersonalInfoWidget();
                  } else if (text == context.localization.profile) {
                    return const ProfileInfoWidget();
                  } else if (text == context.localization.workExperience) {
                    return const WorkExperienceWidget(); // Ensure the widget name matches the import
                  } else if (text == context.localization.skills) {
                    return const SkillsWidget();
                  } else if (text == context.localization.education) {
                    return const EducationWidget();
                  } else if (text == context.localization.languages) {
                    return const LanguagesWidget();
                  } else if (text == context.localization.certifications) {
                    return const CertificationsWidget();
                  } else if (text == context.localization.projects) {
                    return const ProjectsWidget();
                  } else if (text == context.localization.additionalInfo) {
                    return const AdditionalInfoWidget();
                  } else {
                    return Center(
                      child: Text('${context.localization.contentFor} $text'),
                    );
                  }
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
