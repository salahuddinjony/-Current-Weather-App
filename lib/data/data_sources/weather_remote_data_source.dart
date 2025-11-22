import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double latitude, double longitude);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(
      double latitude, double longitude) async {
    final url = ApiConstants.getWeatherUrl(latitude, longitude);
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(jsonData);
    } else if (response.statusCode == 401) {
      // Check if API key is still the placeholder
      if (ApiConstants.apiKey == 'YOUR_API_KEY_HERE') {
        throw Exception(
            'API Key not configured. Please add your OpenWeatherMap API key in lib/core/constants/api_constants.dart');
      } else {
        throw Exception(
            'Invalid API key. Please check your OpenWeatherMap API key in lib/core/constants/api_constants.dart');
      }
    } else {
      // Try to parse error message from response
      try {
        final errorData = json.decode(response.body) as Map<String, dynamic>;
        final message = errorData['message'] as String? ?? 'Unknown error';
        throw Exception('Failed to load weather: $message');
      } catch (_) {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    }
  }
}
