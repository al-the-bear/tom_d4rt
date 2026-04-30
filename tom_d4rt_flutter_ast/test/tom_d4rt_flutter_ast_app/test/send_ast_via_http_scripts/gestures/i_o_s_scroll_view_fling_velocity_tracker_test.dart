// ignore_for_file: avoid_print
// D4rt test script: Deep demo of IOSScrollViewFlingVelocityTracker from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Theme: Cerulean / Sky ──────────────────────────────────────
  const ivPrimary = Color(0xFF0277BD);
  const ivSecondary = Color(0xFF0288D1);
  const ivAccent = Color(0xFF4FC3F7);
  const ivSurface = Color(0xFFE1F5FE);
  const ivDark = Color(0xFF01579B);
  final ivDarkened = Color.lerp(ivPrimary, Colors.black, 0.3)!;

  // ── 1. Creating the tracker ───────────────────────────────────
  print('=== IOSScrollViewFlingVelocityTracker Deep Demo ===');
  final touchTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('Created tracker with PointerDeviceKind.touch');
  print('  runtimeType: ${touchTracker.runtimeType}');

  // ── 2. Simulating vertical scroll ─────────────────────────────
  print('\nSimulating vertical scroll (5 samples):');
  final positions = <(Duration, Offset)>[
    (Duration.zero, Offset.zero),
    (const Duration(milliseconds: 16), const Offset(0, 15)),
    (const Duration(milliseconds: 32), const Offset(0, 35)),
    (const Duration(milliseconds: 48), const Offset(0, 60)),
    (const Duration(milliseconds: 64), const Offset(0, 90)),
  ];
  for (final entry in positions) {
    touchTracker.addPosition(entry.$1, entry.$2);
    print('  t=${entry.$1.inMilliseconds}ms -> ${entry.$2}');
  }

  // ── 3. Velocity estimate ──────────────────────────────────────
  final estimate = touchTracker.getVelocityEstimate();
  print('\nVelocity estimate:');
  print('  pixelsPerSecond: ${estimate.pixelsPerSecond}');
  print('  confidence: ${estimate.confidence}');
  print('  duration: ${estimate.duration}');
  print('  offset: ${estimate.offset}');

  // ── 4. Velocity result ────────────────────────────────────────
  final velocity = touchTracker.getVelocity();
  print('\nVelocity result:');
  print('  pixelsPerSecond: ${velocity.pixelsPerSecond}');

  // ── 5. Mouse pointer tracker ──────────────────────────────────
  final mouseTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.mouse);
  mouseTracker.addPosition(Duration.zero, Offset.zero);
  mouseTracker.addPosition(const Duration(milliseconds: 16), const Offset(30, 0));
  mouseTracker.addPosition(const Duration(milliseconds: 32), const Offset(70, 0));
  mouseTracker.addPosition(const Duration(milliseconds: 48), const Offset(120, 0));
  final mouseVel = mouseTracker.getVelocity();
  print('\nMouse horizontal scroll:');
  print('  velocity: ${mouseVel.pixelsPerSecond}');

  // ── 6. Stylus pointer tracker ─────────────────────────────────
  final stylusTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.stylus);
  stylusTracker.addPosition(Duration.zero, Offset.zero);
  stylusTracker.addPosition(const Duration(milliseconds: 16), const Offset(10, 10));
  stylusTracker.addPosition(const Duration(milliseconds: 32), const Offset(25, 25));
  stylusTracker.addPosition(const Duration(milliseconds: 48), const Offset(45, 45));
  final stylusVel = stylusTracker.getVelocity();
  print('\nStylus diagonal scroll:');
  print('  velocity: ${stylusVel.pixelsPerSecond}');

  // ── 7. Compare with regular VelocityTracker ───────────────────
  final regularTracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  for (final entry in positions) {
    regularTracker.addPosition(entry.$1, entry.$2);
  }
  final regularVel = regularTracker.getVelocity();
  print('\nRegular VelocityTracker comparison:');
  print('  regular velocity: ${regularVel.pixelsPerSecond}');
  print('  iOS velocity: ${velocity.pixelsPerSecond}');
  print('  regular type: ${regularTracker.runtimeType}');
  print('  iOS type: ${touchTracker.runtimeType}');

  // ── 8. Rapid fling simulation ─────────────────────────────────
  final flingTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('\nRapid fling simulation (8 samples):');
  for (var i = 0; i < 8; i++) {
    final t = Duration(milliseconds: i * 8);
    final y = (i * i * 5).toDouble();
    flingTracker.addPosition(t, Offset(0, y));
    print('  t=${t.inMilliseconds}ms -> y=$y');
  }
  final flingVel = flingTracker.getVelocity();
  final flingEstimate = flingTracker.getVelocityEstimate();
  print('  fling velocity: ${flingVel.pixelsPerSecond}');
  print('  fling confidence: ${flingEstimate.confidence}');

  // ── 9. Slow scroll simulation ─────────────────────────────────
  final slowTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('\nSlow scroll simulation:');
  slowTracker.addPosition(Duration.zero, Offset.zero);
  slowTracker.addPosition(const Duration(milliseconds: 50), const Offset(0, 2));
  slowTracker.addPosition(const Duration(milliseconds: 100), const Offset(0, 5));
  slowTracker.addPosition(const Duration(milliseconds: 150), const Offset(0, 7));
  final slowVel = slowTracker.getVelocity();
  print('  slow velocity: ${slowVel.pixelsPerSecond}');

  // ── 10. PointerDeviceKind coverage ────────────────────────────
  print('\nPointerDeviceKind coverage:');
  for (final kind in PointerDeviceKind.values) {
    final tracker = IOSScrollViewFlingVelocityTracker(kind);
    tracker.addPosition(Duration.zero, Offset.zero);
    tracker.addPosition(const Duration(milliseconds: 16), const Offset(10, 10));
    print('  ${kind.name}: vel=${tracker.getVelocity().pixelsPerSecond}');
  }

  // ── 11. Inheritance chain ─────────────────────────────────────
  print('\nInheritance:');
  print('  IOSScrollViewFlingVelocityTracker extends VelocityTracker');
  print('  Overrides getVelocityEstimate() for iOS-like physics');
  print('  Uses weighted polynomial regression');

  // ── 12. Sample count behavior ─────────────────────────────────
  final manyTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('\nAdding 20 samples to test iOS sample window:');
  for (var i = 0; i < 20; i++) {
    manyTracker.addPosition(
      Duration(milliseconds: i * 16),
      Offset(0, i * 8.0),
    );
  }
  final manyVel = manyTracker.getVelocity();
  print('  20-sample velocity: ${manyVel.pixelsPerSecond}');

  // ── 13. Edge case: single sample ──────────────────────────────
  final singleTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  singleTracker.addPosition(Duration.zero, Offset.zero);
  final singleVel = singleTracker.getVelocity();
  print('\nSingle sample velocity: ${singleVel.pixelsPerSecond}');

  // ── 14. Edge case: two samples ────────────────────────────────
  final twoTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  twoTracker.addPosition(Duration.zero, Offset.zero);
  twoTracker.addPosition(const Duration(milliseconds: 16), const Offset(0, 100));
  final twoVel = twoTracker.getVelocity();
  print('Two sample velocity: ${twoVel.pixelsPerSecond}');

  // ── 15. Reverse scroll simulation ─────────────────────────────
  final reverseTracker = IOSScrollViewFlingVelocityTracker(PointerDeviceKind.touch);
  print('\nReverse scroll (upward):');
  reverseTracker.addPosition(Duration.zero, const Offset(0, 100));
  reverseTracker.addPosition(const Duration(milliseconds: 16), const Offset(0, 85));
  reverseTracker.addPosition(const Duration(milliseconds: 32), const Offset(0, 65));
  reverseTracker.addPosition(const Duration(milliseconds: 48), const Offset(0, 40));
  final reverseVel = reverseTracker.getVelocity();
  print('  reverse velocity: ${reverseVel.pixelsPerSecond}');

  // ── 16. Visual builder ────────────────────────────────────────
  print('\nIOSScrollViewFlingVelocityTracker deep demo completed');

  Widget ivVelocityBar(String label, Offset vel, Color barColor) {
    final magnitude = vel.distance.clamp(0, 3000);
    final fraction = magnitude / 3000;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 80, child: Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: ivDark))),
              Expanded(
                child: Container(
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: fraction,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                child: Text(magnitude.toStringAsFixed(0), style: TextStyle(fontSize: 10, color: Colors.grey[600])),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget ivInfoRow(String label, String value) {
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

  Widget ivStatChip(String label, String value, Color color) {
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
              colors: [ivPrimary, ivSecondary, ivAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: ivPrimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: Column(
            children: [
              const Icon(Icons.swipe, color: Colors.white, size: 36),
              const SizedBox(height: 8),
              const Text('IOSScrollViewFling\nVelocityTracker', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(
                'iOS UIScrollView fling physics for Flutter',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Stats ──
        Row(
          children: [
            Expanded(child: ivStatChip('Max Samples', '20', ivPrimary)),
            const SizedBox(width: 8),
            Expanded(child: ivStatChip('Kind Types', '${PointerDeviceKind.values.length}', ivSecondary)),
            const SizedBox(width: 8),
            Expanded(child: ivStatChip('Scenarios', '7', ivAccent)),
          ],
        ),
        const SizedBox(height: 16),

        // ── Velocity comparison bars ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: ivSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ivPrimary.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Velocity Comparisons', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ivDark)),
              const SizedBox(height: 10),
              ivVelocityBar('iOS Touch', velocity.pixelsPerSecond, ivPrimary),
              ivVelocityBar('Regular', regularVel.pixelsPerSecond, Colors.grey),
              ivVelocityBar('Mouse', mouseVel.pixelsPerSecond, const Color(0xFF43A047)),
              ivVelocityBar('Stylus', stylusVel.pixelsPerSecond, const Color(0xFFE65100)),
              ivVelocityBar('Fling', flingVel.pixelsPerSecond, const Color(0xFFC62828)),
              ivVelocityBar('Slow', slowVel.pixelsPerSecond, const Color(0xFF6A1B9A)),
              ivVelocityBar('Reverse', reverseVel.pixelsPerSecond, const Color(0xFF00695C)),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── iOS vs Regular comparison ──
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
              Text('iOS vs Regular Tracker', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ivDark)),
              const SizedBox(height: 8),
              ivInfoRow('iOS type', touchTracker.runtimeType.toString()),
              ivInfoRow('Regular type', regularTracker.runtimeType.toString()),
              ivInfoRow('iOS velocity', velocity.pixelsPerSecond.toString()),
              ivInfoRow('Regular velocity', regularVel.pixelsPerSecond.toString()),
              const Divider(height: 16),
              Text(
                'iOS tracker uses weighted polynomial regression with up to 20 samples, mimicking UIScrollView fling behavior',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Estimate details ──
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.analytics, color: Colors.amber, size: 18),
                    const SizedBox(width: 8),
                    Text('Velocity Estimate', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                  ],
                ),
                const SizedBox(height: 8),
                ivInfoRow('pixelsPerSecond', estimate.pixelsPerSecond.toString()),
                ivInfoRow('confidence', estimate.confidence.toStringAsFixed(4)),
                ivInfoRow('duration', estimate.duration.toString()),
                ivInfoRow('offset', estimate.offset.toString()),
              ],
            ),
          ),
        const SizedBox(height: 16),

        // ── Device kind grid ──
        Text('PointerDeviceKind Coverage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ivDarkened)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: PointerDeviceKind.values.map((kind) {
            final kindIcons = {
              PointerDeviceKind.touch: Icons.touch_app,
              PointerDeviceKind.mouse: Icons.mouse,
              PointerDeviceKind.stylus: Icons.edit,
              PointerDeviceKind.invertedStylus: Icons.edit_off,
              PointerDeviceKind.trackpad: Icons.gamepad,
              PointerDeviceKind.unknown: Icons.help_outline,
            };
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ivPrimary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ivPrimary.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(kindIcons[kind] ?? Icons.help, size: 16, color: ivPrimary),
                  const SizedBox(width: 6),
                  Text(kind.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ivDark)),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // ── Edge cases ──
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange[800], size: 18),
                  const SizedBox(width: 8),
                  Text('Edge Cases', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange[900])),
                ],
              ),
              const SizedBox(height: 8),
              ivInfoRow('1 sample vel', singleVel.pixelsPerSecond.toString()),
              ivInfoRow('2 sample vel', twoVel.pixelsPerSecond.toString()),
              ivInfoRow('20 sample vel', manyVel.pixelsPerSecond.toString()),
              ivInfoRow('Reverse vel', reverseVel.pixelsPerSecond.toString()),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ── Footer ──
        Center(
          child: Text(
            'IOSScrollViewFlingVelocityTracker — iOS UIScrollView physics | weighted regression',
            style: TextStyle(fontSize: 10, color: ivDark.withValues(alpha: 0.5)),
          ),
        ),
      ],
    ),
  );
}
