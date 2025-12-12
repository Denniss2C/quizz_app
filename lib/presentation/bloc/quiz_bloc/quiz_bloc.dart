import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/quiz_result.dart';
import '../../../domain/usecases/check_answer.dart';
import '../../../domain/usecases/get_questions.dart';
import '../../../domain/usecases/save_quiz_result.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuestions getQuestions;
  final CheckAnswer checkAnswer;
  final SaveQuizResult saveQuizResult;

  QuizBloc({
    required this.getQuestions,
    required this.checkAnswer,
    required this.saveQuizResult,
  }) : super(QuizInitial()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
    on<AnswerSelectedEvent>(_onAnswerSelected);
    on<NextQuestionEvent>(_onNextQuestion);
    on<TimeUpEvent>(_onTimeUp);
    on<FinishQuizEvent>(_onFinishQuiz);
  }

  Future<void> _onLoadQuestions(
    LoadQuestionsEvent event,
    Emitter<QuizState> emit,
  ) async {
    emit(QuizLoading());

    final result = await getQuestions();

    result.fold((failure) => emit(QuizError(failure.message)), (questions) {
      if (questions.isEmpty) {
        emit(const QuizError('No hay preguntas disponibles'));
      } else {
        emit(QuizLoaded(questions: questions, currentQuestionIndex: 0));
      }
    });
  }

  void _onAnswerSelected(AnswerSelectedEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;

      if (currentState.isAnswered) return;

      final isCorrect = checkAnswer(
        currentState.currentQuestion,
        event.selectedAnswer,
      );

      emit(
        currentState.copyWith(
          selectedAnswer: event.selectedAnswer,
          isAnswered: true,
          correctAnswers: isCorrect
              ? currentState.correctAnswers + 1
              : currentState.correctAnswers,
          incorrectAnswers: !isCorrect
              ? currentState.incorrectAnswers + 1
              : currentState.incorrectAnswers,
        ),
      );
    }
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;

      if (!currentState.isAnswered) return;

      if (currentState.isLastQuestion) {
        return;
      }

      emit(
        currentState.copyWith(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
          selectedAnswer: null,
          isAnswered: false,
        ),
      );
    }
  }

  void _onTimeUp(TimeUpEvent event, Emitter<QuizState> emit) {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;

      if (currentState.isAnswered) return;

      emit(
        currentState.copyWith(
          isAnswered: true,
          incorrectAnswers: currentState.incorrectAnswers + 1,
        ),
      );
    }
  }

  Future<void> _onFinishQuiz(
    FinishQuizEvent event,
    Emitter<QuizState> emit,
  ) async {
    if (state is QuizLoaded) {
      final currentState = state as QuizLoaded;

      final result = QuizResult(
        score: currentState.score,
        totalQuestions: currentState.totalQuestions,
        correctAnswers: currentState.correctAnswers,
        incorrectAnswers: currentState.incorrectAnswers,
        totalTimeInSeconds: event.totalTimeInSeconds,
        date: DateTime.now(),
      );

      await saveQuizResult(result);

      emit(
        QuizFinished(
          score: currentState.score,
          totalQuestions: currentState.totalQuestions,
          correctAnswers: currentState.correctAnswers,
          incorrectAnswers: currentState.incorrectAnswers,
          totalTimeInSeconds: event.totalTimeInSeconds,
        ),
      );
    }
  }
}
