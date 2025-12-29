import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 400,
        height: 90,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(-3, 7),
              blurRadius: 1,
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.button,
        ),
      ),
    );
  }
}

