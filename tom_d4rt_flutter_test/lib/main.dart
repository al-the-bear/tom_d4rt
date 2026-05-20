/// Entry point for the D4rt test playback app.
///
/// Composition root — owns the long-lived objects ([ScriptRootNotifier],
/// [SourceFlutterD4rt], [TestRunner]) and wires them into the widget tree.
/// All UI lives in `lib/src/widgets/`.
///
/// Layout:
///
///     AppBar          — title + script-count badge
///     PathBar         — root path, Browse button, "Path not found" affordance
///     ScriptSearchBar — case-insensitive filter + 3-row match preview
///     ScriptInfoPanel — cluster / script name / index badge
///     ──── divider ────
///     D4rtScriptView  (Expanded flex 3) — rendered Flutter widget from script
///     ──── divider ────
///     ResultPanel     (flex 1) — pass/fail, output, stack trace
///     ControlBar   (bottomNavigationBar) — Back / Next
library;

import 'package:flutter/material.dart';

import 'src/script_root_notifier.dart';
import 'src/source_flutter_d4rt.dart';
import 'src/test_runner.dart';
import 'src/widgets/control_bar.dart';
import 'src/widgets/d4rt_script_view.dart';
import 'src/widgets/path_bar.dart';
import 'src/widgets/result_panel.dart';
import 'src/widgets/script_info_panel.dart';
import 'src/widgets/script_search_bar.dart';

void main() {
  runApp(const D4rtTestApp());
}

class D4rtTestApp extends StatelessWidget {
  const D4rtTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D4rt Test Runner',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const _AppShell(),
    );
  }
}

/// Creates the three long-lived state objects and disposes them on teardown.
///
/// [SourceFlutterD4rt] is constructed here (not inside [TestRunner]) so it is
/// created exactly once across the app lifetime and can be passed to
/// [D4rtScriptView] without [TestRunner] needing to know about interpreter
/// lifecycles. Bridge registration happens synchronously during construction
/// and is effectively a one-time fixed cost.
class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  late final ScriptRootNotifier _rootNotifier;
  late final SourceFlutterD4rt _d4rt;
  late final TestRunner _runner;

  @override
  void initState() {
    super.initState();
    _rootNotifier = ScriptRootNotifier();
    _d4rt = SourceFlutterD4rt(); // registers all Flutter bridges once
    _runner = TestRunner(_rootNotifier);
  }

  @override
  void dispose() {
    _runner.dispose();
    _rootNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D4rt Test Runner'),
        actions: [_ScriptCountBadge(runner: _runner)],
      ),
      body: Column(
        children: [
          PathBar(notifier: _rootNotifier),
          ScriptSearchBar(runner: _runner),
          ScriptInfoPanel(runner: _runner),
          const Divider(height: 1),
          // Primary area: the Flutter widget produced by the D4rt script.
          // Takes ¾ of the remaining vertical space so the rendered result
          // has room to breathe.
          Expanded(
            flex: 3,
            child: D4rtScriptView(runner: _runner, d4rt: _d4rt),
          ),
          const Divider(height: 1),
          // Secondary area: pass/fail summary, captured output, stack trace.
          Expanded(
            flex: 1,
            child: ResultPanel(runner: _runner),
          ),
        ],
      ),
      bottomNavigationBar: ControlBar(
        runner: _runner,
        rootNotifier: _rootNotifier,
      ),
    );
  }
}

/// AppBar trailing badge showing how many scripts are loaded. Reactive so
/// it updates when the user picks a new folder.
class _ScriptCountBadge extends StatelessWidget {
  final TestRunner runner;
  const _ScriptCountBadge({required this.runner});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: runner,
      builder: (context, _) {
        final count = runner.scripts.length;
        final scheme = Theme.of(context).colorScheme;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count scripts',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
