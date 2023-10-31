import 'package:todo_app/app/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/domain/model/models.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/domain/usecase/base_usecase.dart';

class UpdateTodoTasksUseCase
    implements BaseUseCase<Map<String, TodoTask>, Map<String, TodoTask>> {
  final Repository _repository;

  UpdateTodoTasksUseCase(this._repository);
  @override
  Future<Either<Failure, Map<String, TodoTask>>> execute(
          Map<String, TodoTask> todoTasksToUpdate) async =>
      _repository.updateTodoTasks(todoTasksToUpdate.map(
        (key, value) => MapEntry<String, TodoTaskRequestObject>(
          key,
          TodoTaskRequestObject(
              icon: value.icon.imagePath,
              name: value.name,
              description: value.description,
              dateTime: value.dateTime,
              timeOfDay: value.timeOfDay,
              isDone: value.isDone),
        ),
      ));
}
