import 'dart:async';

import 'package:commerce/src/app.dart';
import 'package:flutter/material.dart';

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    // AppInjector.create();
    // Bloc.observer = MyBlocObserver();
    // Crashlytics.instance.enableInDevMode = false;
    // FlutterError.onError = CrashlyticsService.recordFlutterError;
    runApp(App());
  }, (error, stack) {
    // CrashlyticsService.recordError(error, stack);
  }, zoneSpecification: ZoneSpecification());
}
