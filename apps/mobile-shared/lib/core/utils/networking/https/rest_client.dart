import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// This is a class that contains the Dio instances to be used in the API calls.
class RestClient {
  final dio = Dio(BaseOptions())
    ..interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        request: true,
        responseBody: true,
        responseHeader: true,
      ),
    );

  IRestClient get app => IRestClient(dio);
}
