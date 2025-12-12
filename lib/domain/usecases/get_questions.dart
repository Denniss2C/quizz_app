import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/question.dart';
import '../repositories/quiz_repository.dart';

class GetQuestions {
  final QuizRepository repository;

  GetQuestions(this.repository);

  Future<Either<Failure, List<Question>>> call() async {
    return await repository.getQuestions();
  }
}
