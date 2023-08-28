import 'package:flutter/material.dart';

class ToDoEntryError extends StatelessWidget {
  const ToDoEntryError({
      required this.handleRetry,
      super.key
    });

  final Function() handleRetry;

  @override
  Widget build(BuildContext context) {
    
    return ListTile(
      onTap: handleRetry,
      leading: const Icon(Icons.warning_rounded),
      title: const Text('Error loading entry, click or tap to retry.'),
    );
  }
}