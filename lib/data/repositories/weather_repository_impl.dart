import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/weather_remote_data_source.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WeatherEntity> getCurrentWeather(
      double latitude, double longitude) async {
    try {
      final weatherModel =
          await remoteDataSource.getCurrentWeather(latitude, longitude);
      return weatherModel;
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }
}
