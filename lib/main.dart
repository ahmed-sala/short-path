import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:short_path/core/utils/bloc_observer/bloc_observer.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/presentation/mangers/localization/localization_viewmodel.dart';
import 'package:short_path/src/short_path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/functions/initial_route.dart';

import 'firebase_options.dart';

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.white
    ..indicatorColor = Colors.black
    ..textColor = Colors.black
    ..maskColor = Colors.white.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ctrldaegvckwscgltqlr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN0cmxkYWVndmNrd3NjZ2x0cWxyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDk2NDUyMzksImV4cCI6MjA2NTIyMTIzOX0.4Vm6H5KlhvMWilZ5I4C9d4ziEBhra7Id-zIEbRxx3Tk',
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterDownloader.initialize(
    debug: true, // optional: set to false in production
  );
  configLoading();
  await configureDependencies();
  Bloc.observer = MyBlocObserver();

  final localizationVM = getIt<LocalizationViewmodel>();

  final firstRoute = await initialRoute();

  runApp(
    BlocProvider.value(
      value: localizationVM,
      child: ShortPath(startupRoute: firstRoute!),
    ),
  );
}
