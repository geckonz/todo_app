import 'package:either_dart/either.dart';

import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';

import 'package:todo_app/1_domain/failures/failure.dart';

import '../../1_domain/repositories/todo_repository.dart';

class ToDoRepositoryMock implements ToDoRepository {
  late List<ToDoCollection> toDoCollection;
  late List<ToDoEntry> toDoEntries;
  final toDoStore = <CollectionId, List<EntryId>>{};

  ToDoRepositoryMock() {
    toDoCollection = List<ToDoCollection>.generate(
      10,
      (index) => ToDoCollection(
        id: CollectionId.fromUniqueString(index.toString()),
        title: 'title $index',
        color: ToDoColor(colorIndex: index % ToDoColor.predefinedColors.length),
      ),
    );

    toDoEntries = List<ToDoEntry>.generate(
      100,
      (index) => ToDoEntry(
        description: 'description $index',
        isDone: index % 2 == 0,
        id: EntryId.fromUniqueString(index.toString()),
      ),
    );

    for (var i = 0; i < toDoCollection.length; i++) {
      final startIndex = i * 10;
      int endIndex = startIndex + 9;
      final entryIds =
          toDoEntries.sublist(startIndex, endIndex).map((e) => e.id).toList();
      toDoStore[toDoCollection[i].id] = entryIds;
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() {
    try {
      return Future.delayed(
          const Duration(milliseconds: 200), () => Right(toDoCollection));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) {
    try {
      final entry = toDoEntries.firstWhere((e) => e.id == entryId);
      return Future.delayed(
          const Duration(milliseconds: 200), () => Right(entry));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) {
    try {
      final entryIds = toDoStore[collectionId] ?? const <EntryId>[];
      return Future.delayed(
        const Duration(milliseconds: 300),
        () => Right(entryIds),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      {required CollectionId collectionId, required EntryId entryId}) {
    final index = toDoEntries.indexWhere((element) => element.id == entryId);
    final entryToUpdate = toDoEntries[index];
    final updatedEntry =
        toDoEntries[index].copyWith(isDone: !entryToUpdate.isDone);
    toDoEntries[index] = updatedEntry;

    return Future.delayed(
        const Duration(milliseconds: 100), () => Right(updatedEntry));
  }

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) {
    toDoCollection.add(collection);
    toDoStore[collection.id] = <EntryId>[];

    return Future.delayed(
        const Duration(milliseconds: 100), () => const Right(true));
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
    CollectionId collectionId,
    ToDoEntry entry,
  ) {
    toDoEntries.add(entry);
    toDoStore[collectionId]!.add(entry.id);

    return Future.delayed(
        const Duration(milliseconds: 250), () => const Right(true));
  }
}
