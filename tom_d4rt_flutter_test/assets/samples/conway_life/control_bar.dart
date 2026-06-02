// Bottom control bar: play/pause, step, clear, preset menu, speed.
//
// All interactive widgets carry a stable `Key('…')` so the
// testWidgets harness can drive them without relying on icons or
// tooltip text — important because the test runs inside the d4rt
// interpreter where icon-finding by IconData is fragile.
import 'package:flutter/material.dart';

import 'patterns.dart';

class ControlBar extends StatelessWidget {
  final bool paused;
  final int gen;
  final int alive;
  final double tickMs;
  final VoidCallback onPlayPause;
  final VoidCallback onStep;
  final VoidCallback onClear;
  final ValueChanged<double> onSpeedChanged;
  final ValueChanged<LifePattern> onPreset;

  const ControlBar({
    super.key,
    required this.paused,
    required this.gen,
    required this.alive,
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
              IconButton(
                key: const Key('btn-play-pause'),
                icon: Icon(paused ? Icons.play_arrow : Icons.pause),
                tooltip: paused ? 'Play' : 'Pause',
                onPressed: onPlayPause,
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
              Chip(
                key: const Key('gen-chip'),
                label: Text('gen $gen / alive $alive'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('Speed'),
              Expanded(
                child: Slider(
                  key: const Key('tick-slider'),
                  min: 50.0,
                  max: 1000.0,
                  divisions: 19,
                  value: tickMs,
                  label: '${tickMs.round()} ms',
                  onChanged: onSpeedChanged,
                ),
              ),
              Text(
                '${tickMs.round()} ms',
                key: const Key('tick-readout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
