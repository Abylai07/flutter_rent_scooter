import 'package:almabike_shared/core/utils/constants/bike_constants.dart';
import 'package:almabike_shared/core/utils/networking/https/models/auth/auth_model.dart';
import 'package:almabike_shared/core/utils/networking/https/models/profile/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_rest_client.g.dart';

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio, {String? baseUrl}) = _AuthRestClient;

  @POST('auth/mobile/request-pin')
  Future<dynamic> requestPin(
    @Field() String phone,
  );

  @POST('auth/mobile/confirm-pin')
  Future<AuthTokensModel> login(
    @Field() String phone,
    @Field('pincode') String code,
  );

  @POST('auth/refresh')
  Future<AuthTokensModel> refresh(
    @Field() String refreshToken,
    @Field() String clientId,
  );

  @POST('auth/mobile/profile')
  Future<UserAccountModel> fetchProfile(
    @Field() String authorization,
  );

  @POST('/auth/register')
  Future<dynamic> register(
    @Field() String name,
    @Field() String phone,
    @Field() String email,
  );
}
