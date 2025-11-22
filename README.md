# Current Weather App

A Flutter mobile application that displays current weather conditions based on the user's geographical location. Built with Clean Architecture principles and GetX for state management.

## Features

- **Automatic Location Detection**: Automatically detects the device's current latitude and longitude upon startup
- **Current Weather Display**: Fetches and displays real-time weather data based on detected coordinates
- **Comprehensive Weather Information**:
  - City Name / Location Name
  - Current Temperature (in Celsius)
  - Weather Condition (e.g., "Clear," "Rain," "Clouds")
  - Weather Icon
  - Minimum and Maximum Daily Temperatures
- **Pull-to-Refresh**: Swipe down to refresh weather data
- **Error Handling**: User-friendly error messages with retry functionality

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
│   └── widgets/
│       └── weather_icon.dart
├── home_screen.dart
├── main.dart
└── my_app.dart
```

## Screenshots

<!-- Add your screenshots here after testing the app -->
<!-- Example format:
![Home Screen](screenshots/home_screen.png)
![Loading State](screenshots/loading.png)
![Error State](screenshots/error.png)
-->

### Screenshots Placeholder

Please add screenshots of the app in action:
1. Home screen with weather data
2. Loading state
3. Error state (if applicable)

## Getting Started

This project is a starting point for a Flutter application.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## License

This project is created for educational purposes.
