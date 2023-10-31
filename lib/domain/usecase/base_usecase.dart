import 'package:dartz/dartz.dart';
import 'package:todo_app/app/error/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
