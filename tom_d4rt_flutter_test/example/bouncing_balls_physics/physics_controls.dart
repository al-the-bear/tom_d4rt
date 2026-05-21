// Control bar for the bouncing-balls sandbox.
//
// All interactive widgets carry a stable `Key('btn-…')` so the
// testWidgets harness can drive them without relying on icon or
// tooltip resolution inside the d4rt interpreter.
import 'package:flutter/material.dart';

class PhysicsControls extends StatelessWidget {
  final bool paused;
  final int ballCount;
  final double gravity;
  final double elasticity;
  final VoidCallback onPlayPause;
  final VoidCallback onStep;
  final VoidCallback onSpawn;
  final VoidCallback onClear;
  final ValueChanged<double> onGravityChanged;
  final ValueChanged<double> onElasticityChanged;

  const PhysicsControls({
    super.key,
    required this.paused,
    required this.ballCount,
    required this.gravity,
    required this.elasticity,
    required this.onPlayPause,
    required this.onStep,
    required this.onSpawn,
    required this.onClear,
    required this.onGravityChanged,
    required this.onElasticityChanged,
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
                key: const Key('btn-spawn'),
                icon: const Icon(Icons.add_circle_outline),
                tooltip: 'Spawn',
                onPressed: onSpawn,
              ),
              IconButton(
                key: const Key('btn-clear'),
                icon: const Icon(Icons.clear),
                tooltip: 'Clear',
                onPressed: onClear,
              ),
              const Spacer(),
              Chip(
                key: const Key('ball-chip'),
                label: Text('balls $ballCount'),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 80,
                child: Text('Gravity'),
              ),
              Expanded(
                child: Slider(
                  key: const Key('gravity-slider'),
                  min: 0.0,
                  max: 2000.0,
                  divisions: 20,
                  value: gravity,
                  label: '${gravity.round()}',
                  onChanged: onGravityChanged,
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  '${gravity.round()} px/s²',
                  key: const Key('gravity-readout'),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 80,
                child: Text('Elasticity'),
              ),
              Expanded(
                child: Slider(
                  key: const Key('elasticity-slider'),
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  value: elasticity,
                  label: elasticity.toStringAsFixed(2),
                  onChanged: onElasticityChanged,
                ),
              ),
              SizedBox(
                width: 70,
                child: Text(
                  elasticity.toStringAsFixed(2),
                  key: const Key('elasticity-readout'),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
