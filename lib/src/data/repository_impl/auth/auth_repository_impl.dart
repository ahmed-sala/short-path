import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart';
import 'package:short_path/src/data/data_source/online_data_source/auth/contracts/auth_online_datasource.dart';
import 'package:short_path/src/domain/entities/auth/app_user.dart';
import 'package:short_path/src/domain/repositories/contract/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthOnlineDatasource _authOnlineDatasource;
  final AuthOfflineDataSource _authOfflineDataSource;
  AuthRepositoryImpl(this._authOnlineDatasource, this._authOfflineDataSource);


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
  Future<ApiResult<AppUser?>> getUserData() async {
    return await executeApi<AppUser?>(apiCall: () async {
      var response = await _authOnlineDatasource.getUserData();
      return response.toAppUser();
    });
  }

  @override
  Future<void> logout()async {
    await _authOfflineDataSource.deleteToken();
  }
}
