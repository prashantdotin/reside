import 'package:flutter/material.dart';

class AppColors {
  static const background = Color(0xFFF8F8F8);
  static const card = Colors.white;
  static const text = Color(0xFF242424);
  static const secondaryText = Color(0xFF777777);
  static const border = Color(0xFFE2E2E2);
  static const yellow = Color(0xFFF4C642);
  static const red = Color(0xFFFF1E1E);
  static const green = Color(0xFF4C8A32);
  static const blue = Color(0xFF183BFF);
}

class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
}

class DurationOption {
  static const today = 'Today';
  static const week = 'Week';
  static const month = 'Month';
  static const quarter = 'Quarter';
  static const annual = 'Annual';
  static const tillDate = 'Till Date';
  static const dateRange = 'Date Range';

  static const all = <String>[
    today,
    week,
    month,
    quarter,
    annual,
    tillDate,
    dateRange,
  ];
}
