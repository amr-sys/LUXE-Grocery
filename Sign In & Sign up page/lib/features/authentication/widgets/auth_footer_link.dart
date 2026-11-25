import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';

/// "Don't have an account? Create Account" style footer.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({super.key, required this.prompt, required this.action, required this.onTap});
  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: GoogleFonts.inter(fontSize: 14, color: AppColors.mutedGray)),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.forestGreen,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            minimumSize: const Size(48, 40),
          ),
          child: Text(action,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
