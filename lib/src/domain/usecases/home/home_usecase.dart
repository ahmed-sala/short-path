import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/entities/home/job_entity.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';
import 'package:short_path/src/domain/repositories/contract/home_repository.dart';

@injectable
class HomeUsecase {
  final AuthRepository _authRepository;
  final HomeRepository _homeRepository;
  HomeUsecase(this._authRepository, this._homeRepository);

  Future<ApiResult<AppUser?>> invoke() {
    return _authRepository.getUserData();
  }

  Future<ApiResult<List<JobEntity>?>> getAllJobs() async {
    return await _homeRepository.getAllJobs();
  }
}
