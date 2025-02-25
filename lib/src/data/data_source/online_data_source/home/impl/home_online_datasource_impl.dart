import 'package:injectable/injectable.dart';
import 'package:short_path/src/data/api/core/api_response_model/jobs_response.dart';
import 'package:short_path/src/data/data_source/online_data_source/home/contract/home_online_datasource.dart';

import '../../../../api/api_services.dart';

@Injectable(as: HomeOnlineDatasource)
class HomeOnlineDatasourceImpl implements HomeOnlineDatasource {
  final ApiServices _apiServices;
  HomeOnlineDatasourceImpl(this._apiServices);
  @override
  Future<List<JobsResponse>> getAllJobs() async {
    var response = await _apiServices.getAllJobs();
    return response;
  }
}
