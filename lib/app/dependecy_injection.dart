import 'package:get_it/get_it.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/get_current_weather.dart';
import '../domain/usecases/get_5day_forecast.dart';
import '../data/repositories/weather_repository_impl.dart';
import 'package:http/http.dart' as http;
import '../data/network/weather_remote_data_source.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initDataLayer();
  _initRepositories();
  _initUsecases();
}

void _initDataLayer() {
  // Example: register network clients, local storage, data sources
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(getIt()));
}

void _initRepositories() {
  getIt.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(getIt()));
}

void _initUsecases() {
  getIt.registerFactory<GetCurrentWeather>(() => GetCurrentWeather(getIt()));
  getIt.registerFactory<Get5DayForecast>(() => Get5DayForecast(getIt()));
}

