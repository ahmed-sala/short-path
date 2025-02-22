import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';

abstract interface class AuthRepository {
  Future<ApiResult<void>> login(String email, String password);
  Future<ApiResult<void>> register(AppUser appUserDto);
  Future<bool> isLoggedUser();
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String?> getToken();
  Future<void> onBoardingCompleted();
  Future<bool> isOnBoardingCompleted();
}
