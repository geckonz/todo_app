import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exceptions.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';

class MemoryToDoLocalDataSource implements ToDoLocalDataSourceInterface {
  final List<ToDoCollectionModel> _collections = [];
  final Map<String, List<ToDoEntryModel>> _entries = {};

  @override
  Future<bool> createToDoCollection({required ToDoCollectionModel collection}) {
    try {
      _collections.add(collection);
      _entries.putIfAbsent(collection.id, () => []);
      return Future.value(true);
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createToDoEntry(
      {required String collectionId, required ToDoEntryModel entry}) {
    try {
      final doesCollectionExist = _entries.containsKey(collectionId);
      if (doesCollectionExist) {
        _entries[collectionId]!.add(entry);
      } else {
        throw CollectionNotFoundException();
      }
      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) {
    try {
      final collectionModel = _collections.firstWhere(
        (collection) => collection.id == collectionId,
        orElse: () => throw CollectionNotFoundException(),
      );
      return Future.value(collectionModel);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoCollectionIds() {
    try {
      final collectionIds = _collections.map((collection) => collection.id);
      return Future.value(collectionIds.toList());
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoEntrieIds({required String collectionId}) {
    try {
      if (_entries.containsKey(collectionId)) {
        return Future.value(
          _entries[collectionId]!.map((entry) => entry.id).toList(),
        );
      } else {
        throw EntryNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (_entries.containsKey(collectionId)) {
        final entryModel = _entries[collectionId]!.firstWhere(
          (entry) => entry.id == entryId,
          orElse: () => throw EntryNotFoundException(),
        );
        return Future.value(entryModel);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (_entries.containsKey(collectionId)) {
        final entryModel = _entries[collectionId]!.firstWhere(
          (entry) => entry.id == entryId,
          orElse: () => throw EntryNotFoundException(),
        );
        final updatedEntryModel = ToDoEntryModel(
          id: entryModel.id,
          description: entryModel.description,
          isDone: !entryModel.isDone,
        );
        _entries[collectionId]!.remove(entryModel);
        _entries[collectionId]!.add(updatedEntryModel);
        return Future.value(updatedEntryModel);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
