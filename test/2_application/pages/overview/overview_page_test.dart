import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/pages/overview/bloc/todo_overview_cubit.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_error.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

class MockToDoOverviewCubit extends MockCubit<ToDoOverviewCubitState>
    implements ToDoOverviewCubit {}

void main() {
  Widget widgetUnderTest({required ToDoOverviewCubit cubit}) {
    return MaterialApp(
      home: BlocProvider<ToDoOverviewCubit>(
        create: (context) => cubit,
        child: const Scaffold(body: OverviewPage()),
      ),
    );
  }

  group('OverviewPage', () {
    late ToDoOverviewCubit mockToDoOverviewCubit;

    setUp(() {
      mockToDoOverviewCubit = MockToDoOverviewCubit();
    });

    group('should be displayed in the view state', () {
      testWidgets(
          'Loading when the cubit emits a ToDoOverviewCubitLoadingState',
          (widgetTester) async {
        whenListen(
          mockToDoOverviewCubit,
          Stream.fromIterable([
            ToDoOverviewCubitLoadingState(),
          ]),
          initialState: ToDoOverviewCubitLoadingState(),
        );
        await widgetTester
            .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));

        expect(find.byType(TodoOverviewLoading), findsOneWidget);
      });

      testWidgets('Loaded once the cubit emits a ToDoOverviewCubitLoadedState',
          (widgetTester) async {
        final toDoCollection = ToDoCollection(
          id: CollectionId.fromUniqueString('1'),
          title: 'title',
          color: ToDoColor(colorIndex: 0),
        );

        whenListen(
          mockToDoOverviewCubit,
          Stream.fromIterable([
            ToDoOverviewCubitLoadedState(toDoCollection: [toDoCollection]),
          ]),
          initialState: ToDoOverviewCubitLoadingState(),
        );
        await widgetTester
            .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));
        await widgetTester.pumpAndSettle();

        expect(find.byType(TodoOverviewLoading), findsNothing);
        expect(find.byType(ToDoOverviewLoaded), findsOneWidget);
        expect(find.text('title'), findsOneWidget);
      });

      testWidgets('Error when the cubit emits ToDoOverviewCubitErrorState',
          (widgetTester) async {
        whenListen(
          mockToDoOverviewCubit,
          Stream.fromIterable([
            ToDoOverviewCubitErrorState(),
          ]),
          initialState: ToDoOverviewCubitLoadingState(),
        );
        await widgetTester
            .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));
        await widgetTester.pumpAndSettle();

        expect(find.byType(TodoOverviewError), findsOneWidget);
        expect(find.text('ERROR, Please try again.'), findsOneWidget);
      });
    });
  });
}
