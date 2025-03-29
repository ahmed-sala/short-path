import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:short_path/src/data/api/core/api_request_model/auth/login_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/auth/register_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/job_filter_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/additional_infromation_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/certification_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/education_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/language_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/profile_info_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/project_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/skill_request.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/work_experience_request.dart';
import 'package:short_path/src/data/api/core/api_response_model/additional_info_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/auth_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/certificate_respone.dart';
import 'package:short_path/src/data/api/core/api_response_model/education_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/get_user_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/jobs_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/language_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/profile_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/project_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/skills_response.dart';
import 'package:short_path/src/data/api/core/api_response_model/work_experience_response.dart';
import 'package:short_path/src/data/api/core/constants/apis_baseurl.dart';
import 'package:short_path/src/data/api/core/constants/apis_end_points.dart';

part 'api_services.g.dart';

@singleton
@injectable
@RestApi(baseUrl: ApisBaseurl.baseUrl)
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @POST(ApisEndPoints.login)
  Future<AuthResponse> login(@Body() LoginRequest loginRequest);

  @POST(ApisEndPoints.register)
  Future<AuthResponse> register(@Body() RegisterRequest registerRequest);

  @POST(ApisEndPoints.language)
  Future<void> addLanguage(
    @Body() LanguageRequest languageRequest,
  );
  @GET(ApisEndPoints.language)
  Future<List<LanguageResponse>> getLanguage();

  @POST(ApisEndPoints.skill)
  Future<void> addSkill(
    @Body() SkillRequest skillRequest,
  );
  @GET(ApisEndPoints.skill)
  Future<SkillsResponse> getSkill();

  @POST(ApisEndPoints.profile)
  Future<void> addProfile(
    @Body() ProfileInfoRequest profileRequest,
  );
  @GET(ApisEndPoints.profile)
  Future<ProfileResponse> getProfile();
  @POST(ApisEndPoints.education)
  Future<void> addEducation(
    @Body() EducationRequest educationRequest,
  );
  @GET(ApisEndPoints.education)
  Future<List<EducationResponse>> getEducation();
  @POST(ApisEndPoints.certification)
  Future<void> addCertification(
    @Body() CertificationRequest certificationRequest,
  );
  @GET(ApisEndPoints.certification)
  Future<List<CertificateResponse>> getCertification();
  @POST(ApisEndPoints.project)
  Future<void> addProject(
    @Body() ProjectRequest projectRequest,
  );
  @GET(ApisEndPoints.project)
  Future<List<ProjectResponse>> getProject();

  @POST(ApisEndPoints.workExperience)
  Future<void> addWorkExperience(
    @Body() WorkExperienceRequest workExperienceRequest,
  );
  @GET(ApisEndPoints.workExperience)
  Future<List<WorkExperienceResponse>> getWorkExperience();
  @POST(ApisEndPoints.additionalInfo)
  Future<void> addAdditionalInfo(
    @Body() AdditionalInfromationRequest additionalInfromationRequest,
  );
  @GET(ApisEndPoints.additionalInfo)
  Future<AdditionalInfoResponse> getAdditionalInfo();
  @GET(ApisEndPoints.getUserData)
  Future<GetUserResponse> getUserData();

  @GET(ApisEndPoints.getAllJobs)
  Future<JobsResponse> getAllJobs(
    @Query("term") String term,
    @Query("page") int page,
    @Query("sort", encoded: true) String sort,
    @Query("size") int size,
    @Query('filter') JobFilterRequest filterRequest,
  );
}
