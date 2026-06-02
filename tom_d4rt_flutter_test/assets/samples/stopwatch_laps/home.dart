// Stopwatch home page — owns the timer and the lap list.
//
// `Timer.periodic` ticks at 50 ms while running, updating elapsed time
// via `setState`. A small `TweenAnimationBuilder` provides the running
// indicator's gentle pulse without committing the whole tree to a
// frame-rate ticker (the d4rt interpreter can't keep up with
// `AnimationController.repeat()` here — see comment in
// `time_display.dart`).
//
// Exercises the canonical "script-defined StatefulWidget + State<T>
// + setState + Timer.periodic" path through the d4rt interpreter,
// plus a small `TweenAnimationBuilder` for the in-running indicator.
import 'dart:async';

import 'package:flutter/material.dart';

import 'lap.dart';
import 'lap_list.dart';
import 'time_display.dart';

class StopwatchHome extends StatefulWidget {
  const StopwatchHome({super.key});

  @override
  State<StopwatchHome> createState() => _StopwatchHomeState();
}

class _StopwatchHomeState extends State<StopwatchHome> {
  // Stopwatch state.
  Timer? _ticker;
  int _elapsedMs = 0;
  DateTime? _startedAt;
  int _baselineMs = 0; // Accumulated ms from previous run-segments.
  bool get _running => _ticker != null;

  // Lap state.
  final List<Lap> _laps = <Lap>[];

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  // ── Stopwatch controls ────────────────────────────────────────────

  void _start() {
    if (_running) return;
    _startedAt = DateTime.now();
    // 50 ms tick rate — fine-grained enough that the centisecond
    // digit still moves continuously, but ~5× cheaper than a 10 ms
    // tick when the script-side rebuild is interpreted.
    _ticker = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) => _onTimerTick(),
    );
    setState(() {});
  }

  void _stop() {
    if (!_running) return;
    _ticker?.cancel();
    _ticker = null;
    _baselineMs = _elapsedMs;
    _startedAt = null;
    setState(() {});
  }

  void _toggle() => _running ? _stop() : _start();

  void _reset() {
    _ticker?.cancel();
    _ticker = null;
    setState(() {
      _elapsedMs = 0;
      _baselineMs = 0;
      _startedAt = null;
      _laps.clear();
    });
  }

  void _captureLap() {
    if (!_running && _elapsedMs == 0) return;
    final priorTotal = _laps.isEmpty ? 0 : _laps.last.totalMs;
    final lap = Lap(
      index: _laps.length + 1,
      totalMs: _elapsedMs,
      splitMs: _elapsedMs - priorTotal,
    );
    setState(() {
      _laps.add(lap);
    });
  }

  void _onTimerTick() {
    final started = _startedAt;
    if (started == null) return;
    final now = DateTime.now();
    final live = now.difference(started).inMilliseconds;
    setState(() {
      _elapsedMs = _baselineMs + live;
    });
  }

  // ── Build ─────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final hasElapsed = _elapsedMs > 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
        actions: [
          IconButton(
            tooltip: 'Reset',
            icon: const Icon(Icons.restart_alt),
            // Reset is enabled only when there's something to reset.
            onPressed: (_running || hasElapsed) ? _reset : null,
          ),
        ],
      ),
      body: Column(
        children: [
          TimeDisplay(elapsedMs: _elapsedMs, running: _running),
          const Divider(height: 1),
          Expanded(child: LapList(laps: _laps)),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  // Lap is enabled while running; also allowed when
                  // paused but with a captured time (to mark a final
                  // split for the current segment).
                  onPressed: (_running || hasElapsed) ? _captureLap : null,
                  icon: const Icon(Icons.flag_outlined),
                  label: const Text('Lap'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  key: const ValueKey('toggle'),
                  onPressed: _toggle,
                  icon: Icon(_running
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded),
                  label: Text(_running ? 'Stop' : 'Start'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
