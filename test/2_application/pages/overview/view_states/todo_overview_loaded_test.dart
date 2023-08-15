import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loaded.dart';

void main() {
  final toDoCollection = ToDoCollection(
    id: CollectionId.fromUniqueString('1'),
    title: 'title',
    color: ToDoColor(colorIndex: 0),
  );

  Widget widgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: ToDoOverviewLoaded(toDoCollection: [toDoCollection]),
      ),
    );
  }

  group('ToDoOverviewLoaded', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(widgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text(toDoCollection.title), findsOneWidget);
    });
  });
}
