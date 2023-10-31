import 'package:todo_app/app/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/domain/usecase/base_usecase.dart';
import 'package:todo_app/domain/usecase/inputs.dart';

class AddTodoTaskUseCase implements BaseUseCase<AddTodoTaskUseCaseInput, int> {
  final Repository _repository;

  AddTodoTaskUseCase(this._repository);
  @override
  Future<Either<Failure, int>> execute(AddTodoTaskUseCaseInput input) async =>
      _repository.addTodoTask(TodoTaskRequestObject(
        icon: input.icon,
        name: input.name,
        description: input.description,
        dateTime: input.dateTime,
        timeOfDay: input.timeOfDay,
        isDone: input.isDone,
      ));
}
