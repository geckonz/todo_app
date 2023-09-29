import 'package:either_dart/either.dart';
import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exceptions.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';
import 'package:todo_app/1_domain/entities/todo_collection.dart';
import 'package:todo_app/1_domain/entities/todo_color.dart';
import 'package:todo_app/1_domain/entities/todo_entry.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';

class ToDoRepositoryLocal implements ToDoRepository {
  final ToDoLocalDataSourceInterface localDataSource;

  ToDoRepositoryLocal({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> createToDoCollection(
      ToDoCollection collection) async {
    try {
      final collectionModel = _toDoCollectionModelFromEntity(collection);
      final result = await localDataSource.createToDoCollection(
        collection: collectionModel,
      );
      return Future.value(Right(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, bool>> createToDoEntry(
      CollectionId collectionId, ToDoEntry entry) async {
    try {
      final entryModel = _toDoEntryModelFromEntity(entry);
      final result = await localDataSource.createToDoEntry(
        collectionId: collectionId.value,
        entry: entryModel,
      );
      return Future.value(Right(result));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections() async {
    try {
      final collectionIds = await localDataSource.getToDoCollectionIds();
      final collections = <ToDoCollection>[];
      for (final id in collectionIds) {
        final collectionModel =
            await localDataSource.getToDoCollection(collectionId: id);
        final collection = _toDoCollectionFromModel(collectionModel);
        collections.add(collection);
      }
      return Future.value(Right(collections));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> readToDoEntry(
      CollectionId collectionId, EntryId entryId) async {
    try {
      final entryModel = await localDataSource.getToDoEntry(
        collectionId: collectionId.value,
        entryId: entryId.value,
      );
      final entry = _toDoEntryFromModel(entryModel);
      return Future.value(Right(entry));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, List<EntryId>>> readToDoEntryIds(
      CollectionId collectionId) async {
    try {
      final entryIds = await localDataSource.getToDoEntrieIds(
        collectionId: collectionId.value,
      );
      final entryIdsUnique = entryIds.map((id) => EntryId.fromUniqueString(id));
      return Future.value(Right(entryIdsUnique.toList()));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  @override
  Future<Either<Failure, ToDoEntry>> updateToDoEntry(
      {required CollectionId collectionId, required EntryId entryId}) async {
    try {
      final entry = await localDataSource.updateToDoEntry(
        collectionId: collectionId.value,
        entryId: entryId.value,
      );
      final todoEntry = _toDoEntryFromModel(entry);
      return Future.value(Right(todoEntry));
    } on CacheException catch (e) {
      return Future.value(Left(CacheFailure(stackTrace: e.toString())));
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }

  ToDoCollectionModel _toDoCollectionModelFromEntity(
      ToDoCollection collection) {
    return ToDoCollectionModel(
      id: collection.id.value,
      title: collection.title,
      colourIndex: collection.color.colorIndex,
    );
  }

  ToDoCollection _toDoCollectionFromModel(ToDoCollectionModel model) {
    return ToDoCollection(
      id: CollectionId.fromUniqueString(model.id),
      title: model.title,
      color: ToDoColor(colorIndex: model.colourIndex),
    );
  }

  ToDoEntryModel _toDoEntryModelFromEntity(ToDoEntry entry) {
    return ToDoEntryModel(
      id: entry.id.value,
      description: entry.description,
      isDone: entry.isDone,
    );
  }

  ToDoEntry _toDoEntryFromModel(ToDoEntryModel model) {
    return ToDoEntry(
      id: EntryId.fromUniqueString(model.id),
      description: model.description,
      isDone: model.isDone,
    );
  }
}
