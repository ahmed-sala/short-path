import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/data/api/api_services.dart';
import 'package:short_path/src/data/dto_models/career/cover_sheet_dto.dart';

import '../../../../../../config/helpers/shared_pref/shared_pre_keys.dart';
import '../../../../api/core/constants/apis_end_points.dart';
import '../../../../api/dio_client.dart';
import '../contract/career_online_datasource.dart';

@Injectable(as: CareerOnlineDatasource)
class CareerOnlineDatasourceImpl implements CareerOnlineDatasource {
  final ApiServices _apiServices;

  CareerOnlineDatasourceImpl(this._apiServices);

  @override
  Future<Response<ResponseBody>> downloadFile(
      {String? jobDescription, int? jobId}) async {
    String? token =
        await getIt<FlutterSecureStorage>().read(key: SharedPrefKeys.userToken);
    final response = await DioClient.downloadPdf(
      endPoint: ApisEndPoints.downloadCv,
      token: token!,
      data: {
        "jobDescription": jobDescription,
      },
      queryParameters: {
        "jobId": jobId,
      },
    );
    return response;
  }

  @override
  Future<CoverSheetDto?> generateCoverSheet(
      {String? jobDescription, int? jobId}) async {
    var response = await _apiServices.generateCoverSheet(jobDescription, jobId);
    return response.toDto();
  }
}
