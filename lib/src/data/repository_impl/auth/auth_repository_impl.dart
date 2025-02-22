import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart';
import 'package:short_path/src/data/data_source/online_data_source/auth/contracts/auth_online_datasource.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthOnlineDatasource _authOnlineDatasource;
  AuthOfflineDataSource _authOfflineDataSource;
  AuthRepositoryImpl(this._authOnlineDatasource, this._authOfflineDataSource);
  @override
  Future<void> deleteToken() {
    return _authOfflineDataSource.deleteToken();
  }

  @override
  Future<String?> getToken() {
    return _authOfflineDataSource.getToken();
  }

  @override
  Future<bool> isLoggedUser() {
    return _authOfflineDataSource.isLoggedUser();
  }

  @override
  Future<ApiResult<void>> login(String email, String password) async {
    return executeApi<void>(apiCall: () async {
      var response = await _authOnlineDatasource.login(email, password);
      print('the token is: ${response.token}');
      await _authOfflineDataSource.saveToken(response.token!);
    });
  }

  @override
  Future<ApiResult<void>> register(AppUser appUserDto) {
    return executeApi<void>(apiCall: () async {
      var response =
          await _authOnlineDatasource.register(appUserDto.toAppUserDto());
      print('the token is: ${response.token}');

      await _authOfflineDataSource.saveToken(response.token!);
    });
  }

  @override
  Future<void> saveToken(String token) {
    return _authOfflineDataSource.saveToken(token);
  }

  @override
  Future<void> onBoardingCompleted() {
    return _authOfflineDataSource.onBoardingCompleted();
  }

  @override
  Future<bool> isOnBoardingCompleted() {
    return _authOfflineDataSource.isOnBoardingCompleted();
  }
}
