import 'package:flutter/material.dart';

class ToDoEntryError extends StatelessWidget {
  const ToDoEntryError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error loading ToDo Entry, please try again.'),
    );
  }
}