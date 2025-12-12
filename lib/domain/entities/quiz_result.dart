import 'package:equatable/equatable.dart';

class QuizResult extends Equatable {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int totalTimeInSeconds;
  final DateTime date;

  const QuizResult({
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.totalTimeInSeconds,
    required this.date,
  });

  double get accuracy =>
      totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;

  @override
  List<Object> get props => [
    score,
    totalQuestions,
    correctAnswers,
    incorrectAnswers,
    totalTimeInSeconds,
    date,
  ];
}
