/// Reactive state machine driving D4rt script playback in the test app.
///
/// `TestRunner` owns the playback cursor, status, and result state. It does
/// **not** own or call the D4rt interpreter directly. Instead, it exposes a
/// "pending script" contract:
///
/// 1. `_runCurrent()` stores the next script in [pendingScript] and
///    [notifyListeners()] — the [D4rtScriptView] widget observes this and
///    executes the script inside its Flutter `build(BuildContext context)` call
///    so that the real `BuildContext` (with Theme, Navigator, etc.) is
///    available to the script. This mirrors the execution contract of the
///    `tom_d4rt_flutter_ast` test app.
///
/// 2. After the post-frame callback fires in [D4rtScriptView], it calls
///    [completeScript] with the outcome. `_runCurrent()` is then resumed.
///
/// The runner subscribes to a [ScriptRootNotifier] and reloads the script
/// list whenever the user picks a new folder.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'script_root_notifier.dart';
import 'test_script_loader.dart';

/// Lifecycle state of the runner.
///
/// - [idle]    — no run in progress (initial state, or end-of-list reached)
/// - [running] — `play()` is iterating through scripts
/// - [paused]  — `pause()` stopped an in-flight loop; resumable via `play()`
enum RunnerStatus { idle, running, paused }

/// Outcome of executing a single script.
///
/// [info] carries either the widget's `runtimeType.toString()` on success or
/// the error's `toString()` on failure. [stack] is captured only on failure.
/// [output] holds all `print()` lines emitted by the script, in order.
class TestResult {
  final String scriptName;
  final bool passed;

  /// Widget type on success; error message on failure.
  final String info;
  final StackTrace? stack;

  /// Lines emitted by `print()` calls inside the script.
  final List<String> output;

  TestResult.pass(this.scriptName, this.info, {List<String>? output})
      : passed = true,
        stack = null,
        output = output ?? const [];

  TestResult.fail(
    this.scriptName,
    this.info, [
    this.stack,
    List<String>? output,
  ])  : passed = false,
        output = output ?? const [];
}

/// Drives playback over a list of D4rt test scripts.
///
/// All mutations are performed via the public methods; each calls
/// [notifyListeners()] exactly once per logical transition so
/// `ListenableBuilder` consumers rebuild only when the state actually changes.
class TestRunner extends ChangeNotifier {
  /// Source of the current script-root path. Owned by the caller.
  final ScriptRootNotifier rootNotifier;

  /// Currently loaded scripts. Replaced wholesale on root-path changes.
  List<TestScript> scripts;

  /// Index of the script that will run next (or just ran while paused).
  int currentIndex = 0;

  /// Current playback status.
  RunnerStatus status = RunnerStatus.idle;

  /// Result of the most recently completed execution. Cleared on root change.
  TestResult? lastResult;

  /// The script currently awaiting execution by [D4rtScriptView].
  /// Non-null only while the D4rt build cycle is in progress.
  TestScript? pendingScript;

  bool _paused = false;
  Completer<TestResult>? _pendingCompleter;

  TestRunner(this.rootNotifier)
      : scripts = TestScriptLoader.loadAll(rootNotifier.root) {
    rootNotifier.addListener(_onRootChanged);
  }

  /// The script at [currentIndex]. Null when [scripts] is empty.
  TestScript? get current => scripts.isEmpty
      ? null
      : scripts[currentIndex.clamp(0, scripts.length - 1)];

  // ── Playback controls ────────────────────────────────────────────────────

  /// Start (or resume) the playback loop. No-op when already running.
  void play() {
    if (status == RunnerStatus.running) return;
    if (scripts.isEmpty) return;
    _paused = false;
    unawaited(_runLoop());
  }

  /// Cooperatively pause the playback loop. The currently executing script
  /// always finishes; the loop checks [_paused] before advancing.
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

  // ── Called by D4rtScriptView ─────────────────────────────────────────────

  /// Called by [D4rtScriptView] (via a post-frame callback) once the D4rt
  /// build cycle has finished and a result is available.
  void completeScript(TestResult result) {
    pendingScript = null;
    _pendingCompleter?.complete(result);
    _pendingCompleter = null;
  }

  // ── Internal ─────────────────────────────────────────────────────────────

  Future<void> _runLoop() async {
    status = RunnerStatus.running;
    notifyListeners();
    while (currentIndex < scripts.length && !_paused) {
      await _runCurrent();
      notifyListeners();
      if (_paused) break;
      if (currentIndex >= scripts.length - 1) break;
      currentIndex++;
      // Yield to the Flutter frame pump between scripts so the UI repaints
      // result panels mid-run rather than batching every update.
      await Future<void>.delayed(Duration.zero);
    }
    if (!_paused) status = RunnerStatus.idle;
    notifyListeners();
  }

  /// Signals [D4rtScriptView] to execute the current script inside the
  /// Flutter build cycle (so a real `BuildContext` is in scope), then
  /// suspends until [completeScript] is called from the post-frame callback.
  Future<void> _runCurrent() async {
    if (scripts.isEmpty) return;
    final script = scripts[currentIndex];
    final completer = Completer<TestResult>();
    _pendingCompleter = completer;
    pendingScript = script;
    notifyListeners(); // triggers D4rtScriptView to rebuild and execute

    // Yield control so Flutter can schedule the rebuild.
    await Future<void>.delayed(Duration.zero);

    try {
      lastResult = await completer.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          pendingScript = null;
          _pendingCompleter = null;
          return TestResult.fail(
            script.name,
            'Timed out after 30 seconds — interpreter may be in an '
            'infinite loop.',
          );
        },
      );
    } catch (_) {
      // Completer completed with an error (e.g., root reload cancelled it).
      // The _paused flag is already set; just exit silently.
    }
  }

  void _onRootChanged() {
    _reload();
    notifyListeners();
  }

  void _reload() {
    _paused = true;
    // Cancel any in-flight execution gracefully.
    if (_pendingCompleter != null && !_pendingCompleter!.isCompleted) {
      _pendingCompleter!.complete(
        TestResult.fail(
          pendingScript?.name ?? '',
          'Cancelled: script root changed.',
        ),
      );
    }
    pendingScript = null;
    _pendingCompleter = null;
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
