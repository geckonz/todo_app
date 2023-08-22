import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ToDoEntryLoading extends StatelessWidget {
  const ToDoEntryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Colors.black,
      child: Card(
        color: Colors.grey.withOpacity(0.8),
        margin: const EdgeInsets.all(0),
        child: Container(
          constraints: BoxConstraints(
              minHeight: 100,
              minWidth: MediaQuery.of(context).size.width * 0.9),
        ),
      ),
    );
  }
}
