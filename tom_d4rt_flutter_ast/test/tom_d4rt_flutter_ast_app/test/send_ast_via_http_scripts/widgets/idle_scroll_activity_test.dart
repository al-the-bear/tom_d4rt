// ignore_for_file: avoid_print
// IdleScrollActivity – comprehensive deep demo
// Indigo / Ice palette – the "do-nothing" scroll activity that holds
// a ScrollPosition stationary when no user interaction is happening.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── palette ───────────────────────────────────────────────────────────
  const Color iaIndigo = Color(0xFF283593);
  const Color iaIce = Color(0xFFE8EAF6);
  const Color iaOnIndigo = Color(0xFFFFFFFF);
  const Color iaDark = Color(0xFF001064);
  const Color iaLightIce = Color(0xFFF3F4FB);
  const Color iaTextDark = Color(0xFF131838);
  const Color iaAccent = Color(0xFF5C6BC0);
  const Color iaMuted = Color(0xFF9FA8DA);

  // ─── helpers ───────────────────────────────────────────────────────────
  Widget iaHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [iaIndigo, iaDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: iaOnIndigo)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: TextStyle(
                  fontSize: 12,
                  color: iaOnIndigo.withValues(alpha: 0.85))),
        ],
      ),
    );
  }

  Widget iaSection(String heading, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: iaLightIce,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: iaIndigo.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: iaIndigo.withValues(alpha: 0.07),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: iaIndigo)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children),
          ),
        ],
      ),
    );
  }

  Widget iaBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('▸ ',
              style: TextStyle(color: iaAccent, fontSize: 11)),
          Expanded(
            child: Text(text,
                style: const TextStyle(
                    fontSize: 12, color: iaTextDark, height: 1.4)),
          ),
        ],
      ),
    );
  }

  Widget iaCodeBlock(String code) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF0C1040),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(code,
          style: const TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: iaIce,
              height: 1.5)),
    );
  }

  Widget iaKeyValue(String key, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(key,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: iaDark)),
          ),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: iaTextDark)),
          ),
        ],
      ),
    );
  }

  Widget iaHighlight(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: iaAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: iaAccent.withValues(alpha: 0.2)),
      ),
      child: Text(text,
          style: const TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: iaDark,
              height: 1.4)),
    );
  }

  Widget iaDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Divider(color: iaMuted.withValues(alpha: 0.4), height: 1),
    );
  }

  Widget iaInfoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: iaIndigo.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(icon,
                style: const TextStyle(fontSize: 12, color: iaIndigo)),
          ),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: iaDark)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 11, color: iaTextDark)),
          ),
        ],
      ),
    );
  }

  Widget iaCompare(String label, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 4, right: 8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: iaIndigo,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: '$label: ',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: iaDark)),
                  TextSpan(
                      text: desc,
                      style: const TextStyle(
                          fontSize: 11, color: iaTextDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget iaStateRow(String state, String velocity, String scrolling,
      String pointer, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 80,
            child: Text(state,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color)),
          ),
          Expanded(
            child: Text('vel: $velocity  scroll: $scrolling  ptr: $pointer',
                style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: iaTextDark)),
          ),
        ],
      ),
    );
  }

  // ─── main layout ───────────────────────────────────────────────────────
  return Container(
    color: iaIce,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── header ──
          iaHeader(
            'IdleScrollActivity',
            'The "do-nothing" scroll activity – holds a ScrollPosition '
                'stationary when no scroll interaction or animation is active',
          ),

          // ── 1. class identity ──
          iaSection('1 · Class Identity & Purpose', [
            iaKeyValue('Class', 'IdleScrollActivity'),
            iaKeyValue('Extends', 'ScrollActivity'),
            iaKeyValue('Library', 'package:flutter/widgets.dart'),
            iaKeyValue('Purpose', 'Holds scroll position idle (no motion)'),
            iaDivider(),
            iaBullet(
                'IdleScrollActivity is the default scroll activity. When '
                'nothing is happening to a scrollable widget, it uses this '
                'activity to represent the "resting" state.'),
            iaBullet(
                'It returns velocity 0.0, isScrolling false, and '
                'shouldIgnorePointer false — signaling that the scroll '
                'view is completely at rest.'),
            iaBullet(
                'Every ScrollPosition starts with an IdleScrollActivity '
                'and returns to it after any interaction or animation ends.'),
          ]),

          // ── 2. scroll activity lifecycle ──
          iaSection('2 · Scroll Activity Lifecycle', [
            iaBullet('Phase 1: IDLE — IdleScrollActivity is active.'),
            iaBullet('Phase 2: DRAG — User touches and drags the scroll.'),
            iaBullet('Phase 3: BALLISTIC — Fling animation after release.'),
            iaBullet('Phase 4: IDLE — Animation ends, back to idle.'),
            iaDivider(),
            iaHighlight(
                'IdleScrollActivity bookends every scroll interaction. '
                'It is the starting state (before first touch) and the '
                'ending state (after all motion stops). A scrollable '
                'spends most of its lifetime in the idle state.'),
            iaCodeBlock(
                '// Lifecycle flow:\n'
                '// 1. ScrollPosition created\n'
                '//    → activity = IdleScrollActivity(this)\n'
                '//\n'
                '// 2. User touches and drags\n'
                '//    → activity = DragScrollActivity(this, ...)\n'
                '//\n'
                '// 3. User releases with velocity\n'
                '//    → activity = BallisticScrollActivity(this, ...)\n'
                '//\n'
                '// 4. Animation reaches final position\n'
                '//    → activity = IdleScrollActivity(this)'),
          ]),

          // ── 3. visual: activity state diagram ──
          iaSection('3 · Scroll Activity State Diagram', [
            iaStateRow('IDLE', '0.0', 'false', 'allow',
                const Color(0xFF283593)),
            iaStateRow('DRAG', 'user', 'true', 'varies',
                const Color(0xFFE65100)),
            iaStateRow('BALLISTIC', 'decaying', 'true', 'ignore',
                const Color(0xFF1B5E20)),
            iaStateRow('DRIVEN', 'animated', 'true', 'ignore',
                const Color(0xFF880E4F)),
            iaDivider(),
            iaBullet(
                'IDLE: velocity=0.0, not scrolling, pointer events allowed.'),
            iaBullet(
                'DRAG: velocity comes from user drag delta, scrolling=true.'),
            iaBullet(
                'BALLISTIC: velocity decays over time via simulation.'),
            iaBullet(
                'DRIVEN: velocity follows an AnimationController (animateTo).'),
          ]),

          // ── 4. fixed property values ──
          iaSection('4 · Fixed Property Values', [
            iaKeyValue('velocity', '0.0 (always — no motion)'),
            iaKeyValue('isScrolling', 'false (always — not active)'),
            iaKeyValue('shouldIgnorePointer',
                'false (always — allows taps in content)'),
            iaDivider(),
            iaCodeBlock(
                '// IdleScrollActivity always returns:\n'
                'class IdleScrollActivity extends ScrollActivity {\n'
                '  @override\n'
                '  double get velocity => 0.0;\n'
                '\n'
                '  @override\n'
                '  bool get isScrolling => false;\n'
                '\n'
                '  @override\n'
                '  bool get shouldIgnorePointer => false;\n'
                '}'),
            iaHighlight(
                'These three fixed values define what "idle" means: no speed, '
                'not scrolling, and pointer events pass through to content. '
                'This is the only activity where all three are simultaneously '
                'false/zero.'),
          ]),

          // ── 5. shouldIgnorePointer explained ──
          iaSection('5 · shouldIgnorePointer Explained', [
            iaBullet(
                'When shouldIgnorePointer is true, pointer events (taps, '
                'drags) in the scroll content are ignored. This prevents '
                'accidental taps during fast scrolling.'),
            iaBullet(
                'IdleScrollActivity returns FALSE — all pointer events '
                'pass through to the scrollable content normally.'),
            iaBullet(
                'BallisticScrollActivity typically returns TRUE during '
                'fast flings, preventing taps on moving content.'),
            iaDivider(),
            iaCodeBlock(
                '// How shouldIgnorePointer affects the widget tree:\n'
                '//\n'
                '// Scrollable\n'
                '//   └─ IgnorePointer(\n'
                '//        ignoring: activity.shouldIgnorePointer,\n'
                '//        child: scrollContent,\n'
                '//      )\n'
                '//\n'
                '// When idle:  ignoring = false → taps work\n'
                '// When fling: ignoring = true  → taps blocked'),
          ]),

          // ── 6. applyNewDimensions ──
          iaSection('6 · applyNewDimensions Behavior', [
            iaBullet(
                'When the scroll view dimensions change (layout update, '
                'content size change), applyNewDimensions() is called.'),
            iaBullet(
                'IdleScrollActivity responds by calling '
                'delegate.goBallistic(0.0) — which may trigger a new '
                'activity if the scroll position is out of bounds.'),
            iaCodeBlock(
                '// applyNewDimensions flow:\n'
                '@override\n'
                'void applyNewDimensions() {\n'
                '  delegate.goBallistic(0.0);\n'
                '  // velocity 0.0 → if in bounds, stays idle\n'
                '  // velocity 0.0 → if out of bounds, bounces back\n'
                '}\n'
                '\n'
                '// Scenario: content shrinks, scroll position exceeds\n'
                '// maxScrollExtent → goBallistic creates a new activity\n'
                '// to animate back to valid range.'),
            iaDivider(),
            iaHighlight(
                'This is the key behavior of IdleScrollActivity. When '
                'dimensions change, it does not simply stay put — it asks '
                'the delegate to re-evaluate whether the current position '
                'is still valid.'),
          ]),

          // ── 7. ScrollActivityDelegate ──
          iaSection('7 · ScrollActivityDelegate Interface', [
            iaBullet(
                'IdleScrollActivity requires a ScrollActivityDelegate, '
                'which is typically the ScrollPosition itself.'),
            iaCodeBlock(
                '// ScrollActivityDelegate methods:\n'
                'abstract class ScrollActivityDelegate {\n'
                '  AxisDirection get axisDirection;\n'
                '  double setPixels(double pixels);\n'
                '  void applyUserOffset(double delta);\n'
                '  void goIdle();       // → IdleScrollActivity\n'
                '  void goBallistic(double velocity);\n'
                '}\n'
                '\n'
                '// Creating an IdleScrollActivity:\n'
                '// final idle = IdleScrollActivity(delegate);'),
            iaDivider(),
            iaKeyValue('goIdle()', 'Creates new IdleScrollActivity'),
            iaKeyValue('goBallistic(v)',
                'Creates BallisticScrollActivity with velocity v'),
            iaKeyValue('setPixels(px)', 'Updates the scroll offset'),
            iaKeyValue('applyUserOffset(d)', 'Applies drag delta'),
          ]),

          // ── 8. comparison with other activities ──
          iaSection('8 · Comparison with All Scroll Activities', [
            iaCompare('IdleScrollActivity',
                'Resting state, vel=0, not scrolling, pointer allowed'),
            iaCompare('DragScrollActivity',
                'User dragging, vel=drag delta, scrolling=true'),
            iaCompare('BallisticScrollActivity',
                'Fling animation, decaying velocity, pointer may be ignored'),
            iaCompare('DrivenScrollActivity',
                'Programmatic animation (animateTo), controlled velocity'),
            iaCompare('HoldScrollActivity',
                'User touches during fling, cancels momentum'),
            iaDivider(),
            iaBullet(
                'HoldScrollActivity is similar to Idle but is used '
                'specifically when the user touches during a fling to '
                'stop the animation. It signals "intentional pause."'),
          ]),

          // ── 9. visual: scrollable widget stack ──
          iaSection('9 · Where IdleScrollActivity Fits', [
            iaCodeBlock(
                '// Widget tree for a scrollable:\n'
                '// ListView\n'
                '//   └─ Scrollable\n'
                '//        ├─ ScrollPosition (has current activity)\n'
                '//        │   └─ IdleScrollActivity (initial)\n'
                '//        ├─ Viewport\n'
                '//        │   └─ SliverList (children)\n'
                '//        └─ ScrollController (external handle)'),
            iaDivider(),
            iaBullet(
                'The ScrollPosition owns the current activity. Only one '
                'activity is active at a time.'),
            iaBullet(
                'When beginActivity(newActivity) is called, the old '
                'activity is disposed and the new one becomes current.'),
          ]),

          // ── 10. when idle is created ──
          iaSection('10 · When IdleScrollActivity Is Created', [
            iaInfoRow('1', 'Init:', 'ScrollPosition constructor'),
            iaInfoRow('2', 'Drag end:', 'User releases without momentum'),
            iaInfoRow('3', 'Fling end:', 'Ballistic animation completes'),
            iaInfoRow('4', 'animateTo end:', 'Driven animation completes'),
            iaInfoRow('5', 'jumpTo:', 'After instant position change'),
            iaInfoRow('6', 'goIdle():', 'Explicit idle request'),
            iaDivider(),
            iaBullet(
                'goIdle() on ScrollPosition creates a new '
                'IdleScrollActivity and sets it as the current activity.'),
            iaCodeBlock(
                '// ScrollPosition.goIdle:\n'
                'void goIdle() {\n'
                '  beginActivity(IdleScrollActivity(this));\n'
                '}'),
          ]),

          // ── 11. visual: scroll phases timeline ──
          iaSection('11 · Scroll Interaction Timeline', [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iaIndigo.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: iaIndigo.withValues(alpha: 0.12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(width: 60, height: 20, color: iaIndigo,
                          alignment: Alignment.center,
                          child: const Text('IDLE',
                              style: TextStyle(color: iaOnIndigo, fontSize: 8))),
                      Container(width: 40, height: 20,
                          color: const Color(0xFFE65100),
                          alignment: Alignment.center,
                          child: const Text('DRAG',
                              style: TextStyle(color: iaOnIndigo, fontSize: 8))),
                      Container(width: 80, height: 20,
                          color: const Color(0xFF1B5E20),
                          alignment: Alignment.center,
                          child: const Text('BALLISTIC',
                              style: TextStyle(color: iaOnIndigo, fontSize: 8))),
                      Expanded(
                        child: Container(height: 20, color: iaIndigo,
                            alignment: Alignment.center,
                            child: const Text('IDLE',
                                style: TextStyle(color: iaOnIndigo, fontSize: 8))),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Time →  touch → drag → release → fling → settle → idle',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'monospace',
                        color: iaTextDark),
                  ),
                ],
              ),
            ),
            iaDivider(),
            iaBullet(
                'The IDLE bars at start and end show that the scrollable '
                'spends most of its time in IdleScrollActivity.'),
          ]),

          // ── 12. dispose behavior ──
          iaSection('12 · Dispose & Cleanup', [
            iaBullet(
                'When a new activity replaces IdleScrollActivity, the '
                'idle activity is disposed via its dispose() method.'),
            iaBullet(
                'IdleScrollActivity dispose() calls super.dispose() '
                'which detaches from the delegate.'),
            iaCodeBlock(
                '// Activity replacement flow:\n'
                'void beginActivity(ScrollActivity? newActivity) {\n'
                '  _activity?.dispose();  // old IdleScrollActivity\n'
                '  _activity = newActivity;\n'
                '  // ...\n'
                '}'),
            iaDivider(),
            iaBullet(
                'IdleScrollActivity has minimal state, so dispose() is '
                'lightweight. In contrast, BallisticScrollActivity must '
                'dispose its AnimationController.'),
          ]),

          // ── 13. scroll notification context ──
          iaSection('13 · Scroll Notifications', [
            iaBullet(
                'While IdleScrollActivity is active, no scroll notifications '
                'are dispatched (no ScrollStartNotification, no '
                'ScrollUpdateNotification, no ScrollEndNotification).'),
            iaBullet(
                'When transitioning FROM idle to drag, a '
                'ScrollStartNotification is sent.'),
            iaBullet(
                'When transitioning TO idle from ballistic, a '
                'ScrollEndNotification is sent.'),
            iaCodeBlock(
                '// Notification sequence:\n'
                '// Idle → Drag:       ScrollStartNotification\n'
                '// Drag  → Drag:      ScrollUpdateNotification\n'
                '// Drag  → Ballistic: (intermediate)\n'
                '// Ballistic → Idle:  ScrollEndNotification\n'
                '// Idle → Idle:       (nothing)'),
          ]),

          // ── 14. overscroll and edge cases ──
          iaSection('14 · Overscroll & Edge Cases', [
            iaBullet(
                'If the scroll position is out of bounds when idle starts '
                '(e.g., after a content size change), applyNewDimensions '
                'triggers goBallistic(0.0) to correct it.'),
            iaBullet(
                'With BouncingScrollPhysics, goBallistic(0.0) from an '
                'out-of-bounds position creates a bounce-back animation.'),
            iaBullet(
                'With ClampingScrollPhysics, goBallistic(0.0) from an '
                'out-of-bounds position instantly clamps to bounds.'),
            iaHighlight(
                'This is why you sometimes see a bounce animation when '
                'a ListView content shrinks: the idle activity detects '
                'the position is out of bounds and triggers correction.'),
          ]),

          // ── 15. testing with scroll controllers ──
          iaSection('15 · Working with ScrollController', [
            iaCodeBlock(
                '// Check current activity type:\n'
                'final controller = ScrollController();\n'
                '// ... after attaching to a ListView:\n'
                '\n'
                'final position = controller.position;\n'
                '// position.activity is IdleScrollActivity initially\n'
                '\n'
                '// Force idle:\n'
                'position.goIdle();\n'
                '// Now position.activity is IdleScrollActivity\n'
                '\n'
                '// Jump (goes idle after):\n'
                'controller.jumpTo(100.0);\n'
                '// position is 100.0, activity is IdleScrollActivity'),
            iaDivider(),
            iaBullet(
                'jumpTo() internally calls goIdle() after setting pixels, '
                'so the position is always idle after a jump.'),
            iaBullet(
                'animateTo() replaces idle with DrivenScrollActivity, '
                'which returns to idle when the animation completes.'),
          ]),

          // ── 16. summary ──
          iaSection('16 · Quick API Reference', [
            iaKeyValue('Class', 'IdleScrollActivity'),
            iaKeyValue('Extends', 'ScrollActivity'),
            iaKeyValue('Constructor',
                'IdleScrollActivity(ScrollActivityDelegate)'),
            iaKeyValue('velocity', '0.0 (constant)'),
            iaKeyValue('isScrolling', 'false (constant)'),
            iaKeyValue('shouldIgnorePointer', 'false (constant)'),
            iaKeyValue('applyNewDimensions',
                'Calls delegate.goBallistic(0.0)'),
            iaDivider(),
            iaCodeBlock(
                '// Summary:\n'
                '// IdleScrollActivity is the resting state.\n'
                '// It has no velocity, is not scrolling,\n'
                '// and allows pointer events through.\n'
                '// When dimensions change, it re-evaluates\n'
                '// via goBallistic(0.0).\n'
                '//\n'
                '// Created by: goIdle(), jumpTo(), init\n'
                '// Replaced by: beginActivity(newActivity)'),
          ]),

          // ── footer ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            color: iaIndigo.withValues(alpha: 0.06),
            child: const Text(
              'IdleScrollActivity · Indigo Deep Demo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: iaMuted,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    ),
  );
}
