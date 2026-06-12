// Self-running Conway's Life — a profiling harness, NOT a test sample.
//
// Unlike `conway_life`, this variant exists purely to put the d4rt
// interpreter under a *sustained, hands-free* load so memory/CPU can be
// watched in the Flutter DevTools profiler. The differences are all in
// service of "runs forever on its own with no taps":
//
//   * Boots UNPAUSED with a preset already stamped (no Play button, no
//     manual cell painting needed).
//   * Re-seeds automatically whenever the colony collapses or a
//     generation cap is hit, so the per-tick interpreter work stays
//     roughly constant indefinitely instead of decaying to a still life.
//   * Ticks fast (default 33ms ≈ 30 steps/s) so a per-interpretation
//     leak accumulates quickly and is visible within seconds.
//
// The board/painter/patterns logic is copied verbatim from `conway_life`
// (kept self-contained so this profiling sample never perturbs the
// deterministic test corpus that `conway_life` backs).
//
// ignore_for_file: avoid_print — the print() lines are the run trail.
import 'dart:async';

import 'package:flutter/material.dart';

import 'board.dart';
import 'grid_painter.dart';
import 'patterns.dart';

/// Tick interval driving the self-run. Smaller = more interpreter work
/// per wall-clock second = a faster leak repro.
const int kProfileTickMs = 33;

/// Re-seed once a run reaches this generation, even if the colony is
/// still active — keeps each "episode" bounded and the workload steady.
const int kReseedAtGen = 600;

/// Re-seed early if the live population drops to/below this — an
/// R-pentomino settles into a handful of oscillators; reseeding keeps
/// the per-step neighbour scan (the hot interpreter path) busy.
const int kReseedFloor = 6;

class ProfilerLifeHome extends StatefulWidget {
  const ProfilerLifeHome({super.key});

  @override
  State<ProfilerLifeHome> createState() => _ProfilerLifeHomeState();
}

class _ProfilerLifeHomeState extends State<ProfilerLifeHome> {
  Set<Cell> _live = <Cell>{};
  int _gen = 0;
  int _episode = 0;
  Timer? _ticker;

  // Lightweight rolling step-rate readout so the on-screen HUD shows the
  // run is actually progressing (and how fast the interpreter is going).
  int _stepsSinceMark = 0;
  int _lastMarkMs = 0;
  double _stepsPerSec = 0;

  @override
  void initState() {
    super.initState();
    _seed();
    _lastMarkMs = DateTime.now().millisecondsSinceEpoch;
    _ticker = Timer.periodic(
      const Duration(milliseconds: kProfileTickMs),
      (_) => _tick(),
    );
    print('proflife.init w=$kBoardW h=$kBoardH tickMs=$kProfileTickMs');
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _ticker = null;
    super.dispose();
  }

  /// Stamp the chaotic R-pentomino preset to start a fresh episode.
  void _seed() {
    _live = kRPentomino.stampAt();
    _gen = 0;
    _episode += 1;
    print('proflife.seed episode=$_episode preset=${kRPentomino.name} '
        'alive=${_live.length}');
  }

  void _tick() {
    final next = stepLife(_live);
    final reseed = _gen >= kReseedAtGen || next.length <= kReseedFloor;
    setState(() {
      if (reseed) {
        _seed();
      } else {
        _live = next;
        _gen += 1;
      }
    });
    _markRate();
  }

  void _markRate() {
    _stepsSinceMark += 1;
    final now = DateTime.now().millisecondsSinceEpoch;
    final dtMs = now - _lastMarkMs;
    if (dtMs >= 1000) {
      _stepsPerSec = _stepsSinceMark * 1000.0 / dtMs;
      _stepsSinceMark = 0;
      _lastMarkMs = now;
      print('proflife.rate gen=$_gen alive=${_live.length} '
          'stepsPerSec=${_stepsPerSec.toStringAsFixed(1)} '
          'episode=$_episode');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profiler · Conway (self-running)')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints c) {
                  return CustomPaint(
                    size: Size(c.maxWidth, c.maxHeight),
                    painter: GridPainter(live: _live),
                  );
                },
              ),
            ),
          ),
          Container(
            color: scheme.surfaceContainerHigh,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                _stat('episode', '$_episode'),
                _stat('gen', '$_gen'),
                _stat('alive', '${_live.length}'),
                _stat('steps/s', _stepsPerSec.toStringAsFixed(1)),
                const Spacer(),
                Icon(Icons.autorenew, size: 16, color: scheme.primary),
                const SizedBox(width: 6),
                const Text('self-running',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          Text(value,
              style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
