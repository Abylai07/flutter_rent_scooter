import 'package:almabike_shared/core/utils/networking/https/clients/i_rest_client.dart';
import 'package:dio/dio.dart';

/// This is a class that contains the Dio instances to be used in the API calls.
class RestClient {
  final dio = Dio(BaseOptions());

  IRestClient get app => IRestClient(dio);
}
