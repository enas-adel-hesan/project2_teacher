import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_links.dart';
import 'core/errors/network/network_info.dart';
import 'core/network/dio_client.dart';
import 'data/services/preference_service.dart';
import 'presentation/bloc/categories/cubit.dart';
import 'presentation/bloc/courses/cubit.dart';
import 'presentation/bloc/login/cubit.dart';
import 'presentation/bloc/register_cubit/cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  DioHelper.init(
    baseUrl: AppLinks.baseUrl,
    enableLogging: true,
    receiveTimeout: Duration(minutes: 5),
    connectTimeout: Duration(minutes: 5),
  );

  // External dependencies first
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => PreferencesService(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerFactory(() => RegisterCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerFactory(() => CoursesCubit());
  sl.registerFactory(() => CategoriesCubit());
}
