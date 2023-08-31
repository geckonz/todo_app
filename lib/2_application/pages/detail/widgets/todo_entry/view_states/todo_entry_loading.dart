import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ToDoEntryLoading extends StatelessWidget {
  const ToDoEntryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Shimmer(
        color: Theme.of(context).colorScheme.onBackground,
        child: Container(
          constraints: BoxConstraints(
              minHeight: 50,
              minWidth: MediaQuery.of(context).size.width * 0.9),
        ),
      ),
    );
  }
}
