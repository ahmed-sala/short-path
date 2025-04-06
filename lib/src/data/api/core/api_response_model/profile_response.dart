import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/user_info/profile_dto.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final int? userId;
  @JsonKey(name: "bio")
  final String? bio;
  @JsonKey(name: "linkedInProfile")
  final String? linkedInProfile;
  @JsonKey(name: "portfolioWebsites")
  final List<String>? portfolioWebsites;
  @JsonKey(name: "professionalTitle")
  final String? professionalTitle;
  @JsonKey(name: "profilePhotoUrl")
  final String? profilePhotoUrl;

  ProfileResponse({
    this.id,
    this.userId,
    this.bio,
    this.linkedInProfile,
    this.portfolioWebsites,
    this.professionalTitle,
    this.profilePhotoUrl,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }

  ProfileDto toDto() {
    return ProfileDto(
      bio: bio ?? '',
      linkedInProfile: linkedInProfile ?? '',
      portfolioWebsites: portfolioWebsites ?? [],
      professionalTitle: professionalTitle ?? '',
      profilePhotoUrl: profilePhotoUrl ?? '',
    );
  }
}
