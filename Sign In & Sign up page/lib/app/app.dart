import 'package:flutter/material.dart';

import '../core/constants/app_strings.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class LuxeGroceryApp extends StatelessWidget {
  const LuxeGroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.initial,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
