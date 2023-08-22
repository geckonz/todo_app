import 'package:flutter/material.dart';

class ToDoEntryError extends StatelessWidget {
  const ToDoEntryError({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      onTap: null,
      leading: Icon(Icons.warning_rounded),
      title: Text('Error loading entry, please try again.'),
    );
  }
}