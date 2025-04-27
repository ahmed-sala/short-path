import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/online_data_source/career/contract/career_online_datasource.dart';
import 'package:short_path/src/domain/repositories/contract/career_repository.dart';

import '../../../domain/entities/career/cover_sheet_entity.dart';

@Injectable(as: CareerRepository)
class CareerRepositoryImpl implements CareerRepository {
  CareerOnlineDatasource _careerOnlineDatasource;
  CareerRepositoryImpl(this._careerOnlineDatasource);
  @override
  Future<ApiResult<Response<ResponseBody>>> downloadFile(
      String jobDescription) async {
    return await executeApi<Response<ResponseBody>>(apiCall: () async {
      var result = await _careerOnlineDatasource.downloadFile(jobDescription);
      return result;
    });
  }

  @override
  Future<ApiResult<CoverSheetEntity?>> generateCoverSheet(
      String jobDescription) async {
    return await executeApi<CoverSheetEntity?>(apiCall: () async {
      var result =
          await _careerOnlineDatasource.generateCoverSheet(jobDescription);
      return result?.toEntity();
    });
  }
}
