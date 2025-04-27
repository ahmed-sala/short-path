import 'package:short_path/src/data/dto_models/career/cover_sheet_dto.dart';

class CoverSheetEntity {
  String? coverSheet;
  String? companyName;
  String? companyEmail;
  String? emailSubject;
  CoverSheetEntity({
    this.coverSheet,
    this.companyName,
    this.companyEmail,
    this.emailSubject,
  });

  CoverSheetDto toDto() {
    return CoverSheetDto(
      coverSheet: coverSheet,
      companyName: companyName,
      companyEmail: companyEmail,
      emailSubject: emailSubject,
    );
  }
}
