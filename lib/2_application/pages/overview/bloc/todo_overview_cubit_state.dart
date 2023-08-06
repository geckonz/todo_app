part of 'todo_overview_cubit.dart';

abstract class ToDoOverviewCubitState extends Equatable {
  const ToDoOverviewCubitState();

  @override
  List<Object> get props => [];
}

class ToDoOverviewCubitLoadingState extends ToDoOverviewCubitState {}

class ToDoOverviewCubitErrorState extends ToDoOverviewCubitState {}

class ToDoOverviewCubitLoadedState extends ToDoOverviewCubitState {
  const ToDoOverviewCubitLoadedState({
    required this.toDoCollection,
  });

  final List<ToDoCollection> toDoCollection;

  @override
  List<Object> get props => [toDoCollection];
}