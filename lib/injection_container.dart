import 'package:get_it/get_it.dart';
import 'package:quizz_app/data/datasources/local/quiz_local_datasource.dart';
import 'package:quizz_app/data/datasources/local/quiz_local_datasource_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/quiz_repository_impl.dart';
import 'domain/repositories/quiz_repository.dart';
import 'domain/usecases/check_answer.dart';
import 'domain/usecases/get_questions.dart';
import 'domain/usecases/get_quiz_history.dart';
import 'domain/usecases/save_quiz_result.dart';
import 'presentation/bloc/quiz_bloc/quiz_bloc.dart';
import 'presentation/bloc/ranking_bloc/ranking_bloc.dart';
import 'presentation/bloc/timer_bloc/timer_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(
    () => QuizBloc(getQuestions: sl(), checkAnswer: sl(), saveQuizResult: sl()),
  );

  sl.registerFactory(() => TimerBloc());

  sl.registerFactory(() => RankingBloc(getQuizHistory: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetQuestions(sl()));
  sl.registerLazySingleton(() => CheckAnswer());
  sl.registerLazySingleton(() => SaveQuizResult(sl()));
  sl.registerLazySingleton(() => GetQuizHistory(sl()));

  // Repository
  sl.registerLazySingleton<QuizRepository>(
    () => QuizRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<QuizLocalDataSource>(
    () => QuizLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
