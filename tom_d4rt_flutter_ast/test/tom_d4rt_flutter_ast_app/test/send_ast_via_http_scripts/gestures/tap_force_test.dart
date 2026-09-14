// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for gesture details classes
// (TapDownDetails, ForcePressDetails, Drag*Details, Scale*Details, PointerEvent)
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// =============================================================================
// Gesture Details Classes — Deep Visual Demo
// -----------------------------------------------------------------------------
// The classes covered here are the *data envelopes* a GestureDetector hands to
// its callbacks. They are immutable records (no widget machinery, no lifecycle)
// and live alongside the recognizer. The full ladder is:
//
//   onPanDown      → DragDownDetails           (just position)
//   onPanStart     → DragStartDetails          (position + kind + timestamp)
//   onPanUpdate    → DragUpdateDetails         (position + delta + primaryDelta)
//   onPanEnd       → DragEndDetails            (position + velocity + primaryV)
//   onTapDown      → TapDownDetails            (position + kind?)
//   onTapUp        → TapUpDetails              (position + kind)
//   onLongPressSt. → LongPressStartDetails     (position)
//   onLongPressMU  → LongPressMoveUpdateDetails(pos + offsetFromOrigin)
//   onLongPressEnd → LongPressEndDetails       (position + velocity)
//   onForcePressUp → ForcePressDetails         (position + pressure)
//   onScaleStart   → ScaleStartDetails         (focalPoint + pointerCount)
//   onScaleUpdate  → ScaleUpdateDetails        (focalPoint + scale + rotation)
//   onScaleEnd     → ScaleEndDetails           (velocity + pointerCount)
//
// And the lower-level raw-pointer envelopes (handed to a Listener widget):
//
//   PointerDownEvent    PointerUpEvent    PointerMoveEvent
//   PointerHoverEvent   PointerCancelEvent
//
// All carry a PointerDeviceKind (touch / mouse / stylus / invertedStylus /
// trackpad / unknown). Velocity wraps an Offset of pixels/second; OffsetPair
// bundles a (local, global) Offset pair used by recognizer internals.
// =============================================================================

// A const data record for a vector-arrow drag entry.
class _DragVector {
  final String label;
  final Offset start;
  final Offset delta;
  final double? primaryDelta;
  final Color color;
  final IconData icon;
  const _DragVector({
    required this.label,
    required this.start,
    required this.delta,
    required this.color,
    required this.icon,
    this.primaryDelta,
  });
}

// A const data record for a scale snapshot card.
class _ScaleSnapshot {
  final String label;
  final Offset focalPoint;
  final double scale;
  final double horizontal;
  final double vertical;
  final double rotation;
  final int pointers;
  final Offset focalDelta;
  final Color tint;
  const _ScaleSnapshot({
    required this.label,
    required this.focalPoint,
    required this.scale,
    required this.horizontal,
    required this.vertical,
    required this.rotation,
    required this.pointers,
    required this.focalDelta,
    required this.tint,
  });
}

// A const data record for a PointerEvent catalog entry.
class _PointerSpec {
  final String name;
  final String role;
  final String story;
  final Color color;
  final IconData icon;
  const _PointerSpec({
    required this.name,
    required this.role,
    required this.story,
    required this.color,
    required this.icon,
  });
}

// A const data record for a PointerDeviceKind catalog row.
class _KindRow {
  final PointerDeviceKind kind;
  final String story;
  final IconData icon;
  final Color tint;
  const _KindRow({
    required this.kind,
    required this.story,
    required this.icon,
    required this.tint,
  });
}

// A const data record for a Velocity sample card.
class _VelocitySample {
  final String label;
  final Offset pxPerSec;
  final String story;
  final Color tint;
  const _VelocitySample({
    required this.label,
    required this.pxPerSec,
    required this.story,
    required this.tint,
  });
}

// A const data record for an OffsetPair sample card.
class _OffsetPairSample {
  final String label;
  final Offset local;
  final Offset global;
  final String story;
  final Color tint;
  const _OffsetPairSample({
    required this.label,
    required this.local,
    required this.global,
    required this.story,
    required this.tint,
  });
}

// CustomPainter for the drag-vector showcase. Indexed loop only.
class _DragArrowPainter extends CustomPainter {
  final List<_DragVector> vectors;
  const _DragArrowPainter(this.vectors);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFF7F8FC);
    canvas.drawRect(Offset.zero & size, bg);

    final grid = Paint()
      ..color = const Color(0xFFE3E6EF)
      ..strokeWidth = 1;
    for (int i = 0; i < 12; i++) {
      final dx = size.width * (i / 11);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), grid);
    }
    for (int j = 0; j < 8; j++) {
      final dy = size.height * (j / 7);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), grid);
    }

    for (int i = 0; i < vectors.length; i++) {
      final v = vectors[i];
      final origin = Offset(
        size.width * 0.12 + (i % 3) * size.width * 0.28,
        size.height * 0.18 + (i ~/ 3) * size.height * 0.36,
      );
      final tip = origin + v.delta * 0.6;
      final shaft = Paint()
        ..color = v.color
        ..strokeWidth = 4
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(origin, tip, shaft);

      final dot = Paint()..color = v.color;
      canvas.drawCircle(origin, 5, dot);

      // Arrowhead.
      final dir = (tip - origin);
      final len = dir.distance == 0 ? 1.0 : dir.distance;
      final ux = dir.dx / len;
      final uy = dir.dy / len;
      const headLen = 12.0;
      final head1 = tip + Offset(-ux * headLen - uy * headLen * 0.5,
          -uy * headLen + ux * headLen * 0.5);
      final head2 = tip + Offset(-ux * headLen + uy * headLen * 0.5,
          -uy * headLen - ux * headLen * 0.5);
      final headPaint = Paint()..color = v.color;
      final path = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(head1.dx, head1.dy)
        ..lineTo(head2.dx, head2.dy)
        ..close();
      canvas.drawPath(path, headPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DragArrowPainter old) =>
      old.vectors != vectors;
}

// CustomPainter for the force-press pressure ring.
class _PressureRingPainter extends CustomPainter {
  final double pressure;
  final Color tint;
  const _PressureRingPainter({required this.pressure, required this.tint});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = (size.shortestSide / 2) - 6;
    final bg = Paint()
      ..color = tint.withOpacity(0.10)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, maxR, bg);

    final ringBase = Paint()
      ..color = tint.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawCircle(center, maxR, ringBase);

    final ringFill = Paint()
      ..color = tint
      ..style = PaintingStyle.fill;
    final innerR = maxR * pressure.clamp(0.0, 1.0);
    canvas.drawCircle(center, innerR, ringFill);

    final tickPaint = Paint()
      ..color = tint
      ..strokeWidth = 2;
    for (int i = 0; i < 12; i++) {
      final a = (i / 12) * 6.28318;
      final p1 = center + Offset(0, -maxR + 2).rotate(a);
      final p2 = center + Offset(0, -maxR - 6).rotate(a);
      canvas.drawLine(p1, p2, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PressureRingPainter old) =>
      old.pressure != pressure || old.tint != tint;
}

// Small extension to rotate an Offset around origin. Used only by painters,
// not by the build pipeline directly.
extension _OffsetRotate on Offset {
  Offset rotate(double rad) {
    final c = _cos(rad);
    final s = _sin(rad);
    return Offset(dx * c - dy * s, dx * s + dy * c);
  }
}

// Trivial Taylor-series cos/sin so we do NOT pull in dart:math. Good enough for
// drawing 12 ticks. These are pure functions.
double _cos(double x) {
  // Reduce to [-pi, pi].
  const pi = 3.1415926535897932;
  double y = x;
  while (y > pi) {
    y -= 2 * pi;
  }
  while (y < -pi) {
    y += 2 * pi;
  }
  final y2 = y * y;
  return 1 - y2 / 2 + y2 * y2 / 24 - y2 * y2 * y2 / 720;
}

double _sin(double x) {
  const pi = 3.1415926535897932;
  double y = x;
  while (y > pi) {
    y -= 2 * pi;
  }
  while (y < -pi) {
    y += 2 * pi;
  }
  final y2 = y * y;
  return y - y * y2 / 6 + y * y2 * y2 / 120 - y * y2 * y2 * y2 / 5040;
}

// CustomPainter showing scale focal-point + rotation as a compass.
class _ScaleCompassPainter extends CustomPainter {
  final _ScaleSnapshot snap;
  const _ScaleCompassPainter(this.snap);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = (size.shortestSide / 2) - 8;

    final bg = Paint()..color = snap.tint.withOpacity(0.08);
    canvas.drawCircle(center, maxR, bg);

    final ring = Paint()
      ..color = snap.tint.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, maxR, ring);

    // Scale ring (inner ring whose radius reflects scale relative to 2.0 max).
    final scaleRing = Paint()
      ..color = snap.tint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final scaleR = (snap.scale.clamp(0.0, 2.0) / 2.0) * maxR;
    canvas.drawCircle(center, scaleR, scaleRing);

    // Rotation needle.
    final needle = Paint()
      ..color = snap.tint
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final tip = center + Offset(0, -maxR + 4).rotate(snap.rotation);
    canvas.drawLine(center, tip, needle);

    // Focal point dot (offset from center as a fractional preview).
    final focal = center + Offset(snap.focalDelta.dx * 0.4,
        snap.focalDelta.dy * 0.4);
    final focalPaint = Paint()..color = snap.tint;
    canvas.drawCircle(focal, 6, focalPaint);
  }

  @override
  bool shouldRepaint(covariant _ScaleCompassPainter old) =>
      old.snap.scale != snap.scale ||
      old.snap.rotation != snap.rotation ||
      old.snap.focalDelta != snap.focalDelta;
}

// CustomPainter for velocity arrows.
class _VelocityArrowPainter extends CustomPainter {
  final List<_VelocitySample> samples;
  const _VelocityArrowPainter(this.samples);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFFDFDFF);
    canvas.drawRect(Offset.zero & size, bg);

    for (int i = 0; i < samples.length; i++) {
      final s = samples[i];
      final col = i % 3;
      final row = i ~/ 3;
      final cell = Offset(
        size.width * (0.18 + col * 0.32),
        size.height * (0.25 + row * 0.45),
      );

      final shaft = Paint()
        ..color = s.tint
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      // Scale pxPerSec down so it fits.
      final tip = cell + s.pxPerSec / 25.0;
      canvas.drawLine(cell, tip, shaft);

      final dot = Paint()..color = s.tint;
      canvas.drawCircle(cell, 4, dot);

      final headPaint = Paint()..color = s.tint;
      canvas.drawCircle(tip, 5, headPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _VelocityArrowPainter old) =>
      old.samples != samples;
}

dynamic build(BuildContext context) {
  print('================================================================');
  print('=== tap_force_test.dart  — gesture details deep visual demo    =');
  print('================================================================');

  // ===========================================================================
  // SECTION 1 — TapDownDetails / TapUpDetails inventory
  // ---------------------------------------------------------------------------
  // Both classes implement PositionedGestureDetails and so expose:
  //     globalPosition : Offset   — pointer position in screen coordinates
  //     localPosition  : Offset   — pointer position in widget coordinates
  //                                 (defaults to globalPosition when omitted)
  //     kind           : PointerDeviceKind
  //         - on TapDownDetails it is nullable (`PointerDeviceKind?`)
  //         - on TapUpDetails   it is REQUIRED and non-null
  // These records do NOT carry a delta, velocity, or pressure. They are pure
  // "where the pointer was at this instant" snapshots.
  // ===========================================================================
  print('--- SECTION 1: Tap{Down,Up}Details inventory ---');

  final tapDownTouch = TapDownDetails(
    globalPosition: const Offset(120, 220),
    localPosition: const Offset(40, 30),
    kind: PointerDeviceKind.touch,
  );
  final tapDownMouse = TapDownDetails(
    globalPosition: const Offset(412, 96),
    localPosition: const Offset(212, 18),
    kind: PointerDeviceKind.mouse,
  );
  final tapDownStylus = TapDownDetails(
    globalPosition: const Offset(64, 512),
    localPosition: const Offset(8, 16),
    kind: PointerDeviceKind.stylus,
  );
  final tapDownNullKind = TapDownDetails(
    globalPosition: const Offset(180, 180),
    localPosition: const Offset(60, 60),
  );
  final tapDownDefaults = TapDownDetails();
  final tapDownLocalDefault = TapDownDetails(
    globalPosition: const Offset(256, 384),
    kind: PointerDeviceKind.invertedStylus,
  );

  final tapUpTouch = TapUpDetails(
    globalPosition: const Offset(120, 220),
    localPosition: const Offset(40, 30),
    kind: PointerDeviceKind.touch,
  );
  final tapUpMouse = TapUpDetails(
    globalPosition: const Offset(412, 96),
    localPosition: const Offset(212, 18),
    kind: PointerDeviceKind.mouse,
  );
  final tapUpStylus = TapUpDetails(
    globalPosition: const Offset(64, 512),
    localPosition: const Offset(8, 16),
    kind: PointerDeviceKind.stylus,
  );
  final tapUpTrackpad = TapUpDetails(
    globalPosition: const Offset(330, 330),
    localPosition: const Offset(30, 30),
    kind: PointerDeviceKind.trackpad,
  );
  final tapUpUnknown = TapUpDetails(
    globalPosition: const Offset(0, 0),
    localPosition: const Offset(0, 0),
    kind: PointerDeviceKind.unknown,
  );

  final tapDownSamples = <TapDownDetails>[
    tapDownTouch,
    tapDownMouse,
    tapDownStylus,
    tapDownNullKind,
    tapDownDefaults,
    tapDownLocalDefault,
  ];
  final tapUpSamples = <TapUpDetails>[
    tapUpTouch,
    tapUpMouse,
    tapUpStylus,
    tapUpTrackpad,
    tapUpUnknown,
  ];

  for (int i = 0; i < tapDownSamples.length; i++) {
    final t = tapDownSamples[i];
    print('  TapDown[$i] global=${t.globalPosition} local=${t.localPosition} '
        'kind=${t.kind}');
  }
  for (int i = 0; i < tapUpSamples.length; i++) {
    final t = tapUpSamples[i];
    print('  TapUp[$i]   global=${t.globalPosition} local=${t.localPosition} '
        'kind=${t.kind}');
  }

  Widget tapInventoryRow(int idx, String type, Offset global, Offset local,
      String kindLabel, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withOpacity(0.35), width: 1),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$idx',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 92,
            child: Text(
              type,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: tint,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'global=${global.dx.toStringAsFixed(0)},'
              '${global.dy.toStringAsFixed(0)}  '
              'local=${local.dx.toStringAsFixed(0)},'
              '${local.dy.toStringAsFixed(0)}  '
              'kind=$kindLabel',
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
                color: Color(0xFF2A2A33),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final tapInventoryCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 1 — TapDownDetails & TapUpDetails',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Snapshots of where a tap pointer was when it landed (Down) and '
            'when it lifted (Up). TapDownDetails.kind is nullable; '
            'TapUpDetails.kind is required.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 12),
          tapInventoryRow(0, 'TapDown', tapDownTouch.globalPosition,
              tapDownTouch.localPosition, 'touch', const Color(0xFF1F6FEB)),
          tapInventoryRow(1, 'TapDown', tapDownMouse.globalPosition,
              tapDownMouse.localPosition, 'mouse', const Color(0xFF7C5CFF)),
          tapInventoryRow(2, 'TapDown', tapDownStylus.globalPosition,
              tapDownStylus.localPosition, 'stylus', const Color(0xFF1F9F73)),
          tapInventoryRow(3, 'TapDown', tapDownNullKind.globalPosition,
              tapDownNullKind.localPosition, 'null', const Color(0xFFB02050)),
          tapInventoryRow(4, 'TapDown', tapDownDefaults.globalPosition,
              tapDownDefaults.localPosition, 'null',
              const Color(0xFF555770)),
          tapInventoryRow(5, 'TapDown', tapDownLocalDefault.globalPosition,
              tapDownLocalDefault.localPosition, 'invertedStylus',
              const Color(0xFFCC6F1F)),
          const SizedBox(height: 8),
          tapInventoryRow(0, 'TapUp', tapUpTouch.globalPosition,
              tapUpTouch.localPosition, 'touch', const Color(0xFF1F6FEB)),
          tapInventoryRow(1, 'TapUp', tapUpMouse.globalPosition,
              tapUpMouse.localPosition, 'mouse', const Color(0xFF7C5CFF)),
          tapInventoryRow(2, 'TapUp', tapUpStylus.globalPosition,
              tapUpStylus.localPosition, 'stylus', const Color(0xFF1F9F73)),
          tapInventoryRow(3, 'TapUp', tapUpTrackpad.globalPosition,
              tapUpTrackpad.localPosition, 'trackpad',
              const Color(0xFFB02050)),
          tapInventoryRow(4, 'TapUp', tapUpUnknown.globalPosition,
              tapUpUnknown.localPosition, 'unknown',
              const Color(0xFF555770)),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 2 — ForcePressDetails with pressure visualization
  // ---------------------------------------------------------------------------
  // ForcePressDetails is what onForcePressStart, onForcePressPeak,
  // onForcePressUpdate, and onForcePressEnd hand back. It carries:
  //     globalPosition : Offset
  //     localPosition  : Offset   (defaults to globalPosition)
  //     pressure       : double   (0.0 .. 1.0, normalized between min/max)
  //
  // Pressure is reported in the [0..1] range AFTER ForcePressGestureRecognizer
  // normalizes the raw PointerEvent pressure against [pressureMin, pressureMax].
  // ===========================================================================
  print('--- SECTION 2: ForcePressDetails ---');

  final forceLight = ForcePressDetails(
    globalPosition: const Offset(120, 220),
    localPosition: const Offset(40, 30),
    pressure: 0.15,
  );
  final forceMedium = ForcePressDetails(
    globalPosition: const Offset(200, 240),
    localPosition: const Offset(60, 40),
    pressure: 0.45,
  );
  final forceFirm = ForcePressDetails(
    globalPosition: const Offset(310, 180),
    localPosition: const Offset(110, 28),
    pressure: 0.72,
  );
  final forcePeak = ForcePressDetails(
    globalPosition: const Offset(420, 96),
    localPosition: const Offset(220, 18),
    pressure: 1.0,
  );
  final forceZero = ForcePressDetails(
    globalPosition: const Offset(0, 0),
    pressure: 0.0,
  );
  final forceLocalDefault = ForcePressDetails(
    globalPosition: const Offset(256, 384),
    pressure: 0.5,
  );

  final forceSamples = <ForcePressDetails>[
    forceZero,
    forceLight,
    forceMedium,
    forceLocalDefault,
    forceFirm,
    forcePeak,
  ];

  for (int i = 0; i < forceSamples.length; i++) {
    final f = forceSamples[i];
    print('  ForcePress[$i] global=${f.globalPosition} '
        'local=${f.localPosition} pressure=${f.pressure}');
  }

  Widget pressureCard(int idx, ForcePressDetails f, String label,
      Color tint) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: tint.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withOpacity(0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tint,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '$idx',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 80,
            child: CustomPaint(
              painter: _PressureRingPainter(
                pressure: f.pressure,
                tint: tint,
              ),
              child: Center(
                child: Text(
                  f.pressure.toStringAsFixed(2),
                  style: TextStyle(
                    color: tint,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'global=${f.globalPosition.dx.toStringAsFixed(0)},'
            '${f.globalPosition.dy.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
          ),
          Text(
            'local =${f.localPosition.dx.toStringAsFixed(0)},'
            '${f.localPosition.dy.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 10, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  final forcePressCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 2 — ForcePressDetails',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Each card is a separate ForcePressDetails instance, with its '
            'pressure value (0..1) drawn as the filled radius of the ring. '
            'No state, just data.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: <Widget>[
              pressureCard(0, forceZero, 'zero pressure',
                  const Color(0xFF555770)),
              pressureCard(1, forceLight, 'light tap',
                  const Color(0xFF1F6FEB)),
              pressureCard(2, forceMedium, 'medium press',
                  const Color(0xFF7C5CFF)),
              pressureCard(3, forceLocalDefault, 'default local',
                  const Color(0xFF1F9F73)),
              pressureCard(4, forceFirm, 'firm press',
                  const Color(0xFFCC6F1F)),
              pressureCard(5, forcePeak, 'peak (1.0)',
                  const Color(0xFFB02050)),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 3 — LongPressStartDetails, LongPressEndDetails,
  //             LongPressMoveUpdateDetails
  // ---------------------------------------------------------------------------
  //   LongPressStartDetails:      globalPosition, localPosition
  //   LongPressEndDetails:        globalPosition, localPosition, velocity
  //   LongPressMoveUpdateDetails: globalPosition, localPosition,
  //                               offsetFromOrigin, localOffsetFromOrigin
  //
  // The "origin" in MoveUpdateDetails is where the long-press FIRST landed —
  // the fingers can travel away from it without ending the gesture (this is
  // how iOS text selection drag-handles work).
  // ===========================================================================
  print('--- SECTION 3: LongPress*Details ---');

  final lpStart1 = const LongPressStartDetails(
    globalPosition: Offset(80, 120),
    localPosition: Offset(20, 18),
  );
  final lpStart2 = const LongPressStartDetails(
    globalPosition: Offset(240, 300),
    localPosition: Offset(40, 22),
  );
  final lpStartDefault = const LongPressStartDetails(
    globalPosition: Offset(160, 160),
  );

  final lpMoveSmall = const LongPressMoveUpdateDetails(
    globalPosition: Offset(85, 122),
    localPosition: Offset(25, 20),
    offsetFromOrigin: Offset(5, 2),
    localOffsetFromOrigin: Offset(5, 2),
  );
  final lpMoveMed = const LongPressMoveUpdateDetails(
    globalPosition: Offset(140, 180),
    localPosition: Offset(60, 60),
    offsetFromOrigin: Offset(60, 60),
    localOffsetFromOrigin: Offset(40, 42),
  );
  final lpMoveFar = const LongPressMoveUpdateDetails(
    globalPosition: Offset(260, 320),
    localPosition: Offset(120, 80),
    offsetFromOrigin: Offset(180, 200),
  );
  final lpMoveDefaultOffsets = const LongPressMoveUpdateDetails(
    globalPosition: Offset(80, 80),
  );

  final lpEndStill = const LongPressEndDetails(
    globalPosition: Offset(80, 120),
    localPosition: Offset(20, 18),
  );
  final lpEndFling = const LongPressEndDetails(
    globalPosition: Offset(260, 320),
    localPosition: Offset(120, 80),
    velocity: Velocity(pixelsPerSecond: Offset(600, -120)),
  );
  final lpEndDownward = const LongPressEndDetails(
    globalPosition: Offset(140, 480),
    localPosition: Offset(60, 200),
    velocity: Velocity(pixelsPerSecond: Offset(40, 800)),
  );

  print('  LP start: ${lpStart1.globalPosition} / ${lpStart2.globalPosition} '
      '/ ${lpStartDefault.globalPosition}');
  print('  LP move small offset:  ${lpMoveSmall.offsetFromOrigin} '
      'local=${lpMoveSmall.localOffsetFromOrigin}');
  print('  LP move med offset:    ${lpMoveMed.offsetFromOrigin} '
      'local=${lpMoveMed.localOffsetFromOrigin}');
  print('  LP move far offset:    ${lpMoveFar.offsetFromOrigin} '
      'local=${lpMoveFar.localOffsetFromOrigin}');
  print('  LP move default:       ${lpMoveDefaultOffsets.offsetFromOrigin}');
  print('  LP end velocities:     ${lpEndStill.velocity} / '
      '${lpEndFling.velocity} / ${lpEndDownward.velocity}');

  Widget lpRow(String label, String detail, Color tint, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: tint, size: 18),
          const SizedBox(width: 8),
          SizedBox(
            width: 200,
            child: Text(
              label,
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final longPressCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 3 — LongPress {Start, MoveUpdate, End} Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Three distinct records along the long-press chain. MoveUpdate '
            'is the only one that knows the original landing point (via '
            'offsetFromOrigin); End is the only one that carries velocity.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 12),
          const Text('LongPressStartDetails',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF1F6FEB))),
          lpRow('start@(80,120)',
              'global=${lpStart1.globalPosition}  '
              'local=${lpStart1.localPosition}',
              const Color(0xFF1F6FEB), Icons.touch_app),
          lpRow('start@(240,300)',
              'global=${lpStart2.globalPosition}  '
              'local=${lpStart2.localPosition}',
              const Color(0xFF1F6FEB), Icons.touch_app),
          lpRow('start default-local',
              'global=${lpStartDefault.globalPosition}  '
              'local=${lpStartDefault.localPosition}',
              const Color(0xFF1F6FEB), Icons.touch_app),
          const Divider(height: 18),
          const Text('LongPressMoveUpdateDetails',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF7C5CFF))),
          lpRow('small drift',
              'global=${lpMoveSmall.globalPosition} '
              'offsetFromOrigin=${lpMoveSmall.offsetFromOrigin}',
              const Color(0xFF7C5CFF), Icons.timeline),
          lpRow('medium drift',
              'global=${lpMoveMed.globalPosition} '
              'offsetFromOrigin=${lpMoveMed.offsetFromOrigin} '
              'localOFO=${lpMoveMed.localOffsetFromOrigin}',
              const Color(0xFF7C5CFF), Icons.timeline),
          lpRow('far drift',
              'global=${lpMoveFar.globalPosition} '
              'offsetFromOrigin=${lpMoveFar.offsetFromOrigin}',
              const Color(0xFF7C5CFF), Icons.timeline),
          lpRow('all-defaults move',
              'global=${lpMoveDefaultOffsets.globalPosition} '
              'offsetFromOrigin=${lpMoveDefaultOffsets.offsetFromOrigin}',
              const Color(0xFF7C5CFF), Icons.timeline),
          const Divider(height: 18),
          const Text('LongPressEndDetails',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF1F9F73))),
          lpRow('end still',
              'global=${lpEndStill.globalPosition} '
              'velocity=${lpEndStill.velocity.pixelsPerSecond}',
              const Color(0xFF1F9F73), Icons.stop_circle_outlined),
          lpRow('end right-flick',
              'global=${lpEndFling.globalPosition} '
              'velocity=${lpEndFling.velocity.pixelsPerSecond}',
              const Color(0xFF1F9F73), Icons.east),
          lpRow('end downward',
              'global=${lpEndDownward.globalPosition} '
              'velocity=${lpEndDownward.velocity.pixelsPerSecond}',
              const Color(0xFF1F9F73), Icons.south),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 4 — Drag details: DragDownDetails, DragStartDetails,
  //             DragUpdateDetails, DragEndDetails
  // ---------------------------------------------------------------------------
  //   DragDownDetails:   globalPosition, localPosition
  //   DragStartDetails:  globalPosition, localPosition, sourceTimeStamp?, kind?
  //   DragUpdateDetails: globalPosition, localPosition, sourceTimeStamp?,
  //                      delta, primaryDelta?, kind?
  //   DragEndDetails:    globalPosition, localPosition,
  //                      velocity, primaryVelocity?
  //
  // primaryDelta / primaryVelocity are only used by axis-locked recognizers
  // (Horizontal*, Vertical*); the assert in the constructor REQUIRES that
  // the non-primary axis be zero when primaryDelta/primaryVelocity is set.
  // ===========================================================================
  print('--- SECTION 4: Drag*Details ---');

  final dragDown1 = DragDownDetails(
    globalPosition: const Offset(64, 96),
    localPosition: const Offset(16, 24),
  );
  final dragDown2 = DragDownDetails(
    globalPosition: const Offset(220, 180),
    localPosition: const Offset(60, 30),
  );
  final dragDownNoLocal = DragDownDetails(
    globalPosition: const Offset(180, 240),
  );

  final dragStart1 = DragStartDetails(
    globalPosition: const Offset(64, 96),
    localPosition: const Offset(16, 24),
    kind: PointerDeviceKind.touch,
    sourceTimeStamp: const Duration(milliseconds: 12),
  );
  final dragStartMouse = DragStartDetails(
    globalPosition: const Offset(280, 220),
    localPosition: const Offset(120, 30),
    kind: PointerDeviceKind.mouse,
    sourceTimeStamp: const Duration(microseconds: 4500),
  );
  final dragStartStylus = DragStartDetails(
    globalPosition: const Offset(412, 480),
    localPosition: const Offset(212, 40),
    kind: PointerDeviceKind.stylus,
  );
  final dragStartDefault = DragStartDetails();
  final dragStartTrackpad = DragStartDetails(
    globalPosition: const Offset(120, 360),
    kind: PointerDeviceKind.trackpad,
    sourceTimeStamp: const Duration(milliseconds: 90),
  );

  final dragUpdateXY = DragUpdateDetails(
    globalPosition: const Offset(160, 200),
    localPosition: const Offset(60, 80),
    delta: const Offset(8, 6),
    kind: PointerDeviceKind.touch,
    sourceTimeStamp: const Duration(milliseconds: 30),
  );
  final dragUpdateHorizPrimary = DragUpdateDetails(
    globalPosition: const Offset(200, 200),
    localPosition: const Offset(100, 80),
    delta: const Offset(14, 0),
    primaryDelta: 14,
    kind: PointerDeviceKind.touch,
  );
  final dragUpdateVertPrimary = DragUpdateDetails(
    globalPosition: const Offset(200, 240),
    localPosition: const Offset(100, 120),
    delta: const Offset(0, -22),
    primaryDelta: -22,
    kind: PointerDeviceKind.touch,
  );
  final dragUpdateMouse = DragUpdateDetails(
    globalPosition: const Offset(320, 180),
    delta: const Offset(-6, 4),
    kind: PointerDeviceKind.mouse,
  );
  final dragUpdateNoDelta = DragUpdateDetails(
    globalPosition: const Offset(100, 100),
  );

  final dragEndFlick = DragEndDetails(
    globalPosition: const Offset(240, 200),
    localPosition: const Offset(140, 80),
    velocity:
        const Velocity(pixelsPerSecond: Offset(1200, -200)),
  );
  final dragEndHorizPrimary = DragEndDetails(
    globalPosition: const Offset(240, 200),
    velocity: const Velocity(pixelsPerSecond: Offset(800, 0)),
    primaryVelocity: 800,
  );
  final dragEndVertPrimary = DragEndDetails(
    globalPosition: const Offset(240, 200),
    velocity: const Velocity(pixelsPerSecond: Offset(0, -1500)),
    primaryVelocity: -1500,
  );
  final dragEndStill = DragEndDetails(
    globalPosition: const Offset(100, 100),
  );

  print('  drag down: ${dragDown1.globalPosition} / '
      '${dragDown2.globalPosition} / ${dragDownNoLocal.globalPosition}');
  print('  drag start kinds: ${dragStart1.kind} / ${dragStartMouse.kind} / '
      '${dragStartStylus.kind} / ${dragStartDefault.kind} / '
      '${dragStartTrackpad.kind}');
  print('  drag update deltas: ${dragUpdateXY.delta} / '
      '${dragUpdateHorizPrimary.delta}(${dragUpdateHorizPrimary.primaryDelta})'
      ' / ${dragUpdateVertPrimary.delta}'
      '(${dragUpdateVertPrimary.primaryDelta})'
      ' / ${dragUpdateMouse.delta} / ${dragUpdateNoDelta.delta}');
  print('  drag end velocities: ${dragEndFlick.velocity.pixelsPerSecond}'
      ' primary=${dragEndFlick.primaryVelocity}');
  print('  drag end horiz primary: ${dragEndHorizPrimary.primaryVelocity}');
  print('  drag end vert  primary: ${dragEndVertPrimary.primaryVelocity}');
  print('  drag end still: ${dragEndStill.velocity.pixelsPerSecond}');

  final dragVectors = <_DragVector>[
    _DragVector(
      label: 'XY drift',
      start: dragUpdateXY.globalPosition,
      delta: dragUpdateXY.delta,
      color: const Color(0xFF1F6FEB),
      icon: Icons.swap_horiz,
    ),
    _DragVector(
      label: 'horiz primary',
      start: dragUpdateHorizPrimary.globalPosition,
      delta: dragUpdateHorizPrimary.delta,
      primaryDelta: dragUpdateHorizPrimary.primaryDelta,
      color: const Color(0xFF7C5CFF),
      icon: Icons.east,
    ),
    _DragVector(
      label: 'vert primary',
      start: dragUpdateVertPrimary.globalPosition,
      delta: dragUpdateVertPrimary.delta,
      primaryDelta: dragUpdateVertPrimary.primaryDelta,
      color: const Color(0xFF1F9F73),
      icon: Icons.north,
    ),
    _DragVector(
      label: 'mouse drift',
      start: dragUpdateMouse.globalPosition,
      delta: dragUpdateMouse.delta,
      color: const Color(0xFFCC6F1F),
      icon: Icons.mouse,
    ),
    _DragVector(
      label: 'flick fling',
      start: dragEndFlick.globalPosition,
      delta: dragEndFlick.velocity.pixelsPerSecond / 25.0,
      color: const Color(0xFFB02050),
      icon: Icons.bolt,
    ),
    _DragVector(
      label: 'still end',
      start: dragEndStill.globalPosition,
      delta: const Offset(0.01, 0.01),
      color: const Color(0xFF555770),
      icon: Icons.stop,
    ),
  ];

  Widget dragRow(int idx, String type, String details, Color tint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$idx',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(
              type,
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              details,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Color(0xFF2A2A33),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final dragDetailsCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 4 — Drag {Down, Start, Update, End} Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'The drag chain: Down → Start → Update* → End. Only Update '
            'carries a delta; only End carries a velocity. primaryDelta and '
            'primaryVelocity are non-null only on axis-locked recognizers '
            '(Horizontal*, Vertical*).',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 12),
          dragRow(0, 'DragDown',
              'global=${dragDown1.globalPosition} '
              'local=${dragDown1.localPosition}',
              const Color(0xFF1F6FEB)),
          dragRow(1, 'DragDown',
              'global=${dragDown2.globalPosition} '
              'local=${dragDown2.localPosition}',
              const Color(0xFF1F6FEB)),
          dragRow(2, 'DragDown',
              'global=${dragDownNoLocal.globalPosition} '
              'local=${dragDownNoLocal.localPosition} (default)',
              const Color(0xFF1F6FEB)),
          const Divider(height: 14),
          dragRow(0, 'DragStart',
              'global=${dragStart1.globalPosition} kind=${dragStart1.kind} '
              'sourceTS=${dragStart1.sourceTimeStamp}',
              const Color(0xFF7C5CFF)),
          dragRow(1, 'DragStart',
              'global=${dragStartMouse.globalPosition} '
              'kind=${dragStartMouse.kind} '
              'sourceTS=${dragStartMouse.sourceTimeStamp}',
              const Color(0xFF7C5CFF)),
          dragRow(2, 'DragStart',
              'global=${dragStartStylus.globalPosition} '
              'kind=${dragStartStylus.kind} '
              'sourceTS=${dragStartStylus.sourceTimeStamp}',
              const Color(0xFF7C5CFF)),
          dragRow(3, 'DragStart',
              'global=${dragStartDefault.globalPosition} '
              'kind=${dragStartDefault.kind} (all-defaults)',
              const Color(0xFF7C5CFF)),
          dragRow(4, 'DragStart',
              'global=${dragStartTrackpad.globalPosition} '
              'kind=${dragStartTrackpad.kind}',
              const Color(0xFF7C5CFF)),
          const Divider(height: 14),
          dragRow(0, 'DragUpdate',
              'global=${dragUpdateXY.globalPosition} '
              'delta=${dragUpdateXY.delta} primaryDelta='
              '${dragUpdateXY.primaryDelta} kind=${dragUpdateXY.kind}',
              const Color(0xFF1F9F73)),
          dragRow(1, 'DragUpdate',
              'global=${dragUpdateHorizPrimary.globalPosition} '
              'delta=${dragUpdateHorizPrimary.delta} primaryDelta='
              '${dragUpdateHorizPrimary.primaryDelta}',
              const Color(0xFF1F9F73)),
          dragRow(2, 'DragUpdate',
              'global=${dragUpdateVertPrimary.globalPosition} '
              'delta=${dragUpdateVertPrimary.delta} primaryDelta='
              '${dragUpdateVertPrimary.primaryDelta}',
              const Color(0xFF1F9F73)),
          dragRow(3, 'DragUpdate',
              'global=${dragUpdateMouse.globalPosition} '
              'delta=${dragUpdateMouse.delta} primaryDelta='
              '${dragUpdateMouse.primaryDelta} kind=${dragUpdateMouse.kind}',
              const Color(0xFF1F9F73)),
          dragRow(4, 'DragUpdate',
              'global=${dragUpdateNoDelta.globalPosition} '
              'delta=${dragUpdateNoDelta.delta} (zero)',
              const Color(0xFF1F9F73)),
          const Divider(height: 14),
          dragRow(0, 'DragEnd',
              'global=${dragEndFlick.globalPosition} '
              'velocity=${dragEndFlick.velocity.pixelsPerSecond}',
              const Color(0xFFCC6F1F)),
          dragRow(1, 'DragEnd',
              'velocity=${dragEndHorizPrimary.velocity.pixelsPerSecond} '
              'primaryVelocity=${dragEndHorizPrimary.primaryVelocity}',
              const Color(0xFFCC6F1F)),
          dragRow(2, 'DragEnd',
              'velocity=${dragEndVertPrimary.velocity.pixelsPerSecond} '
              'primaryVelocity=${dragEndVertPrimary.primaryVelocity}',
              const Color(0xFFCC6F1F)),
          dragRow(3, 'DragEnd',
              'global=${dragEndStill.globalPosition} '
              'velocity=${dragEndStill.velocity.pixelsPerSecond} (still)',
              const Color(0xFFCC6F1F)),
          const SizedBox(height: 12),
          const Text(
            'Drag-update delta vector showcase (CustomPaint, no animation):',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2A2A33)),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _DragArrowPainter(dragVectors),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 5 — Scale details: ScaleStartDetails, ScaleUpdateDetails,
  //             ScaleEndDetails
  // ---------------------------------------------------------------------------
  //   ScaleStartDetails:
  //     focalPoint, localFocalPoint, pointerCount, sourceTimeStamp?, kind?
  //   ScaleUpdateDetails:
  //     focalPoint, localFocalPoint, scale, horizontalScale, verticalScale,
  //     rotation, pointerCount, focalPointDelta, sourceTimeStamp?
  //   ScaleEndDetails:
  //     velocity, scaleVelocity, pointerCount
  //
  // The focal point is the geometric centroid of all active pointers. scale is
  // 1.0 when the gesture begins; rotation is in radians, with positive values
  // rotating the focal frame counter-clockwise. focalPointDelta is the change
  // since the previous update (it is NOT a running total).
  // ===========================================================================
  print('--- SECTION 5: Scale*Details ---');

  final scaleStartTwo = ScaleStartDetails(
    focalPoint: const Offset(180, 240),
    localFocalPoint: const Offset(80, 60),
    pointerCount: 2,
    sourceTimeStamp: const Duration(milliseconds: 50),
    kind: PointerDeviceKind.touch,
  );
  final scaleStartThree = ScaleStartDetails(
    focalPoint: const Offset(220, 280),
    localFocalPoint: const Offset(120, 100),
    pointerCount: 3,
    sourceTimeStamp: const Duration(milliseconds: 60),
    kind: PointerDeviceKind.touch,
  );
  final scaleStartDefault = ScaleStartDetails();
  final scaleStartTrackpad = ScaleStartDetails(
    focalPoint: const Offset(320, 200),
    pointerCount: 2,
    kind: PointerDeviceKind.trackpad,
  );

  final scaleSnapshots = <_ScaleSnapshot>[
    const _ScaleSnapshot(
      label: 'pinch-out 1.8x',
      focalPoint: Offset(200, 200),
      scale: 1.8,
      horizontal: 1.85,
      vertical: 1.78,
      rotation: 0.0,
      pointers: 2,
      focalDelta: Offset(2, 1),
      tint: Color(0xFF1F6FEB),
    ),
    const _ScaleSnapshot(
      label: 'pinch-in 0.55x',
      focalPoint: Offset(220, 260),
      scale: 0.55,
      horizontal: 0.55,
      vertical: 0.55,
      rotation: -0.15,
      pointers: 2,
      focalDelta: Offset(-1, 0),
      tint: Color(0xFF7C5CFF),
    ),
    const _ScaleSnapshot(
      label: 'rotate +45°',
      focalPoint: Offset(180, 180),
      scale: 1.0,
      horizontal: 1.0,
      vertical: 1.0,
      rotation: 0.78539816,
      pointers: 2,
      focalDelta: Offset(0, 0),
      tint: Color(0xFF1F9F73),
    ),
    const _ScaleSnapshot(
      label: 'rotate -90°',
      focalPoint: Offset(280, 220),
      scale: 1.2,
      horizontal: 1.2,
      vertical: 1.2,
      rotation: -1.5707963,
      pointers: 2,
      focalDelta: Offset(3, -2),
      tint: Color(0xFFCC6F1F),
    ),
    const _ScaleSnapshot(
      label: 'aniso (1.5h, 0.9v)',
      focalPoint: Offset(160, 320),
      scale: 1.2,
      horizontal: 1.5,
      vertical: 0.9,
      rotation: 0.2,
      pointers: 2,
      focalDelta: Offset(4, 4),
      tint: Color(0xFFB02050),
    ),
    const _ScaleSnapshot(
      label: 'three-finger pan',
      focalPoint: Offset(220, 280),
      scale: 1.0,
      horizontal: 1.0,
      vertical: 1.0,
      rotation: 0.0,
      pointers: 3,
      focalDelta: Offset(10, 6),
      tint: Color(0xFF555770),
    ),
  ];

  final scaleUpdates = <ScaleUpdateDetails>[];
  for (int i = 0; i < scaleSnapshots.length; i++) {
    final s = scaleSnapshots[i];
    scaleUpdates.add(ScaleUpdateDetails(
      focalPoint: s.focalPoint,
      localFocalPoint: s.focalPoint - const Offset(100, 100),
      scale: s.scale,
      horizontalScale: s.horizontal,
      verticalScale: s.vertical,
      rotation: s.rotation,
      pointerCount: s.pointers,
      focalPointDelta: s.focalDelta,
      sourceTimeStamp: Duration(milliseconds: 60 + i * 16),
    ));
  }

  final scaleEndStill = ScaleEndDetails();
  final scaleEndFling = ScaleEndDetails(
    velocity:
        const Velocity(pixelsPerSecond: Offset(900, -300)),
    scaleVelocity: 2.4,
    pointerCount: 2,
  );
  final scaleEndContracting = ScaleEndDetails(
    velocity: const Velocity(pixelsPerSecond: Offset(0, 0)),
    scaleVelocity: -1.8,
    pointerCount: 2,
  );
  final scaleEndThreeFinger = ScaleEndDetails(
    velocity: const Velocity(pixelsPerSecond: Offset(200, 100)),
    pointerCount: 3,
  );

  print('  scaleStart twos: focalPoint=${scaleStartTwo.focalPoint} '
      'pointerCount=${scaleStartTwo.pointerCount} kind=${scaleStartTwo.kind}');
  print('  scaleStart threes: pointerCount=${scaleStartThree.pointerCount} '
      'kind=${scaleStartThree.kind}');
  print('  scaleStart default: focalPoint=${scaleStartDefault.focalPoint}');
  print('  scaleStart trackpad: kind=${scaleStartTrackpad.kind}');
  for (int i = 0; i < scaleUpdates.length; i++) {
    final s = scaleUpdates[i];
    print('  scaleUpdate[$i]: focal=${s.focalPoint} scale=${s.scale} '
        'horiz=${s.horizontalScale} vert=${s.verticalScale} '
        'rot=${s.rotation.toStringAsFixed(3)} '
        'pointers=${s.pointerCount} focalDelta=${s.focalPointDelta} '
        'ts=${s.sourceTimeStamp}');
  }
  print('  scaleEnd still: vel=${scaleEndStill.velocity.pixelsPerSecond} '
      'scaleVel=${scaleEndStill.scaleVelocity} '
      'pointers=${scaleEndStill.pointerCount}');
  print('  scaleEnd flick: vel=${scaleEndFling.velocity.pixelsPerSecond} '
      'scaleVel=${scaleEndFling.scaleVelocity} '
      'pointers=${scaleEndFling.pointerCount}');
  print('  scaleEnd contracting: scaleVel=${scaleEndContracting.scaleVelocity}'
      ' pointers=${scaleEndContracting.pointerCount}');
  print('  scaleEnd 3-finger: vel=${scaleEndThreeFinger.velocity.pixelsPerSecond}'
      ' pointers=${scaleEndThreeFinger.pointerCount}');

  Widget scaleSnapshotCard(int idx, _ScaleSnapshot s, ScaleUpdateDetails u) {
    return Container(
      width: 180,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: s.tint.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: s.tint.withOpacity(0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: s.tint,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text('$idx',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    )),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  s.label,
                  style: TextStyle(
                    color: s.tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 90,
            child: CustomPaint(
              painter: _ScaleCompassPainter(s),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 4),
          Text('focal=${u.focalPoint.dx.toStringAsFixed(0)},'
              '${u.focalPoint.dy.toStringAsFixed(0)}',
              style: const TextStyle(
                  fontSize: 10, fontFamily: 'monospace')),
          Text('scale=${u.scale.toStringAsFixed(2)} '
              'h=${u.horizontalScale.toStringAsFixed(2)} '
              'v=${u.verticalScale.toStringAsFixed(2)}',
              style: const TextStyle(
                  fontSize: 10, fontFamily: 'monospace')),
          Text('rot=${u.rotation.toStringAsFixed(3)} rad',
              style: const TextStyle(
                  fontSize: 10, fontFamily: 'monospace')),
          Text('pointers=${u.pointerCount} '
              'fpDelta=${u.focalPointDelta.dx.toStringAsFixed(1)},'
              '${u.focalPointDelta.dy.toStringAsFixed(1)}',
              style: const TextStyle(
                  fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  final scaleDetailsCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 5 — Scale {Start, Update, End} Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Each card is one ScaleUpdateDetails snapshot rendered as a '
            'compass: needle = rotation, inner ring radius = scale '
            '(relative to 2.0), tint dot = focalPointDelta.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: <Widget>[
              for (int i = 0; i < scaleSnapshots.length; i++)
                scaleSnapshotCard(i, scaleSnapshots[i], scaleUpdates[i]),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'ScaleStartDetails samples:',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Color(0xFF1F6FEB)),
          ),
          Text(
            '  twoPointer: focalPoint=${scaleStartTwo.focalPoint}  '
            'localFocalPoint=${scaleStartTwo.localFocalPoint}  '
            'pointerCount=${scaleStartTwo.pointerCount}  '
            'kind=${scaleStartTwo.kind}  '
            'ts=${scaleStartTwo.sourceTimeStamp}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            '  threePointer: focalPoint=${scaleStartThree.focalPoint}  '
            'pointerCount=${scaleStartThree.pointerCount}  '
            'kind=${scaleStartThree.kind}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            '  defaults: focalPoint=${scaleStartDefault.focalPoint}  '
            'pointerCount=${scaleStartDefault.pointerCount}  '
            'kind=${scaleStartDefault.kind}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            '  trackpad: focalPoint=${scaleStartTrackpad.focalPoint}  '
            'kind=${scaleStartTrackpad.kind}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 10),
          const Text(
            'ScaleEndDetails samples:',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: Color(0xFF1F9F73)),
          ),
          Text(
            '  still: velocity=${scaleEndStill.velocity.pixelsPerSecond} '
            'scaleVelocity=${scaleEndStill.scaleVelocity} '
            'pointerCount=${scaleEndStill.pointerCount}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            '  fling: velocity=${scaleEndFling.velocity.pixelsPerSecond} '
            'scaleVelocity=${scaleEndFling.scaleVelocity} '
            'pointerCount=${scaleEndFling.pointerCount}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            '  contracting: scaleVelocity=${scaleEndContracting.scaleVelocity}'
            ' pointerCount=${scaleEndContracting.pointerCount}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            '  three-finger pan: '
            'velocity=${scaleEndThreeFinger.velocity.pixelsPerSecond} '
            'pointerCount=${scaleEndThreeFinger.pointerCount}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 6 — PointerEvent type catalog
  // ---------------------------------------------------------------------------
  // PointerEvent is the raw, pre-recognition envelope. Listener widgets see
  // these directly; recognizers translate them into the Tap/Drag/Scale
  // details above. The five we surface here are the most common:
  //   PointerDownEvent    — finger landed
  //   PointerMoveEvent    — finger moved while pressed (carries `delta`)
  //   PointerUpEvent      — finger lifted (carries `pressure` = 0 by default)
  //   PointerHoverEvent   — mouse/stylus moved without buttons pressed
  //   PointerCancelEvent  — gesture interrupted by the platform
  //
  // ALL of them inherit the same wide field set from PointerEvent (position,
  // delta, kind, device, pointer, buttons, pressure, distance, orientation,
  // tilt, radius{Major,Minor,Min,Max}, synthesized, embedderId, viewId…).
  // ===========================================================================
  print('--- SECTION 6: PointerEvent catalog ---');

  final pDown = const PointerDownEvent(
    timeStamp: Duration(milliseconds: 100),
    pointer: 7,
    device: 1,
    position: Offset(120, 200),
    kind: PointerDeviceKind.touch,
    pressure: 0.6,
    pressureMin: 0.0,
    pressureMax: 1.0,
    radiusMajor: 12,
    radiusMinor: 10,
    orientation: 0.2,
    tilt: 0.1,
  );
  final pMove = const PointerMoveEvent(
    timeStamp: Duration(milliseconds: 116),
    pointer: 7,
    device: 1,
    position: Offset(132, 204),
    delta: Offset(12, 4),
    kind: PointerDeviceKind.touch,
    pressure: 0.65,
  );
  final pUp = const PointerUpEvent(
    timeStamp: Duration(milliseconds: 240),
    pointer: 7,
    device: 1,
    position: Offset(180, 220),
    kind: PointerDeviceKind.touch,
    pressure: 0.0,
  );
  final pHover = const PointerHoverEvent(
    timeStamp: Duration(milliseconds: 8),
    pointer: 0,
    device: 2,
    position: Offset(300, 80),
    delta: Offset(4, 2),
    kind: PointerDeviceKind.mouse,
  );
  final pCancel = const PointerCancelEvent(
    timeStamp: Duration(milliseconds: 312),
    pointer: 7,
    device: 1,
    position: Offset(180, 220),
    kind: PointerDeviceKind.touch,
  );

  final pointerSpecs = <_PointerSpec>[
    const _PointerSpec(
      name: 'PointerDownEvent',
      role: 'finger landed',
      story: 'Carries initial pressure, pointer id, and device kind. '
          'Recognizers route this through GestureBinding to compete.',
      color: Color(0xFF1F6FEB),
      icon: Icons.touch_app,
    ),
    const _PointerSpec(
      name: 'PointerMoveEvent',
      role: 'finger moving (pressed)',
      story: 'Carries `delta` (since last move). Drives drag-update '
          'recognition and force-press normalization.',
      color: Color(0xFF7C5CFF),
      icon: Icons.swipe,
    ),
    const _PointerSpec(
      name: 'PointerUpEvent',
      role: 'finger lifted',
      story: 'pressure defaults to 0.0 but can be non-zero on some '
          'platforms — see Flutter issue #31340.',
      color: Color(0xFF1F9F73),
      icon: Icons.touch_app_outlined,
    ),
    const _PointerSpec(
      name: 'PointerHoverEvent',
      role: 'mouse/stylus moved (no buttons)',
      story: 'No buttons pressed; carries `delta`. Recognizers usually '
          'ignore it but it drives MouseRegion and hover effects.',
      color: Color(0xFFCC6F1F),
      icon: Icons.mouse,
    ),
    const _PointerSpec(
      name: 'PointerCancelEvent',
      role: 'gesture interrupted',
      story: 'Platform took the gesture away (e.g. system alert, '
          'multitouch eviction). Recognizers MUST clean up.',
      color: Color(0xFFB02050),
      icon: Icons.cancel,
    ),
  ];

  print('  PointerDownEvent: position=${pDown.position} pressure=${pDown.pressure}'
      ' pointer=${pDown.pointer} kind=${pDown.kind} buttons=${pDown.buttons}'
      ' radiusMajor=${pDown.radiusMajor} orientation=${pDown.orientation}');
  print('  PointerMoveEvent: position=${pMove.position} delta=${pMove.delta} '
      'pressure=${pMove.pressure} kind=${pMove.kind}');
  print('  PointerUpEvent: position=${pUp.position} pressure=${pUp.pressure} '
      'kind=${pUp.kind}');
  print('  PointerHoverEvent: position=${pHover.position} delta=${pHover.delta}'
      ' kind=${pHover.kind} buttons=${pHover.buttons}');
  print('  PointerCancelEvent: position=${pCancel.position} kind=${pCancel.kind}');

  Widget pointerSpecCard(int idx, _PointerSpec spec, String fieldsSummary) {
    return Container(
      width: 260,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: spec.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: spec.color.withOpacity(0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(spec.icon, color: spec.color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  spec.name,
                  style: TextStyle(
                    color: spec.color,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: spec.color,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '$idx',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(spec.role,
              style: TextStyle(
                  color: spec.color, fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 4),
          Text(spec.story,
              style: const TextStyle(fontSize: 11, color: Color(0xFF40404A))),
          const SizedBox(height: 8),
          Text(fieldsSummary,
              style: const TextStyle(
                  fontSize: 10, fontFamily: 'monospace', color: Color(0xFF333344))),
        ],
      ),
    );
  }

  final pointerCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 6 — PointerEvent family',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Raw envelopes pre-recognition. Each card shows one '
            'PointerEvent subclass and the actual field values from a '
            'sample instance.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: <Widget>[
              pointerSpecCard(0, pointerSpecs[0],
                  'position=${pDown.position}\n'
                  'pressure=${pDown.pressure} pmin=${pDown.pressureMin} '
                  'pmax=${pDown.pressureMax}\n'
                  'radiusMajor=${pDown.radiusMajor} '
                  'radiusMinor=${pDown.radiusMinor}\n'
                  'orientation=${pDown.orientation} tilt=${pDown.tilt}\n'
                  'pointer=${pDown.pointer} device=${pDown.device} '
                  'kind=${pDown.kind}\n'
                  'buttons=${pDown.buttons} ts=${pDown.timeStamp}'),
              pointerSpecCard(1, pointerSpecs[1],
                  'position=${pMove.position}\n'
                  'delta=${pMove.delta}\n'
                  'pressure=${pMove.pressure}\n'
                  'pointer=${pMove.pointer} device=${pMove.device} '
                  'kind=${pMove.kind}\n'
                  'ts=${pMove.timeStamp}'),
              pointerSpecCard(2, pointerSpecs[2],
                  'position=${pUp.position}\n'
                  'pressure=${pUp.pressure}\n'
                  'pointer=${pUp.pointer} device=${pUp.device} '
                  'kind=${pUp.kind}\n'
                  'ts=${pUp.timeStamp}'),
              pointerSpecCard(3, pointerSpecs[3],
                  'position=${pHover.position}\n'
                  'delta=${pHover.delta}\n'
                  'buttons=${pHover.buttons} (no buttons pressed)\n'
                  'pointer=${pHover.pointer} device=${pHover.device} '
                  'kind=${pHover.kind}\n'
                  'ts=${pHover.timeStamp}'),
              pointerSpecCard(4, pointerSpecs[4],
                  'position=${pCancel.position}\n'
                  'pointer=${pCancel.pointer} device=${pCancel.device} '
                  'kind=${pCancel.kind}\n'
                  'ts=${pCancel.timeStamp}'),
            ],
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 7 — PointerDeviceKind catalog
  // ---------------------------------------------------------------------------
  // The PointerDeviceKind enum. Touch / mouse / stylus / invertedStylus /
  // trackpad / unknown. Every Tap/Drag/Scale Start record can carry one of
  // these (mostly nullable). Stylus + invertedStylus is the eraser-end of a
  // capacitive pen; trackpad is reserved for macOS trackpad gestures that
  // never produce on-screen pointers.
  // ===========================================================================
  print('--- SECTION 7: PointerDeviceKind catalog ---');

  final kindRows = <_KindRow>[
    const _KindRow(
      kind: PointerDeviceKind.touch,
      story: 'Capacitive touch (finger). Most common on phones and tablets.',
      icon: Icons.touch_app,
      tint: Color(0xFF1F6FEB),
    ),
    const _KindRow(
      kind: PointerDeviceKind.mouse,
      story: 'Mouse cursor. Reports buttons and hover events.',
      icon: Icons.mouse,
      tint: Color(0xFF7C5CFF),
    ),
    const _KindRow(
      kind: PointerDeviceKind.stylus,
      story: 'Active stylus tip. Reports pressure, tilt, orientation.',
      icon: Icons.edit,
      tint: Color(0xFF1F9F73),
    ),
    const _KindRow(
      kind: PointerDeviceKind.invertedStylus,
      story: 'Eraser-end of an active stylus (Apple Pencil reverse-grip).',
      icon: Icons.delete_outline,
      tint: Color(0xFFCC6F1F),
    ),
    const _KindRow(
      kind: PointerDeviceKind.trackpad,
      story: 'macOS trackpad gesture without an on-screen pointer. '
          'Scale-start events use this kind for trackpad pinch.',
      icon: Icons.touch_app_outlined,
      tint: Color(0xFFB02050),
    ),
    const _KindRow(
      kind: PointerDeviceKind.unknown,
      story: 'Platform did not report a device kind.',
      icon: Icons.help_outline,
      tint: Color(0xFF555770),
    ),
  ];

  for (int i = 0; i < kindRows.length; i++) {
    final k = kindRows[i];
    print('  PointerDeviceKind.${k.kind.name}: ${k.story}');
  }

  Widget kindRow(_KindRow k) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: k.tint.withOpacity(0.07),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: k.tint.withOpacity(0.35), width: 1),
      ),
      child: Row(
        children: <Widget>[
          Icon(k.icon, color: k.tint, size: 20),
          const SizedBox(width: 8),
          SizedBox(
            width: 160,
            child: Text(
              'PointerDeviceKind.${k.kind.name}',
              style: TextStyle(
                color: k.tint,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              k.story,
              style: const TextStyle(fontSize: 12, color: Color(0xFF40404A)),
            ),
          ),
        ],
      ),
    );
  }

  final pointerKindCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 7 — PointerDeviceKind catalog',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Every gesture details record (except DragDownDetails) can '
            'carry a PointerDeviceKind. Six values total.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 8),
          for (int i = 0; i < kindRows.length; i++) kindRow(kindRows[i]),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 8 — Velocity and OffsetPair reference
  // ---------------------------------------------------------------------------
  //   Velocity:
  //     pixelsPerSecond : Offset   — the only field; everything else is
  //                                  derived (`Velocity.zero`, `-v`, `a - b`).
  //   OffsetPair:
  //     local  : Offset
  //     global : Offset
  //     Factory: OffsetPair.fromEventPosition(PointerEvent)
  //              OffsetPair.fromEventDelta(PointerEvent)
  //     Const : OffsetPair.zero (both Offset.zero)
  // OffsetPair is used internally by drag recognizers to track per-event
  // (local, global) positions and accumulated delta.
  // ===========================================================================
  print('--- SECTION 8: Velocity and OffsetPair reference ---');

  final velSamples = <_VelocitySample>[
    const _VelocitySample(
      label: 'flick right',
      pxPerSec: Offset(1200, 0),
      story: '1200 px/s along +x (a hard rightward flick).',
      tint: Color(0xFF1F6FEB),
    ),
    const _VelocitySample(
      label: 'fling up',
      pxPerSec: Offset(0, -1500),
      story: '−1500 px/s along y (upward fling).',
      tint: Color(0xFF7C5CFF),
    ),
    const _VelocitySample(
      label: 'diagonal',
      pxPerSec: Offset(600, 400),
      story: '600 px/s east + 400 px/s south.',
      tint: Color(0xFF1F9F73),
    ),
    const _VelocitySample(
      label: 'gentle drift',
      pxPerSec: Offset(40, -20),
      story: 'Slow drift; well below most fling thresholds (~50 px/s).',
      tint: Color(0xFFCC6F1F),
    ),
    const _VelocitySample(
      label: 'still',
      pxPerSec: Offset.zero,
      story: 'Velocity.zero — used as the default in many details records.',
      tint: Color(0xFF555770),
    ),
    const _VelocitySample(
      label: 'fast left',
      pxPerSec: Offset(-2400, 0),
      story: '−2400 px/s along x — well past most fling thresholds.',
      tint: Color(0xFFB02050),
    ),
  ];

  final velocities = <Velocity>[];
  for (int i = 0; i < velSamples.length; i++) {
    final v = Velocity(pixelsPerSecond: velSamples[i].pxPerSec);
    velocities.add(v);
    print('  Velocity[$i] ${velSamples[i].label}: '
        'pixelsPerSecond=${v.pixelsPerSecond}');
  }

  // Velocity arithmetic showcase. Velocity supports unary negation,
  // subtraction (Velocity - Velocity), and the special clamp-magnitude method.
  final velA = const Velocity(pixelsPerSecond: Offset(800, 200));
  final velB = const Velocity(pixelsPerSecond: Offset(200, 100));
  final velNeg = -velA;
  final velDiff = velA - velB;
  final velZero = Velocity.zero;
  print('  Velocity arithmetic: -velA=${velNeg.pixelsPerSecond} '
      'velA-velB=${velDiff.pixelsPerSecond} '
      'Velocity.zero=${velZero.pixelsPerSecond}');

  final offsetPairSamples = <_OffsetPairSample>[
    const _OffsetPairSample(
      label: 'screen-origin landing',
      local: Offset(0, 0),
      global: Offset(0, 0),
      story: 'A pointer at the screen origin in both coordinate systems.',
      tint: Color(0xFF555770),
    ),
    const _OffsetPairSample(
      label: 'nested widget tap',
      local: Offset(20, 16),
      global: Offset(180, 244),
      story: 'Inside a deeply nested widget; local differs from global by '
          'the widget origin offset (160, 228).',
      tint: Color(0xFF1F6FEB),
    ),
    const _OffsetPairSample(
      label: 'edge of screen',
      local: Offset(8, 412),
      global: Offset(8, 412),
      story: 'Pointer at the bottom-left edge; no nesting → local==global.',
      tint: Color(0xFF7C5CFF),
    ),
    const _OffsetPairSample(
      label: 'transformed (scaled)',
      local: Offset(60, 40),
      global: Offset(120, 80),
      story: 'A scale-2x transform between the screen and the widget '
          'doubles global vs local.',
      tint: Color(0xFF1F9F73),
    ),
    const _OffsetPairSample(
      label: 'delta accumulator',
      local: Offset(14, 0),
      global: Offset(14, 0),
      story: 'Used as a per-event delta; the values are increments, not '
          'absolute positions.',
      tint: Color(0xFFCC6F1F),
    ),
    const _OffsetPairSample(
      label: 'OffsetPair.zero',
      local: Offset(0, 0),
      global: Offset(0, 0),
      story: 'The canonical zero pair (both Offset.zero).',
      tint: Color(0xFFB02050),
    ),
  ];

  final offsetPairs = <OffsetPair>[];
  for (int i = 0; i < offsetPairSamples.length; i++) {
    final s = offsetPairSamples[i];
    final pair = OffsetPair(local: s.local, global: s.global);
    offsetPairs.add(pair);
    print('  OffsetPair[$i] ${s.label}: '
        'local=${pair.local} global=${pair.global}');
  }

  // OffsetPair has + and - operators (component-wise).
  final pairSum = offsetPairs[1] + offsetPairs[2];
  final pairDiff = offsetPairs[3] - offsetPairs[4];
  print('  OffsetPair arithmetic: nested+edge='
      'local=${pairSum.local} global=${pairSum.global} '
      'transformed-delta='
      'local=${pairDiff.local} global=${pairDiff.global}');

  // OffsetPair.fromEventPosition — exercise the factory.
  final pairFromDown = OffsetPair.fromEventPosition(pDown);
  final pairFromHover = OffsetPair.fromEventPosition(pHover);
  final pairDeltaFromMove = OffsetPair.fromEventDelta(pMove);
  print('  OffsetPair.fromEventPosition(down):  '
      'local=${pairFromDown.local} global=${pairFromDown.global}');
  print('  OffsetPair.fromEventPosition(hover): '
      'local=${pairFromHover.local} global=${pairFromHover.global}');
  print('  OffsetPair.fromEventDelta(move):     '
      'local=${pairDeltaFromMove.local} global=${pairDeltaFromMove.global}');

  Widget velocityCard(int i, _VelocitySample s) {
    return Container(
      width: 220,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: s.tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: s.tint.withOpacity(0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: s.tint,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '$i',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  s.label,
                  style: TextStyle(
                    color: s.tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'pixelsPerSecond=${s.pxPerSec.dx.toStringAsFixed(0)},'
            '${s.pxPerSec.dy.toStringAsFixed(0)}',
            style: const TextStyle(
                fontSize: 11, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 4),
          Text(
            s.story,
            style: const TextStyle(
                fontSize: 11, color: Color(0xFF40404A)),
          ),
        ],
      ),
    );
  }

  Widget offsetPairCard(int i, _OffsetPairSample s) {
    return Container(
      width: 240,
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: s.tint.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: s.tint.withOpacity(0.45), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: s.tint,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  '$i',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  s.label,
                  style: TextStyle(
                    color: s.tint,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'local =${s.local.dx.toStringAsFixed(0)},'
            '${s.local.dy.toStringAsFixed(0)}',
            style: const TextStyle(
                fontSize: 11, fontFamily: 'monospace'),
          ),
          Text(
            'global=${s.global.dx.toStringAsFixed(0)},'
            '${s.global.dy.toStringAsFixed(0)}',
            style: const TextStyle(
                fontSize: 11, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 4),
          Text(
            s.story,
            style: const TextStyle(
                fontSize: 11, color: Color(0xFF40404A)),
          ),
        ],
      ),
    );
  }

  final velocityCardWidget = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 8a — Velocity reference',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Velocity wraps a single Offset (pixelsPerSecond). It is the '
            'value carried by DragEndDetails.velocity, '
            'LongPressEndDetails.velocity and ScaleEndDetails.velocity.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: <Widget>[
              for (int i = 0; i < velSamples.length; i++)
                velocityCard(i, velSamples[i]),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Velocity arithmetic — Velocity supports unary `-` and binary '
            '`-` (yielding another Velocity). There is also a clampMagnitude '
            'helper available on Velocity itself.',
            style: TextStyle(fontSize: 12, color: Color(0xFF505060)),
          ),
          Text(
            '  velA = ${velA.pixelsPerSecond}\n'
            '  velB = ${velB.pixelsPerSecond}\n'
            '  -velA = ${velNeg.pixelsPerSecond}\n'
            '  velA - velB = ${velDiff.pixelsPerSecond}\n'
            '  Velocity.zero = ${velZero.pixelsPerSecond}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: CustomPaint(
              painter: _VelocityArrowPainter(velSamples),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    ),
  );

  final offsetPairCardWidget = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 8b — OffsetPair reference',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'OffsetPair bundles a (local, global) pair. Recognizer internals '
            'use it to track event positions across frames. Two named '
            'factories convert directly from a PointerEvent.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: <Widget>[
              for (int i = 0; i < offsetPairSamples.length; i++)
                offsetPairCard(i, offsetPairSamples[i]),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Factory results from real PointerEvent values (constructed in '
            'Section 6):',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600,
                color: Color(0xFF40404A)),
          ),
          Text(
            '  fromEventPosition(pDown):  local=${pairFromDown.local}  '
            'global=${pairFromDown.global}\n'
            '  fromEventPosition(pHover): local=${pairFromHover.local}  '
            'global=${pairFromHover.global}\n'
            '  fromEventDelta(pMove):     local=${pairDeltaFromMove.local}  '
            'global=${pairDeltaFromMove.global}',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 8),
          const Text(
            'OffsetPair arithmetic (component-wise on both local and global):',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600,
                color: Color(0xFF40404A)),
          ),
          Text(
            '  pair[1] + pair[2] = (local=${pairSum.local}, '
            'global=${pairSum.global})\n'
            '  pair[3] - pair[4] = (local=${pairDiff.local}, '
            'global=${pairDiff.global})',
            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ],
      ),
    ),
  );

  // ===========================================================================
  // SECTION 9 — Callback signature wiring (no-op closures only)
  // ---------------------------------------------------------------------------
  // For completeness: a GestureDetector wires each of these details classes
  // to a typed callback. We declare them all as no-op closures so the demo
  // demonstrates the *types* without ever firing. This catches callback-type
  // changes at AST parse time.
  // ===========================================================================
  print('--- SECTION 9: GestureDetector callback wiring (no-op) ---');

  void onTapDown(TapDownDetails d) {}
  void onTapUp(TapUpDetails d) {}
  void onLPStart(LongPressStartDetails d) {}
  void onLPMove(LongPressMoveUpdateDetails d) {}
  void onLPEnd(LongPressEndDetails d) {}
  void onForce(ForcePressDetails d) {}
  void onDragDown(DragDownDetails d) {}
  void onDragStart(DragStartDetails d) {}
  void onDragUpdate(DragUpdateDetails d) {}
  void onDragEnd(DragEndDetails d) {}
  void onScaleStart(ScaleStartDetails d) {}
  void onScaleUpdate(ScaleUpdateDetails d) {}
  void onScaleEnd(ScaleEndDetails d) {}

  print('  onTapDown      : ${onTapDown.runtimeType}');
  print('  onTapUp        : ${onTapUp.runtimeType}');
  print('  onLPStart      : ${onLPStart.runtimeType}');
  print('  onLPMove       : ${onLPMove.runtimeType}');
  print('  onLPEnd        : ${onLPEnd.runtimeType}');
  print('  onForce        : ${onForce.runtimeType}');
  print('  onDragDown     : ${onDragDown.runtimeType}');
  print('  onDragStart    : ${onDragStart.runtimeType}');
  print('  onDragUpdate   : ${onDragUpdate.runtimeType}');
  print('  onDragEnd      : ${onDragEnd.runtimeType}');
  print('  onScaleStart   : ${onScaleStart.runtimeType}');
  print('  onScaleUpdate  : ${onScaleUpdate.runtimeType}');
  print('  onScaleEnd     : ${onScaleEnd.runtimeType}');

  // Construct a GestureDetector with every callback wired (still no-op).
  // It WILL never receive a real pointer because it's behind an
  // IgnorePointer, but the typed wiring is still validated by the parser.
  //
  // Note: Flutter's GestureDetector forbids combining onPan* and onScale*
  // callbacks on the same detector — scale subsumes pan, and Flutter's
  // `_debugCheckGestureArguments` asserts the two families are mutually
  // exclusive. The pan callback *types* (DragDownDetails, …) are still
  // exercised above via the unused closure declarations, so the typed
  // wiring is still validated even though they aren't passed to this
  // GestureDetector.
  final wiredDetector = IgnorePointer(
    ignoring: true,
    child: GestureDetector(
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onLongPressStart: onLPStart,
      onLongPressMoveUpdate: onLPMove,
      onLongPressEnd: onLPEnd,
      onForcePressStart: onForce,
      onForcePressEnd: onForce,
      onForcePressUpdate: onForce,
      onForcePressPeak: onForce,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0xFFEAF1FB),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF1F6FEB), width: 1),
        ),
        alignment: Alignment.center,
        child: const Text(
          'GestureDetector wired to tap/LP/force/scale (IgnorePointer; no-op)',
          style: TextStyle(
            color: Color(0xFF1F6FEB),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  final callbackCard = Card(
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Section 9 — Callback wiring',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          const Text(
            'Every details class above corresponds to a typed callback on '
            'GestureDetector. The wiring below uses no-op closures behind '
            'IgnorePointer so the callbacks never fire; their TYPES are '
            'still validated.',
            style: TextStyle(fontSize: 13, color: Color(0xFF505060)),
          ),
          const SizedBox(height: 10),
          wiredDetector,
        ],
      ),
    ),
  );

  // ===========================================================================
  // Final composition — single ListView containing every section card.
  // ===========================================================================
  print('--- composing final Scaffold ---');
  print('================================================================');
  print('=== tap_force_test.dart  — build() finished                    =');
  print('================================================================');

  return Scaffold(
    backgroundColor: const Color(0xFFF2F3F8),
    appBar: AppBar(
      title: const Text('Gesture details — deep visual demo'),
      backgroundColor: const Color(0xFF1F2A44),
      foregroundColor: Colors.white,
    ),
    body: ListView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2A44),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'tap_force_test.dart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'A hand-authored deep visual demo for every Flutter '
                'gesture-details record: TapDown/Up, ForcePress, '
                'LongPress*, Drag* (Down/Start/Update/End), Scale* '
                '(Start/Update/End), the PointerEvent family, '
                'PointerDeviceKind, Velocity, and OffsetPair.',
                style: TextStyle(
                  color: Color(0xFFD0D6E2),
                  fontSize: 13,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'No state, no animation controllers, no async. Every '
                'visual reads a const-constructed details record and '
                'turns its fields directly into widgets.',
                style: TextStyle(
                  color: Color(0xFF9FAAC2),
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        tapInventoryCard,
        forcePressCard,
        longPressCard,
        dragDetailsCard,
        scaleDetailsCard,
        pointerCard,
        pointerKindCard,
        velocityCardWidget,
        offsetPairCardWidget,
        callbackCard,
        const SizedBox(height: 24),
      ],
    ),
  );
}
