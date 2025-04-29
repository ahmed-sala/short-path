import 'package:json_annotation/json_annotation.dart';
import 'package:short_path/src/data/dto_models/career/cover_sheet_dto.dart';

part 'cover_sheet_response.g.dart';

@JsonSerializable()
class CoverSheetResponse {
  @JsonKey(name: "coverSheet")
  final String? coverSheet;
  @JsonKey(name: "companyName")
  final String? companyName;
  @JsonKey(name: "companyEmail")
  final String? companyEmail;
  @JsonKey(name: "emailSubject")
  final String? emailSubject;

  CoverSheetResponse({
    this.coverSheet,
    this.companyName,
    this.companyEmail,
    this.emailSubject,
  });

  factory CoverSheetResponse.fromJson(Map<String, dynamic> json) {
    return _$CoverSheetResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CoverSheetResponseToJson(this);
  }

  CoverSheetDto toDto() {
    return CoverSheetDto(
      coverSheet: coverSheet,
      companyName: companyName,
      companyEmail: companyEmail,
      emailSubject: emailSubject,
    );
  }
}
