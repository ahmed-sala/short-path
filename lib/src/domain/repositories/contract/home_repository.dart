import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/domain/entities/home/job_entity.dart';

abstract interface class HomeRepository {
  Future<ApiResult<List<JobEntity>?>> getAllJobs();
}
