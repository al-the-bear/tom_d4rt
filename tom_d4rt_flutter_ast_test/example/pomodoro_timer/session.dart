// Pomodoro session state — a `ChangeNotifier` owning the cycling work /
// break timer.
//
// The session ticks via `Timer.periodic` at 1 Hz while running. Each tick
// decrements `remainingSeconds`; when it hits zero the phase flips and the
// counter resets to the configured length for the new phase. Flipping
// also sets `pendingNotice` so the UI can show a phase-end chip; the
// notice clears after a short delay or when the user dismisses it.
//
// Durations are constructor-injected so tests can use short cycles
// (e.g. 3 / 2 seconds) without simulating fifteen minutes of fake
// clock. The default durations are the classic 25 / 5.
import 'dart:async';

import 'package:flutter/foundation.dart';

enum PomodoroPhase { work, breakTime }

class PomodoroSession extends ChangeNotifier {
  /// 25 min of work in the classic technique.
  static const int defaultWorkSeconds = 25 * 60;

  /// 5 min of break in the classic technique.
  static const int defaultBreakSeconds = 5 * 60;

  /// How long a single phase-end notice stays visible before it
  /// auto-dismisses (the user can also tap it to dismiss earlier).
  static const Duration noticeAutoDismiss = Duration(seconds: 3);

  PomodoroSession({
    this.workSeconds = defaultWorkSeconds,
    this.breakSeconds = defaultBreakSeconds,
  })  : assert(workSeconds > 0, 'workSeconds must be positive'),
        assert(breakSeconds > 0, 'breakSeconds must be positive'),
        _remainingSeconds = workSeconds;

  final int workSeconds;
  final int breakSeconds;

  PomodoroPhase _phase = PomodoroPhase.work;
  int _remainingSeconds;
  int _completedWorkCycles = 0;
  bool _isRunning = false;
  String? _pendingNotice;
  Timer? _ticker;
  Timer? _noticeTimer;

  PomodoroPhase get phase => _phase;
  int get remainingSeconds => _remainingSeconds;
  int get completedWorkCycles => _completedWorkCycles;
  bool get isRunning => _isRunning;
  String? get pendingNotice => _pendingNotice;

  /// Total length, in seconds, of the phase that's currently active.
  int get totalForPhase =>
      _phase == PomodoroPhase.work ? workSeconds : breakSeconds;

  /// Fraction of the current phase that has already elapsed, in `[0, 1]`.
  double get progress {
    final total = totalForPhase;
    if (total <= 0) return 0.0;
    return 1.0 - (_remainingSeconds / total);
  }

  // ── Controls ─────────────────────────────────────────────────────

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _ticker = Timer.periodic(const Duration(seconds: 1), _onTick);
    notifyListeners();
  }

  void pause() {
    if (!_isRunning) return;
    _isRunning = false;
    _ticker?.cancel();
    _ticker = null;
    notifyListeners();
  }

  void toggle() {
    _isRunning ? pause() : start();
  }

  void reset() {
    _ticker?.cancel();
    _ticker = null;
    _noticeTimer?.cancel();
    _noticeTimer = null;
    _isRunning = false;
    _phase = PomodoroPhase.work;
    _remainingSeconds = workSeconds;
    _completedWorkCycles = 0;
    _pendingNotice = null;
    notifyListeners();
  }

  /// Cuts the current phase short — useful as a "next" button.
  /// Flips immediately to the other phase but does not change the
  /// running/paused state.
  void skipPhase() {
    _flipPhase();
    notifyListeners();
  }

  /// Dismiss the phase-end chip. Idempotent.
  void dismissNotice() {
    if (_pendingNotice == null) return;
    _pendingNotice = null;
    _noticeTimer?.cancel();
    _noticeTimer = null;
    notifyListeners();
  }

  // ── Internals ────────────────────────────────────────────────────

  void _onTick(Timer _) {
    if (_remainingSeconds > 1) {
      _remainingSeconds -= 1;
      notifyListeners();
      return;
    }
    // Last tick of the phase — flip into the next one.
    _flipPhase();
    notifyListeners();
  }

  void _flipPhase() {
    if (_phase == PomodoroPhase.work) {
      _completedWorkCycles += 1;
      _phase = PomodoroPhase.breakTime;
      _remainingSeconds = breakSeconds;
      _pendingNotice = 'Break time';
    } else {
      _phase = PomodoroPhase.work;
      _remainingSeconds = workSeconds;
      _pendingNotice = 'Back to work';
    }
    _noticeTimer?.cancel();
    _noticeTimer = Timer(noticeAutoDismiss, _autoDismissNotice);
  }

  void _autoDismissNotice() {
    if (_pendingNotice == null) return;
    _pendingNotice = null;
    _noticeTimer = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    _noticeTimer?.cancel();
    _noticeTimer = null;
    super.dispose();
  }
}

/// Format a non-negative second-count as `MM:SS`.
String formatRemaining(int seconds) {
  if (seconds < 0) seconds = 0;
  final mm = (seconds ~/ 60).toString().padLeft(2, '0');
  final ss = (seconds % 60).toString().padLeft(2, '0');
  return '$mm:$ss';
}

/// Human-readable label for the current phase.
String labelForPhase(PomodoroPhase phase) {
  switch (phase) {
    case PomodoroPhase.work:
      return 'Focus';
    case PomodoroPhase.breakTime:
      return 'Break';
  }
}
