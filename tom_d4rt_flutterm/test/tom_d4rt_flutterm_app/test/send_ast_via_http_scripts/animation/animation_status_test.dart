import 'package:flutter/material.dart';

/// Demonstrates AnimationStatus enum - the four states an animation can be in.
dynamic build(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AnimationStatus Demo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 16),
      for (final status in AnimationStatus.values)
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _statusColor(status).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _statusColor(status)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_statusIcon(status), color: _statusColor(status)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(status.name, style: TextStyle(fontWeight: FontWeight.bold, color: _statusColor(status))),
                  Text(_statusDesc(status), style: const TextStyle(fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
    ],
  );
}

Color _statusColor(AnimationStatus s) => switch (s) {
  AnimationStatus.dismissed => Colors.grey,
  AnimationStatus.forward => Colors.blue,
  AnimationStatus.reverse => Colors.orange,
  AnimationStatus.completed => Colors.green,
};

IconData _statusIcon(AnimationStatus s) => switch (s) {
  AnimationStatus.dismissed => Icons.stop,
  AnimationStatus.forward => Icons.play_arrow,
  AnimationStatus.reverse => Icons.replay,
  AnimationStatus.completed => Icons.check_circle,
};

String _statusDesc(AnimationStatus s) => switch (s) {
  AnimationStatus.dismissed => 'At beginning (value=0)',
  AnimationStatus.forward => 'Playing toward end',
  AnimationStatus.reverse => 'Playing toward start',
  AnimationStatus.completed => 'At end (value=1)',
};
