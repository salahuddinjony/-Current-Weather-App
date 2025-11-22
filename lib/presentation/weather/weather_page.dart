import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/weather_controller.dart';
import '../widgets/weather_asset_helper.dart';
import '../../core/utils/date_helper.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeatherController());
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? Colors.teal : Colors.blue,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? Colors.teal : Colors.blue,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 600,
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.blue,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Obx(() {
              // Only show loading on initial load
              if (controller.isLoading.value && controller.isInitialLoad.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }

              // Only show error if we don't have any weather data
              if (controller.errorMessage.value.isNotEmpty && controller.weather.value == null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => controller.fetchWeather(showLoading: true),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final weather = controller.weather.value;
              if (weather == null && !controller.isLoading.value) {
                return const Center(
                  child: Text(
                    'No weather data available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                );
              }

              // If loading but we have previous data, show previous data (no flicker)
              if (weather == null) {
                return const SizedBox.shrink();
              }

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📍 ${weather.cityName}',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateHelper.getGreeting(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    _getWeatherIcon(weather.weatherConditionCode, isDarkMode),
                    Center(
                      child: Text(
                        '${weather.temperature.toStringAsFixed(0)}°C',
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        weather.condition.toUpperCase(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Obx(() => Text(
                        controller.currentTime.value.isEmpty 
                          ? DateHelper.getCurrentTime() 
                          : controller.currentTime.value,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      )),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _weatherDetail(
                          'Sunrise',
                          WeatherAssetHelper.getSunriseIcon(),
                          DateHelper.formatTime(weather.sunrise),
                          isDarkMode,
                        ),
                        _weatherDetail(
                          'Sunset',
                          WeatherAssetHelper.getSunsetIcon(),
                          DateHelper.formatTime(weather.sunset),
                          isDarkMode,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Divider(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _weatherDetail(
                          'Temp Max',
                          WeatherAssetHelper.getTempMaxIcon(),
                          '${weather.maxTemperature.toStringAsFixed(0)}°C',
                          isDarkMode,
                        ),
                        _weatherDetail(
                          'Temp Min',
                          WeatherAssetHelper.getTempMinIcon(),
                          '${weather.minTemperature.toStringAsFixed(0)}°C',
                          isDarkMode,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _getWeatherIcon(int? code, bool isDarkMode) {
    double iconSize = 200.0;

    String assetPath = WeatherAssetHelper.getWeatherIcon(code);

    return Center(
      child: Image.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
      ),
    );
  }

  Widget _weatherDetail(
    String title,
    String imagePath,
    dynamic value,
    bool isDarkMode,
  ) {
    return Row(
      children: [
        Image.asset(imagePath, scale: 8),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
