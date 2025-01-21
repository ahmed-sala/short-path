import '../../../../api/core/api_response_model/auth_response.dart';
import '../../../../dto_models/auth/app_user_dto.dart';

abstract interface class AuthOnlineDatasource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(AppUserDto appUserDto);
}
