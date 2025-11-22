class WeatherEntity {
  final String cityName;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final String condition;
  final String description;
  final String iconCode;
  final int? weatherConditionCode; // Weather condition code from API
  final int sunrise; // Unix timestamp
  final int sunset; // Unix timestamp

  WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.condition,
    required this.description,
    required this.iconCode,
    this.weatherConditionCode,
    required this.sunrise,
    required this.sunset,
  });
}

