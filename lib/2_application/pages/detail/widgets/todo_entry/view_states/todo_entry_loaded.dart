import 'package:flutter/material.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';

class ToDoEntryLoaded extends StatelessWidget {
  const ToDoEntryLoaded({
    required this.toDoEntry,
    required this.onChanged,
    super.key,
  });

  final ToDoEntry toDoEntry;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      title: Text(toDoEntry.description),
      value: toDoEntry.isDone,
      onChanged: onChanged,
    );
  }
}
