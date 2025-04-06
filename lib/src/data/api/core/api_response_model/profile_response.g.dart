// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['userId'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      linkedInProfile: json['linkedInProfile'] as String?,
      portfolioWebsites: (json['portfolioWebsites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      professionalTitle: json['professionalTitle'] as String?,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'bio': instance.bio,
      'linkedInProfile': instance.linkedInProfile,
      'portfolioWebsites': instance.portfolioWebsites,
      'professionalTitle': instance.professionalTitle,
      'profilePhotoUrl': instance.profilePhotoUrl,
    };
