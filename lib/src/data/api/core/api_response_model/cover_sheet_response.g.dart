// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_sheet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoverSheetResponse _$CoverSheetResponseFromJson(Map<String, dynamic> json) =>
    CoverSheetResponse(
      coverSheet: json['coverSheet'] as String?,
      companyName: json['companyName'] as String?,
      companyEmail: json['companyEmail'] as String?,
      emailSubject: json['emailSubject'] as String?,
    );

Map<String, dynamic> _$CoverSheetResponseToJson(CoverSheetResponse instance) =>
    <String, dynamic>{
      'coverSheet': instance.coverSheet,
      'companyName': instance.companyName,
      'companyEmail': instance.companyEmail,
      'emailSubject': instance.emailSubject,
    };
