import '../../domain/entities/quiz_result.dart';

class QuizResultModel extends QuizResult {
  const QuizResultModel({
    required super.score,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.incorrectAnswers,
    required super.totalTimeInSeconds,
    required super.date,
  });

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      score: json['score'] as int,
      totalQuestions: json['totalQuestions'] as int,
      correctAnswers: json['correctAnswers'] as int,
      incorrectAnswers: json['incorrectAnswers'] as int,
      totalTimeInSeconds: json['totalTimeInSeconds'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'totalTimeInSeconds': totalTimeInSeconds,
      'date': date.toIso8601String(),
    };
  }

  factory QuizResultModel.fromEntity(QuizResult entity) {
    return QuizResultModel(
      score: entity.score,
      totalQuestions: entity.totalQuestions,
      correctAnswers: entity.correctAnswers,
      incorrectAnswers: entity.incorrectAnswers,
      totalTimeInSeconds: entity.totalTimeInSeconds,
      date: entity.date,
    );
  }
}
