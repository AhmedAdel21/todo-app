import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/network/rest_api/app_api.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/data/response/responses.dart';

@GenerateMocks([AppServiceClient])
import 'app_api_test.mocks.dart';

void main() {
  group("#fetchPokemon", () {
    late AppServiceClient service;
    setUp(() {
      service = MockAppServiceClient(); // #1
    });
    final tLoginRequest = LoginRequest("email", "password");
    test('send login request ', () async {
      when(service.login(tLoginRequest.username, tLoginRequest.password))
          .thenAnswer(// #2
              (_) async => AuthenticationResponse.fromJson(json));

      final result =
          await service.login(tLoginRequest.username, tLoginRequest.password);
      print(result.toJson());
    });
  });
}

final json = {
  "status": 0,
  "message": "Succuss",
  "userId": 1,
  "userName": "Dola",
  "password": "123"
};
