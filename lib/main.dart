import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const ResideApp());
}

class ResideApp extends StatelessWidget {
  const ResideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reside',
      theme: AppTheme.light,
      home: const DashboardScreen(),
    );
  }
}