import 'package:dio/dio.dart';

abstract interface class CareerOnlineDatasource {
  Future<Response<ResponseBody>> downloadFile(String jobDescription);
  Future<String?> generateCoverSheet(
    String jobDescription,
  );
}
