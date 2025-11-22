import 'package:current_weather_app/core/dependency_injections/injection_container.dart';
import 'package:current_weather_app/my_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Initialize dependency injection
  runApp(const MyApp());
}
