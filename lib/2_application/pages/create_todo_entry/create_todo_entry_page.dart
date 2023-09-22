import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/form_value.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/cubit/create_to_do_entry_page_cubit.dart';

class CreateToDoEntryPageProvider extends StatelessWidget {
  const CreateToDoEntryPageProvider({
    required this.collectionId,
    required this.onEntryCreatedCallback,
    super.key,
  });

  final CollectionId collectionId;
  final Function onEntryCreatedCallback;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoEntryPageCubit>(
      create: (context) => CreateToDoEntryPageCubit(
        collectionId: collectionId,
        createToDoEntry: CreateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child:
          CreateToDoEntryPage(onEntryCreatedCallback: onEntryCreatedCallback),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  const CreateToDoEntryPage({
    required this.onEntryCreatedCallback,
    super.key,
  });

  static const pageConfig = PageConfig(
//    icon: Icons.note_add_rounded,
    icon: Icons.add_rounded,
    name: 'create_todo_entry',
    child: Placeholder(),
  );

  final Function onEntryCreatedCallback;

  @override
  State<CreateToDoEntryPage> createState() => _CreateToDoEntryPageState();
}

class _CreateToDoEntryPageState extends State<CreateToDoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) => context
                  .read<CreateToDoEntryPageCubit>()
                  .descriptionChanged(description: value),
              validator: (value) {
                final currentValidationStatus = context
                        .read<CreateToDoEntryPageCubit>()
                        .state
                        .description
                        ?.validationStatus ??
                    ValidationStatus.notValidated;
                switch (currentValidationStatus) {
                  case ValidationStatus.valid:
                    return null;
                  case ValidationStatus.invalid:
                    return 'Please specify a description for the task!';
                  case ValidationStatus.notValidated:
                    return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              key: const Key('save_button'),
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == true) {
                  context.read<CreateToDoEntryPageCubit>().submit();
                  widget.onEntryCreatedCallback();
                  context.pop();
                }
              },
              child: const Text('Save Entry'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateToDoEntryPageExtra {
  const CreateToDoEntryPageExtra({
    required this.collectionId,
    required this.toDoEntryItemAddedCallback,
  });

  final CollectionId collectionId;
  final Function toDoEntryItemAddedCallback;
}
