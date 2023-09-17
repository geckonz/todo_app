import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/form_value.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_to_do_entry_page_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateToDoEntryPageState> {
  final CollectionId collectionId;
  final CreateToDoEntry createToDoEntry;

  CreateToDoEntryPageCubit({
    required this.createToDoEntry,
    required this.collectionId,
  }) : super(const CreateToDoEntryPageState());

  void descriptionChanged({String? description}) {
    ValidationStatus validationStatus = ValidationStatus.notValidated;
    // Here we could do more complex validation like calling backend etc.
    if (description == null || description.isEmpty || description.length < 2) {
      validationStatus = ValidationStatus.invalid;
    } else {
      validationStatus = ValidationStatus.valid;
    }
    emit(state.copyWith(
        description:
            FormValue(value: description, validationStatus: validationStatus)));
  }

  Future<void> submit() async {
    await createToDoEntry(ToDoEntryParams(
      entry: ToDoEntry.empty().copyWith(
        description: state.description?.value,
      ),
      collectionId: collectionId,
    ));
  }
}
