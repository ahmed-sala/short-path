import 'language_entity.dart';

class ProfileEntity {
  final List<String> portfolioLinks;
  final String jobTitle;

  final String linkedIn;
  final String profilePicture;
  final String bio;
  final List<LanguageEntity> languages;

  ProfileEntity({
    required this.portfolioLinks,
    required this.jobTitle,
    required this.linkedIn,
    required this.profilePicture,
    required this.bio,
    required this.languages,
  });
}
