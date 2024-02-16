import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:reqres_flutter_case/services/dio_service.dart';
import 'package:reqres_flutter_case/utilities/shared_pref_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

void setupDependencies() {
  locator.registerLazySingleton<DioService>(() => DioService(Dio(BaseOptions(contentType: 'application/json'))));
  locator.registerLazySingletonAsync<SharedPrefHelper>(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return SharedPrefHelper(sharedPreferences);
  });
}
