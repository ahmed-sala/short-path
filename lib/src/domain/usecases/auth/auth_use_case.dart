import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';

@injectable
class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<ApiResult<void>> loginInvoke(String email, String password) async {
    return await _authRepository.login(email, password);
  }

  Future<ApiResult<void>> registerInvoke(AppUser appUser) async {
    return await _authRepository.register(appUser);
  }
}
