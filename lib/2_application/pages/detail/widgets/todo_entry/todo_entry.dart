import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/2_application/pages/detail/widgets/todo_entry/cubit/to_do_entry_cubit.dart';
import 'package:todo_app/2_application/pages/detail/widgets/todo_entry/view_states/todo_entry_error.dart';
import 'package:todo_app/2_application/pages/detail/widgets/todo_entry/view_states/todo_entry_loaded.dart';
import 'package:todo_app/2_application/pages/detail/widgets/todo_entry/view_states/todo_entry_loading.dart';

class ToDoEntryProvider extends StatelessWidget {
  const ToDoEntryProvider({
    required this.collectionId,
    required this.entryId,
    super.key,
  });

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoEntryCubit>(
        create: (context) => ToDoEntryCubit(
              collectionId: collectionId,
              entryId: entryId,
              loadToDoEntry: LoadToDoEntry(
                toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
              ),
            )..fetch(),
        child: ToDoEntryWidget(
          collectionId: collectionId,
          entryId: entryId,
        ));
  }
}

class ToDoEntryWidget extends StatelessWidget {
  const ToDoEntryWidget({
    required this.collectionId,
    required this.entryId,
    super.key,
  });

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoEntryCubit, ToDoEntryState>(
        builder: (context, state) {
      if (state is ToDoEntryLoadingState) {
        return const ToDoEntryLoading();
      } else if (state is ToDoEntryLoadedState) {
        return ToDoEntryLoaded(
          toDoEntry: state.toDoEntry,
        );
      } else {
        return const ToDoEntryError();
      }
    });
  }
}
