import 'package:almabike_shared/almabike_shared.dart';
import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// This is a class that contains the Dio instances to be used in the API calls.
class RestClient {
  final dio = Dio(BaseOptions(
    baseUrl: BikeConstants.baseUrl,
  ))
    ..interceptors.addAll(
      [
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
