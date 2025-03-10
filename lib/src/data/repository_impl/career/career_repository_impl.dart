import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_execute.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/online_data_source/career/contract/career_online_datasource.dart';
import 'package:short_path/src/domain/repositories/contract/career_repository.dart';

@Injectable(as: CareerRepository)
class CareerRepositoryImpl implements CareerRepository {
  CareerOnlineDatasource _careerOnlineDatasource;
  CareerRepositoryImpl(this._careerOnlineDatasource);
  @override
  Future<ApiResult<void>> downloadFile() async {
    return await executeApi<void>(apiCall: () async {
      await _careerOnlineDatasource.downloadFile();
    });
  }
}
