# Current Weather App

A Flutter mobile application that displays current weather conditions based on the user's geographical location. Built with Clean Architecture principles and GetX for state management.

## Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="assets/project_screen/splash page.png" alt="Splash Screen" width="200"/>
        <br><strong>Splash Screen</strong>
      </td>
      <td align="center">
        <img src="assets/project_screen/Home page.png" alt="Home Page" width="200"/>
        <br><strong>Home Page</strong>
      </td>
      <td align="center">
        <img src="assets/project_screen/location permission.png" alt="Location Permission" width="200"/>
        <br><strong>Location Permission</strong>
      </td>
    </tr>
  </table>
</div>

## Weather Icons

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="assets/images/1.png" alt="Thunderstorm" width="120"/>
        <br><strong>Thunderstorm</strong>
        <br><small>(Code: 200-299)</small>
      </td>
      <td align="center">
        <img src="assets/images/2.png" alt="Drizzle" width="120"/>
        <br><strong>Drizzle</strong>
        <br><small>(Code: 300-399)</small>
      </td>
      <td align="center">
        <img src="assets/images/3.png" alt="Rain" width="120"/>
        <br><strong>Rain</strong>
        <br><small>(Code: 500-599)</small>
      </td>
      <td align="center">
        <img src="assets/images/4.png" alt="Snow" width="120"/>
        <br><strong>Snow</strong>
        <br><small>(Code: 600-699)</small>
      </td>
      <td align="center">
        <img src="assets/images/6.png" alt="Clear Sky" width="120"/>
        <br><strong>Clear Sky</strong>
        <br><small>(Code: 800)</small>
      </td>
    </tr>
  </table>
</div>

## Features

- **Automatic Location Detection**: Automatically detects the device's current latitude and longitude upon startup
- **Current Weather Display**: Fetches and displays real-time weather data based on detected coordinates
- **Comprehensive Weather Information**:
  - City Name / Location Name
  - Current Temperature (in Celsius)
  - Weather Condition (e.g., "Clear," "Rain," "Clouds")
  - Weather Icon
  - Minimum and Maximum Daily Temperatures
  - Sunrise and Sunset Times
- **Automatic Updates**:
  - **Weather Data**: Automatically refreshes every 5 minutes in the background
  - **Time Display**: Updates every 1 minute to show current time
  - **Silent Updates**: Background updates happen seamlessly without flickering or disrupting user experience
- **Pull-to-Refresh**: Swipe down to refresh weather data manually
- **Error Handling**: User-friendly error messages with retry functionality
- **Splash Screen**: Beautiful animated splash screen on app launch

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

- **Domain Layer**: Contains business logic, entities, and repository interfaces
- **Data Layer**: Handles data sources, models, and repository implementations
- **Presentation Layer**: Contains UI components and GetX controllers

## Tech Stack

- **Flutter**: Cross-platform mobile framework
- **GetX**: State management and dependency injection
- **Geolocator**: Location services
- **HTTP**: API communication
- **OpenWeatherMap API**: Weather data provider

## Setup Instructions

### 1. Get an API Key

1. Visit [OpenWeatherMap](https://openweathermap.org/api)
2. Sign up for a free account
3. Get your API key from the dashboard

### 2. Configure API Key

Open `lib/core/constants/api_constants.dart` and replace `YOUR_API_KEY_HERE` with your actual API key:

```dart
static const String apiKey = 'your_actual_api_key_here';
```

### 3. Install Dependencies

```bash
flutter pub get
```

### 4. Generate Code (if needed)

If you modify the models, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Run the App

```bash
flutter run
```

## Automatic Updates

The app features intelligent automatic updates:

- **Weather Data Updates**: 
  - Automatically fetches fresh weather data every **5 minutes**
  - Updates happen silently in the background
  - No loading indicators or flickering during updates
  - Previous data remains visible while new data loads

- **Time Display Updates**:
  - Current time updates every **1 minute**
  - Shows time in 12-hour format (e.g., "8:18 PM")
  - Updates independently from weather data

- **Customization**:
  - Update intervals can be customized in `lib/presentation/controllers/weather_controller.dart`
  - Change `_weatherUpdateInterval` for weather update frequency
  - Change `_timeUpdateInterval` for time update frequency

## Permissions

The app requires location permissions to function:

- **Android**: Permissions are automatically configured in `AndroidManifest.xml`
- **iOS**: Permissions are configured in `Info.plist`. Make sure to grant location permissions when prompted.

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── api_constants.dart
│   ├── di/
│   │   └── injection_container.dart
│   └── utils/
│       └── location_helper.dart
├── data/
│   ├── data_sources/
│   │   ├── location_data_source.dart
│   │   └── weather_remote_data_source.dart
│   ├── models/
│   │   ├── weather_model.dart
│   │   └── weather_model.g.dart
│   └── repositories/
│       └── weather_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── weather_entity.dart
│   └── repositories/
│       ├── location_repository.dart
│       └── weather_repository.dart
├── presentation/
│   ├── controllers/
│   │   └── weather_controller.dart
│   ├── pages/
│   │   └── splash_screen.dart
│   ├── weather/
│   │   └── weather_page.dart
│   └── widgets/
│       └── weather_asset_helper.dart
├── home_screen.dart
├── main.dart
└── my_app.dart
```


## Getting Started

This project is a starting point for a Flutter application.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## License

This project is created for educational purposes.
