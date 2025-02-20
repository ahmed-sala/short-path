import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../config/helpers/shared_pref/shared_pre_keys.dart';
import '../config/routes/app_route.dart';
import '../config/routes/routes_name.dart';
import '../core/styles/theme/app_theme.dart';
import '../dependency_injection/di.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class ShortPath extends StatefulWidget {
  const ShortPath({Key? key}) : super(key: key);

  @override
  State<ShortPath> createState() => _ShortPathState();
}

class _ShortPathState extends State<ShortPath> {
  String? _initialRoute = RoutesName.onBoarding;
  bool _isInitialized = true;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    // // Perform initialization logic
    String? token =
        await getIt<FlutterSecureStorage>().read(key: SharedPrefKeys.userToken);

    // print('Token: $token');
    if (token != null) {
      // getIt<Dio>().options.headers['Authorization'] = 'Bearer $token';

      // _initialRoute = RoutesName.onBoarding;
    }
    // } else {
    //   _initialRoute = RoutesName.onBoarding;
    // }

    // Ensure the splash screen is removed after initialization
    FlutterNativeSplash.remove();

    // setState(() {
    //   _isInitialized = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox
          .shrink(); // Display nothing until initialization is complete
    }

    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              navigatorKey: navKey,
              initialRoute: _initialRoute,
              onGenerateRoute: AppRoute.onGenerateRoute,
            ));
  }
}
