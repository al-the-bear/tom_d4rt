import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Solitaire',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF1B5E20),
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFF0F6B2C),
    ),
    home: const SolitaireHome(),
  );
}
