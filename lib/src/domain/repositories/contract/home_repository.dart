import 'package:short_path/core/common/api/api_result.dart';

import '../../../data/api/core/api_request_model/job_filter_request.dart';
import '../../entities/home/jobs_entity.dart';

abstract interface class HomeRepository {
  Future<ApiResult<JobEntity?>> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  });
  Future<ApiResult<void>> saveJobToFavorite(ContentEntity contentEntity);
  Future<ApiResult<void>> removeJobFromFavorite(ContentEntity contentEntity);
  Future<ApiResult<List<ContentEntity>?>> getFavoriteJobs();
}
