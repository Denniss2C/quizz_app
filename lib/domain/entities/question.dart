import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswer;

  const Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  @override
  List<Object> get props => [id, question, options, correctAnswer];
}
