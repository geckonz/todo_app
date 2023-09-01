import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_to_do_entry_page_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateToDoEntryPageState> {
  final CreateToDoEntry createToDoEntry;

  CreateToDoEntryPageCubit({required this.createToDoEntry})
      : super(const CreateToDoEntryPageState());

  void descriptionChanged(String description) {
    emit(state.copyWith(description: description));
  }

  Future<void> submit() async {
    await createToDoEntry(ToDoEntryParams(
      entry: ToDoEntry.empty().copyWith(
        description: state.description,
      ),
    ));
  }
}
