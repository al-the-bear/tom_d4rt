import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: "St. Paul's Outside the Walls — Plan",
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF8B6F3F),
      brightness: Brightness.light,
    ),
    home: const PlanHome(),
  );
}
