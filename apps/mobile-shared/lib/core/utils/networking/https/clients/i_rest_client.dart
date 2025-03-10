import 'package:almabike_shared/core/utils/networking/https/models/device_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'i_rest_client.g.dart';

@RestApi(baseUrl: 'https://api-dev.almabike.mimishki.kz/')
abstract class IRestClient {
  factory IRestClient(Dio dio, {String? baseUrl}) = _IRestClient;

  @GET('/devices')
  Future<List<Device>> fetchDevices();

  @POST('/devices/lock')
  Future<dynamic> lock(@Field() int deviceId);

  @POST('/auth/login')
  Future<dynamic> login(
    @Field() String phone,
    @Field() String code,
  );

  @POST('/auth/register')
  Future<dynamic> register(
    @Field() String name,
    @Field() String phone,
    @Field() String email,
  );

  @POST('/devices/unlock')
  Future<dynamic> unlock(@Field() int deviceId);

  @POST('/devices/unlock-battery')
  Future<dynamic> unlockBattery(@Field() int deviceId);
}
