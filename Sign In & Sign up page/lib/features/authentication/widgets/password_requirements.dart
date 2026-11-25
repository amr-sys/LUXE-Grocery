import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';
import '../../../core/validators/validators.dart';

/// Live checklist of password rules.
class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({super.key, required this.password});
  final String password;

  @override
  Widget build(BuildContext context) {
    final rules = <(String, bool)>[
      ('At least 8 characters', Validators.hasMinLength(password)),
      ('One uppercase letter', Validators.hasUppercase(password)),
      ('One lowercase letter', Validators.hasLowercase(password)),
      ('One number', Validators.hasNumber(password)),
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightSage,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (label, ok) in rules)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      ok ? Icons.check_circle : Icons.radio_button_unchecked,
                      key: ValueKey(ok),
                      size: 16,
                      color: ok ? AppColors.success : AppColors.mutedGray,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(label,
                        style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: ok ? AppColors.success : AppColors.mutedGray)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
