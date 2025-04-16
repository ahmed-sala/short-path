import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';

abstract interface class AuthRepository {
  Future<ApiResult<void>> login(String email, String password);
  Future<ApiResult<void>> register(AppUser appUserDto);
  Future<ApiResult<AppUser?>> getUserData();
  Future<void>logout();
}
