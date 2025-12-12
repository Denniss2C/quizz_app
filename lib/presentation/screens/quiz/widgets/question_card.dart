import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

class QuestionCard extends StatelessWidget {
  final String question;

  const QuestionCard({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Text(
          question,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
