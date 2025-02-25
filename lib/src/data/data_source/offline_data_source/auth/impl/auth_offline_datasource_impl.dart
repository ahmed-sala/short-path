import 'package:injectable/injectable.dart';
import 'package:short_path/config/extensions/extensions.dart';

import 'package:short_path/config/helpers/shared_pref/shared_pre_keys.dart';
import 'package:short_path/config/helpers/shared_pref/shared_pref_helper.dart';
import 'package:short_path/src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart';

@Injectable(as: AuthOfflineDataSource)
class authOfflineDatasourceImpl implements AuthOfflineDataSource {
  @override
  Future<void> deleteToken() async {
    print('====================deleteToken');
    await SharedPrefHelper.removeSecureString(SharedPrefKeys.userToken);
  }

  @override
  Future<String?> getToken() async {
    return await SharedPrefHelper.getSecureString(SharedPrefKeys.userToken);
  }

  @override
  Future<bool> isLoggedUser() async {
    var token =
        await SharedPrefHelper.getSecureString(SharedPrefKeys.userToken);
    return (token?.isNullOrEmpty() == true);
  }

  @override
  Future<void> saveToken(String token) async {
    await SharedPrefHelper.setSecureString(SharedPrefKeys.userToken, token);
  }

  @override
  Future<void> onBoardingCompleted() async {
    await SharedPrefHelper.setDate(SharedPrefKeys.onBoardingCompleted, true);
  }

  @override
  Future<bool> isOnBoardingCompleted() async {
    return await SharedPrefHelper.getBoolean(
        SharedPrefKeys.onBoardingCompleted);
  }
}
