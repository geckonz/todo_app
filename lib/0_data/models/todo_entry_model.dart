import 'package:equatable/equatable.dart';

class ToDoEntryModel extends Equatable {
  final String id;
  final String description;
  final bool isDone;

  const ToDoEntryModel({
    required this.id,
    required this.description,
    required this.isDone,
  });

  factory ToDoEntryModel.fromJson(Map<String, dynamic> json) {
    return ToDoEntryModel(
      id: json['id'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [id, description, isDone];
}