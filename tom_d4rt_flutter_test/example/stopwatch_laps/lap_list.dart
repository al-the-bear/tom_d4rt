// Scrolling lap history. Newest lap goes on top so the user always
// sees their latest split without scrolling.
//
// The fastest and slowest lap (by `splitMs`) get a small "FAST" /
// "SLOW" chip so the user can spot their best and worst at a glance.
import 'package:flutter/material.dart';

import 'format.dart';
import 'lap.dart';

class LapList extends StatelessWidget {
  final List<Lap> laps;

  const LapList({super.key, required this.laps});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (laps.isEmpty) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: Text(
          'No laps yet — tap "Lap" while running.',
          style: TextStyle(color: scheme.outline),
        ),
      );
    }

    // Identify best (fastest) and worst (slowest) by split.
    int bestIdx = 0;
    int worstIdx = 0;
    for (var i = 1; i < laps.length; i++) {
      if (laps[i].splitMs < laps[bestIdx].splitMs) bestIdx = i;
      if (laps[i].splitMs > laps[worstIdx].splitMs) worstIdx = i;
    }

    // Newest first.
    final reversed = laps.reversed.toList();

    return ListView.builder(
      reverse: false,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      itemCount: reversed.length,
      itemBuilder: (context, i) {
        final lap = reversed[i];
        final realIdx = laps.length - 1 - i;
        final isBest = laps.length > 1 && realIdx == bestIdx;
        final isWorst = laps.length > 1 && realIdx == worstIdx;
        return _LapTile(lap: lap, isBest: isBest, isWorst: isWorst);
      },
    );
  }
}

class _LapTile extends StatelessWidget {
  final Lap lap;
  final bool isBest;
  final bool isWorst;

  const _LapTile({
    required this.lap,
    required this.isBest,
    required this.isWorst,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final splitColor = isBest
        ? Colors.greenAccent.shade400
        : isWorst
            ? Colors.redAccent.shade200
            : scheme.onSurfaceVariant;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${lap.index}',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 12),
          if (isBest)
            _Chip(label: 'FAST', color: Colors.greenAccent.shade400)
          else if (isWorst)
            _Chip(label: 'SLOW', color: Colors.redAccent.shade200)
          else
            const SizedBox.shrink(),
          const Spacer(),
          Text(
            formatElapsed(lap.splitMs),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              color: splitColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            formatElapsed(lap.totalMs),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: scheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: Colors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
