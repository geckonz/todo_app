part of 'to_do_entry_cubit.dart';

sealed class ToDoEntryState extends Equatable {
  const ToDoEntryState();

  @override
  List<Object> get props => [];
}

final class ToDoEntryLoadingState extends ToDoEntryState {
  const ToDoEntryLoadingState();
}

final class ToDoEntryLoadedState extends ToDoEntryState {
  const ToDoEntryLoadedState({
    required this.toDoEntry,
  });

  final ToDoEntry toDoEntry;

  @override
  List<Object> get props => [toDoEntry];
}

final class ToDoEntryErrorState extends ToDoEntryState {
  const ToDoEntryErrorState();
}
