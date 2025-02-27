import 'package:injectable/injectable.dart';
import 'package:short_path/core/common/api/api_result.dart';
import 'package:short_path/src/data/data_source/offline_data_source/auth/contracts/auth_offline_datasource.dart';
import 'package:short_path/src/data/data_source/online_data_source/home/contract/home_online_datasource.dart';
import 'package:short_path/src/domain/entities/home/job_entity.dart';
import 'package:short_path/src/domain/repositories/contract/home_repository.dart';

import '../../../../core/common/api/api_execute.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeOnlineDatasource homeOnlineDatasource;
  AuthOfflineDataSource authOfflineDataSource;
  HomeRepositoryImpl(this.homeOnlineDatasource, this.authOfflineDataSource);
  @override
  Future<ApiResult<List<JobEntity>?>> getAllJobs() async {
    return await executeApi<List<JobEntity>?>(apiCall: () async {
      var response = await homeOnlineDatasource.getAllJobs();
      List<JobEntity> jobs = response.map((e) => e.toEntity()).toList();
      return jobs;
    });
  }
}
