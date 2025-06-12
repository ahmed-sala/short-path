import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:short_path/config/routes/app_route.dart';
import 'package:short_path/core/styles/theme/app_theme.dart';
import 'package:short_path/src/presentation/mangers/localization/localization_viewmodel.dart';

import '../config/localization/app_localizations.dart';
import '../core/common/common_imports.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class ShortPath extends StatelessWidget {
  final String startupRoute;

  const ShortPath({Key? key, required this.startupRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationViewmodel, LocalizationState>(
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            final vm = context.read<LocalizationViewmodel>();
            return MaterialApp(
              locale: Locale(vm.cachedLanguageCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              title: 'Short Path',
              builder: EasyLoading.init(),
              navigatorKey: navKey,
              initialRoute: startupRoute,
              onGenerateRoute: AppRoute.onGenerateRoute,
            );
          },
        );
      },
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
