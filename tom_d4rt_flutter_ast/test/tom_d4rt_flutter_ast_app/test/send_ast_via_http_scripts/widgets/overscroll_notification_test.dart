// ignore_for_file: avoid_print
// D4rt deep demo: OverscrollNotification — scroll overscroll data notification
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Indigo / Violet ───────────────────────────────────────
  const deepIndigo = Color(0xFF1A237E);
  const indigo = Color(0xFF283593);
  const violet = Color(0xFF5C6BC0);
  const softViolet = Color(0xFF9FA8DA);
  const lightIndigo = Color(0xFFC5CAE9);
  const paleIndigo = Color(0xFFE8EAF6);
  const whiteIndigo = Color(0xFFF3F4FC);
  const darkNavy = Color(0xFF0D1137);
  const accentOrange = Color(0xFFE65100);
  const accentGreen = Color(0xFF2E7D32);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionHeader(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.75)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
          if (subtitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(subtitle,
                  style: TextStyle(
                      color: fg.withValues(alpha: 0.85), fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget infoBox(String text, Color border, Color bg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: border, width: 4)),
      ),
      child: Text(text,
          style: TextStyle(fontSize: 13, color: darkNavy)),
    );
  }

  Widget fieldRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: darkNavy)),
          ),
        ],
      ),
    );
  }

  Widget pill(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('OverscrollNotification deep demo executing');
  print('=' * 60);

  print('\n--- OverscrollNotification class ---');
  print('Defined in widgets/scroll_notification.dart line 226');
  print('Extends ScrollNotification');
  print('Reports that the scroll position overscrolled');

  print('\n--- Constructor ---');
  print('OverscrollNotification({');
  print('  required ScrollMetrics metrics,');
  print('  required BuildContext context,');
  print('  DragUpdateDetails? dragDetails,');
  print('  required double overscroll,');
  print('  double velocity = 0.0,');
  print('})');

  print('\n--- Key members ---');
  print('overscroll (double) — pixel amount past extent');
  print('dragDetails (DragUpdateDetails?) — drag info if from drag');
  print('velocity (double) — velocity at overscroll moment');

  print('\n--- Lifecycle position ---');
  print('ScrollStartNotification');
  print('  -> ScrollUpdateNotification');
  print('  -> OverscrollNotification (when past extent)');
  print('  -> ScrollEndNotification');

  print('\n${'=' * 60}');
  print('OverscrollNotification deep demo completed');

  // ── Build ──────────────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── 1. Title banner ──────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepIndigo, indigo, violet],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.compare_arrows, size: 28, color: lightIndigo),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverscrollNotification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A scroll notification that reports the scroll position '
                  'has exceeded its scroll extent boundaries. Carries the '
                  'overscroll amount, drag details, and velocity at the '
                  'moment of overscroll.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('extends ScrollNotification', indigo, Colors.white),
                pill('overscroll', violet, Colors.white),
                pill('dragDetails', softViolet, darkNavy),
                pill('velocity', lightIndigo, darkNavy),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionHeader('1 \u00b7 What Is OverscrollNotification',
            'Data notification for scroll extent overflow',
            deepIndigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepIndigo.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepIndigo.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'class OverscrollNotification\n'
                    '    extends ScrollNotification {\n'
                    '  OverscrollNotification({\n'
                    '    required super.metrics,\n'
                    '    required super.context,\n'
                    '    this.dragDetails,\n'
                    '    required this.overscroll,\n'
                    '    this.velocity = 0.0,\n'
                    '  });\n'
                    '\n'
                    '  final double overscroll;\n'
                    '  final DragUpdateDetails? dragDetails;\n'
                    '  final double velocity;\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepIndigo)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'OverscrollNotification is dispatched by the scroll position '
                'when the physics report that scrolling has gone past the '
                'scroll extent. Unlike OverscrollIndicatorNotification, this '
                'is purely informational — it reports the data, not controls '
                'any visual effect.',
                deepIndigo,
                paleIndigo,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Scroll notification hierarchy ─────────────────────────
        sectionHeader('2 \u00b7 Scroll Notification Hierarchy',
            'Where OverscrollNotification fits in the notification family',
            indigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightIndigo),
          ),
          child: Column(
            children: [
              for (final node in [
                (0, 'Notification', 'Base notification class', violet, false),
                (1, 'ScrollNotification', 'Base for scroll events', indigo, true),
                (2, 'ScrollStartNotification', 'Scroll began', softViolet, false),
                (2, 'ScrollUpdateNotification', 'Position changed', softViolet, false),
                (2, 'OverscrollNotification', 'Past extent boundary', accentOrange, true),
                (2, 'ScrollEndNotification', 'Scroll finished', softViolet, false),
                (2, 'UserScrollNotification', 'User direction changed', softViolet, false),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: node.$1 * 16.0, top: 3, bottom: 3),
                  child: Row(
                    children: [
                      if (node.$1 > 0)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text('\u2514\u2500',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: softViolet)),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: node.$4.withValues(alpha: node.$5 ? 0.15 : 0.06),
                          borderRadius: BorderRadius.circular(4),
                          border: node.$5
                              ? Border.all(color: node.$4, width: 2)
                              : Border.all(
                                  color: node.$4.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(node.$2,
                                style: TextStyle(
                                    fontWeight: node.$5
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    fontSize: 10,
                                    color: node.$4)),
                            if (node.$3.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(node.$3,
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontStyle: FontStyle.italic,
                                        color: node.$4)),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Overscroll property ───────────────────────────────────
        sectionHeader('3 \u00b7 The overscroll Property',
            'Pixel amount past the scroll extent',
            deepIndigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentGreen.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentGreen),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_upward,
                              size: 24, color: accentGreen),
                          Text('overscroll > 0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentGreen)),
                          const Divider(),
                          Text('Scrolled past the maximum extent '
                              '(bottom for vertical, end for horizontal). '
                              'Positive value = pixels beyond max.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: accentOrange.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: accentOrange),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.arrow_downward,
                              size: 24, color: accentOrange),
                          Text('overscroll < 0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentOrange)),
                          const Divider(),
                          Text('Scrolled past the minimum extent '
                              '(top for vertical, start for horizontal). '
                              'Negative value = pixels beyond min.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              infoBox(
                'The sign of the overscroll value indicates direction. Positive '
                'means scrolling past the end, negative means scrolling past '
                'the start. The absolute value is the pixel count beyond the '
                'boundary.',
                deepIndigo,
                paleIndigo,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. dragDetails ───────────────────────────────────────────
        sectionHeader('4 \u00b7 dragDetails Property',
            'The DragUpdateDetails at the overscroll moment',
            indigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldRow('Type', 'DragUpdateDetails?', indigo),
              fieldRow('Null when', 'Overscroll caused by ballistic '
                  'fling, not by active drag', violet),
              fieldRow('Non-null when', 'User is actively dragging '
                  'past the scroll boundary', deepIndigo),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: indigo.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: indigo.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DragUpdateDetails contains:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: indigo)),
                    const SizedBox(height: 4),
                    for (final prop in [
                      'globalPosition — pointer position in global coords',
                      'localPosition — pointer position in local coords',
                      'delta — distance moved since last update',
                      'primaryDelta — single-axis movement delta',
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Text('\u2022 $prop',
                            style: TextStyle(
                                fontSize: 9,
                                fontFamily: 'monospace',
                                color: darkNavy)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. velocity ──────────────────────────────────────────────
        sectionHeader('5 \u00b7 velocity Property',
            'Speed at the moment of overscroll',
            violet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              fieldRow('Type', 'double', violet),
              fieldRow('Default', '0.0', indigo),
              fieldRow('Unit', 'Pixels per second', deepIndigo),
              fieldRow('Source', 'From the ballistic simulation or '
                  'drag velocity tracker', violet),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: violet.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: violet),
                      ),
                      child: Column(
                        children: [
                          Text('Low velocity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: violet)),
                          Text('Gentle overscroll from slow drag or '
                              'scroll near boundary',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentOrange.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentOrange),
                      ),
                      child: Column(
                        children: [
                          Text('High velocity',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: accentOrange)),
                          Text('Aggressive overscroll from fast fling '
                              'hitting the scroll boundary',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 9, color: darkNavy)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Scroll notification lifecycle ─────────────────────────
        sectionHeader('6 \u00b7 Notification Lifecycle',
            'Where OverscrollNotification appears in the scroll sequence',
            deepIndigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightIndigo),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [indigo, violet, accentOrange, accentOrange, indigo][i]
                        .withValues(alpha: i == 2 || i == 3 ? 0.15 : 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [indigo, violet, accentOrange, accentOrange, indigo][i],
                        width: i == 2 || i == 3 ? 2 : 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: [indigo, violet, accentOrange, accentOrange, indigo][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'ScrollStartNotification',
                              'ScrollUpdateNotification (repeats)',
                              'OverscrollNotification',
                              'OverscrollNotification (may repeat)',
                              'ScrollEndNotification',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: [indigo, violet, accentOrange, accentOrange, indigo][i])),
                            Text([
                              'User begins scroll gesture or fling starts',
                              'Position changes within valid bounds',
                              'Position exceeds scroll extent boundary',
                              'Continued dragging past the boundary',
                              'Scroll gesture or ballistic simulation ends',
                            ][i],
                                style: TextStyle(
                                    fontSize: 9, color: darkNavy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 4)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softViolet),
                  ),
              ],
              const SizedBox(height: 8),
              infoBox(
                'OverscrollNotification replaces ScrollUpdateNotification when '
                'the position hits a boundary. If the user continues dragging, '
                'multiple OverscrollNotifications are dispatched with cumulative '
                'overscroll amounts.',
                deepIndigo,
                paleIndigo,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. ScrollMetrics inherited ───────────────────────────────
        sectionHeader('7 \u00b7 Inherited ScrollMetrics',
            'Metrics available from the parent ScrollNotification',
            indigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final metric in [
                ('pixels', 'Current scroll offset', indigo),
                ('minScrollExtent', 'Minimum scrollable position', violet),
                ('maxScrollExtent', 'Maximum scrollable position', deepIndigo),
                ('viewportDimension', 'Size of the visible area', violet),
                ('axisDirection', 'Scroll axis direction', indigo),
                ('extentBefore', 'Amount scrolled before viewport', softViolet),
                ('extentInside', 'Amount visible in viewport', softViolet),
                ('extentAfter', 'Amount remaining after viewport', softViolet),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(metric.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: metric.$3)),
                      ),
                      Expanded(
                        child: Text(metric.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkNavy)),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              infoBox(
                'OverscrollNotification inherits the full ScrollMetrics from '
                'ScrollNotification. At the moment of overscroll, pixels will '
                'be at either minScrollExtent or maxScrollExtent. The overscroll '
                'property tells you how far beyond that boundary the scroll went.',
                indigo,
                paleIndigo,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Drag-caused vs fling-caused ───────────────────────────
        sectionHeader('8 \u00b7 Drag vs Fling Overscroll',
            'Two ways overscroll can happen',
            violet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: indigo.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: indigo),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.touch_app, size: 24, color: indigo),
                      Text('Drag Overscroll',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: indigo)),
                      const Divider(),
                      Text('dragDetails != null\n'
                          'velocity = 0.0\n\n'
                          'User is actively touching and '
                          'dragging past the boundary.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: darkNavy)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentOrange.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentOrange),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.swipe, size: 24, color: accentOrange),
                      Text('Fling Overscroll',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentOrange)),
                      const Divider(),
                      Text('dragDetails == null\n'
                          'velocity > 0.0\n\n'
                          'Ballistic simulation hit the '
                          'boundary at speed.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 9,
                              color: darkNavy)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. ScrollPhysics role ───────────────────────────────────
        sectionHeader('9 \u00b7 ScrollPhysics Role',
            'Which physics trigger OverscrollNotification',
            deepIndigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final phys in [
                ('ClampingScrollPhysics', 'Clamps at boundary. Reports '
                    'full excess as overscroll. Default on Android.',
                    Icons.pan_tool, indigo, true),
                ('BouncingScrollPhysics', 'Allows position past boundary. '
                    'No OverscrollNotification dispatched — uses bounce.',
                    Icons.sports_basketball, softViolet, false),
                ('NeverScrollableScrollPhysics', 'Prevents scrolling entirely. '
                    'No overscroll is possible.',
                    Icons.lock, softViolet, false),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: phys.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: phys.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(phys.$3, size: 18, color: phys.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(phys.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        color: phys.$4)),
                                if (phys.$5) ...[
                                  const SizedBox(width: 6),
                                  pill('dispatches', accentOrange,
                                      Colors.white),
                                ],
                              ],
                            ),
                            Text(phys.$2,
                                style: TextStyle(
                                    fontSize: 10, color: darkNavy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              infoBox(
                'Only ClampingScrollPhysics (and similar clamping physics) '
                'dispatch OverscrollNotification. BouncingScrollPhysics allows '
                'the position to exceed the boundary naturally, so there is '
                'no overscroll to report.',
                deepIndigo,
                paleIndigo,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. NotificationListener pattern ─────────────────────────
        sectionHeader('10 \u00b7 Listening Pattern',
            'How to capture overscroll events',
            indigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: indigo.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: indigo.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'NotificationListener<OverscrollNotification>(\n'
                    '  onNotification: (notification) {\n'
                    '    final amount = notification.overscroll;\n'
                    '    final wasDrag =\n'
                    '        notification.dragDetails != null;\n'
                    '    final speed = notification.velocity;\n'
                    '    // Use amount, wasDrag, speed...\n'
                    '    return false;\n'
                    '  },\n'
                    '  child: ListView(...),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: indigo)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Return false from onNotification to allow the notification '
                'to continue bubbling up the tree. Return true to absorb it. '
                'For type-safe handling, always type the NotificationListener '
                'with OverscrollNotification specifically.',
                indigo,
                paleIndigo,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. OverscrollNotification vs OverscrollIndicatorNotification ─
        sectionHeader('11 \u00b7 Notification Comparison',
            'OverscrollNotification vs OverscrollIndicatorNotification',
            violet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(4),
              2: FlexColumnWidth(4),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: violet),
                children: [
                  for (final h in ['Aspect', 'Overscroll\nNotification', 'OverscrollIndicator\nNotification'])
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8)),
                    ),
                ],
              ),
              for (final row in [
                ('Purpose', 'Reports data', 'Controls visual'),
                ('Dispatched by', 'ScrollPosition', 'Indicator widget'),
                ('Has overscroll', '\u2713 (double)', '\u2717'),
                ('Has leading', '\u2717', '\u2713 (bool)'),
                ('Suppressible', '\u2717', '\u2713 (disallow)'),
                ('Extends', 'ScrollNotification', 'Notification'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: deepIndigo)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 8, color: darkNavy)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 8, color: darkNavy)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Visual: overscroll at boundaries ─────────────────────
        sectionHeader('12 \u00b7 Visual: Overscroll at Boundaries',
            'Where overscroll occurs in a scrollable',
            deepIndigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightIndigo),
          ),
          child: Container(
            width: double.infinity,
            height: 180,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: deepIndigo.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepIndigo.withValues(alpha: 0.2)),
            ),
            child: Stack(
              children: [
                // Min extent overscroll zone
                Positioned(
                  top: 0,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: accentOrange.withValues(alpha: 0.1),
                      border: Border.all(
                          color: accentOrange,
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6)),
                    ),
                    child: Center(
                      child: Text('overscroll < 0 (past min extent)',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: accentOrange)),
                    ),
                  ),
                ),
                // Valid scroll range
                Positioned(
                  top: 34,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: accentGreen.withValues(alpha: 0.06),
                      border: Border.all(color: accentGreen),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Valid scroll range',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: accentGreen)),
                        Text('minScrollExtent \u2264 pixels \u2264 maxScrollExtent',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 8,
                                color: accentGreen)),
                        const SizedBox(height: 6),
                        Text('ScrollUpdateNotification dispatched here',
                            style: TextStyle(
                                fontSize: 7,
                                fontStyle: FontStyle.italic,
                                color: darkNavy)),
                      ],
                    ),
                  ),
                ),
                // Max extent overscroll zone
                Positioned(
                  bottom: 0,
                  left: 10,
                  right: 10,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: accentOrange.withValues(alpha: 0.1),
                      border: Border.all(
                          color: accentOrange,
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(6)),
                    ),
                    child: Center(
                      child: Text('overscroll > 0 (past max extent)',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: accentOrange)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Practical applications ───────────────────────────────
        sectionHeader('13 \u00b7 Practical Applications',
            'Real-world uses for overscroll data',
            indigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final app in [
                ('Pull-to-refresh', 'Monitor negative overscroll amount '
                    'to trigger content refresh',
                    Icons.refresh, deepIndigo),
                ('Load more content', 'Detect positive overscroll to '
                    'trigger pagination or infinite scroll',
                    Icons.add_circle_outline, indigo),
                ('Scroll analytics', 'Track how often users hit boundaries '
                    'to optimize content length',
                    Icons.analytics, violet),
                ('Custom bounce effects', 'Use overscroll amount to drive '
                    'custom animations at boundaries',
                    Icons.animation, softViolet),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: app.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: app.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(app.$3, size: 18, color: app.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(app.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: app.$4)),
                            Text(app.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkNavy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance notes ────────────────────────────────────
        sectionHeader('14 \u00b7 Performance Notes',
            'Considerations when listening to overscroll',
            violet, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteIndigo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final note in [
                ('High frequency', 'During active drag overscroll, '
                    'notifications fire every frame. Keep callbacks lightweight.',
                    Icons.speed, indigo),
                ('Bubble propagation', 'Notifications bubble up the entire '
                    'widget tree. Stop propagation early when possible.',
                    Icons.bubble_chart, violet),
                ('Type-safe listeners', 'Use typed NotificationListener to '
                    'avoid processing unrelated notifications.',
                    Icons.filter_alt, deepIndigo),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: note.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: note.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(note.$3, size: 16, color: note.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${note.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: note.$4)),
                            TextSpan(
                                text: note.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkNavy)),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionHeader('15 \u00b7 Summary',
            'Key takeaways', deepIndigo, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepIndigo, indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends ScrollNotification — carries full scroll metrics',
                'overscroll property reports pixels beyond the scroll extent',
                'Positive overscroll = past max, negative = past min extent',
                'dragDetails is non-null for drag overscroll, null for fling',
                'velocity captures the speed at the boundary crossing',
                'Only dispatched with clamping physics, not bouncing',
                'Part of the scroll lifecycle: Start, Update, Overscroll, End',
                'Purely informational — cannot suppress visual indicators',
                'Different from OverscrollIndicatorNotification which controls visuals',
                'Useful for pull-to-refresh, load-more, and boundary analytics',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightIndigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
