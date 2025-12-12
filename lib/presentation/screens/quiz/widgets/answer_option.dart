import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrect;
  final bool isWrong;
  final bool isDisabled;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.isDisabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? borderColor;
    Widget? icon;

    if (isCorrect) {
      backgroundColor = AppColors.success.withOpacity(0.1);
      borderColor = AppColors.success;
      icon = const Icon(Icons.check_circle, color: AppColors.success);
    } else if (isWrong) {
      backgroundColor = AppColors.error.withOpacity(0.1);
      borderColor = AppColors.error;
      icon = const Icon(Icons.cancel, color: AppColors.error);
    } else if (isSelected) {
      backgroundColor = AppColors.primary.withOpacity(0.1);
      borderColor = AppColors.primary;
    }

    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected || isCorrect || isWrong
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
            if (icon != null) icon,
          ],
        ),
      ),
    );
  }
}
