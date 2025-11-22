import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../data/data_sources/location_data_source.dart';
import '../../data/data_sources/weather_remote_data_source.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/weather_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data Sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(client: http.Client()),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => LocationDataSource(),
  );

  // Repositories
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(remoteDataSource: sl()),
  );
}

