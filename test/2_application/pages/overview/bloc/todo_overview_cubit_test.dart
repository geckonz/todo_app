import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_collections.dart';
import 'package:todo_app/2_application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:todo_app/core/use_case.dart';

class MockLoadToDoCollections extends Mock implements LoadToDoCollections {}

void main() {
  group('ToDoOverviewCubit', () {
    group('should emit', () {
      MockLoadToDoCollections mockLoadToDoCollections =
          MockLoadToDoCollections();
      blocTest(
        'nothing when no method is called',
        build: () =>
            ToDoOverviewCubit(loadToDoCollections: mockLoadToDoCollections),
        expect: () => const <ToDoOverviewCubitState>[],
        verify: (_) => verifyNoMoreInteractions(mockLoadToDoCollections),
      );

      blocTest(
        '[ToDoOverviewCubitLoadingState, ToDoOverviewCubitLoadedState] when readToDoCollections is called',
        setUp: () => when(() => mockLoadToDoCollections(NoParams())).thenAnswer(
          (_) => Future.value(
            const Right(<ToDoCollection>[]),
          ),
        ),
        build: () =>
            ToDoOverviewCubit(loadToDoCollections: mockLoadToDoCollections),
        act: (ToDoOverviewCubit cubit) => cubit.readToDoCollections(),
        expect: () => <ToDoOverviewCubitState>[
          ToDoOverviewCubitLoadingState(),
          const ToDoOverviewCubitLoadedState(
              toDoCollection: <ToDoCollection>[]),
        ],
      );
      blocTest(
        '[ToDoOverviewCubitLoadingState, ToDoOverviewCubitErrorState] when readToDoCollections is called and a ServerFailure occurs',
        setUp: () => when(() => mockLoadToDoCollections(NoParams())).thenAnswer(
          (_) => Future.value(
            Left(ServerFailure()),
          ),
        ),
        build: () =>
            ToDoOverviewCubit(loadToDoCollections: mockLoadToDoCollections),
        act: (ToDoOverviewCubit cubit) => cubit.readToDoCollections(),
        expect: () => <ToDoOverviewCubitState>[
          ToDoOverviewCubitLoadingState(),
          ToDoOverviewCubitErrorState(),
        ],
      );
      blocTest(
        '[ToDoOverviewCubitLoadingState, ToDoOverviewCubitErrorState] when readToDoCollections is called and throws an Exception',
        setUp: () => when(() => mockLoadToDoCollections(NoParams())).thenThrow(
          Exception(),
        ),
        build: () =>
            ToDoOverviewCubit(loadToDoCollections: mockLoadToDoCollections),
        act: (ToDoOverviewCubit cubit) => cubit.readToDoCollections(),
        expect: () => <ToDoOverviewCubitState>[
          ToDoOverviewCubitLoadingState(),
          ToDoOverviewCubitErrorState(),
        ],
      );
    });
  });
}
