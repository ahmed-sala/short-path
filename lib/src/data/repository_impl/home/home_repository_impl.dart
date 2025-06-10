import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart';
import 'package:short_path/src/data/data_source/online_data_source/home/contract/home_online_datasource.dart';
import 'package:short_path/src/domain/repositories/contract/home_repository.dart';

import '../../../../core/common/api/api_execute.dart';
import '../../../domain/entities/home/jobs_entity.dart';
import '../../api/core/api_request_model/job_filter_request.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeOnlineDatasource homeOnlineDatasource;
  AuthOfflineDataSource authOfflineDataSource;
  HomeRepositoryImpl(this.homeOnlineDatasource, this.authOfflineDataSource);
  @override
  Future<ApiResult<JobEntity?>> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  }) async {
    return await executeApi<JobEntity>(apiCall: () async {
      var response = await homeOnlineDatasource.getAllJobs(
        term: term,
        page: page,
        sort: sort,
        size: size,
        jobFilterRequest: jobFilterRequest,
      );
      return response;
    });
  }

  @override
  Future<ApiResult<List<ContentEntity>?>> getFavoriteJobs() {
    return executeApi<List<ContentEntity>?>(
      apiCall: () async {
        var response = await homeOnlineDatasource.getFavoriteJobs();
        return response.map((job) => job.toEntity()).toList();
      },
    );
  }

  @override
  Future<ApiResult<void>> removeJobFromFavorite(ContentEntity contentEntity) {
    return executeApi<void>(
      apiCall: () async {
        await homeOnlineDatasource.removeJobFromFavorite(
          contentEntity.toSavedJobModel(),
        );
      },
    );
  }

  @override
  Future<ApiResult<void>> saveJobToFavorite(ContentEntity contentEntity) {
    return executeApi<void>(
      apiCall: () async {
        await homeOnlineDatasource.saveJobToFavorite(
          contentEntity.toSavedJobModel(),
        );
      },
    );
  }
}
