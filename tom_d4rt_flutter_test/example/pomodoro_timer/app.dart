// MaterialApp wrapper that owns the [PomodoroSession] and animates the
// surrounding theme across phase boundaries.
//
// The seed colour swaps between red (focus) and green (break) and
// `AnimatedTheme` interpolates the resulting ColorScheme over ~600 ms
// — every theme-driven colour in the tree (background, primary, on*)
// rides that transition without per-widget tweens.
import 'package:flutter/material.dart';

import 'home.dart';
import 'session.dart';

class PomodoroApp extends StatefulWidget {
  /// Seconds spent in a single focus phase. Defaults to the classic
  /// 25 minutes; tests inject a shorter value to keep the FakeTimer
  /// clock manageable.
  final int workSeconds;

  /// Seconds spent in a single break phase. Defaults to 5 minutes.
  final int breakSeconds;

  const PomodoroApp({
    super.key,
    this.workSeconds = PomodoroSession.defaultWorkSeconds,
    this.breakSeconds = PomodoroSession.defaultBreakSeconds,
  });

  @override
  State<PomodoroApp> createState() => _PomodoroAppState();
}

class _PomodoroAppState extends State<PomodoroApp> {
  late final PomodoroSession _session;

  @override
  void initState() {
    super.initState();
    _session = PomodoroSession(
      workSeconds: widget.workSeconds,
      breakSeconds: widget.breakSeconds,
    );
    // Drive the theme rebuild from the same notifier — when the phase
    // flips we want the surrounding MaterialApp to pick up a new theme.
    _session.addListener(_onSessionChanged);
  }

  void _onSessionChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _session.removeListener(_onSessionChanged);
    _session.dispose();
    super.dispose();
  }

  ThemeData _themeFor(PomodoroPhase phase) {
    final seed = phase == PomodoroPhase.work
        ? Colors.redAccent
        : Colors.greenAccent;
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.light,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro',
      debugShowCheckedModeBanner: false,
      // AnimatedTheme inside the MaterialApp interpolates between
      // ThemeData values smoothly when the phase flips. The
      // MaterialApp itself doesn't animate its theme — wrapping the
      // home with AnimatedTheme lets us drive the transition
      // explicitly.
      theme: _themeFor(_session.phase),
      home: AnimatedTheme(
        data: _themeFor(_session.phase),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        child: PomodoroHome(session: _session),
      ),
    );
  }
}
