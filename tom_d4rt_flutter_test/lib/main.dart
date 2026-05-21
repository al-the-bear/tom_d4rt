/// Entry point for the D4rt test playback app.
///
/// Composition root — owns the long-lived objects ([ScriptRootNotifier],
/// [SourceFlutterD4rt], [TestRunner], [SampleAppsNotifier],
/// [GeneratorNotifier]) and wires them into the widget tree. All UI
/// lives in `lib/src/widgets/`.
///
/// Shell layout: a top-level `TabBar` with three tabs —
///   • Examples — the original test runner / sample picker.
///   • Generate — multi-line description + Send prompt button (new).
///   • Log      — streamed thinking/text + Run button (new).
///
/// Clicking "Send prompt" programmatically switches to the Log tab.
library;

import 'package:flutter/material.dart';

import 'src/generator/generator_notifier.dart';
import 'src/generator/prefs_store.dart';
import 'src/sample_apps_notifier.dart';
import 'src/script_root_notifier.dart';
import 'src/source_flutter_d4rt.dart';
import 'src/test_runner.dart';
import 'src/widgets/control_bar.dart';
import 'src/widgets/d4rt_script_view.dart';
import 'src/widgets/generate_panel.dart';
import 'src/widgets/log_panel.dart';
import 'src/widgets/path_bar.dart';
import 'src/widgets/preferences_screen.dart';
import 'src/widgets/result_panel.dart';
import 'src/widgets/sample_app_page.dart';
import 'src/widgets/samples_bar.dart';
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

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell>
    with TickerProviderStateMixin {
  late final ScriptRootNotifier _rootNotifier;
  late final SampleAppsNotifier _samplesNotifier;
  late final SourceFlutterD4rt _d4rt;
  late final TestRunner _runner;
  late final GeneratorNotifier _generator;
  late final TabController _tabs;

  GeneratorPrefs _prefs = GeneratorPrefs();
  bool _prefsLoaded = false;

  @override
  void initState() {
    super.initState();
    _rootNotifier = ScriptRootNotifier();
    _samplesNotifier = SampleAppsNotifier();
    _d4rt = SourceFlutterD4rt();
    _runner = TestRunner(_rootNotifier);
    _generator = GeneratorNotifier(samplesNotifier: _samplesNotifier);
    _tabs = TabController(length: 3, vsync: this);
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final loaded = await GeneratorPrefs.load();
    if (!mounted) return;
    setState(() {
      _prefs = loaded;
      _prefsLoaded = true;
    });
  }

  @override
  void dispose() {
    _runner.dispose();
    _rootNotifier.dispose();
    _samplesNotifier.dispose();
    _generator.dispose();
    _tabs.dispose();
    super.dispose();
  }

  void _runSample(SampleAppEntry sample) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SampleAppPage(sample: sample, d4rt: _d4rt),
      ),
    );
  }

  Future<void> _openSettings() async {
    final updated =
        await PreferencesScreen.pushAndAwait(context, _prefs);
    if (!mounted) return;
    setState(() => _prefs = updated);
  }

  void _switchToLog() {
    _tabs.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D4rt Test Runner'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(icon: Icon(Icons.folder_open), text: 'Examples'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Generate'),
            Tab(icon: Icon(Icons.terminal), text: 'Log'),
          ],
        ),
        actions: [
          _ScriptCountBadge(runner: _runner),
          IconButton(
            tooltip: 'Generator settings',
            icon: const Icon(Icons.settings),
            onPressed: _prefsLoaded ? _openSettings : null,
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _ExamplesTab(
            rootNotifier: _rootNotifier,
            samplesNotifier: _samplesNotifier,
            d4rt: _d4rt,
            runner: _runner,
            onRunSample: _runSample,
          ),
          GeneratePanel(
            notifier: _generator,
            prefs: _prefs,
            onSent: _switchToLog,
            onOpenSettings: _openSettings,
          ),
          LogPanel(
            notifier: _generator,
            samples: _samplesNotifier,
            onRun: _runSample,
          ),
        ],
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _tabs,
        builder: (context, _) {
          // Bottom control bar only makes sense on the Examples tab —
          // hide it on Generate/Log to avoid stealing space.
          if (_tabs.index != 0) return const SizedBox.shrink();
          return ControlBar(
            runner: _runner,
            rootNotifier: _rootNotifier,
          );
        },
      ),
    );
  }
}

/// The original test-runner UI, lifted out of [_AppShell] into a tab.
class _ExamplesTab extends StatelessWidget {
  final ScriptRootNotifier rootNotifier;
  final SampleAppsNotifier samplesNotifier;
  final SourceFlutterD4rt d4rt;
  final TestRunner runner;
  final void Function(SampleAppEntry) onRunSample;

  const _ExamplesTab({
    required this.rootNotifier,
    required this.samplesNotifier,
    required this.d4rt,
    required this.runner,
    required this.onRunSample,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PathBar(notifier: rootNotifier),
        ScriptSearchBar(runner: runner),
        SamplesBar(notifier: samplesNotifier, onRun: onRunSample),
        ScriptInfoPanel(runner: runner),
        const Divider(height: 1),
        Expanded(
          flex: 3,
          child: D4rtScriptView(runner: runner, d4rt: d4rt),
        ),
        const Divider(height: 1),
        Expanded(
          flex: 1,
          child: ResultPanel(runner: runner),
        ),
      ],
    );
  }
}

/// AppBar trailing badge showing how many scripts are loaded.
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
          padding: const EdgeInsets.only(right: 4),
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
