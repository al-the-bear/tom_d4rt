// Top-level MaterialApp wrapper for the Sudoku sample. Keeps theming /
// localisation concerns isolated from the gameplay logic in home.dart.
import 'package:flutter/material.dart';

import 'home.dart';

class SudokuApp extends StatelessWidget {
  const SudokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: SudokuHome(),
    );
  }
}
