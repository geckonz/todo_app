import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_todo_collection_page_state.dart';

class CreateToDoCollectionPageCubit
    extends Cubit<CreateToDoCollectionPageState> {
  final CreateToDoCollection createToDoCollection;

  CreateToDoCollectionPageCubit({required this.createToDoCollection})
      : super(const CreateToDoCollectionPageState());

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void colorChanged(String colour) {
    emit(state.copyWith(colour: colour));
  }

  Future<void> submit() async {
    //TODO: this is marked async but there was no await - casued the failed refresh after save problem
    final parsedColourIndex = int.tryParse(state.colour ?? '') ?? 0;
    await createToDoCollection(ToDoCollectionParams(
      collection: ToDoCollection.empty().copyWith(
        title: state.title,
        color: ToDoColor(colorIndex: parsedColourIndex),
      ),
    ));
  }
}
