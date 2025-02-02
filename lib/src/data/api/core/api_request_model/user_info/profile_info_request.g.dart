// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfoRequest _$ProfileInfoRequestFromJson(Map<String, dynamic> json) =>
    ProfileInfoRequest(
      profile: json['profile'] == null
          ? null
          : Profile.fromJson(json['profile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileInfoRequestToJson(ProfileInfoRequest instance) =>
    <String, dynamic>{
      'profile': instance.profile,
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      bio: json['bio'] as String?,
      linkedInProfile: json['linkedInProfile'] as String?,
      portfolioWebsites: (json['portfolioWebsites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      professionalTitle: json['professionalTitle'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'bio': instance.bio,
      'linkedInProfile': instance.linkedInProfile,
      'portfolioWebsites': instance.portfolioWebsites,
      'professionalTitle': instance.professionalTitle,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };
