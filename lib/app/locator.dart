import 'package:get_it/get_it.dart';
import '../services/http_service.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => HttpService());
}
