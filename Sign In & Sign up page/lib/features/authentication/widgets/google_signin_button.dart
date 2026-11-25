import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';
import '../../../core/constants/app_spacing.dart';

/// Google-branded button (white, gray border, multicolor "G").
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key, required this.label, this.onPressed, this.isLoading = false});
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.pureWhite,
          foregroundColor: const Color(0xFF1F1F1F),
          overlayColor: AppColors.lightSage,
          side: const BorderSide(color: Color(0xFF747775)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.buttonRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.mutedGray))
                : const ExcludeSemantics(
                    child: SizedBox.square(
                        dimension: 18, child: CustomPaint(painter: _GoogleGPainter()))),
            const SizedBox(width: 10),
            Flexible(
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      fontSize: 14, height: 20 / 14, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Draws Google's official four-color "G" (from the 24x24 brand SVG).
class _GoogleGPainter extends CustomPainter {
  const _GoogleGPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24, size.height / 24);
    void fill(Path p, int c) => canvas.drawPath(p, Paint()..color = Color(c));

    fill(
        Path()
          ..moveTo(23.49, 12.27)
          ..cubicTo(23.49, 11.48, 23.42, 10.73, 23.30, 10.0)
          ..lineTo(12, 10)
          ..lineTo(12, 14.51)
          ..lineTo(18.47, 14.51)
          ..cubicTo(18.18, 15.99, 17.33, 17.24, 16.07, 18.09)
          ..lineTo(16.07, 21.09)
          ..lineTo(19.93, 21.09)
          ..cubicTo(22.19, 19.0, 23.49, 15.92, 23.49, 12.27)
          ..close(),
        0xFF4285F4);
    fill(
        Path()
          ..moveTo(12, 24)
          ..cubicTo(15.24, 24, 17.95, 22.92, 19.93, 21.09)
          ..lineTo(16.07, 18.09)
          ..cubicTo(14.99, 18.81, 13.62, 19.25, 12, 19.25)
          ..cubicTo(8.87, 19.25, 6.22, 17.14, 5.27, 14.29)
          ..lineTo(1.29, 14.29)
          ..lineTo(1.29, 17.38)
          ..cubicTo(3.26, 21.3, 7.31, 24, 12, 24)
          ..close(),
        0xFF34A853);
    fill(
        Path()
          ..moveTo(5.27, 14.29)
          ..cubicTo(5.02, 13.57, 4.89, 12.8, 4.89, 12)
          ..cubicTo(4.89, 11.2, 5.03, 10.43, 5.27, 9.71)
          ..lineTo(5.27, 6.62)
          ..lineTo(1.29, 6.62)
          ..cubicTo(0.47, 8.24, 0, 10.06, 0, 12)
          ..cubicTo(0, 13.94, 0.47, 15.76, 1.29, 17.38)
          ..close(),
        0xFFFBBC05);
    fill(
        Path()
          ..moveTo(12, 4.75)
          ..cubicTo(13.77, 4.75, 15.35, 5.36, 16.6, 6.55)
          ..lineTo(20.02, 3.13)
          ..cubicTo(17.95, 1.19, 15.24, 0, 12, 0)
          ..cubicTo(7.31, 0, 3.26, 2.7, 1.29, 6.62)
          ..lineTo(5.27, 9.71)
          ..cubicTo(6.22, 6.86, 8.87, 4.75, 12, 4.75)
          ..close(),
        0xFFEA4335);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
