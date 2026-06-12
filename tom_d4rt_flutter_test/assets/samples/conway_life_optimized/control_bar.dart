// Bottom control bar: play/pause, step, clear, preset menu, speed
// (optimized variant).
//
// This is a `StatelessWidget` built once. The dynamic readouts are isolated
// into tiny `ValueListenableBuilder`s so a generation tick rebuilds only the
// affected leaf (the play/pause icon, the gen/alive chip, or the speed
// row) — never the whole bar:
//   * `paused` → play/pause icon;
//   * `stats`  → `gen … / alive …` chip;
//   * `tickMs` → slider + readout.
//
// All interactive widgets keep their stable `Key('…')` so a testWidgets
// harness can drive them without relying on icons.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'life_controller.dart';
import 'patterns.dart';

class ControlBar extends StatelessWidget {
  final ValueListenable<bool> paused;
  final ValueListenable<LifeStats> stats;
  final ValueListenable<double> tickMs;
  final VoidCallback onPlayPause;
  final VoidCallback onStep;
  final VoidCallback onClear;
  final ValueChanged<double> onSpeedChanged;
  final ValueChanged<LifePattern> onPreset;

  const ControlBar({
    super.key,
    required this.paused,
    required this.stats,
    required this.tickMs,
    required this.onPlayPause,
    required this.onStep,
    required this.onClear,
    required this.onSpeedChanged,
    required this.onPreset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              ValueListenableBuilder<bool>(
                valueListenable: paused,
                builder: (BuildContext context, bool isPaused, Widget? _) {
                  return IconButton(
                    key: const Key('btn-play-pause'),
                    icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                    tooltip: isPaused ? 'Play' : 'Pause',
                    onPressed: onPlayPause,
                  );
                },
              ),
              IconButton(
                key: const Key('btn-step'),
                icon: const Icon(Icons.skip_next),
                tooltip: 'Step',
                onPressed: onStep,
              ),
              IconButton(
                key: const Key('btn-clear'),
                icon: const Icon(Icons.clear),
                tooltip: 'Clear',
                onPressed: onClear,
              ),
              const SizedBox(width: 8),
              PopupMenuButton<LifePattern>(
                key: const Key('preset-menu'),
                tooltip: 'Presets',
                onSelected: onPreset,
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<LifePattern>>[
                    for (final p in kPatterns)
                      PopupMenuItem<LifePattern>(
                        value: p,
                        child: Text(p.name),
                      ),
                  ];
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const <Widget>[
                      Text('Preset'),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ValueListenableBuilder<LifeStats>(
                valueListenable: stats,
                builder: (BuildContext context, LifeStats s, Widget? _) {
                  return Chip(
                    key: const Key('gen-chip'),
                    label: Text('gen ${s.gen} / alive ${s.alive}'),
                  );
                },
              ),
            ],
          ),
          ValueListenableBuilder<double>(
            valueListenable: tickMs,
            builder: (BuildContext context, double ms, Widget? _) {
              return Row(
                children: <Widget>[
                  const Text('Speed'),
                  Expanded(
                    child: Slider(
                      key: const Key('tick-slider'),
                      min: 50.0,
                      max: 1000.0,
                      divisions: 19,
                      value: ms,
                      label: '${ms.round()} ms',
                      onChanged: onSpeedChanged,
                    ),
                  ),
                  Text(
                    '${ms.round()} ms',
                    key: const Key('tick-readout'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
