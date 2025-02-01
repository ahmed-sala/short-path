import 'package:json_annotation/json_annotation.dart';

part 'profile_info_request.g.dart';

@JsonSerializable()
class ProfileInfoRequest {
  @JsonKey(name: "profile")
  final Profile? profile;

  ProfileInfoRequest({
    this.profile,
  });

  factory ProfileInfoRequest.fromJson(Map<String, dynamic> json) {
    return _$ProfileInfoRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileInfoRequestToJson(this);
  }
}

@JsonSerializable()
class Profile {
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

  Profile({
    this.bio,
    this.linkedInProfile,
    this.portfolioWebsites,
    this.professionalTitle,
    this.profilePhotoUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileToJson(this);
  }
}
