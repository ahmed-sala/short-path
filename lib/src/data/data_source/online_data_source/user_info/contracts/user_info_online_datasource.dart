import '../../../../dto_models/user_info/language_dto.dart';
import '../../../../dto_models/user_info/profile_dto.dart';

abstract interface class UserInfoOnlineDataSource {
  Future<void> addProfile(
      ProfileDto profileRequest, LanguagesDto languageRequest, String token);
}
