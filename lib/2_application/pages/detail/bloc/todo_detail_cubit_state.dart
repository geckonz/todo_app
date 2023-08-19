part of 'todo_detail_cubit.dart';

sealed class ToDoDetailCubitState extends Equatable {
  const ToDoDetailCubitState();

  @override
  List<Object> get props => [];
}

final class ToDoDetailLoadingState extends ToDoDetailCubitState {
  const ToDoDetailLoadingState();
}

final class ToDoDetailErrorState extends ToDoDetailCubitState {
  const ToDoDetailErrorState();
}

final class ToDoDetailLoadedState extends ToDoDetailCubitState {
  const ToDoDetailLoadedState({required this.entryIds});

  final List<EntryId> entryIds;

  @override
  List<Object> get props => [entryIds];
}
