abstract class LocationRepository {
  Future<({double latitude, double longitude})> getCurrentLocation();
}

