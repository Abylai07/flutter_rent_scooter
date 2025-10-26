import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/config/env_config.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  final EnvConfig _config;

  RestClient({EnvConfig? config}) : _config = config ?? EnvConfig.fromEnvironment();

  late final Dio dio = Dio(
    BaseOptions(
      baseUrl: _config.apiBaseUrl,
      connectTimeout: Duration(seconds: _config.apiTimeout),
      receiveTimeout: Duration(seconds: _config.apiTimeout),
      sendTimeout: Duration(seconds: _config.apiTimeout),
    ),
  )..interceptors.addAll(
      [
        if (_config.debugMode)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            request: true,
            responseBody: true,
            responseHeader: true,
          ),
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final needAuth = _requiresAuth(options.path, options.method);
            if (needAuth) {
              final token = AppStorage.accessToken;
              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
            }
            return handler.next(options);
          },
        ),
      ],
    );

  DeviceRestClient get device => DeviceRestClient(dio);
  AuthRestClient get auth => AuthRestClient(dio);
}

bool _requiresAuth(String path, String method) {
  final protectedEndpoints = [
    '/devices',
    '/devices/lock',
    '/devices/unlock',
    '/devices/unlock-battery',
  ];
  return protectedEndpoints.contains(path);
}
