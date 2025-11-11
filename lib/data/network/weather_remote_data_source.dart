import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../app/config/app_config.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String city);
  Future<List<ForecastModel>> get5DayForecast(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client _client;
  WeatherRemoteDataSourceImpl(this._client);

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    final uri = Uri.parse(
      '${AppConfig.openWeatherBaseUrl}/weather?q=$city&appid=${AppConfig.openWeatherApiKey}&units=metric',
    );
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch weather');
    }
    final Map<String, dynamic> jsonMap = json.decode(response.body) as Map<String, dynamic>;
    return WeatherModel.fromJson(jsonMap);
  }

  @override
  Future<List<ForecastModel>> get5DayForecast(String city) async {
    final uri = Uri.parse(
      '${AppConfig.openWeatherBaseUrl}/forecast?q=$city&appid=${AppConfig.openWeatherApiKey}&units=metric',
    );
    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch 5-day forecast');
    }
    final Map<String, dynamic> jsonMap = json.decode(response.body) as Map<String, dynamic>;
    final list = (jsonMap['list'] as List?) ?? [];
    final forecasts = <ForecastModel>[];
    final seenDays = <String>{};
    
    // Get one forecast per day (prefer forecasts around noon - index 4, 8, 12, etc.)
    // API returns 3-hour intervals, so index 4 = 12 hours = noon
    for (int i = 4; i < list.length && forecasts.length < 5; i += 8) {
      if (i < list.length) {
        final item = list[i] as Map<String, dynamic>;
        final dt = (item['dt'] as int?) ?? 0;
        final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
        final dayKey = '${date.year}-${date.month}-${date.day}';
        
        if (!seenDays.contains(dayKey)) {
          seenDays.add(dayKey);
          forecasts.add(ForecastModel.fromJson(item));
        }
      }
    }
    
    // If we don't have 5 forecasts yet, fill from remaining items
    if (forecasts.length < 5) {
      for (int i = 0; i < list.length && forecasts.length < 5; i++) {
        final item = list[i] as Map<String, dynamic>;
        final dt = (item['dt'] as int?) ?? 0;
        final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
        final dayKey = '${date.year}-${date.month}-${date.day}';
        
        if (!seenDays.contains(dayKey)) {
          seenDays.add(dayKey);
          forecasts.add(ForecastModel.fromJson(item));
        }
      }
    }
    
    return forecasts;
  }
}


