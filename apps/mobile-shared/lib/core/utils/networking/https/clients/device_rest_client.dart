import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
import 'package:almabike_shared/core/utils/networking/https/models/device/device_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'device_rest_client.g.dart';

@RestApi()
abstract class DeviceRestClient {
  factory DeviceRestClient(Dio dio, {String? baseUrl}) = _DeviceRestClient;

  @GET('/devices')
  Future<List<Device>> fetchDevices();

  @POST('/devices/lock')
  Future<dynamic> lock(@Field() int deviceId);

  @POST('/devices/unlock')
  Future<dynamic> unlock(@Field() int deviceId);

  @POST('/devices/unlock-battery')
  Future<dynamic> unlockBattery(@Field() int deviceId);
}
