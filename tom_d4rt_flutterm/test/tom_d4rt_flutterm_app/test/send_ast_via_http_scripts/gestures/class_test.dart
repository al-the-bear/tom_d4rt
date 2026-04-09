// ignore_for_file: avoid_print
// D4rt test script: Deep demo of gestures package classes
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Theme: Plum / Mauve ────────────────────────────────────────
  const gcPrimary = Color(0xFF7B1FA2);
  const gcSecondary = Color(0xFF9C27B0);
  const gcAccent = Color(0xFFCE93D8);
  const gcSurface = Color(0xFFF3E5F5);
  const gcDark = Color(0xFF4A148C);
  final gcDarkened = Color.lerp(gcPrimary, Colors.black, 0.3)!;

  // ── 1. DragDownDetails ────────────────────────────────────────
  print('=== Gestures Classes Deep Demo ===');
  final ddd = DragDownDetails(globalPosition: const Offset(100, 200));
  print('DragDownDetails:');
  print('  globalPosition: ${ddd.globalPosition}');
  print('  localPosition: ${ddd.localPosition}');

  // ── 2. DragStartDetails ───────────────────────────────────────
  final dsd = DragStartDetails(
    globalPosition: const Offset(50, 60),
    localPosition: const Offset(25, 30),
    sourceTimeStamp: const Duration(milliseconds: 100),
  );
  print('\nDragStartDetails:');
  print('  globalPosition: ${dsd.globalPosition}');
  print('  localPosition: ${dsd.localPosition}');
  print('  sourceTimeStamp: ${dsd.sourceTimeStamp}');

  // ── 3. DragUpdateDetails ──────────────────────────────────────
  final dud = DragUpdateDetails(
    globalPosition: const Offset(150, 250),
    delta: const Offset(5, 10),
    localPosition: const Offset(75, 125),
    sourceTimeStamp: const Duration(milliseconds: 200),
  );
  print('\nDragUpdateDetails:');
  print('  globalPosition: ${dud.globalPosition}');
  print('  delta: ${dud.delta}');
  print('  localPosition: ${dud.localPosition}');
  print('  primaryDelta: ${dud.primaryDelta}');
  print('  sourceTimeStamp: ${dud.sourceTimeStamp}');

  // ── 4. DragEndDetails ─────────────────────────────────────────
  final ded = DragEndDetails(
    velocity: const Velocity(pixelsPerSecond: Offset(300, 400)),
    primaryVelocity: 300.0,
  );
  print('\nDragEndDetails:');
  print('  velocity: ${ded.velocity}');
  print('  primaryVelocity: ${ded.primaryVelocity}');
  print('  pixelsPerSecond: ${ded.velocity.pixelsPerSecond}');

  // ── 5. Velocity class ─────────────────────────────────────────
  const vel1 = Velocity(pixelsPerSecond: Offset(300, 400));
  const vel2 = Velocity(pixelsPerSecond: Offset(-100, 200));
  final combined = vel1 + vel2;
  final negated = -vel1;
  final clamped = vel1.clampMagnitude(0, 100);
  print('\nVelocity:');
  print('  vel1: ${vel1.pixelsPerSecond}');
  print('  vel2: ${vel2.pixelsPerSecond}');
  print('  combined (vel1 + vel2): ${combined.pixelsPerSecond}');
  print('  negated (-vel1): ${negated.pixelsPerSecond}');
  print('  clamped (0..100): ${clamped.pixelsPerSecond}');
  print('  vel1 == vel1: ${vel1 == vel1}');
  print('  Velocity.zero: ${Velocity.zero.pixelsPerSecond}');

  // ── 6. VelocityEstimate ───────────────────────────────────────
  const estimate = VelocityEstimate(
    pixelsPerSecond: Offset(500, 600),
    confidence: 0.95,
    duration: Duration(milliseconds: 64),
    offset: Offset(40, 50),
  );
  print('\nVelocityEstimate:');
  print('  pixelsPerSecond: ${estimate.pixelsPerSecond}');
  print('  confidence: ${estimate.confidence}');
  print('  duration: ${estimate.duration}');
  print('  offset: ${estimate.offset}');

  // ── 7. VelocityTracker ────────────────────────────────────────
  final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  tracker.addPosition(Duration.zero, Offset.zero);
  tracker.addPosition(const Duration(milliseconds: 16), const Offset(0, 10));
  tracker.addPosition(const Duration(milliseconds: 32), const Offset(0, 25));
  tracker.addPosition(const Duration(milliseconds: 48), const Offset(0, 50));
  final trackerVel = tracker.getVelocity();
  final trackerEstimate = tracker.getVelocityEstimate();
  print('\nVelocityTracker:');
  print('  runtimeType: ${tracker.runtimeType}');
  print('  velocity: ${trackerVel.pixelsPerSecond}');
  if (trackerEstimate != null) {
    print('  estimate confidence: ${trackerEstimate.confidence}');
  }

  // ── 8. GestureRecognizer types ────────────────────────────────
  final tap = TapGestureRecognizer();
  final longPress = LongPressGestureRecognizer();
  final doubleTap = DoubleTapGestureRecognizer();
  final horizontalDrag = HorizontalDragGestureRecognizer();
  final verticalDrag = VerticalDragGestureRecognizer();
  final pan = PanGestureRecognizer();
  final scale = ScaleGestureRecognizer();
  print('\nGestureRecognizer types:');
  print('  TapGestureRecognizer: ${tap.runtimeType}');
  print('  LongPressGestureRecognizer: ${longPress.runtimeType}');
  print('  DoubleTapGestureRecognizer: ${doubleTap.runtimeType}');
  print('  HorizontalDragGestureRecognizer: ${horizontalDrag.runtimeType}');
  print('  VerticalDragGestureRecognizer: ${verticalDrag.runtimeType}');
  print('  PanGestureRecognizer: ${pan.runtimeType}');
  print('  ScaleGestureRecognizer: ${scale.runtimeType}');
  tap.dispose();
  longPress.dispose();
  doubleTap.dispose();
  horizontalDrag.dispose();
  verticalDrag.dispose();
  pan.dispose();
  scale.dispose();

  // ── 9. ScaleStartDetails / ScaleUpdateDetails / ScaleEndDetails ─
  final ssd = ScaleStartDetails(focalPoint: const Offset(100, 100), localFocalPoint: const Offset(50, 50), pointerCount: 2);
  final sud = ScaleUpdateDetails(
    focalPoint: const Offset(110, 110),
    localFocalPoint: const Offset(55, 55),
    scale: 1.5,
    horizontalScale: 1.2,
    verticalScale: 1.8,
    rotation: 0.3,
    pointerCount: 2,
    focalPointDelta: const Offset(10, 10),
  );
  final sed = ScaleEndDetails(velocity: const Velocity(pixelsPerSecond: Offset(50, 50)), pointerCount: 2);
  print('\nScaleStartDetails: focalPoint=${ssd.focalPoint}, pointerCount=${ssd.pointerCount}');
  print('ScaleUpdateDetails: scale=${sud.scale}, rotation=${sud.rotation}');
  print('ScaleEndDetails: velocity=${sed.velocity}, pointerCount=${sed.pointerCount}');

  // ── 10. LongPressStartDetails / MoveUpdate / EndDetails ───────
  final lpsd = LongPressStartDetails(globalPosition: const Offset(80, 90), localPosition: const Offset(40, 45));
  final lpmu = LongPressMoveUpdateDetails(globalPosition: const Offset(85, 95), localPosition: const Offset(42, 48));
  final lped = LongPressEndDetails(globalPosition: const Offset(88, 98), localPosition: const Offset(44, 49));
  print('\nLongPress details:');
  print('  Start: globalPosition=${lpsd.globalPosition}');
  print('  Move: offsetFromOrigin=${lpmu.offsetFromOrigin}');
  print('  End: globalPosition=${lped.globalPosition}');

  // ── 11. TapDownDetails / TapUpDetails ─────────────────────────
  final tdd = TapDownDetails(globalPosition: const Offset(60, 70), localPosition: const Offset(30, 35), kind: PointerDeviceKind.touch);
  final tud = TapUpDetails(globalPosition: const Offset(61, 71), localPosition: const Offset(31, 36), kind: PointerDeviceKind.touch);
  print('\nTapDownDetails: pos=${tdd.globalPosition}, kind=${tdd.kind}');
  print('TapUpDetails: pos=${tud.globalPosition}, kind=${tud.kind}');

  // ── 12. PointerDeviceKind ─────────────────────────────────────
  print('\nPointerDeviceKind values:');
  for (final kind in PointerDeviceKind.values) {
    print('  ${kind.name} (index ${kind.index})');
  }

  // ── 13. GestureDisposition ────────────────────────────────────
  print('\nGestureDisposition values:');
  for (final d in GestureDisposition.values) {
    print('  ${d.name} (index ${d.index})');
  }

  // ── 14. DragStartBehavior ─────────────────────────────────────
  print('\nDragStartBehavior values:');
  for (final b in DragStartBehavior.values) {
    print('  ${b.name} (index ${b.index})');
  }

  // ── 15. ForcePressDetails ─────────────────────────────────────
  final fpd = ForcePressDetails(globalPosition: const Offset(120, 130), localPosition: const Offset(60, 65), pressure: 0.75);
  print('\nForcePressDetails:');
  print('  globalPosition: ${fpd.globalPosition}');
  print('  pressure: ${fpd.pressure}');

  // ── 16. Visual builder ────────────────────────────────────────
  print('\nGestures classes deep demo completed');

  final recognizerNames = [
    'TapGestureRecognizer',
    'LongPressGestureRecognizer',
    'DoubleTapGestureRecognizer',
    'HorizontalDragGestureRecognizer',
    'VerticalDragGestureRecognizer',
    'PanGestureRecognizer',
    'ScaleGestureRecognizer',
  ];

  final detailClasses = [
    ('DragDownDetails', 'globalPosition, localPosition'),
    ('DragStartDetails', 'globalPosition, localPosition, sourceTimeStamp'),
    ('DragUpdateDetails', 'globalPosition, delta, primaryDelta'),
    ('DragEndDetails', 'velocity, primaryVelocity'),
    ('ScaleStartDetails', 'focalPoint, pointerCount'),
    ('ScaleUpdateDetails', 'scale, rotation, focalPointDelta'),
    ('ScaleEndDetails', 'velocity, pointerCount'),
    ('LongPressStartDetails', 'globalPosition, localPosition'),
    ('LongPressMoveUpdateDetails', 'globalPosition, offsetFromOrigin'),
    ('LongPressEndDetails', 'globalPosition, localPosition'),
    ('TapDownDetails', 'globalPosition, kind'),
    ('TapUpDetails', 'globalPosition, kind'),
    ('ForcePressDetails', 'globalPosition, pressure'),
  ];

  Widget gcDetailCard(String name, String fields) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: gcAccent.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: gcSecondary, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: gcDark)),
                Text(fields, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget gcRecognizerChip(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: gcPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gcPrimary.withValues(alpha: 0.3)),
      ),
      child: Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: gcDark)),
    );
  }

  Widget gcInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: TextStyle(fontSize: 11, color: Colors.grey[600]))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget gcStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        ],
      ),
    );
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Header ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [gcPrimary, gcSecondary, gcAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: gcPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              const Icon(Icons.touch_app, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              const Text('Gestures Classes', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'Detail classes, recognizers, velocity & input tracking',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Stats ──
        Row(
          children: [
            Expanded(child: gcStatChip('Recognizers', '${recognizerNames.length}', gcPrimary)),
            const SizedBox(width: 8),
            Expanded(child: gcStatChip('Detail Classes', '${detailClasses.length}', gcSecondary)),
            const SizedBox(width: 8),
            Expanded(child: gcStatChip('Enums', '3', gcAccent)),
          ],
        ),
        const SizedBox(height: 16),

        // ── Velocity section ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: gcSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: gcPrimary.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Velocity Tracking', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: gcDark)),
              const SizedBox(height: 8),
              gcInfoRow('vel1', '${vel1.pixelsPerSecond}'),
              gcInfoRow('vel2', '${vel2.pixelsPerSecond}'),
              gcInfoRow('vel1 + vel2', '${combined.pixelsPerSecond}'),
              gcInfoRow('-vel1', '${negated.pixelsPerSecond}'),
              gcInfoRow('clamped(0,100)', '${clamped.pixelsPerSecond}'),
              const Divider(height: 12),
              gcInfoRow('Tracker velocity', '${trackerVel.pixelsPerSecond}'),
              gcInfoRow('Estimate conf.', trackerEstimate != null ? '${trackerEstimate.confidence}' : 'null'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Recognizers ──
        Text('Gesture Recognizers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: gcDarkened)),
        const SizedBox(height: 8),
        Wrap(children: recognizerNames.map(gcRecognizerChip).toList()),
        const SizedBox(height: 16),

        // ── Detail classes ──
        Text('Detail Classes', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: gcDarkened)),
        const SizedBox(height: 8),
        ...detailClasses.map((dc) => gcDetailCard(dc.$1, dc.$2)),
        const SizedBox(height: 16),

        // ── Enums section ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Related Enums', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: gcDark)),
              const SizedBox(height: 8),
              gcInfoRow('PointerDeviceKind', PointerDeviceKind.values.map((v) => v.name).join(', ')),
              gcInfoRow('GestureDisposition', GestureDisposition.values.map((v) => v.name).join(', ')),
              gcInfoRow('DragStartBehavior', DragStartBehavior.values.map((v) => v.name).join(', ')),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Scale details ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scale Gesture Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: gcDark)),
              const SizedBox(height: 8),
              gcInfoRow('Start focal', '${ssd.focalPoint}'),
              gcInfoRow('Start pointers', '${ssd.pointerCount}'),
              gcInfoRow('Update scale', '${sud.scale}'),
              gcInfoRow('Update rotation', sud.rotation.toStringAsFixed(2)),
              gcInfoRow('End velocity', sed.velocity.pixelsPerSecond.toString()),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Force press ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.compress, color: Colors.amber[800], size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ForcePressDetails', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Text('position: ${fpd.globalPosition} | pressure: ${fpd.pressure}', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Footer ──
        Center(
          child: Text(
            'Gestures — ${recognizerNames.length} recognizers | ${detailClasses.length} detail classes | 3 enums',
            style: TextStyle(fontSize: 10, color: gcDark.withValues(alpha: 0.5)),
          ),
        ),
      ],
    ),
  );
}
