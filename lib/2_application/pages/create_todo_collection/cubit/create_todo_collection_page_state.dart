part of 'create_todo_collection_page_cubit.dart';

class CreateToDoCollectionPageState extends Equatable {
  final String? title;
  final String? colour;

  const CreateToDoCollectionPageState({this.title, this.colour});

  @override
  List<Object?> get props => [title, colour];

  CreateToDoCollectionPageState copyWith({String? title, String? colour}) {
    return CreateToDoCollectionPageState(
        colour: colour ?? this.colour, title: title ?? this.title);
  }
}
