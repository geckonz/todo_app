part of 'create_to_do_entry_page_cubit.dart';

class CreateToDoEntryPageState extends Equatable {
  final FormValue<String?>? description;

  const CreateToDoEntryPageState({this.description});

  @override
  List<Object?> get props => [description];

  CreateToDoEntryPageState copyWith({FormValue<String?>? description}) {
    return CreateToDoEntryPageState(
        description: description ?? this.description);
  }
}
