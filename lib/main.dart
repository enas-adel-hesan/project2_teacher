import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:teacher/routes.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/navigation_observer.dart';
import 'data/services/preference_service.dart';
import 'injection_container.dart';

late String initialRoute; // global variable

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await init(); // initialize dependencies

  initialRoute = await _determineInitialScreen(); // set the global variable

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      navigatorObservers: [MyNavigatorObserver()],// use the global variable
      onGenerateRoute: RoutesGenerator.getRoute,
    );
  }
}

Future<String> _determineInitialScreen() async {
  final prefs = sl<PreferencesService>();
  return prefs.isLoggedIn ? Routes.home : Routes.welcomeRoute;
}
