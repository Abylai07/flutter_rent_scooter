class EnvConfig {
  final String apiBaseUrl;
  final String? mapApiKey;
  final bool debugMode;
  final int apiTimeout;

  EnvConfig({
    String? apiBaseUrl,
    this.mapApiKey,
    bool? debugMode,
    int? apiTimeout,
  })  : apiBaseUrl = apiBaseUrl ??
            const String.fromEnvironment(
              'API_BASE_URL',
              defaultValue: 'https://api.example.com/',
            ),
        debugMode = debugMode ??
            const bool.fromEnvironment(
              'DEBUG_MODE',
              defaultValue: false,
            ),
        apiTimeout = apiTimeout ??
            const int.fromEnvironment(
              'API_TIMEOUT',
              defaultValue: 30,
            );

  factory EnvConfig.fromEnvironment() {
    return EnvConfig(
      apiBaseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.example.com/',
      ),
      mapApiKey: const String.fromEnvironment(
        'MAP_API_KEY',
        defaultValue: '',
      ).isEmpty
          ? null
          : const String.fromEnvironment('MAP_API_KEY'),
      debugMode: const bool.fromEnvironment(
        'DEBUG_MODE',
        defaultValue: false,
      ),
      apiTimeout: const int.fromEnvironment(
        'API_TIMEOUT',
        defaultValue: 30,
      ),
    );
  }

  void validate() {
    if (apiBaseUrl.isEmpty) {
      throw ConfigurationException('API_BASE_URL is required');
    }

    if (!apiBaseUrl.startsWith('http://') &&
        !apiBaseUrl.startsWith('https://')) {
      throw ConfigurationException(
        'API_BASE_URL must start with http:// or https://',
      );
    }
  }

  @override
  String toString() {
    return 'EnvConfig('
        'apiBaseUrl: $apiBaseUrl, '
        'mapApiKey: ${mapApiKey != null ? '***' : 'null'}, '
        'debugMode: $debugMode, '
        'apiTimeout: ${apiTimeout}s'
        ')';
  }
}

class ConfigurationException implements Exception {
  final String message;

  ConfigurationException(this.message);

  @override
  String toString() => 'ConfigurationException: $message';
}