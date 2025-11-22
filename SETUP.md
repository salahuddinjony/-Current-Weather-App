# Setup Guide

## Quick Start

1. **Get OpenWeatherMap API Key**
   - Visit: https://openweathermap.org/api
   - Sign up for a free account
   - Navigate to API keys section
   - Copy your API key

2. **Configure API Key**
   - Open `lib/core/constants/api_constants.dart`
   - Replace `YOUR_API_KEY_HERE` with your actual API key:
     ```dart
     static const String apiKey = 'your_actual_api_key_here';
     ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

## Important Notes

- Make sure location permissions are granted when the app requests them
- The app requires an active internet connection to fetch weather data
- Free tier of OpenWeatherMap API has rate limits (60 calls/minute)

