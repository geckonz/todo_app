import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({
    super.key,
    required this.toDoCollection,
  });

  final List<ToDoCollection> toDoCollection;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        itemCount: toDoCollection.length,
        itemBuilder: (context, index) {
          final item = toDoCollection[index];
          final colorScheme = Theme.of(context).colorScheme;
          return BlocBuilder<NavigationToDoCubit, NavigationToDoCubitState>(
            buildWhen: (previous, current) =>
                previous.selectedCollectionId != current.selectedCollectionId,
            builder: (context, state) {
              return ListTile(
                tileColor: colorScheme.surface,
                selectedTileColor: colorScheme.surfaceVariant,
                iconColor: item.color.color,
                selectedColor: item.color.color,
                selected: state.selectedCollectionId == item.id,
                onTap: () {
                  context
                      .read<NavigationToDoCubit>()
                      .selectedToDoCollectionChanged(collectionId: item.id);

                  if (Breakpoints.small.isActive(context)) {
                    context.pushNamed(
                      ToDoDetailPage.pageConfig.name,
                      pathParameters: {'collectionId': item.id.value},
                    );
                  }
                },
                leading: const Icon(Icons.circle),
                title: Text(item.title),
              );
            },
          );
        },
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            key: const Key('create_todo_collection_button'),
            heroTag: CreateToDoCollectionPage.pageConfig.name,
            onPressed: () =>
                context.pushNamed(CreateToDoCollectionPage.pageConfig.name),
            child: Icon(CreateToDoCollectionPage.pageConfig.icon),
          ),
        ),
      ),
    ]);
  }
}
