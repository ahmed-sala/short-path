import 'package:injectable/injectable.dart';
import 'package:short_path/src/domain/entities/infromation_gathering/profile_entity.dart';

@injectable
class UserInfoUsecase {
  void invokeProfile(ProfileEntity profile) {
    print('jobTitle: ${profile.jobTitle}');
    print('linkedIn: ${profile.linkedIn}');
    print('profilePicture: ${profile.profilePicture}');
    print('bio: ${profile.bio}');
    print('languages: ${profile.languages}');
    print('portfolioLinks: ${profile.portfolioLinks}');
  }
}
