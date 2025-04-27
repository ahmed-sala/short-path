import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:short_path/config/routes/app_route.dart';
import 'package:short_path/config/routes/routes_name.dart';
import 'package:short_path/core/styles/theme/app_theme.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/localization/localization_viewmodel.dart';

import '../core/common/common_imports.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class ShortPath extends StatelessWidget {
  ShortPath({super.key});
  LocalizationViewmodel localizationViewmodel = getIt<LocalizationViewmodel>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => localizationViewmodel,
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
                    supportedLocales: const [
                      Locale('en'),
                      Locale('ar'),
                    ],
                    locale: Locale(localizationViewmodel.cachedLanguageCode),
                    theme: AppTheme.lightTheme,
                    debugShowCheckedModeBanner: false,
                    title: 'Short Path',
                    builder: EasyLoading.init(),
                    navigatorKey: navKey,
                    initialRoute: RoutesName.sectionScreen,
                    onGenerateRoute: AppRoute.onGenerateRoute,
                  ));
        },
      ),
    );
  }
}
