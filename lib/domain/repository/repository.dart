import 'package:dartz/dartz.dart';
import 'package:todo_app/app/error/failure.dart';
import 'package:todo_app/data/requests.dart';
import 'package:todo_app/domain/model/models.dart';

abstract class Repository {
  Future<void> initRepo();
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, int>> addTodoTask(TodoTaskRequestObject request);
  Future<Either<Failure, Map<String, TodoTask>>> getAllTodoTasks();
  Future<Either<Failure, Map<String, TodoTask>>> updateTodoTasks(
      Map<String, TodoTaskRequestObject> todoTasksToUpdate);
}
