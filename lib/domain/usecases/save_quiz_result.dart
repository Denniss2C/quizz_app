import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/quiz_result.dart';
import '../repositories/quiz_repository.dart';

class SaveQuizResult {
  final QuizRepository repository;

  SaveQuizResult(this.repository);

  Future<Either<Failure, void>> call(QuizResult result) async {
    return await repository.saveQuizResult(result);
  }
}
