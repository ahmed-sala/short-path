import 'package:short_path/src/data/api/core/api_response_model/auth_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/get_user_response.dart';
import 'package:short_path/src/data/dto_models/auth/app_user_dto.dart';

abstract interface class AuthOnlineDatasource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(AppUserDto appUserDto);
  Future<GetUserResponse> getUserData(String token);
}
