import 'package:hive/hive.dart';
import 'package:todo_app/0_data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/0_data/exceptions/exceptions.dart';
import 'package:todo_app/0_data/models/todo_collection_model.dart';
import 'package:todo_app/0_data/models/todo_entry_model.dart';

class HiveLocalDataSource implements ToDoLocalDataSourceInterface {
  late BoxCollection _todoCollections;
  bool isInitialized = false;

  Future<void> init() async {
    if (!isInitialized) {
      _todoCollections = await BoxCollection.open(
        'todo',
        {
          'collection',
          'entry',
        },
        path: './data/',
      );
      isInitialized = true;
    } else {
      throw Exception('HiveLocalDataSource already initialized');
    }
  }

  Future<CollectionBox<Map>> _openCollectionBox() async {
    return _todoCollections.openBox<Map>('collection');
  }

  Future<CollectionBox<Map>> _openEntryBox() async {
    return _todoCollections.openBox<Map>('entry');
  }

  @override
  Future<bool> createToDoCollection(
      {required ToDoCollectionModel collection}) async {
    try {
      final collectionBox = await _openCollectionBox();
      final entryBox = await _openEntryBox();

      await collectionBox.put(collection.id, collection.toJson());
      await entryBox.put(collection.id, {});

      return Future.value(true);
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }

  @override
  Future<bool> createToDoEntry(
      {required String collectionId, required ToDoEntryModel entry}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) {
        throw CollectionNotFoundException();
      }

      await entryList
          .cast<String, dynamic>()
          .putIfAbsent(entry.id, () => entry.toJson());

      await entryBox.put(collectionId, entryList);

      return Future.value(true);
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) async {
    try {
      final collectionBox = await _openCollectionBox();
      final collection = await collectionBox.get(collectionId);

      if (collection == null) {
        throw CollectionNotFoundException();
      }

      return Future.value(
        ToDoCollectionModel.fromJson((collection).cast<String, dynamic>()),
      );
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }

  @override
  Future<List<String>> getToDoCollectionIds() async {
    try {
      final collectionBox = await _openCollectionBox();
      final collectionIds = await collectionBox.getAllKeys();

      return Future.value(collectionIds);
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }

  @override
  Future<List<String>> getToDoEntrieIds({required String collectionId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);

      if (entryList == null) throw CollectionNotFoundException();

      final entryIdList = entryList.cast<String, dynamic>().keys.toList();

      return Future.value(entryIdList);
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) throw CollectionNotFoundException();
      if (!entryList.containsKey(entryId)) throw EntryNotFoundException();

      final entry = entryList[entryId].cast<String, dynamic>();

      return Future.value(ToDoEntryModel.fromJson(entry));
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) async {
    try {
      final entryBox = await _openEntryBox();
      final entryList = await entryBox.get(collectionId);
      if (entryList == null) throw CollectionNotFoundException();
      if (!entryList.containsKey(entryId)) throw EntryNotFoundException();

      final entry =
          ToDoEntryModel.fromJson(entryList[entryId].cast<String, dynamic>());

      final updatedEntry = ToDoEntryModel(
        id: entry.id,
        description: entry.description,
        isDone: !entry.isDone,
      );

      entryList[entryId] = updatedEntry.toJson();

      await entryBox.put(collectionId, entryList);

      return Future.value(updatedEntry);
    } on Exception catch (_) {
      throw CollectionBoxException();
    }
  }
}
