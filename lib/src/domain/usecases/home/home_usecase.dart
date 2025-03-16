import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';
import 'package:short_path/src/domain/repositories/contract/home_repository.dart';

import '../../../data/api/core/api_request_model/job_filter_request.dart';
import '../../entities/home/jobs_entity.dart';

@injectable
class HomeUsecase {
  final AuthRepository _authRepository;
  final HomeRepository _homeRepository;
  HomeUsecase(this._authRepository, this._homeRepository);

  Future<ApiResult<AppUser?>> invoke() {
    return _authRepository.getUserData();
  }

  Future<ApiResult<JobEntity?>> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  }) async {
    return await _homeRepository.getAllJobs(
      term: term,
      page: page,
      sort: sort,
      size: size,
      jobFilterRequest: jobFilterRequest,
    );
  }
}
