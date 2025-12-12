import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuestionsEvent extends QuizEvent {}

class AnswerSelectedEvent extends QuizEvent {
  final int selectedAnswer;

  const AnswerSelectedEvent(this.selectedAnswer);

  @override
  List<Object?> get props => [selectedAnswer];
}

class NextQuestionEvent extends QuizEvent {}

class TimeUpEvent extends QuizEvent {}

class FinishQuizEvent extends QuizEvent {
  final int totalTimeInSeconds;

  const FinishQuizEvent(this.totalTimeInSeconds);

  @override
  List<Object?> get props => [totalTimeInSeconds];
}
