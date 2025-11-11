import '../../domain/entities/forecast.dart';

class ForecastModel {
  final String day;
  final String icon;
  final double temperatureC;

  const ForecastModel({
    required this.day,
    required this.icon,
    required this.temperatureC,
  });

  Forecast toEntity() => Forecast(
        day: day,
        icon: icon,
        temperatureC: temperatureC,
      );

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final dt = (json['dt'] as int?) ?? 0;
    final date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    final dayNames = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final dayName = dayNames[date.weekday - 1];

    final weatherList = (json['weather'] as List?) ?? [];
    final weatherIcon = weatherList.isNotEmpty
        ? (weatherList.first['main'] as String? ?? 'Clear').toLowerCase()
        : 'clear';

    final main = (json['main'] as Map<String, dynamic>?) ?? {};
    final temp = (main['temp'] as num?)?.toDouble() ?? 0.0;

    return ForecastModel(
      day: dayName,
      icon: weatherIcon,
      temperatureC: temp,
    );
  }
}

