import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

class ProfileEntity {
  final List<String> portfolioLinks;
  final String jobTitle;

  final String linkedIn;
  final String profilePicture;
  final String bio;
  final int yearOfExperience;
  final int projectsCompleted;
  ProfileEntity({
    required this.yearOfExperience,
    required this.projectsCompleted,
    required this.portfolioLinks,
    required this.jobTitle,
    required this.linkedIn,
    required this.profilePicture,
    required this.bio,
  });
  ProfileDto toProfileDto() {
    return ProfileDto(
      yearOfExperience: yearOfExperience,
      projectsCompleted: projectsCompleted,
      bio: bio,
      linkedInProfile: linkedIn,
      portfolioWebsites: portfolioLinks,
      professionalTitle: jobTitle,
      profilePhotoUrl: profilePicture,
    );
  }
}
