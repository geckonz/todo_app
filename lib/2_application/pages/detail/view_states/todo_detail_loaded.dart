import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/2_application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/2_application/pages/detail/widgets/todo_entry/todo_entry.dart';

class ToDoDetailLoaded extends StatelessWidget {
  const ToDoDetailLoaded({
    super.key,
    required this.collectionId,
    required this.entryIds,
  });

  final List<EntryId> entryIds;
  final CollectionId collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 50,
            child: IconButton(
              onPressed: () {
                context.pushNamed(CreateToDoEntryPage.pageConfig.name);
              },
              icon: Icon(CreateToDoEntryPage.pageConfig.icon),
              tooltip: 'Add ToDo Entry',
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.onSecondary),
          Expanded(
            child: ListView.separated(
              itemCount: entryIds.length,
              itemBuilder: (context, index) => ToDoEntryProvider(
                collectionId: collectionId,
                entryId: entryIds[index],
              ),
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
