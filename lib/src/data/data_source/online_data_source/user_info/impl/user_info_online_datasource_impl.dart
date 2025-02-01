import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/dto_models/user_info/language_dto.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

import '../../../../api/api_services.dart';
import '../contracts/user_info_online_datasource.dart';

@Injectable(as: UserInfoOnlineDataSource)
class UserInfoOnlineDatasourceImpl implements UserInfoOnlineDataSource {
  ApiServices _apiServices;
  UserInfoOnlineDatasourceImpl(this._apiServices);

  @override
  Future<void> addProfile(ProfileDto profileRequest,
      LanguagesDto languageRequest, String token) async {
    await _apiServices.addProfile(profileRequest.toProfileRequest(), token);
  }

  @override
  Future<void> addLanguage(LanguagesDto languageRequest, String token) {
    return _apiServices.addLanguage(languageRequest.toLanguagesRequest(), token);
  }
}
