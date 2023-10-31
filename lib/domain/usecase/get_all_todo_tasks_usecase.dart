import 'package:todo_app/app/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/domain/usecase/base_usecase.dart';
import 'package:todo_app/presentation/ui/common/ui_models/ui_models.dart';

class GetAllTodoTasksUseCase
    implements BaseUseCase<void, Map<String, TodoTask>> {
  final Repository _repository;

  GetAllTodoTasksUseCase(this._repository);
  @override
  Future<Either<Failure, Map<String, TodoTask>>> execute(_) async =>
      _repository.getAllTodoTasks();
}
