import '../../../../api/core/api_request_model/job_filter_request.dart';
import '../../../../api/core/api_response_model/jobs_response.dart';

abstract interface class HomeOnlineDatasource {
  Future<JobsResponse> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  });
  Future<void> saveJobToFavorite(JobsResponse jobResponse);
  Future<void> removeJobFromFavorite(JobsResponse jobResponse);
  Future<JobsResponse> getFavoriteJobs();
}
