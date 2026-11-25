import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key, this.text = 'OR'});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderGray)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(text,
              style: GoogleFonts.inter(
                  fontSize: 12,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mutedGray)),
        ),
        const Expanded(child: Divider(color: AppColors.borderGray)),
      ],
    );
  }
}
