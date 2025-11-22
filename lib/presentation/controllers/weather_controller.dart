import 'dart:async';
import 'package:get/get.dart';
import '../../core/di/injection_container.dart';
import '../../core/utils/date_helper.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherController extends GetxController {
  final WeatherRepository _weatherRepository = sl<WeatherRepository>();
  final LocationRepository _locationRepository = sl<LocationRepository>();

  final Rx<WeatherEntity?> weather = Rx<WeatherEntity?>(null);
  final RxBool isLoading = false.obs; // Only for initial load
  final RxBool isInitialLoad = true.obs; // Track if it's the first load
  final RxString errorMessage = ''.obs;
  final RxString currentTime = ''.obs; // Reactive current time

  Timer? _autoUpdateTimer;
  Timer? _timeUpdateTimer;
  static const Duration _weatherUpdateInterval =
      Duration(minutes: 5); // Update weather every 5 minutes
  static const Duration _timeUpdateInterval =
      Duration(minutes: 1); // Update time every 1 minute

  @override
  void onInit() {
    super.onInit();
    _updateCurrentTime(); // Set initial time
    fetchWeather(showLoading: true);
    _startAutoUpdate();
    _startTimeUpdate();
  }

  @override
  void onClose() {
    _stopAutoUpdate();
    _stopTimeUpdate();
    super.onClose();
  }

  void _startAutoUpdate() {
    _autoUpdateTimer = Timer.periodic(_weatherUpdateInterval, (timer) {
      // Silent background update - no loading indicator
      _fetchWeatherSilently();
    });
  }

  void _stopAutoUpdate() {
    _autoUpdateTimer?.cancel();
    _autoUpdateTimer = null;
  }

  void _startTimeUpdate() {
    _timeUpdateTimer = Timer.periodic(_timeUpdateInterval, (timer) {
      _updateCurrentTime();
    });
  }

  void _stopTimeUpdate() {
    _timeUpdateTimer?.cancel();
    _timeUpdateTimer = null;
  }

  void _updateCurrentTime() {
    currentTime.value = DateHelper.getCurrentTime();
  }

  Future<void> _fetchWeatherSilently() async {
    try {
      // Don't set isLoading for background updates
      errorMessage.value = '';

      // Get current location
      final location = await _locationRepository.getCurrentLocation();

      // Fetch weather data
      final weatherData = await _weatherRepository.getCurrentWeather(
        location.latitude,
        location.longitude,
      );

      // Update weather data silently - UI will update smoothly via Obx
      weather.value = weatherData;
    } catch (e) {
      // Only show error if it's a critical error, otherwise fail silently
      // to avoid disrupting user experience
      if (weather.value == null) {
        errorMessage.value = e.toString().replaceAll('Exception: ', '');
      }
    }
  }

  Future<void> fetchWeather({bool showLoading = false}) async {
    try {
      if (showLoading) {
        isLoading.value = true;
      }
      errorMessage.value = '';

      // Get current location
      final location = await _locationRepository.getCurrentLocation();

      // Fetch weather data
      final weatherData = await _weatherRepository.getCurrentWeather(
        location.latitude,
        location.longitude,
      );

      weather.value = weatherData;
      isInitialLoad.value = false;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      weather.value = null;
    } finally {
      if (showLoading) {
        isLoading.value = false;
      }
    }
  }

  Future<void> refreshWeather() async {
    await fetchWeather(showLoading: false); // Manual refresh also silent
  }
}
