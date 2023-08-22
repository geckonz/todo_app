import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class ToDoCollection extends Equatable{
  final CollectionId id;
  final String title;
  final ToDoColor color;

  const ToDoCollection({
    required this.id,
    required this.title,
    required this.color,
    });

  factory ToDoCollection.empty() {
    return ToDoCollection(
      id: CollectionId(),
      title: '',
      color: ToDoColor(
        colorIndex: 0,
      ),
    );
  }

  @override
  List<Object> get props {
    return [id, title, color];
  }
}