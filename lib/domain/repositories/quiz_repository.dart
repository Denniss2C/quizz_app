import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/question.dart';
import '../entities/quiz_result.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<Question>>> getQuestions();
  Future<Either<Failure, void>> saveQuizResult(QuizResult result);
  Future<Either<Failure, List<QuizResult>>> getQuizHistory();
}
