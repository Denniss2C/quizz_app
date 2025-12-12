import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../domain/entities/quiz_result.dart';

class RankingCard extends StatelessWidget {
  final QuizResult result;
  final int index;

  const RankingCard({super.key, required this.result, required this.index});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final minutes = result.totalTimeInSeconds ~/ 60;
    final seconds = result.totalTimeInSeconds % 60;

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.marginM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        child: Row(
          children: [
            _buildRank(),
            const SizedBox(width: AppDimensions.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Puntuación: ${result.score}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getAccuracyColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusS,
                          ),
                        ),
                        child: Text(
                          '${result.accuracy.toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: _getAccuracyColor(),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${result.correctAnswers}/${result.totalQuestions} correctas',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${minutes}m ${seconds}s',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      const SizedBox(width: AppDimensions.paddingM),
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(result.date),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRank() {
    Color color;
    IconData icon;

    if (index == 0) {
      color = const Color(0xFFFFD700); // Gold
      icon = Icons.emoji_events;
    } else if (index == 1) {
      color = const Color(0xFFC0C0C0); // Silver
      icon = Icons.emoji_events;
    } else if (index == 2) {
      color = const Color(0xFFCD7F32); // Bronze
      icon = Icons.emoji_events;
    } else {
      color = Colors.grey;
      icon = Icons.emoji_events_outlined;
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Center(
        child: Icon(icon, color: color, size: AppDimensions.iconL),
      ),
    );
  }

  Color _getAccuracyColor() {
    if (result.accuracy >= 80) {
      return AppColors.success;
    } else if (result.accuracy >= 60) {
      return AppColors.warning;
    } else {
      return AppColors.error;
    }
  }
}
