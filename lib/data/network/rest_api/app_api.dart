import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:todo_app/app/constants/global_constants.dart';
import 'package:todo_app/data/network/rest_api/network_constants.dart';
import 'package:todo_app/data/response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(RESTPaths.loginPath)
  Future<AuthenticationResponse> login(
    @Field("username") String username,
    @Field("password") String password,
  );
}
