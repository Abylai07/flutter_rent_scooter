import 'package:mobility_hub_shared/core/config/env_config.dart';

class AppConstants {
  static const String appAdminTitle = 'ScooterShare Admin';
  static const String appTitle = 'ScooterShare';

  @Deprecated('Use EnvConfig.fromEnvironment().apiBaseUrl instead')
  static const String baseUrl = 'https://api.example.com/';

  static String getBaseUrl() {
    return EnvConfig.fromEnvironment().apiBaseUrl;
  }

  static const int maxRideDurationMinutes = 480;
  static const int minBatteryPercentToRent = 20;
  static const double maxRideDistanceKm = 50.0;
  static const int unlockTimeoutSeconds = 30;
  static const int locationUpdateIntervalSeconds = 5;
}
