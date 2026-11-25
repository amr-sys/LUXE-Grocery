import 'package:flutter/material.dart';

import 'brand_logo.dart';

/// Logo + heading + subtitle shared by both auth pages.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      children: [
        const BrandLogo(iconSize: 60),
        const SizedBox(height: 24),
        Text(title, textAlign: TextAlign.center, style: t.headlineMedium),
        const SizedBox(height: 8),
        Text(subtitle, textAlign: TextAlign.center, style: t.bodyMedium),
      ],
    );
  }
}
