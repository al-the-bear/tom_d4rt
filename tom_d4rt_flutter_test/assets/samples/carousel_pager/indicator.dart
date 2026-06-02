// Page-indicator dots.
//
// Each dot's size and opacity scale with the dot's distance from the
// current `page` (which can be fractional while the user is mid-
// swipe). The active dot is large and opaque; off-axis dots shrink
// and fade. The colour fades from `colorA` of the active page so the
// indicator picks up the carousel's palette.
import 'package:flutter/material.dart';

import 'pages.dart';

class PageIndicator extends StatelessWidget {
  final double page;
  final int count;

  const PageIndicator({
    super.key,
    required this.page,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final int activeIndex = page.round().clamp(0, count - 1);
    final Color baseColor = kPages[activeIndex].colorA;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          for (int i = 0; i < count; i = i + 1)
            _DotForIndex(
              key: Key('indicator-dot-$i'),
              index: i,
              page: page,
              color: baseColor,
            ),
        ],
      ),
    );
  }
}

class _DotForIndex extends StatelessWidget {
  final int index;
  final double page;
  final Color color;

  const _DotForIndex({
    super.key,
    required this.index,
    required this.page,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double distance = (index - page).abs();
    // Scale curve: 1.0 at the active dot, dropping toward 0.4 fast.
    final double t = (1.0 - distance).clamp(0.0, 1.0);
    final double diameter = 6.0 + 8.0 * t;
    final double opacity = 0.3 + 0.7 * t;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: opacity),
      ),
    );
  }
}
