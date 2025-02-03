import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:short_path/src/data/api/core/api_request_model/user_info/profile_info_request.dart';
import 'package:short_path/src/data/api/core/api_response_model/auth_response.dart';

import 'core/api_request_model/auth/login_request.dart';
import 'core/api_request_model/auth/register_request.dart';
import 'core/api_request_model/user_info/language_request.dart';
import 'core/api_request_model/user_info/skill_request.dart';
import 'core/api_request_model/user_info/work_experience_request.dart';
import 'core/constants/apis_baseurl.dart';
import 'core/constants/apis_end_points.dart';

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
  Future<void> addLanguage(@Body() LanguageRequest languageRequest);

  @POST(ApisEndPoints.skill)
  Future<void> addSkill(
      @Body() SkillRequest skillRequest, @Header('Authorization') String token);

  @POST(ApisEndPoints.profile)
  Future<void> addProfile(
    @Body() ProfileInfoRequest profileRequest,
    @Header('Authorization') String token,
  );

  @POST(ApisEndPoints.workExperience)
  Future<void> addWorkExperience(
    @Body() WorkExperienceRequest workExperienceRequest,
    @Header('Authorization') String token,
  );
}
