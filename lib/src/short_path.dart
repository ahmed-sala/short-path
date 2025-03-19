import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:short_path/config/helpers/shared_pref/shared_pre_keys.dart';
import 'package:short_path/config/routes/app_route.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/theme/app_theme.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/localization/localization_viewmodel.dart';

import '../core/common/common_imports.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class ShortPath extends StatefulWidget {
  const ShortPath({Key? key}) : super(key: key);

  @override
  State<ShortPath> createState() => _ShortPathState();
}

class _ShortPathState extends State<ShortPath> {
  String? _initialRoute = RoutesName.login;
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

    return BlocProvider(
      create: (context) => getIt<LocalizationViewmodel>(),
      child: BlocBuilder<LocalizationViewmodel, LocalizationState>(
        builder: (context, state) {
          return ScreenUtilInit(
              designSize: const Size(375, 812),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) => MaterialApp(
                    localizationsDelegates: const [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    locale: Locale(
                        BlocProvider.of<LocalizationViewmodel>(context)
                            .cachedLanguageCode),
                    theme: AppTheme.lightTheme,
                    debugShowCheckedModeBanner: false,
                    title: 'Short Path',
                    navigatorKey: navKey,
                    initialRoute: _initialRoute,
                    onGenerateRoute: AppRoute.onGenerateRoute,
                  ));
        },
      ),
    );
  }
}
