import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/create_todo_collection.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/cubit/create_todo_collection_page_cubit.dart';

typedef ToDoCollectionAddedCallback = void Function();

class CreateToDoCollectionPageProvider extends StatelessWidget {
  const CreateToDoCollectionPageProvider({
    required this.onCollectionCreatedCallback,
    super.key,});

  final ToDoCollectionAddedCallback onCollectionCreatedCallback;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoCollectionPageCubit>(
      create: (context) => CreateToDoCollectionPageCubit(
        createToDoCollection: CreateToDoCollection(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: CreateToDoCollectionPage(onCollectionCreatedCallback: onCollectionCreatedCallback,),
    );
  }
}

class CreateToDoCollectionPage extends StatefulWidget {
  const CreateToDoCollectionPage({
    required this.onCollectionCreatedCallback,
    super.key,
  });

  final ToDoCollectionAddedCallback onCollectionCreatedCallback;

  static const pageConfig = PageConfig(
    icon: Icons.add_task_rounded,
    name: 'create_todo_collection',
    child: Placeholder(),
  );

  @override
  State<CreateToDoCollectionPage> createState() =>
      _CreateToDoColelctionPageState();
}

class _CreateToDoColelctionPageState extends State<CreateToDoCollectionPage> {
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
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => context
                    .read<CreateToDoCollectionPageCubit>()
                    .titleChanged(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please specify a title!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Colour'),
                onChanged: (value) => context
                    .read<CreateToDoCollectionPageCubit>()
                    .colorChanged(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please specify a number between 0 and ${ToDoColor.predefinedColors.length - 1}.';
                  } else {
                    final parsedColourIndex = int.tryParse(value);
                    if (parsedColourIndex == null ||
                        parsedColourIndex < 0 ||
                        parsedColourIndex > ToDoColor.predefinedColors.length) {
                      return 'Only numbers between 0 and ${ToDoColor.predefinedColors.length - 1} are permitted.';
                    }
                  }
                  return null;
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
                    context.read<CreateToDoCollectionPageCubit>().submit();
                    widget.onCollectionCreatedCallback();
                    context.pop();
                  }
                },
                child: const Text('Save Collection'),
              ),
            ],
          )),
    );
  }
}
