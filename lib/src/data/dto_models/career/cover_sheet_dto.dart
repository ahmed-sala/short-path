import 'package:short_path/src/domain/entities/career/cover_sheet_entity.dart';

class CoverSheetDto {
  String? coverSheet;
  String? companyName;
  String? companyEmail;
  String? emailSubject;
  CoverSheetDto({
    this.coverSheet,
    this.companyName,
    this.companyEmail,
    this.emailSubject,
  });

  CoverSheetEntity toEntity() {
    return CoverSheetEntity(
      coverSheet: coverSheet,
      companyName: companyName,
      companyEmail: companyEmail,
      emailSubject: emailSubject,
    );
  }
}
