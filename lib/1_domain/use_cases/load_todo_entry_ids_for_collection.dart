import 'package:either_dart/either.dart';
import 'package:todo_app/1_domain/entities/unique_id.dart';
import 'package:todo_app/1_domain/failures/failure.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class LoadToDoEntryIdsForCollection
    implements UseCase<List<EntryId>, CollectionIdParam> {
  final ToDoRepository toDoRepository;

  const LoadToDoEntryIdsForCollection(this.toDoRepository);

  @override
  Future<Either<Failure, List<EntryId>>> call(CollectionIdParam params) async {
    try {
      final loadedIds = toDoRepository.readToDoEntryIds(
        params.collectionId,
      );

      return loadedIds.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Future.value(Left(ServerFailure(stackTrace: e.toString())));
    }
  }
}
