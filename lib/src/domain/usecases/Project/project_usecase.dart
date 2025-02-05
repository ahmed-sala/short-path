import 'package:injectable/injectable.dart';

import '../../entities/user_info/Project_Entity.dart';

@injectable
class ProjectUsecase {
  void invoke(ProjectEntity project) {
    print('Project Title: ${project.projectTitle}');
    print('Role: ${project.role}');
    print('Description: ${project.description}');
    print('Technologies Used: ${project.technologiesUsed}');
  }
}
