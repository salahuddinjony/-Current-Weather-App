class WeatherAssetHelper {
  static String getWeatherIcon(int? code) {
    if (code == null) return 'assets/images/7.png';
    
    switch (code) {
      case >= 200 && < 300:
        return 'assets/images/1.png'; // Thunderstorm
      case >= 300 && < 400:
        return 'assets/images/2.png'; // Drizzle
      case >= 500 && < 600:
        return 'assets/images/3.png'; // Rain
      case >= 600 && < 700:
        return 'assets/images/4.png'; // Snow
      case >= 700 && < 800:
        return 'assets/images/5.png'; // Atmosphere (mist, smoke, etc.)
      case == 800:
        return 'assets/images/6.png'; // Clear
      case > 800 && <= 804:
        return 'assets/images/7.png'; // Clouds
      default:
        return 'assets/images/7.png';
    }
  }
  
  static String getSunriseIcon() => 'assets/images/11.png';  // Sunrise icon
  static String getSunsetIcon() => 'assets/images/12.png';  // Sunset icon
  static String getTempMaxIcon() => 'assets/images/13.png';  // Temperature max icon
  static String getTempMinIcon() => 'assets/images/14.png';  // Temperature min icon
}

