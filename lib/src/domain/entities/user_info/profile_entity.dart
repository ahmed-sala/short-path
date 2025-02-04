import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

class ProfileEntity {
  final List<String> portfolioLinks;
  final String jobTitle;

  final String linkedIn;
  final String profilePicture;
  final String bio;

  ProfileEntity({
    required this.portfolioLinks,
    required this.jobTitle,
    required this.linkedIn,
    required this.profilePicture,
    required this.bio,
  });
  ProfileDto toProfileDto() {
    return ProfileDto(
      bio: bio,
      linkedInProfile: linkedIn,
      portfolioWebsites: portfolioLinks,
      professionalTitle: jobTitle,
      profilePhotoUrl: profilePicture,
    );
  }
}
