import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/src/presentation/screens/widgets/profile/project/project_card.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../mangers/profile/personal_profile_viewmodel.dart';

class ProjectsWidget extends StatelessWidget {
  const ProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileCubit, PersonalProfileState>(
      builder: (context, state) {
        final cubit = context.read<PersonalProfileCubit>();
        final projects = cubit.projectsEntity?.projects;

        if (projects == null || projects.isEmpty) {
          return Center(child: Text(context.localization.noProjectsAvailable));
        }
        if (state is ProjectsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: projects
                  .map((project) => ProjectCard(project: project))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
