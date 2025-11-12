import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Getx/weather_controller.dart';
import '../../app/config/app_color.dart';

class WeatherDetailsView extends GetView<WeatherController> {
  const WeatherDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'Assets/Assets/Images/forest_sunny.png',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                // Overlay current weather text at upper section
                Positioned.fill(
                  child: IgnorePointer(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        Obx(() {
                          final w = controller.weather.value;
                          final loading = controller.isLoading.value;
                          final err = controller.error.value;
                          if (loading) {
                            return const SizedBox.shrink();
                          }
                          if (err != null || w == null) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            children: [
                              Text(
                                '${w.temperatureC.toStringAsFixed(0)}°',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 56,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                w.description.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Min/Current/Max temperature section
            Container(
              color: AppColors.green,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Obx(() {
                final w = controller.weather.value;
                final loading = controller.isLoading.value;
                final err = controller.error.value;
                if (loading || err != null || w == null) {
                  return const SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Min temperature
                    Column(
                      children: [
                        Text(
                          '${w.minTempC.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'min',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    // Current temperature
                    Column(
                      children: [
                        Text(
                          '${w.temperatureC.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Current',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    // Max temperature
                    Column(
                      children: [
                        Text(
                          '${w.maxTempC.toStringAsFixed(0)}°',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'max',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            // Divider line
            Container(
              height: 1,
              color: Colors.white.withOpacity(0.5),
            ),
            // 5-day forecast section
            Expanded(
              child: Container(
                color: AppColors.green,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Obx(() {
                  final forecastList = controller.forecasts;
                  if (forecastList.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return ListView.builder(
                    itemCount: forecastList.length,
                    itemBuilder: (context, index) {
                      final forecast = forecastList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Day name on the left
                            Text(
                              forecast.day,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // Spacer to push icon to center
                            Expanded(
                              child: Center(
                                child: _getWeatherIcon(forecast.icon),
                              ),
                            ),
                            // Temperature on the right
                            Text(
                              '${forecast.temperatureC.toStringAsFixed(0)}°',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWeatherIcon(String icon) {
    // Map weather condition to asset icon
    String iconPath;
    switch (icon.toLowerCase()) {
      case 'rain':
      case 'drizzle':
        iconPath = 'Assets/Assets/Icons/rain.png';
        break;
      case 'clouds':
      case 'cloud':
        iconPath = 'Assets/Assets/Icons/partlysunny.png';
        break;
      case 'clear':
      case 'sunny':
        iconPath = 'Assets/Assets/Icons/clear.png';
        break;
      default:
        iconPath = 'Assets/Assets/Icons/partlysunny.png';
    }
    
    return Image.asset(
      iconPath,
      width: 32,
      height: 32,
      fit: BoxFit.contain,
    );
  }
}


// Feature branch commit test
