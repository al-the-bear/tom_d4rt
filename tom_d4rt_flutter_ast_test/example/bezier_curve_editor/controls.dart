// Bottom control panel for the bezier_curve_editor sample.
//
// Stateless — all state lives on the parent's [BezierModel] /
// AnimationController; this widget just renders the affordances
// (resolution slider, construction toggle, play/reset buttons)
// and routes events back through callbacks.
import 'package:flutter/material.dart';

import 'bezier_model.dart';

class Controls extends StatelessWidget {
  final BezierModel model;

  /// True when the preview animation is currently running. Used
  /// to swap the play button into a pause label and to gate the
  /// reset button.
  final bool isPlaying;

  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onReset;

  const Controls({
    super.key,
    required this.model,
    required this.isPlaying,
    required this.onPlay,
    required this.onPause,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(width: 12.0, child: Text('R:')),
              const SizedBox(width: 8.0),
              Expanded(
                child: Slider(
                  key: const Key('bezier-resolution-slider'),
                  min: 2.0,
                  max: 48.0,
                  divisions: 46,
                  value: model.resolution.toDouble(),
                  label: '${model.resolution}',
                  onChanged: (double v) => model.setResolution(v.round()),
                ),
              ),
              SizedBox(
                width: 32.0,
                child: Text(
                  '${model.resolution}',
                  key: const Key('bezier-resolution-label'),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Text('Construction'),
              const SizedBox(width: 8.0),
              Switch(
                key: const Key('bezier-construction-switch'),
                value: model.showConstruction,
                onChanged: (bool v) => model.setShowConstruction(v),
              ),
              const Spacer(),
              IconButton(
                key: const Key('bezier-reset-button'),
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset preview',
                onPressed: onReset,
              ),
              FilledButton.icon(
                key: const Key('bezier-play-button'),
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                label: Text(isPlaying ? 'Pause' : 'Play'),
                onPressed: isPlaying ? onPause : onPlay,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
