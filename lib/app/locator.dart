import 'package:cart/services/authentication.dart';
import 'package:cart/viewmodel/base_model.dart';
import 'package:get_it/get_it.dart';
import '../services/http_service.dart';
import '../viewmodel/theme_model.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ThemeModel());
  locator.registerLazySingleton(() => HttpService());
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => Authentication());
}
