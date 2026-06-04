// Snake game — entry #7 from `doc/example_app_plan.md`.
//
// A 20×20 grid, head-first snake, arrow-keys / WASD steering, food
// pellets that speed the snake up as the score climbs. The game
// starts paused at boot so tests can deterministically tap a
// "Step" button instead of racing against `Timer.periodic`.
//
// Exercises:
//   * `KeyboardListener` + `LogicalKeyboardKey` + `FocusNode` for
//     arrow / WASD / space-bar / R input
//   * `Timer.periodic` for the auto-play tick (cancelled on
//     pause / game-over)
//   * `CustomPainter` rendering of grid, snake body, head, food
//   * Score / Best readouts inside the `AppBar.actions`
//   * Seeded `Random` (`kFoodSeed`) for reproducible test layouts
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Snake',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.light,
      ),
    ),
    home: const SnakeGameHome(),
  );
}
