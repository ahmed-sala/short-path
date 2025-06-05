import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:short_path/config/helpers/shared_pref/shared_pre_keys.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/dependency_injection/di.dart';

Future<String?> initialRoute() async {
  String? token =
      await getIt<FlutterSecureStorage>().read(key: SharedPrefKeys.userToken);
  var onBoardingDone =
      getIt<SharedPreferences>().getBool(SharedPrefKeys.onBoardingCompleted) ??
          false;
  if (token != null && token.isNotEmpty) {
    return RoutesName.sectionScreen;
  } else if (onBoardingDone) {
    return RoutesName.login;
  } else {
    return RoutesName.onBoarding;
  }
}
