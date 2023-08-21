import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';

class ToDoEntryLoaded extends StatelessWidget {
  const ToDoEntryLoaded({
    required this.toDoEntry,
    super.key,
  });

  final ToDoEntry toDoEntry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(toDoEntry.isDone ? Icons.task_alt_rounded : null),
      title: Text(toDoEntry.description),
    );
  }
}
