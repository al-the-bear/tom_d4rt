/// Entry point for the D4rt test playback app.
///
/// Composition root only — owns the [ScriptRootNotifier] and [TestRunner]
/// lifetimes and wires them into the widget tree. All UI lives in
/// `lib/src/widgets/`.
library;

import 'package:flutter/material.dart';

import 'src/script_root_notifier.dart';
import 'src/test_runner.dart';
import 'src/widgets/control_bar.dart';
import 'src/widgets/path_bar.dart';
import 'src/widgets/result_panel.dart';
import 'src/widgets/script_info_panel.dart';

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

/// Owns the long-lived state objects (`ScriptRootNotifier`, `TestRunner`)
/// and stitches them into the layout sketched in
/// `doc/implementation_plan.md` step 8.
class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  late final ScriptRootNotifier _rootNotifier;
  late final TestRunner _runner;

  @override
  void initState() {
    super.initState();
    _rootNotifier = ScriptRootNotifier();
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
          ScriptInfoPanel(runner: _runner),
          const Divider(height: 1),
          Expanded(child: ResultPanel(runner: _runner)),
        ],
      ),
      bottomNavigationBar: ControlBar(
        runner: _runner,
        rootNotifier: _rootNotifier,
      ),
    );
  }
}

/// AppBar trailing badge — counts loaded scripts. Reactive so it updates
/// when the user picks a new folder.
class _ScriptCountBadge extends StatelessWidget {
  final TestRunner runner;
  const _ScriptCountBadge({required this.runner});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: runner,
      builder: (context, _) {
        final count = runner.scripts.length;
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .secondaryContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$count scripts',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context)
                      .colorScheme
                      .onSecondaryContainer,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
