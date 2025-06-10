import 'package:injectable/injectable.dart';
import 'package:short_path/config/helpers/firestore/firestore_services.dart';
import 'package:short_path/src/data/api/core/api_response_model/jobs_response.dart';
import 'package:short_path/src/data/data_source/online_data_source/home/contract/home_online_datasource.dart';

import '../../../../api/api_services.dart';
import '../../../../api/core/api_request_model/job_filter_request.dart';

@Injectable(as: HomeOnlineDatasource)
class HomeOnlineDatasourceImpl implements HomeOnlineDatasource {
  FirestoreService _firestoreService;
  final ApiServices _apiServices;
  HomeOnlineDatasourceImpl(this._apiServices, this._firestoreService);
  @override
  Future<JobsResponse> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  }) async {
    var response = await _apiServices.getAllJobs(
        term ?? '', page ?? 0, sort ?? '', size ?? 10, jobFilterRequest!);
    return response;
  }

  @override
  Future<JobsResponse> getFavoriteJobs() {
    // TODO: implement getFavoriteJobs
    throw UnimplementedError();
  }

  @override
  Future<void> removeJobFromFavorite(JobsResponse jobResponse) {
    // TODO: implement removeJobFromFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> saveJobToFavorite(JobsResponse jobResponse) {
    // TODO: implement saveJobToFavorite
    throw UnimplementedError();
  }
}
