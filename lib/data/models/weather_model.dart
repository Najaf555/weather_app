import '../../domain/entities/weather.dart';

class WeatherModel {
  final String location;
  final String description;
  final double temperatureC;
  final double minTempC;
  final double maxTempC;

  const WeatherModel({
    required this.location,
    required this.description,
    required this.temperatureC,
    required this.minTempC,
    required this.maxTempC,
  });

  Weather toEntity() => Weather(
        location: location,
        description: description,
        temperatureC: temperatureC,
        minTempC: minTempC,
        maxTempC: maxTempC,
      );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final name = (json['name'] as String?) ?? 'Unknown';
    final weatherList = (json['weather'] as List?) ?? [];
    final desc = weatherList.isNotEmpty ? (weatherList.first['main'] as String? ?? '') : '';
    final main = (json['main'] as Map<String, dynamic>?) ?? {};
    final temp = (main['temp'] as num?)?.toDouble() ?? 0.0;
    final tempMin = (main['temp_min'] as num?)?.toDouble() ?? temp;
    final tempMax = (main['temp_max'] as num?)?.toDouble() ?? temp;
    return WeatherModel(
      location: name,
      description: desc,
      temperatureC: temp,
      minTempC: tempMin,
      maxTempC: tempMax,
    );
  }
}


