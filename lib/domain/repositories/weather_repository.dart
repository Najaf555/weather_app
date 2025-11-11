import '../entities/weather.dart';
import '../entities/forecast.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String location);
  Future<List<Forecast>> get5DayForecast(String location);
}


