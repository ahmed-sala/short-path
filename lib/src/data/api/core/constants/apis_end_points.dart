import 'apis_baseurl.dart';

abstract class ApisEndPoints {
  static const String login = "${ApisBaseurl.baseUrl}auth/login";
  static const String register = "${ApisBaseurl.baseUrl}auth/register";
}
