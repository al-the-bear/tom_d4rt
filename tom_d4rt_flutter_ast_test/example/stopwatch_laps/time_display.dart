// Large digital readout in the top half of the screen.
//
// The running indicator dot at the top uses a `TweenAnimationBuilder`
// so its colour fades in/out *exactly once* when the running state
// flips — no continuous frame-rate ticking that the d4rt
// interpreter would have to keep up with on every tick. The
// elapsed-time text refreshes via `Timer.periodic` + setState on the
// parent (50 ms cadence, two-decimal-second granularity).
import 'package:flutter/material.dart';

import 'format.dart';

class TimeDisplay extends StatelessWidget {
  final int elapsedMs;
  final bool running;

  const TimeDisplay({
    super.key,
    required this.elapsedMs,
    required this.running,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: running ? 16 : 12,
            height: running ? 16 : 12,
            decoration: BoxDecoration(
              color: running ? scheme.primary : scheme.outlineVariant,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            formatElapsed(elapsedMs),
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w300,
              fontFamily: 'monospace',
              letterSpacing: -1,
              color: scheme.onSurface,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            running ? 'running' : 'paused',
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 1.4,
              color: scheme.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
