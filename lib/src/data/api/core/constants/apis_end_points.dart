import 'apis_baseurl.dart';

abstract class ApisEndPoints {
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String language = "language/";
  static const String skill = "skills/";
  static const String profile = "profile/";
  static const String education = "education/";
  static const String certification = "certifications/";
  static const String project = "projects/";
  static const String login = "${ApisBaseurl.baseUrl}auth/login";
  static const String register = "${ApisBaseurl.baseUrl}auth/register";
  static const String language = "${ApisBaseurl.baseUrl}language/";
  static const String skill = "${ApisBaseurl.baseUrl}skills/";
  static const String profile = "${ApisBaseurl.baseUrl}profile/";
  static const String workExperience = "${ApisBaseurl.baseUrl}work-experience/";
}
