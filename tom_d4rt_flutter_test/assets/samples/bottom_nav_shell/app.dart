// Root `MaterialApp` shell. Owns the `ThemeNotifier` and rebuilds
// itself whenever the notifier fires (so `MaterialApp.themeMode`
// follows the flag) while exposing the same notifier through the
// `ThemeScope` ancestor for descendants that want to read or toggle
// the flag.
import 'package:flutter/material.dart';

import 'home.dart';
import 'theme_scope.dart';

class BottomNavShellApp extends StatefulWidget {
  const BottomNavShellApp({super.key});

  @override
  State<BottomNavShellApp> createState() => _BottomNavShellAppState();
}

class _BottomNavShellAppState extends State<BottomNavShellApp> {
  final ThemeNotifier _theme = ThemeNotifier();

  @override
  void initState() {
    super.initState();
    _theme.addListener(_onChange);
  }

  @override
  void dispose() {
    _theme.removeListener(_onChange);
    _theme.dispose();
    super.dispose();
  }

  void _onChange() {
    setState(() {
      // The setState body intentionally does nothing — the rebuild
      // emits a fresh `ThemeScope(isDark: _theme.isDark, ...)` so
      // dependents see the new snapshot.
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      notifier: _theme,
      isDark: _theme.isDark,
      child: MaterialApp(
        title: 'Bottom-nav shell',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _theme.isDark ? ThemeMode.dark : ThemeMode.light,
        home: const BottomNavShellHome(),
      ),
    );
  }
}
