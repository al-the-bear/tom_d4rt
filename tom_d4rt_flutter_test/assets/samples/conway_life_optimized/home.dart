// Conway's Game of Life home page — optimized variant.
//
// The page is a thin `StatefulWidget` that exists ONLY to own the controller
// lifecycle (create in `initState`, dispose in `dispose`). Its `build()` runs
// **exactly once** — nothing here ever calls `setState`. All per-generation
// updates flow through the controller's `ValueNotifier`s:
//
//   * the board is a single static `CustomPaint` whose `GridPainter` listens
//     to `controller.cells` via `repaint:` — a tick repaints the board with
//     zero widget rebuild;
//   * taps / drags update `controller.cells` instead of calling `setState`;
//   * the control bar isolates its dynamic readouts in `ValueListenableBuilder`s.
//
// Combined with the integer-keyed sparse model, per-tick churn drops to just
// the interpreted `paint()` plus a `stepLife` whose cost scales with the live
// population rather than the full board area.
import 'package:flutter/material.dart';

import 'control_bar.dart';
import 'grid_painter.dart';
import 'life_controller.dart';

class ConwayLifeHome extends StatefulWidget {
  const ConwayLifeHome({super.key});

  @override
  State<ConwayLifeHome> createState() => _ConwayLifeHomeState();
}

class _ConwayLifeHomeState extends State<ConwayLifeHome> {
  late final LifeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LifeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conway's Life (optimized)")),
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
                      _controller.toggleCellAt(d.localPosition, size);
                    },
                    onPanUpdate: (DragUpdateDetails d) {
                      _controller.paintCellAt(d.localPosition, size);
                    },
                    child: CustomPaint(
                      size: size,
                      painter: GridPainter(cells: _controller.cells),
                    ),
                  );
                },
              ),
            ),
          ),
          ControlBar(
            paused: _controller.paused,
            stats: _controller.stats,
            tickMs: _controller.tickMs,
            onPlayPause: _controller.togglePause,
            onStep: _controller.stepOnce,
            onClear: _controller.clear,
            onSpeedChanged: _controller.onSpeedChanged,
            onPreset: _controller.applyPreset,
          ),
        ],
      ),
    );
  }
}
