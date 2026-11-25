import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';

/// LUXE GROCERY logo: a shopping bag with a leaf, plus the wordmark.
class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.iconSize = 64, this.showWordmark = true});
  final double iconSize;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'LUXE GROCERY logo',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: iconSize,
            child: CustomPaint(painter: _LeafBagPainter()),
          ),
          if (showWordmark) ...[
            const SizedBox(height: 10),
            Text('LUXE',
                style: GoogleFonts.poppins(
                    fontSize: iconSize * 0.42,
                    height: 1,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 6,
                    color: AppColors.forestGreen)),
            const SizedBox(height: 6),
            Text('GROCERY',
                style: GoogleFonts.poppins(
                    fontSize: iconSize * 0.16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 5,
                    color: AppColors.softGold)),
          ],
        ],
      ),
    );
  }
}

class _LeafBagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final green = Paint()..color = AppColors.forestGreen;
    final stroke = Paint()
      ..color = AppColors.forestGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.06
      ..strokeCap = StrokeCap.round;

    // Bag handle
    final handle = Path()
      ..moveTo(w * 0.36, h * 0.40)
      ..lineTo(w * 0.36, h * 0.30)
      ..arcToPoint(Offset(w * 0.64, h * 0.30), radius: Radius.circular(w * 0.14))
      ..lineTo(w * 0.64, h * 0.40);
    canvas.drawPath(handle, stroke);

    // Bag body (slightly tapered, rounded bottom)
    final body = Path()
      ..moveTo(w * 0.20, h * 0.38)
      ..lineTo(w * 0.80, h * 0.38)
      ..lineTo(w * 0.86, h * 0.86)
      ..quadraticBezierTo(w * 0.87, h * 0.95, w * 0.78, h * 0.95)
      ..lineTo(w * 0.22, h * 0.95)
      ..quadraticBezierTo(w * 0.13, h * 0.95, w * 0.14, h * 0.86)
      ..close();
    canvas.drawPath(body, green);

    // Leaf on the bag
    final leaf = Path()
      ..moveTo(w * 0.36, h * 0.84)
      ..quadraticBezierTo(w * 0.34, h * 0.52, w * 0.66, h * 0.50)
      ..quadraticBezierTo(w * 0.68, h * 0.80, w * 0.36, h * 0.84)
      ..close();
    canvas.drawPath(leaf, Paint()..color = AppColors.sageGreen);

    // Leaf vein
    final vein = Paint()
      ..color = AppColors.forestGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.025
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.38, h * 0.82), Offset(w * 0.62, h * 0.55), vein);

    // Gold accent dot
    canvas.drawCircle(Offset(w * 0.74, h * 0.46), w * 0.035,
        Paint()..color = AppColors.softGold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
