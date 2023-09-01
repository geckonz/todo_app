import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/cubit/create_to_do_entry_page_cubit.dart';

class CreateToDoEntryPageProvider extends StatelessWidget {
  const CreateToDoEntryPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoEntryPageCubit>(
      create: (context) => CreateToDoEntryPageCubit(
        createToDoEntry: CreateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: const CreateToDoEntryPage(),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  const CreateToDoEntryPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.note_add_rounded,
    name: 'create_todo_entry',
    child: CreateToDoEntryPageProvider(),
  );

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
                  .descriptionChanged(value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please specify a description for the task!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();
                if (isValid == true) {
                  context.read<CreateToDoEntryPageCubit>().submit();
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
