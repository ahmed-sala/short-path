import 'package:injectable/injectable.dart';
import '../../entities/infromation_gathering/EducationProject_Entity.dart';

@injectable
class EducationProjectUsecase {
  void invoke(EducationProjectEntity educationProject) {
    print('Project Name: ${educationProject.projectName}');
    print('Project Description: ${educationProject.projectDescription}');
    print('Project Link: ${educationProject.projectLink}');
    print('Tools/Technologies: ${educationProject.toolsTechnologies}');
  }
}