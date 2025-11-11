import 'package:get/get.dart';
import '../../presentation/Views/onboarding_view.dart';
import '../../presentation/Views/weather_details_view.dart';
import 'app_routes.dart';
import '../../presentation/Getx/onboarding_controller.dart';
import '../../presentation/Getx/weather_controller.dart';
import '../dependecy_injection.dart';
import '../../domain/usecases/get_current_weather.dart';
import '../../domain/usecases/get_5day_forecast.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    final getCurrentWeather = getIt<GetCurrentWeather>();
    final get5DayForecast = getIt<Get5DayForecast>();
    Get.lazyPut<WeatherController>(() => WeatherController(getCurrentWeather, get5DayForecast));
  }
}

class AppPages {
  static final routes = <GetPage>[
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.weatherDetails,
      page: () => const WeatherDetailsView(),
      binding: WeatherBinding(),
    ),
  ];
}


