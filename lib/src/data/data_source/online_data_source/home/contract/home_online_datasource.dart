import '../../../../api/core/api_response_model/jobs_response.dart';

abstract interface class HomeOnlineDatasource {
  Future<List<JobsResponse>> getAllJobs();
}
