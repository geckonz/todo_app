import 'package:equatable/equatable.dart';

class ToDoCollectionModel extends Equatable {
  final String id;
  final String title;
  final int colourIndex;

  const ToDoCollectionModel({
    required this.id,
    required this.title,
    required this.colourIndex,
  });

  factory ToDoCollectionModel.fromJson(Map<String, dynamic> json) {
    return ToDoCollectionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      colourIndex: json['colourIndex'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'colourIndex': colourIndex,
    };
  }

  @override
  List<Object?> get props => [id, title, colourIndex];
}