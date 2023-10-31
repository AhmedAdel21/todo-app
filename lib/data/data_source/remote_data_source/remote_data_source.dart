import 'package:todo_app/data/network/rest_api/app_api.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async =>
      _appServiceClient.login(loginRequest.username, loginRequest.password);
}
