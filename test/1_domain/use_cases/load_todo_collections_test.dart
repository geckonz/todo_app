import 'package:either_dart/either.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/core/use_case.dart';

class MockToDoRepository extends Mock implements ToDoRepository {}

void main() {
  group('LoadToDoCollections', () {
    late ToDoRepository mockToDoRepository;
    late NoParams params;

    setUp(() {
      mockToDoRepository = MockToDoRepository();
      params = NoParams();
    });

    group('should return a ToDoCollection List', () {
      test('when toDoRepository returns a ToDoCollection', () {
        final loadToDoCollectionUseCaseUnderTest =
            LoadToDoCollections(toDoRepository: mockToDoRepository);

        final list = List<ToDoCollection>.generate(
          5,
          (index) => ToDoCollection(
            id: CollectionId.fromUniqueString(index.toString()),
            title: 'title $index',
            color: ToDoColor(
                colorIndex: index % ToDoColor.predefinedColors.length),
          ),
        );

        when(() => mockToDoRepository.readToDoCollections())
            .thenAnswer((_) => Future.value(Right(list)));

        expect(loadToDoCollectionUseCaseUnderTest(params),
            completion(equals(Right(list))));

        verify(() => mockToDoRepository.readToDoCollections()).called(1);
        verifyNoMoreInteractions(mockToDoRepository);
      });
    });

    group('should return a left', () {
      test('when toDoRepository returns a Failure', () {
        final loadToDoCollectionUseCaseUnderTest =
            LoadToDoCollections(toDoRepository: mockToDoRepository);

        when(() => mockToDoRepository.readToDoCollections())
            .thenAnswer((_) => Future.value(Left(ServerFailure())));

        expect(loadToDoCollectionUseCaseUnderTest(params),
            completion(equals(Left(ServerFailure()))));

        verify(() => mockToDoRepository.readToDoCollections()).called(1);
        verifyNoMoreInteractions(mockToDoRepository);
      });
    });
  });
}
