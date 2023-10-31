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
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      when(mockRepository.addTodoTask(any))
          .thenAnswer((_) async => const Right(1));
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = await usecase.execute(tAddTodoTaskUseCaseInput);
      // UseCase should simply return whatever was returned from the Repository
      expect(result, const Right(1));
      // Verify that the method has been called on the Repository
      verify(mockRepository.addTodoTask(any));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
