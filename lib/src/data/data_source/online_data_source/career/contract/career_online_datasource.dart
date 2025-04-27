import 'package:dio/dio.dart';
import 'package:short_path/src/data/dto_models/career/cover_sheet_dto.dart';

abstract interface class CareerOnlineDatasource {
  Future<Response<ResponseBody>> downloadFile(String jobDescription);
  Future<CoverSheetDto?> generateCoverSheet(
    String jobDescription,
  );
}
