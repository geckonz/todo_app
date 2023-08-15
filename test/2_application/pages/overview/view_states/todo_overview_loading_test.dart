import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/2_application/pages/overview/view_states/todo_overview_loading.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: TodoOverviewLoading(),
      ),
    );
  }

  group('ToDoOverviewLoading', () {
    testWidgets('should render correctly', (tester) async {
      await tester.pumpWidget(widgetUnderTest());

      final circularProgressIndicatorFinder =
          find.byType(CircularProgressIndicator);

      expect(circularProgressIndicatorFinder, findsOneWidget);
    });
  });
}
