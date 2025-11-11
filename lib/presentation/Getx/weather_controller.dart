import 'package:get/get.dart';
import '../../domain/entities/weather.dart';
import '../../domain/entities/forecast.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_5day_forecast.dart';

class WeatherController extends GetxController {
  WeatherController(this._getCurrentWeather, this._get5DayForecast);

  final GetCurrentWeather _getCurrentWeather;
  final Get5DayForecast _get5DayForecast;

  final RxBool isLoading = false.obs;
  final RxnString error = RxnString(null);
  final Rxn<Weather> weather = Rxn<Weather>();
  final RxList<Forecast> forecasts = <Forecast>[].obs;

  @override
  void onReady() {
    // Initial load for a default or last-known location can be triggered here.
    // This keeps Views passive and avoids side-effects in build().
    load('Dubai');
    super.onReady();
  }

  Future<void> load(String location) async {
    isLoading.value = true;
    error.value = null;
    try {
      final currentWeatherResult = await _getCurrentWeather(location);
      weather.value = currentWeatherResult;
      
      final forecastResult = await _get5DayForecast(location);
      forecasts.value = forecastResult;
    } catch (e) {
      error.value = 'Failed to load weather';
    } finally {
      isLoading.value = false;
    }
  }
}


