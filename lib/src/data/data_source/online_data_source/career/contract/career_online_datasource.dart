import 'package:dio/dio.dart';
import 'package:short_path/src/data/dto_models/career/cover_sheet_dto.dart';

abstract interface class CareerOnlineDatasource {
  Future<Response<ResponseBody>> downloadFile(
      {String? jobDescription, int? jobId});
  Future<CoverSheetDto?> generateCoverSheet(
      {String? jobDescription, int? jobId});
}
