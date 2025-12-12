import '../entities/question.dart';

class CheckAnswer {
  bool call(Question question, int selectedAnswer) {
    return question.correctAnswer == selectedAnswer;
  }
}
