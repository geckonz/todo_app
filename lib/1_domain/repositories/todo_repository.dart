import 'package:either_dart/either.dart';

import '../entities/todo_collection.dart';
import '../failures/failure.dart';

abstract class ToDoRepository {
  Future<Either<Failure, List<ToDoCollection>>> readToDoCollections();
}