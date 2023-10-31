import 'package:todo_app/app/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/domain/usecase/base_usecase.dart';
import 'package:todo_app/domain/usecase/inputs.dart';

class LoginUseCase implements BaseUseCase<UserLoginDataUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
          UserLoginDataUseCaseInput input) async =>
      _repository.login(LoginRequest(input.userName, input.password));
}
