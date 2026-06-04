// Memory match — entry #6 from `doc/example_app_plan.md`.
//
// Pair-matching grid: 4×4 (easy) or 6×6 (hard). Tap a card to flip
// it; tap a second to attempt a match. The flow lives in
// `MemoryMatchHome` — this file is just the `MaterialApp` shell.
//
// Exercises:
//   * `TweenAnimationBuilder<double>` for the per-card Y-axis flip
//   * `Timer` (one-shot `Future.delayed`-style) for the
//     match/no-match resolve window
//   * `GridView.count` for the board layout
//   * `OutlinedButton`-toggle pair as a lightweight difficulty
//     selector (instead of `SegmentedButton`, which keeps the
//     bridge surface modest)
//   * Per-difficulty highscore stored in a `Map<Difficulty, int>`
//     that survives Reset
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Memory Match',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.indigo,
        brightness: Brightness.light,
      ),
    ),
    home: const MemoryMatchHome(),
  );
}
