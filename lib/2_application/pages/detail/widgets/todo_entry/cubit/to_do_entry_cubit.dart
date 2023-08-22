import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part 'to_do_entry_state.dart';

class ToDoEntryCubit extends Cubit<ToDoEntryState> {
  ToDoEntryCubit({
    required this.collectionId,
    required this.entryId,
    required this.loadToDoEntry,
    required this.updateToDoEntry,
  }) : super(const ToDoEntryLoadingState());

  final CollectionId collectionId;
  final EntryId entryId;

  final LoadToDoEntry loadToDoEntry;
  final UpdateToDoEntry updateToDoEntry;

  Future<void> fetch() async {
    emit(const ToDoEntryLoadingState());

    try {
      final entry = await loadToDoEntry.call(
          ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId));

      if (entry.isLeft) {
        emit(const ToDoEntryErrorState());
      } else {
        emit(ToDoEntryLoadedState(toDoEntry: entry.right));
      }
    } on Exception {
      emit(const ToDoEntryErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await updateToDoEntry(
          ToDoEntryIdsParam(collectionId: collectionId, entryId: entryId));

      if (updatedEntry.isLeft) {
        emit(const ToDoEntryErrorState());
      } else {
        emit(ToDoEntryLoadedState(toDoEntry: updatedEntry.right));
      }
    } on Exception {
      emit(const ToDoEntryErrorState());
    }
  }
}
