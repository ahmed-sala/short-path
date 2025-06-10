import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/config/helpers/firestore/firestore_services.dart';
import 'package:short_path/config/helpers/shared_pref/shared_pre_keys.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/data/data_source/online_data_source/home/contract/home_online_datasource.dart';
import 'package:short_path/src/data/dto_models/saved_job_model.dart';

import '../../../../../domain/entities/home/jobs_entity.dart';
import '../../../../api/api_services.dart';
import '../../../../api/core/api_request_model/job_filter_request.dart';

@Injectable(as: HomeOnlineDatasource)
class HomeOnlineDatasourceImpl implements HomeOnlineDatasource {
  final FirestoreService _firestoreService;
  final ApiServices _apiServices;

  HomeOnlineDatasourceImpl(this._apiServices, this._firestoreService);

  @override
  Future<JobEntity> getAllJobs({
    String? term,
    int? page,
    String? sort,
    int? size,
    JobFilterRequest? jobFilterRequest,
  }) async {
    // 1. fetch the raw jobs page
    final apiResponse = await _apiServices.getAllJobs(
      term ?? '',
      page ?? 0,
      sort ?? '',
      size ?? 10,
      jobFilterRequest!,
    );

    // 2. map the API model into our domain entity
    final jobEntity = JobEntity(
      content: apiResponse.content
          ?.map((dto) => ContentEntity(
                id: dto.id,
                title: dto.title,
                company: dto.company,
                description: dto.description,
                image: dto.image,
                location: dto.location,
                employmentType: dto.employmentType,
                datePosted: dto.datePosted,
                salaryRange: dto.salaryRange,
                url: dto.url,
                isSaved: false, // default
              ))
          .toList(),
      pageNumber: apiResponse.pageNumber,
      pageSize: apiResponse.pageSize,
      totalElements: apiResponse.totalElements,
      totalPages: apiResponse.totalPages,
      last: apiResponse.last,
      fullTimeJobsCount: apiResponse.fullTimeJobsCount,
      partTimeJobsCount: apiResponse.partTimeJobsCount,
      internshipJobsCount: apiResponse.internshipJobsCount,
    );

    // 3. load the list of saved jobs from Firestore
    final savedJobs = await getFavoriteJobs();
    final savedIds = savedJobs.map((j) => j.id).toSet();

    // 4. mark each ContentEntity if it's in the saved set
    for (var job in jobEntity.content!) {
      if (job.id != null && savedIds.contains(job.id)) {
        job.isSaved = true;
      }
    }

    return jobEntity;
  }

  @override
  Future<List<SavedJobModel>> getFavoriteJobs() async {
    int? userId = getIt<SharedPreferences>().getInt(SharedPrefKeys.userId);
    if (userId != null) {
      final String userDocId = userId.toString();
      final Map<String, dynamic>? userData =
          await _firestoreService.getDocumentById(
              'users', userDocId); // Assuming 'users' collection for user data

      if (userData != null && userData.containsKey('savedJobs')) {
        final List<dynamic> savedJobsData =
            userData['savedJobs'] as List<dynamic>;
        return savedJobsData
            .map((jobJson) =>
                SavedJobModel.fromJson(jobJson as Map<String, dynamic>))
            .toList();
      } else {
        return []; // No saved jobs found for this user
      }
    } else {
      throw Exception('User ID is not available');
    }
  }

  @override
  Future<void> removeJobFromFavorite(SavedJobModel savedJobModel) async {
    int? userId = getIt<SharedPreferences>().getInt(SharedPrefKeys.userId);
    if (userId != null) {
      final String userDocId = userId.toString();
      // Get the current list of saved jobs
      final Map<String, dynamic>? userData =
          await _firestoreService.getDocumentById('users', userDocId);

      if (userData != null && userData.containsKey('savedJobs')) {
        List<dynamic> savedJobs =
            List.from(userData['savedJobs']); // Create a mutable copy
        // Remove the job that matches the ID
        savedJobs.removeWhere((jobJson) => jobJson['id'] == savedJobModel.id);
        // Update the document with the modified list
        await _firestoreService
            .updateDocument('users', userDocId, {'savedJobs': savedJobs});
      }
    } else {
      throw Exception('User ID is not available');
    }
  }

  @override
  Future<void> saveJobToFavorite(SavedJobModel savedJobModel) async {
    int? userId = getIt<SharedPreferences>().getInt(SharedPrefKeys.userId);
    if (userId != null) {
      savedJobModel.userId = userId; // Set the userId in the model
      final String userDocId = userId.toString();
      final Map<String, dynamic>? userData =
          await _firestoreService.getDocumentById('users', userDocId);

      if (userData != null && userData.containsKey('savedJobs')) {
        List<dynamic> savedJobs =
            List.from(userData['savedJobs']); // Create a mutable copy
        if (!savedJobs.any((jobJson) => jobJson['id'] == savedJobModel.id)) {
          savedJobs.add(savedJobModel.toJson());
          await _firestoreService
              .updateDocument('users', userDocId, {'savedJobs': savedJobs});
        }
      } else {
        await _firestoreService.addDocument(
            'users',
            {
              'savedJobs': [savedJobModel.toJson()]
            },
            userDocId);
      }
    } else {
      throw Exception('User ID is not available');
    }
  }
}
