import 'package:injectable/injectable.dart';

import '../../../../api/api_services.dart';
import '../../../../api/core/api_request_model/login_request.dart';
import '../../../../api/core/api_response_model/auth_response.dart';
import '../../../../dto_models/auth/app_user_dto.dart';
import '../contracts/auth_online_datasource.dart';

@Injectable(as: AuthOnlineDatasource)
class AuthOnlineDataSourceImpl implements AuthOnlineDatasource {
  ApiServices _apiServices;
  AuthOnlineDataSourceImpl(this._apiServices);

  @override
  Future<AuthResponse> login(String email, String password) async {
    LoginRequest loginRequest = LoginRequest(email: email, password: password);
    var response = await _apiServices.login(loginRequest);
    return response;
  }

  @override
  Future<AuthResponse> register(AppUserDto appUserDto) async {
    var response = await _apiServices.register(appUserDto.toRegisterRequest());
    return response;
  }
}
