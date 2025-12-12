import 'package:equatable/equatable.dart';

import '../../../domain/entities/question.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int? selectedAnswer;
  final bool isAnswered;
  final int correctAnswers;
  final int incorrectAnswers;

  const QuizLoaded({
    required this.questions,
    required this.currentQuestionIndex,
    this.selectedAnswer,
    this.isAnswered = false,
    this.correctAnswers = 0,
    this.incorrectAnswers = 0,
  });

  Question get currentQuestion => questions[currentQuestionIndex];
  int get totalQuestions => questions.length;
  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;
  int get score => correctAnswers * 10;

  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentQuestionIndex,
    int? selectedAnswer,
    bool? isAnswered,
    int? correctAnswers,
    int? incorrectAnswers,
  }) {
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswer: selectedAnswer,
      isAnswered: isAnswered ?? this.isAnswered,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      incorrectAnswers: incorrectAnswers ?? this.incorrectAnswers,
    );
  }

  @override
  List<Object?> get props => [
    questions,
    currentQuestionIndex,
    selectedAnswer,
    isAnswered,
    correctAnswers,
    incorrectAnswers,
  ];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object?> get props => [message];
}

class QuizFinished extends QuizState {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int totalTimeInSeconds;

  const QuizFinished({
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.totalTimeInSeconds,
  });

  @override
  List<Object?> get props => [
    score,
    totalQuestions,
    correctAnswers,
    incorrectAnswers,
    totalTimeInSeconds,
  ];
}
