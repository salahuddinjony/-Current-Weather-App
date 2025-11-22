import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.minTemperature,
    required super.maxTemperature,
    required super.condition,
    required super.description,
    required super.iconCode,
    super.weatherConditionCode,
    required super.sunrise,
    required super.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] as String? ?? 'Unknown',
      temperature: (json['main']?['temp'] as num?)?.toDouble() ?? 0.0,
      minTemperature: (json['main']?['temp_min'] as num?)?.toDouble() ?? 0.0,
      maxTemperature: (json['main']?['temp_max'] as num?)?.toDouble() ?? 0.0,
      condition: json['weather']?[0]?['main'] as String? ?? 'Unknown',
      description: json['weather']?[0]?['description'] as String? ?? 'Unknown',
      iconCode: json['weather']?[0]?['icon'] as String? ?? '01d',
      weatherConditionCode: json['weather']?[0]?['id'] as int?,
      sunrise: (json['sys']?['sunrise'] as int?) ?? 0,
      sunset: (json['sys']?['sunset'] as int?) ?? 0,
    );
  }
}

