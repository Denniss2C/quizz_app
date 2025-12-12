import 'package:flutter/material.dart';

import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/quiz/quiz_screen.dart';
import '../../presentation/screens/result/result_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case AppRoutes.quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());

      case AppRoutes.result:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: args?['score'] ?? 0,
            totalQuestions: args?['totalQuestions'] ?? 0,
            correctAnswers: args?['correctAnswers'] ?? 0,
            totalTime: args?['totalTime'] ?? 0,
          ),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Página no encontrada')),
      ),
    );
  }
}
