import 'package:geolocator/geolocator.dart';
import 'package:dgis_mobile_sdk_map/dgis.dart' as sdk;

mixin LocationMixin {
  Future<sdk.GeoPoint?> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever || permission == LocationPermission.denied) {
        return null;
      }
    }

    final position = await Geolocator.getCurrentPosition();
    return sdk.GeoPoint(
      latitude: sdk.Latitude(position.latitude),
      longitude: sdk.Longitude(position.longitude),
    );
  }
}