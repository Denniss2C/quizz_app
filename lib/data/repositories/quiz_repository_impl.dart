import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/quiz_result.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../datasources/local/quiz_local_datasource.dart';
import '../models/quiz_result_model.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Question>>> getQuestions() async {
    try {
      final questions = await localDataSource.getQuestions();
      // Mezclar preguntas aleatoriamente
      questions.shuffle();
      return Right(questions);
    } on DataException catch (e) {
      return Left(DataFailure(e.message));
    } catch (e) {
      return Left(DataFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> saveQuizResult(QuizResult result) async {
    try {
      final resultModel = QuizResultModel.fromEntity(result);
      await localDataSource.saveQuizResult(resultModel);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<QuizResult>>> getQuizHistory() async {
    try {
      final history = await localDataSource.getQuizHistory();
      // Ordenar por fecha descendente (más reciente primero)
      history.sort((a, b) => b.date.compareTo(a.date));
      return Right(history);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
