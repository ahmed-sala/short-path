import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/repositories/contract/user_info_repository.dart';

import '../../entities/user_info/Project_Entity.dart';

@injectable
class ProjectUsecase {
  UserInfoRepository _userInfoRepository;
  ProjectUsecase(this._userInfoRepository);
  Future<ApiResult<void>> invoke(ProjectsEntity project) async {
    return await _userInfoRepository.saveProjects(project);
  }
}
