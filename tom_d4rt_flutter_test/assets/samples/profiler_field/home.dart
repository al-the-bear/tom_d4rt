// Self-running particle field — a profiling harness, NOT a test sample.
//
// Unlike `particle_field`, this variant exists purely to put the d4rt
// interpreter under a *sustained, hands-free* load that reproduces the
// "freezes after ~1 minute of lively running, especially after changing
// the mode a few times" report without any taps. The differences are all
// in service of running forever on its own:
//
//   * Boots UNPAUSED with the raw Ticker already running (no Play tap).
//   * AUTO-CYCLES the mode attract -> repel -> orbit every
//     `kModeCycleMs`, mimicking the user manually switching the type a
//     few times — the interaction that triggers the freeze.
//   * Nudges the attractor on a slower cadence so the field stays lively
//     instead of settling into a still orbit.
//   * Emits a `field.rate` trail line every second (steps/sec + current
//     mode + cumulative mode-switch count). When the interpreter freezes
//     the rate line stops / stepsPerSec collapses to ~0, timestamping the
//     hang hands-free in the run log.
//
// The model/painter are copied verbatim from `particle_field` (kept
// self-contained so this profiling sample never perturbs the
// deterministic test corpus that `particle_field` backs).
//
// ignore_for_file: avoid_print — the print() lines are the run trail.
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'field.dart';
import 'particle_painter.dart';

/// How often to auto-advance the mode attract -> repel -> orbit. The
/// freeze report is "after changing the type a few times", so a brisk
/// cadence reproduces it quickly.
const int kModeCycleMs = 2500;

/// How often to nudge the attractor to a fresh point, keeping the field
/// energetic instead of converging to a quiet steady state.
const int kAttractorNudgeMs = 4000;

class ProfilerFieldHome extends StatefulWidget {
  const ProfilerFieldHome({super.key});

  @override
  State<ProfilerFieldHome> createState() => _ProfilerFieldHomeState();
}

class _ProfilerFieldHomeState extends State<ProfilerFieldHome>
    with SingleTickerProviderStateMixin {
  late Field _field;
  late math.Random _rng;
  Ticker? _ticker;
  Timer? _modeTimer;
  Timer? _attractorTimer;
  int _lastElapsedUs = 0;

  // Cumulative mode switches — the report ties the freeze to repeated
  // type changes, so surface the count alongside the rate.
  int _modeSwitches = 0;

  // Rolling step-rate readout so the HUD/trail shows the run is still
  // progressing (and how fast the interpreter is going).
  int _stepsSinceMark = 0;
  int _lastMarkMs = 0;
  double _stepsPerSec = 0;
  int _bootMs = 0;

  @override
  void initState() {
    super.initState();
    _rng = math.Random(kParticleSeed);
    _field = seedField(_rng, kParticleCount);
    _bootMs = DateTime.now().millisecondsSinceEpoch;
    _lastMarkMs = _bootMs;
    print('field.init w=${kWorldW.round()} h=${kWorldH.round()} '
        'particles=${_field.particles.length} '
        'mode=${_field.mode.label} cycleMs=$kModeCycleMs');

    // Boot unpaused: drive the sim from a raw Ticker, exactly like the
    // interactive sample does on Play.
    _ticker = createTicker(_onFrame)..start();

    // Auto-cycle the mode — this is the "changed the type a few times"
    // interaction, automated.
    _modeTimer = Timer.periodic(
      const Duration(milliseconds: kModeCycleMs),
      (_) => _advanceMode(),
    );
    _attractorTimer = Timer.periodic(
      const Duration(milliseconds: kAttractorNudgeMs),
      (_) => _nudgeAttractor(),
    );
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    _modeTimer?.cancel();
    _modeTimer = null;
    _attractorTimer?.cancel();
    _attractorTimer = null;
    super.dispose();
  }

  void _onFrame(Duration elapsed) {
    if (!mounted) return;
    final nowUs = elapsed.inMicroseconds;
    if (_lastElapsedUs == 0) {
      _lastElapsedUs = nowUs;
      return;
    }
    final dtUs = nowUs - _lastElapsedUs;
    _lastElapsedUs = nowUs;
    final dt = (dtUs / 1000000.0).clamp(0.0, 0.05);
    if (dt <= 0.0) return;
    final next = stepField(_field, dt);
    setState(() {
      _field = next;
    });
    _markRate();
  }

  /// attract -> repel -> orbit -> attract ...
  void _advanceMode() {
    if (!mounted) return;
    final values = FieldMode.values;
    final nextMode = values[(_field.mode.index + 1) % values.length];
    setState(() {
      _field = _field.copyWith(mode: nextMode);
    });
    _modeSwitches += 1;
    print('field.mode mode=${nextMode.label} switches=$_modeSwitches');
  }

  void _nudgeAttractor() {
    if (!mounted) return;
    final x = _rng.nextDouble() * kWorldW;
    final y = _rng.nextDouble() * kWorldH;
    setState(() {
      _field = _field.copyWith(attractorX: x, attractorY: y);
    });
  }

  void _markRate() {
    _stepsSinceMark += 1;
    final now = DateTime.now().millisecondsSinceEpoch;
    final dtMs = now - _lastMarkMs;
    if (dtMs >= 1000) {
      _stepsPerSec = _stepsSinceMark * 1000.0 / dtMs;
      _stepsSinceMark = 0;
      _lastMarkMs = now;
      final elapsedS = (now - _bootMs) / 1000.0;
      print('field.rate t=${elapsedS.toStringAsFixed(1)}s '
          'mode=${_field.mode.label} switches=$_modeSwitches '
          'stepsPerSec=${_stepsPerSec.toStringAsFixed(1)}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Profiler · Particle Field')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: kWorldW / kWorldH,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints c) {
                    return CustomPaint(
                      size: Size(c.maxWidth, c.maxHeight),
                      painter: ParticlePainter(
                        particles: _field.particles,
                        attractorX: _field.attractorX,
                        attractorY: _field.attractorY,
                        mode: _field.mode,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            color: scheme.surfaceContainerHigh,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                _stat('mode', _field.mode.label),
                _stat('switches', '$_modeSwitches'),
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
