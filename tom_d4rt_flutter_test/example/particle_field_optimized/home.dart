// Particle-field home — optimized variant.
//
// The page is a thin `StatefulWidget` that exists ONLY to own the controller
// lifecycle (create in `initState`, dispose in `dispose`) and to supply a
// `TickerProvider` for the physics ticker. Crucially its `build()` runs
// **exactly once** — nothing here ever calls `setState`. All per-frame
// updates flow through the controller's `ValueNotifier`s:
//
//   * the canvas is a single static `CustomPaint` whose `ParticlePainter`
//     listens to `controller.field` via `repaint:` — a tick / hover repaints
//     the canvas with zero widget rebuild;
//   * `onHover` / taps update `controller.field` instead of calling
//     `setState`, so moving the mouse no longer re-interprets the tree;
//   * the mode controls and play/pause icon are wrapped in tiny
//     `ValueListenableBuilder`s that rebuild only their own leaf widget when
//     their specific notifier fires.
//
// Net effect: per-frame interpreted rebuild churn drops to ~0; only the
// interpreted `paint()` (iterating the particles) remains.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'field.dart';
import 'field_controller.dart';
import 'mode_selector.dart';
import 'particle_painter.dart';

class ParticleFieldHome extends StatefulWidget {
  const ParticleFieldHome({super.key});

  @override
  State<ParticleFieldHome> createState() => _ParticleFieldHomeState();
}

class _ParticleFieldHomeState extends State<ParticleFieldHome>
    with SingleTickerProviderStateMixin {
  late final FieldController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FieldController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Particle Field (optimized)')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: kWorldW / kWorldH,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints c) {
                    final size = Size(c.maxWidth, c.maxHeight);
                    return MouseRegion(
                      key: const Key('field-mouse-region'),
                      onHover: (PointerHoverEvent e) {
                        _controller.setAttractorFromCanvas(
                            e.localPosition, size, 'cursor');
                      },
                      child: GestureDetector(
                        key: const Key('field-canvas'),
                        behavior: HitTestBehavior.opaque,
                        onTapDown: (TapDownDetails d) {
                          _controller.setAttractorFromCanvas(
                              d.localPosition, size, 'tap');
                        },
                        child: CustomPaint(
                          size: size,
                          painter: ParticlePainter(field: _controller.field),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ValueListenableBuilder<FieldMode>(
                  valueListenable: _controller.mode,
                  builder: (BuildContext context, FieldMode mode, Widget? _) {
                    return ModeSelector(
                        mode: mode, onChanged: _controller.setMode);
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ValueListenableBuilder<bool>(
                      valueListenable: _controller.paused,
                      builder: (BuildContext context, bool paused, Widget? _) {
                        return IconButton(
                          key: const Key('btn-play-pause'),
                          icon: Icon(
                              paused ? Icons.play_arrow : Icons.pause),
                          tooltip: paused ? 'Play' : 'Pause',
                          onPressed: _controller.togglePause,
                        );
                      },
                    ),
                    IconButton(
                      key: const Key('btn-step'),
                      icon: const Icon(Icons.skip_next),
                      tooltip: 'Step',
                      onPressed: _controller.stepOnce,
                    ),
                    IconButton(
                      key: const Key('btn-reset'),
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reset',
                      onPressed: _controller.reset,
                    ),
                    const SizedBox(width: 12),
                    ValueListenableBuilder<FieldMode>(
                      valueListenable: _controller.mode,
                      builder: (BuildContext context, FieldMode mode, Widget? _) {
                        return Chip(
                          key: const Key('mode-chip'),
                          label: Text('mode ${mode.label}'),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
