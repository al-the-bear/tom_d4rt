/// Reactive state machine driving D4rt script playback in the test app.
///
/// `TestRunner` owns a single [SourceFlutterD4rt] interpreter, a list of
/// loaded [TestScript]s, and a current index pointer. It exposes
/// `play / pause / next / back` controls and `notifyListeners()` on every
/// state transition so the surrounding UI rebuilds reactively.
///
/// The script list is sourced from a [ScriptRootNotifier] passed into the
/// constructor: the runner subscribes to root-path changes and reloads
/// (resetting index, status, and last result) whenever the user picks a
/// new folder.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'script_root_notifier.dart';
import 'source_flutter_d4rt.dart';
import 'test_script_loader.dart';

/// Lifecycle state of the runner.
///
/// - [idle]   — no run in progress (initial state, or end-of-list reached)
/// - [running] — `play()` is iterating through scripts
/// - [paused]  — `pause()` stopped an in-flight loop; resumable via `play()`
enum RunnerStatus { idle, running, paused }

/// Outcome of executing a single script.
///
/// `info` carries either the runtime type name of the returned value (on
/// success) or the error's `toString()` (on failure). [stack] is captured
/// only on failure so the UI can show a "Show stack trace" affordance
/// without forcing the success path to allocate one.
class TestResult {
  final String scriptName;
  final bool passed;
  final String info;
  final StackTrace? stack;

  const TestResult.pass(this.scriptName, this.info)
      : passed = true,
        stack = null;

  const TestResult.fail(this.scriptName, this.info, [this.stack])
      : passed = false;
}

/// Drives playback over a list of D4rt test scripts.
///
/// State is exposed as plain fields rather than getters so the UI layer can
/// read them inside a `ListenableBuilder` without ceremony. Mutations
/// happen only via the public methods, each of which calls
/// `notifyListeners()` exactly once per logical transition.
class TestRunner extends ChangeNotifier {
  /// Source of the current script-root path. Owned by the caller — the
  /// runner only listens; it does not dispose the notifier.
  final ScriptRootNotifier rootNotifier;

  /// Underlying interpreter. Reused across script invocations because
  /// re-registering Flutter bridges per script is expensive (and the
  /// interpreter's bridge tables are append-only, so leaking state between
  /// scripts is the same risk we already accept in `tom_d4rt_flutter_ast`).
  final SourceFlutterD4rt _d4rt = SourceFlutterD4rt();

  /// Currently loaded scripts. Replaced wholesale on root-path changes.
  List<TestScript> scripts;

  /// Index into [scripts] of the script that will run next (or just ran,
  /// while [status] is [RunnerStatus.paused]).
  int currentIndex = 0;

  /// Current playback status.
  RunnerStatus status = RunnerStatus.idle;

  /// Result of the most recent `_runCurrent()`. Cleared on root-path change.
  TestResult? lastResult;

  /// Pause flag read inside [_runLoop] to break out cooperatively. Separate
  /// from [status] so the loop can distinguish "user asked to pause" from
  /// "loop finished naturally".
  bool _paused = false;

  TestRunner(this.rootNotifier)
      : scripts = TestScriptLoader.loadAll(rootNotifier.root) {
    rootNotifier.addListener(_onRootChanged);
  }

  /// The script that would run next. Null when [scripts] is empty.
  TestScript? get current =>
      scripts.isEmpty ? null : scripts[currentIndex.clamp(0, scripts.length - 1)];

  /// Start (or resume) the playback loop. No-op when already running.
  void play() {
    if (status == RunnerStatus.running) return;
    if (scripts.isEmpty) return;
    _paused = false;
    unawaited(_runLoop());
  }

  /// Cooperatively pause the playback loop. The currently-executing script
  /// finishes first; the loop checks [_paused] before advancing.
  void pause() {
    if (status != RunnerStatus.running) return;
    _paused = true;
    status = RunnerStatus.paused;
    notifyListeners();
  }

  /// Step forward one script and run it. No-op at end-of-list.
  Future<void> next() async {
    if (scripts.isEmpty) return;
    if (currentIndex >= scripts.length - 1) return;
    currentIndex++;
    await _runCurrent();
    notifyListeners();
  }

  /// Step backward one script and run it. No-op at start-of-list.
  Future<void> back() async {
    if (scripts.isEmpty) return;
    if (currentIndex <= 0) return;
    currentIndex--;
    await _runCurrent();
    notifyListeners();
  }

  Future<void> _runLoop() async {
    status = RunnerStatus.running;
    notifyListeners();
    while (currentIndex < scripts.length && !_paused) {
      await _runCurrent();
      notifyListeners();
      if (_paused) break;
      if (currentIndex >= scripts.length - 1) break;
      currentIndex++;
      // Yield to the Flutter frame pump between scripts so the UI can
      // repaint result panels mid-run rather than batching every update
      // into one frame after the loop exits.
      await Future<void>.delayed(Duration.zero);
    }
    if (!_paused) status = RunnerStatus.idle;
    notifyListeners();
  }

  Future<void> _runCurrent() async {
    if (scripts.isEmpty) return;
    final script = scripts[currentIndex];
    try {
      final raw = _d4rt.execute<dynamic>(script.source);
      lastResult = TestResult.pass(script.name, raw.runtimeType.toString());
    } catch (e, st) {
      lastResult = TestResult.fail(script.name, e.toString(), st);
    }
  }

  void _onRootChanged() {
    _reload();
    notifyListeners();
  }

  void _reload() {
    _paused = true; // signal any in-flight loop to bail out
    currentIndex = 0;
    status = RunnerStatus.idle;
    lastResult = null;
    scripts = TestScriptLoader.loadAll(rootNotifier.root);
  }

  @override
  void dispose() {
    rootNotifier.removeListener(_onRootChanged);
    super.dispose();
  }
}
