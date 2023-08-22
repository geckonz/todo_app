import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

class ToDoEntry extends Equatable {
  final String description;
  final bool isDone;
  final EntryId id;

  const ToDoEntry({
    required this.description,
    required this.isDone,
    required this.id,
  });

  factory ToDoEntry.empty() {
    return ToDoEntry(
      description: '',
      isDone: false,
      id: EntryId(),
    );
  }

  ToDoEntry copyWith({
    String? description,
    bool? isDone,
  }) {
    return ToDoEntry(
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      id: id,
    );
  }

  @override
  List<Object> get props {
    return [description, isDone, id];
  }
}
