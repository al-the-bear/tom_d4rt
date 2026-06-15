// Rotary timezone dial.
//
// `GestureDetector.onPanStart`/`onPanUpdate` track the user's finger
// in polar coordinates around the centre. The angular delta from one
// frame to the next is converted to a minute-delta (via the dial's
// scale of `kMinutesPerRadian`) and pushed through `onChanged`.
//
// The widget is stateful so it can keep the last touch angle without
// pushing it up into the parent; the parent only sees integer
// minute deltas, which it then quantises with
// `quantizeOffsetMinutes()`.
//
// The dial itself rotates with `AnimatedRotation` so taps + drags
// give the user a continuous-looking response even though the
// parent only receives quantised events.
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'clock.dart';

/// Visual scale: one full rotation (2π) maps to 12 hours = 720 min.
const double kMinutesPerRadian = 720.0 / (math.pi * 2.0);

class TimezoneDial extends StatefulWidget {
  final int offsetMinutes;
  final ValueChanged<int> onChanged;

  const TimezoneDial({
    super.key,
    required this.offsetMinutes,
    required this.onChanged,
  });

  @override
  State<TimezoneDial> createState() => _TimezoneDialState();
}

class _TimezoneDialState extends State<TimezoneDial> {
  double? _lastAngle;
  double _accumulatedMinutes = 0.0;

  void _onPanStart(DragStartDetails d, Size size) {
    final Offset c = Offset(size.width / 2.0, size.height / 2.0);
    final Offset delta = d.localPosition - c;
    _lastAngle = math.atan2(delta.dy, delta.dx);
    _accumulatedMinutes = 0.0;
  }

  void _onPanUpdate(DragUpdateDetails d, Size size) {
    final Offset c = Offset(size.width / 2.0, size.height / 2.0);
    final Offset delta = d.localPosition - c;
    final double angle = math.atan2(delta.dy, delta.dx);
    if (_lastAngle == null) {
      _lastAngle = angle;
      return;
    }
    double angleDelta = angle - _lastAngle!;
    // Wrap into (-π, π] so a tiny jump across the discontinuity
    // doesn't become a "spin around the dial" event.
    if (angleDelta > math.pi) angleDelta = angleDelta - math.pi * 2.0;
    if (angleDelta < -math.pi) angleDelta = angleDelta + math.pi * 2.0;
    _lastAngle = angle;
    _accumulatedMinutes = _accumulatedMinutes + angleDelta * kMinutesPerRadian;

    final int raw = widget.offsetMinutes + _accumulatedMinutes.round();
    final int snapped = quantizeOffsetMinutes(raw);
    if (snapped != widget.offsetMinutes) {
      _accumulatedMinutes = 0.0;
      widget.onChanged(snapped);
    }
  }

  void _onPanEnd(DragEndDetails _) {
    _lastAngle = null;
    _accumulatedMinutes = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints c) {
        final Size size = Size(c.maxWidth, c.maxHeight);
        return GestureDetector(
          key: const Key('timezone-dial'),
          behavior: HitTestBehavior.opaque,
          onPanStart: (DragStartDetails d) => _onPanStart(d, size),
          onPanUpdate: (DragUpdateDetails d) => _onPanUpdate(d, size),
          onPanEnd: _onPanEnd,
          child: AnimatedRotation(
            key: const Key('dial-rotation'),
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            turns: widget.offsetMinutes / 720.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1A237E),
                border: Border.all(
                  color: const Color(0xFF9FA8DA),
                  width: 3.0,
                ),
              ),
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10.0),
              child: const _DialIndicator(),
            ),
          ),
        );
      },
    );
  }
}

class _DialIndicator extends StatelessWidget {
  const _DialIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.0,
      height: 14.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFFFC107),
      ),
    );
  }
}
