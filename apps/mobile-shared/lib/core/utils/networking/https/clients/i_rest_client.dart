import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'i_rest_client.g.dart';

@RestApi(baseUrl: 'https://api-dev.almabike.mimishki.kz/')
abstract class IRestClient {
  factory IRestClient(Dio dio, {String? baseUrl}) = _IRestClient;

  @GET('/devices')
  Future<dynamic> fetchDevices();

  @POST('/devices/lock')
  Future<dynamic> lock(@Field() int deviceId);

  @POST('/devices/unlock')
  Future<dynamic> unlock(@Field() int deviceId);
}
