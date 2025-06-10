import '../../../../../domain/entities/home/jobs_entity.dart';
import '../../../../api/core/api_request_model/job_filter_request.dart';
import '../../../../dto_models/saved_job_model.dart';

abstract interface class HomeOnlineDatasource {
  Future<JobEntity> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  });
  Future<void> saveJobToFavorite(SavedJobModel savedJobModel);
  Future<void> removeJobFromFavorite(SavedJobModel savedJobModel);
  Future<List<SavedJobModel>> getFavoriteJobs();
}
