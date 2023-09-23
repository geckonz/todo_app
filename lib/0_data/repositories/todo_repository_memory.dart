import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class ToDoRespositoryMemory implements ToDoRepository {
  final List<ToDoCollection> toDoCollection = [];
  final List<ToDoEntry> toDoEntries = [];
  final toDoStore = <CollectionId, List<EntryId>>{};

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) {
    try {
      toDoCollection.add(collection);
      toDoStore[collection.id] = <EntryId>[];
      return Future.delayed(
          const Duration(milliseconds: 100), () => const Right(true));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry entry) {
    try {
      toDoEntries.add(entry);
      toDoStore[collectionId]!.add(entry.id);
      return Future.delayed(
          const Duration(milliseconds: 100), () => const Right(true));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
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
}
