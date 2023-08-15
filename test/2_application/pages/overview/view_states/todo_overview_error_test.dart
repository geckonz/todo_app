import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_error.dart';

void main() {

  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: TodoOverviewError(),
      ),
    );
  }

  group('ToDoOverviewError', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(widgetUnderTest());
      await tester.pumpAndSettle();

      expect(find.byType(Card), findsOneWidget);
      expect(find.text('ERROR, Please try again.'), findsOneWidget);
    });
  });
}