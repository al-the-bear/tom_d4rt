// Pomodoro timer with theme transitions — entry #3 from
// `doc/example_app_plan.md`.
//
// A 25-minute work session followed by a 5-minute break, cycling. The
// theme seed colour swaps between red (work) and green (break) and the
// swap animates via `AnimatedTheme`. A notification chip slides in via
// `AnimatedSlide` + `AnimatedOpacity` when a phase ends.
//
// Exercises:
//   * `Timer.periodic` driving the per-second countdown
//   * `ChangeNotifier` subclass for session state
//   * `ListenableBuilder` driving the UI off the notifier
//   * Dynamic `Theme.of(context)` with `ColorScheme.fromSeed`
//   * Implicit animations on theme-derived colours
//   * Phase-end UI nudge
import 'package:flutter/material.dart';

import 'app.dart';

Widget build(BuildContext context) {
  return const PomodoroApp();
}
