import 'package:flutter/material.dart';
import 'package:todo_app/2_application/core/page_config.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.task_rounded,
    name: 'task',
    child: TaskPage()
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
    );
  }
}