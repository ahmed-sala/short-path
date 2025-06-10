import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/config/helpers/shared_pref/shared_pre_keys.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/data/api/api_services.dart';
import 'package:short_path/src/data/api/core/api_request_model/auth/login_request.dart';
import 'package:short_path/src/data/api/core/api_response_model/auth_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/get_user_response.dart';
import 'package:short_path/src/data/data_source/online_data_source/auth/contracts/auth_online_datasource.dart';
import 'package:short_path/src/data/dto_models/auth/app_user_dto.dart';

@Injectable(as: AuthOnlineDatasource)
class AuthOnlineDataSourceImpl implements AuthOnlineDatasource {
  final ApiServices _apiServices;
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

  @override
  Future<GetUserResponse> getUserData() async {
    var response = await _apiServices.getUserData();

    var userId = response.id;
    print(userId);
    getIt<SharedPreferences>().setInt(SharedPrefKeys.userId, userId!);
    return response;
  }
}
