import 'package:flutter/material.dart';

import '../../../app/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

/// Full-width Forest Green button with loading and disabled states.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, this.onPressed, this.isLoading = false});
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.forestGreen,
          foregroundColor: AppColors.pureWhite,
          disabledBackgroundColor: AppColors.forestGreen.withValues(alpha: 0.35),
          disabledForegroundColor: AppColors.pureWhite,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.buttonRadius)),
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? const SizedBox.square(
                  key: ValueKey('loading'),
                  dimension: 22,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.4, color: AppColors.pureWhite),
                )
              : Text(label, key: const ValueKey('label')),
        ),
      ),
    );
  }
}
