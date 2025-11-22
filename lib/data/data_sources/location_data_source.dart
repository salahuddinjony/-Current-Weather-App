import '../../core/utils/location_helper.dart';
import '../../domain/repositories/location_repository.dart';

class LocationDataSource implements LocationRepository {
  @override
  Future<({double latitude, double longitude})> getCurrentLocation() async {
    try {
      final position = await LocationHelper.getCurrentLocation();
      return (latitude: position.latitude, longitude: position.longitude);
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }
}

