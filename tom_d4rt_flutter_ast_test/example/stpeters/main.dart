import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: "St. Peter's Plan",
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFFB08D57),
      scaffoldBackgroundColor: const Color(0xFFF4ECD8),
    ),
    home: const PlanHome(),
  );
}
