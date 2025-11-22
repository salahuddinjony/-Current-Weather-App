class ApiConstants {
  // ⚠️ IMPORTANT: Replace 'YOUR_API_KEY_HERE' with your actual OpenWeatherMap API key
  // 
  // Steps to get your API key:
  // 1. Visit https://openweathermap.org/api
  // 2. Sign up for a free account
  // 3. Navigate to API keys section in your account dashboard
  // 4. Copy your API key and paste it below (replace the placeholder)
  // 
  // Example: static const String apiKey = 'abc123def456ghi789';
  static const String apiKey = '8808172424a256afe27f965505cd1ff3';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String weatherEndpoint = '/weather';
  
  static String getWeatherUrl(double lat, double lon) {
    return '$baseUrl$weatherEndpoint?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  }
}

