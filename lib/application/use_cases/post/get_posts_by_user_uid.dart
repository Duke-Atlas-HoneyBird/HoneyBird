import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/post.dart';
import '../../../domain/repositories/post_repository.dart';

class GetPostsByUserUID {
  final PostRepository repository;

  GetPostsByUserUID(this.repository);

  Future<Either<Failure, List<Post>>> call(String userUID) {
    return repository.getPostsByUserUID(userUID);
  }
}
