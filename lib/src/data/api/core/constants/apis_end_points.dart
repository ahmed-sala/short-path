import 'apis_baseurl.dart';

abstract class ApisEndPoints {
  static const String login = "${ApisBaseurl.baseUrl}auth/login";
  static const String register = "${ApisBaseurl.baseUrl}auth/register";
  static const String language = "${ApisBaseurl.baseUrl}language/";
  static const String skill = "${ApisBaseurl.baseUrl}skills/";
  static const String profile = "${ApisBaseurl.baseUrl}profile/";
}
