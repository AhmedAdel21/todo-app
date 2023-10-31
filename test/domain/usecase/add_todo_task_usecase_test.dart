import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/domain/repository/repository.dart';
import 'package:todo_app/domain/usecase/inputs.dart';
import 'package:todo_app/domain/usecase/usecase.dart';

@GenerateMocks([Repository])
import 'add_todo_task_usecase_test.mocks.dart';

void main() {
  late AddTodoTaskUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();

    usecase = AddTodoTaskUseCase(mockRepository);
  });
  final timeNow = DateTime.now();
  final tAddTodoTaskUseCaseInput = AddTodoTaskUseCaseInput(
    icon: "icon",
    name: "name",
    description: "description",
    dateTime: timeNow,
    timeOfDay: TimeOfDay.now(),
    isDone: false,
  );
  test(
    'should get true for the call from the repository',
    () async {
      when(mockRepository.addTodoTask(any))
          .thenAnswer((_) async => const Right(1));
      final result = await usecase.execute(tAddTodoTaskUseCaseInput);
      expect(result, const Right(1));
      verify(mockRepository.addTodoTask(any));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
