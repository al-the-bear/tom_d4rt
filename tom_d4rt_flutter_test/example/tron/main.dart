import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Tron Light Cycles',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.cyan,
      scaffoldBackgroundColor: const Color(0xFF05060A),
    ),
    home: const TronHome(),
  );
}
