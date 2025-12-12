import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import 'widgets/score_card.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int totalTime;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = (correctAnswers / totalQuestions) * 100;
    final incorrectAnswers = totalQuestions - correctAnswers;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppDimensions.paddingXL),
              _buildHeader(accuracy),
              const SizedBox(height: AppDimensions.paddingXXL),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScoreCard(score: score, accuracy: accuracy),
                      const SizedBox(height: AppDimensions.paddingL),
                      _buildStatsGrid(correctAnswers, incorrectAnswers),
                      const SizedBox(height: AppDimensions.paddingL),
                      _buildTimeCard(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimensions.paddingL),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double accuracy) {
    String message;
    IconData icon;
    Color color;

    if (accuracy >= 80) {
      message = AppStrings.excellentWork;
      icon = Icons.emoji_events;
      color = AppColors.success;
    } else if (accuracy >= 60) {
      message = AppStrings.goodJob;
      icon = Icons.thumb_up;
      color = AppColors.warning;
    } else {
      message = AppStrings.keepPracticing;
      icon = Icons.school;
      color = AppColors.error;
    }

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: AppDimensions.iconXXL, color: color),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        Text(
          message,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStatsGrid(int correct, int incorrect) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            AppStrings.correctAnswers,
            correct.toString(),
            AppColors.success,
            Icons.check_circle,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: _buildStatCard(
            AppStrings.incorrectAnswers,
            incorrect.toString(),
            AppColors.error,
            Icons.cancel,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          children: [
            Icon(icon, size: AppDimensions.iconL, color: color),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeCard() {
    final minutes = totalTime ~/ 60;
    final seconds = totalTime % 60;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time, size: AppDimensions.iconL),
            const SizedBox(width: AppDimensions.paddingM),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.totalTime,
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '${minutes}m ${seconds}s',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.quiz,
              (route) => false,
            );
          },
          icon: const Icon(Icons.refresh),
          label: const Text(AppStrings.playAgain),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingL,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        OutlinedButton.icon(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
          icon: const Icon(Icons.home),
          label: const Text(AppStrings.backToHome),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingL,
            ),
          ),
        ),
      ],
    );
  }
}
