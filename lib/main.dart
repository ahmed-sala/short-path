import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:short_path/core/utils/bloc_observer/bloc_observer.dart';
import 'package:short_path/dependency_injection/di.dart';
import 'package:short_path/src/short_path.dart';

void main() async {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: widgetsFlutterBinding,
  );

  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  runApp(const ShortPath());
}
