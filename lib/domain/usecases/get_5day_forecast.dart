import '../entities/forecast.dart';
import '../repositories/weather_repository.dart';

class Get5DayForecast {
  Get5DayForecast(this._repository);

  final WeatherRepository _repository;

  Future<List<Forecast>> call(String location) => _repository.get5DayForecast(location);
}

