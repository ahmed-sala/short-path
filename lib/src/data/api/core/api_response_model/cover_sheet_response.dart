import 'package:json_annotation/json_annotation.dart';

part 'cover_sheet_response.g.dart';

@JsonSerializable()
class CoverSheetResponse {
  @JsonKey(name: "coverSheet")
  final String? coverSheet;

  CoverSheetResponse({
    this.coverSheet,
  });

  factory CoverSheetResponse.fromJson(Map<String, dynamic> json) {
    return _$CoverSheetResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CoverSheetResponseToJson(this);
  }
}
