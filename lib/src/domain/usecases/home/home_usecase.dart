import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';

@injectable
class HomeUsecase {
  final AuthRepository _authRepository;
  HomeUsecase(this._authRepository);

  Future<ApiResult<AppUser?>> invoke() {
    return _authRepository.getUserData();
  }
}
