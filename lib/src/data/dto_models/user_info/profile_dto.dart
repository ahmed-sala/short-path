import 'package:short_path/src/data/api/core/api_request_model/user_info/profile_info_request.dart';

class ProfileDto {
  final String bio;
  final String linkedInProfile;
  final List<String> portfolioWebsites;
  final String professionalTitle;
  final String profilePhotoUrl;

  ProfileDto({
    required this.bio,
    required this.linkedInProfile,
    required this.portfolioWebsites,
    required this.professionalTitle,
    required this.profilePhotoUrl,
  });

  ProfileInfoRequest toProfileRequest() {
    return ProfileInfoRequest(
      profile: Profile(
        bio: bio,
        linkedInProfile: linkedInProfile,
        portfolioWebsites: portfolioWebsites,
        professionalTitle: professionalTitle,
        profilePhotoUrl: profilePhotoUrl,
      ),
    );
  }
}
