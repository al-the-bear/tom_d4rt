// Conway's Game of Life home page.
//
// State machine:
//   * `_live`   — Set<Cell> of currently-alive cells. Replaced (not
//                 mutated in place) on every step so the painter can
//                 use identity checks.
//   * `_gen`    — generation counter.
//   * `_paused` — whether the ticker is currently driving the board.
//   * `_tickMs` — slider-controlled interval, restarts the ticker.
//   * `_ticker` — current `Timer.periodic` handle (null when paused).
//
// We start paused so the testWidgets harness can drive a perfectly
// deterministic sequence: stamp a pattern, press step, assert.
//
// Trail (`print(...)`) lines are stable and prefixed with `life.`
// so the test can scan them with a single matcher.
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'dart:async';

import 'package:flutter/material.dart';

import 'board.dart';
import 'control_bar.dart';
import 'grid_painter.dart';
import 'patterns.dart';

class ConwayLifeHome extends StatefulWidget {
  const ConwayLifeHome({super.key});

  @override
  State<ConwayLifeHome> createState() => _ConwayLifeHomeState();
}

class _ConwayLifeHomeState extends State<ConwayLifeHome> {
  Set<Cell> _live = <Cell>{};
  int _gen = 0;
  bool _paused = true;
  double _tickMs = 200.0;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    print('life.init w=$kBoardW h=$kBoardH gen=$_gen alive=${_live.length}');
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _stepOnce() {
    setState(() {
      _live = stepLife(_live);
      _gen += 1;
    });
    print('life.step gen=$_gen alive=${_live.length}');
  }

  void _clear() {
    setState(() {
      _live = <Cell>{};
      _gen = 0;
    });
    print('life.clear gen=$_gen alive=${_live.length}');
  }

  void _togglePause() {
    setState(() {
      _paused = !_paused;
    });
    if (_paused) {
      _ticker?.cancel();
      _ticker = null;
      print('life.pause');
    } else {
      _restartTicker();
      print('life.play interval=${_tickMs.round()}ms');
    }
  }

  void _restartTicker() {
    _ticker?.cancel();
    final ms = _tickMs.round();
    _ticker = Timer.periodic(Duration(milliseconds: ms), (_) {
      _stepOnce();
    });
  }

  void _onSpeedChanged(double v) {
    setState(() {
      _tickMs = v;
    });
    print('life.slider ms=${_tickMs.round()}');
    if (!_paused) {
      _restartTicker();
    }
  }

  void _applyPreset(LifePattern p) {
    final stamped = p.stampAt();
    setState(() {
      _live = stamped;
      _gen = 0;
    });
    print('life.preset name=${p.name} alive=${_live.length}');
  }

  void _toggleCell(Cell c) {
    if (!c.inBounds) return;
    setState(() {
      final next = <Cell>{};
      next.addAll(_live);
      if (next.contains(c)) {
        next.remove(c);
      } else {
        next.add(c);
      }
      _live = next;
    });
    print('life.toggle x=${c.x} y=${c.y} alive=${_live.length}');
  }

  Cell? _hitTest(Offset local, Size size) {
    if (size.width <= 0 || size.height <= 0) return null;
    final cellW = size.width / kBoardW;
    final cellH = size.height / kBoardH;
    final x = (local.dx / cellW).floor();
    final y = (local.dy / cellH).floor();
    if (x < 0 || x >= kBoardW) return null;
    if (y < 0 || y >= kBoardH) return null;
    return Cell(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conway's Life")),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints c) {
                  final size = Size(c.maxWidth, c.maxHeight);
                  return GestureDetector(
                    key: const Key('life-board'),
                    behavior: HitTestBehavior.opaque,
                    onTapDown: (TapDownDetails d) {
                      final cell = _hitTest(d.localPosition, size);
                      if (cell != null) _toggleCell(cell);
                    },
                    onPanUpdate: (DragUpdateDetails d) {
                      final cell = _hitTest(d.localPosition, size);
                      if (cell == null) return;
                      if (_live.contains(cell)) return;
                      _toggleCell(cell);
                    },
                    child: CustomPaint(
                      size: size,
                      painter: GridPainter(live: _live),
                    ),
                  );
                },
              ),
            ),
          ),
          ControlBar(
            paused: _paused,
            gen: _gen,
            alive: _live.length,
            tickMs: _tickMs,
            onPlayPause: _togglePause,
            onStep: _stepOnce,
            onClear: _clear,
            onSpeedChanged: _onSpeedChanged,
            onPreset: _applyPreset,
          ),
        ],
      ),
    );
  }
}
