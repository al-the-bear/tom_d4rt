/// Reactive state machine driving D4rt script playback in the test app.
///
/// `TestRunner` owns the playback cursor, filter state, and the result of the
/// most recent execution. It does **not** own or call the D4rt interpreter
/// directly. Instead, it exposes a "pending script" contract:
///
/// 1. `_runCurrent()` stores the next script in [pendingScript] and
///    `notifyListeners()` — the [D4rtScriptView] widget observes this and
///    executes the script inside its Flutter `build(BuildContext context)` call
///    so that the real `BuildContext` (with Theme, Navigator, etc.) is
///    available to the script.
///
/// 2. After the post-frame callback fires in [D4rtScriptView], it calls
///    [completeScript] with the outcome. `_runCurrent()` is then resumed.
///
/// The runner subscribes to a [ScriptRootNotifier] and reloads the script
/// list whenever the user picks a new folder.
///
/// **No autoplay.** A script is launched only on explicit user input
/// (`next`, `back`, or `jumpTo`); once rendered, the produced widget remains
/// on screen indefinitely so Flutter's normal frame-pumping drives any
/// animations the script defines.
library;

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'script_root_notifier.dart';
import 'test_script_loader.dart';

/// Lifecycle state of the runner.
///
/// - [idle]      — no script execution in flight (initial state)
/// - [executing] — the interpreter is producing a widget for the current
///                 script; Back/Next are temporarily disabled
enum RunnerStatus { idle, executing }

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

/// Drives single-step playback over a list of D4rt test scripts with an
/// optional substring filter.
///
/// All mutations are performed via the public methods; each calls
/// `notifyListeners()` exactly once per logical transition so
/// `ListenableBuilder` consumers rebuild only when the state actually changes.
class TestRunner extends ChangeNotifier {
  /// Source of the current script-root path. Owned by the caller.
  final ScriptRootNotifier rootNotifier;

  /// Full corpus loaded from disk — never mutated except on root reload.
  List<TestScript> _allScripts;

  /// Filter substring, case-folded and trimmed. Empty means "no filter".
  String _filterQuery = '';

  /// Filtered view that drives the UI and Next/Back navigation.
  List<TestScript> scripts;

  /// Index into [scripts] (the filtered view) of the script that just ran
  /// or is about to run.
  int currentIndex = 0;

  /// Current execution status.
  RunnerStatus status = RunnerStatus.idle;

  /// Result of the most recently completed execution. Cleared on root change.
  TestResult? lastResult;

  /// The script currently awaiting execution by [D4rtScriptView].
  /// Non-null only while the D4rt build cycle is in progress.
  TestScript? pendingScript;

  Completer<TestResult>? _pendingCompleter;

  TestRunner(this.rootNotifier)
      : _allScripts = TestScriptLoader.loadAll(rootNotifier.root),
        scripts = const [] {
    scripts = List<TestScript>.unmodifiable(_allScripts);
    rootNotifier.addListener(_onRootChanged);
  }

  /// The script at [currentIndex]. Null when [scripts] is empty.
  TestScript? get current => scripts.isEmpty
      ? null
      : scripts[currentIndex.clamp(0, scripts.length - 1)];

  /// Number of scripts in the full corpus (before filtering).
  int get totalScriptCount => _allScripts.length;

  /// Current filter substring (trimmed, original casing).
  String get filterQuery => _filterQuery;

  // ── Filter ───────────────────────────────────────────────────────────────

  /// Apply a case-insensitive substring filter against each script's full
  /// path. Empty / whitespace clears the filter. Resets [currentIndex] to 0
  /// and notifies listeners when the filter actually changes.
  void setFilter(String query) {
    final normalized = query.trim();
    if (normalized == _filterQuery) return;
    _filterQuery = normalized;
    _applyFilter();
    notifyListeners();
  }

  void _applyFilter() {
    if (_filterQuery.isEmpty) {
      scripts = List<TestScript>.unmodifiable(_allScripts);
    } else {
      final needle = _filterQuery.toLowerCase();
      scripts = List<TestScript>.unmodifiable(
        _allScripts.where((s) => s.name.toLowerCase().contains(needle)),
      );
    }
    currentIndex = 0;
  }

  // ── Playback controls ────────────────────────────────────────────────────

  /// Run the script at [index] in the current filtered view. No-op when
  /// the index is out of range or another execution is in flight.
  Future<void> jumpTo(int index) async {
    if (scripts.isEmpty) return;
    if (status == RunnerStatus.executing) return;
    final clamped = index.clamp(0, scripts.length - 1);
    currentIndex = clamped;
    await _runCurrent();
    notifyListeners();
  }

  /// Step forward one script and run it. No-op at end-of-list or while
  /// another execution is in flight.
  Future<void> next() async {
    if (scripts.isEmpty) return;
    if (status == RunnerStatus.executing) return;
    if (currentIndex >= scripts.length - 1) return;
    currentIndex++;
    await _runCurrent();
    notifyListeners();
  }

  /// Step backward one script and run it. No-op at start-of-list or while
  /// another execution is in flight.
  Future<void> back() async {
    if (scripts.isEmpty) return;
    if (status == RunnerStatus.executing) return;
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

  /// Signals [D4rtScriptView] to execute the current script inside the
  /// Flutter build cycle (so a real `BuildContext` is in scope), then
  /// suspends until [completeScript] is called from the post-frame callback.
  Future<void> _runCurrent() async {
    if (scripts.isEmpty) return;
    final script = scripts[currentIndex];
    final completer = Completer<TestResult>();
    _pendingCompleter = completer;
    pendingScript = script;
    status = RunnerStatus.executing;
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
    } finally {
      status = RunnerStatus.idle;
    }
  }

  void _onRootChanged() {
    _reload();
    notifyListeners();
  }

  void _reload() {
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
    status = RunnerStatus.idle;
    lastResult = null;
    _allScripts = TestScriptLoader.loadAll(rootNotifier.root);
    _applyFilter();
  }

  @override
  void dispose() {
    rootNotifier.removeListener(_onRootChanged);
    super.dispose();
  }
}
