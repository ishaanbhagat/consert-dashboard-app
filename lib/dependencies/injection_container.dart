import 'package:get_it/get_it.dart';
import '../configuration/api_http_requests.dart';


class InjectionContainer {
  static Future<void> setupLocator() async {
    final GetIt locator = GetIt.instance;
    locator.registerLazySingleton(() => DioClient());
  }
}
