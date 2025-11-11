import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/repositories/weather_repository.dart';
import '../network/weather_remote_data_source.dart';
import '../models/forecast_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._remote);

  final WeatherRemoteDataSource _remote;

  @override
  Future<Weather> getCurrentWeather(String location) async {
    final model = await _remote.getCurrentWeather(location);
    return model.toEntity();
  }

  @override
  Future<List<Forecast>> get5DayForecast(String location) async {
    final models = await _remote.get5DayForecast(location);
    return models.map((model) => model.toEntity()).toList();
  }
}


