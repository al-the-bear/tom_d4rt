// ignore_for_file: avoid_print
// D4rt deep demo: OverscrollIndicatorNotification — overscroll glow/stretch control
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Amber / Copper ────────────────────────────────────────
  const deepCopper = Color(0xFF6D3200);
  const copper = Color(0xFF8D4E00);
  const amber = Color(0xFFFFA000);
  const softAmber = Color(0xFFFFCA28);
  const lightAmber = Color(0xFFFFF3E0);
  const paleAmber = Color(0xFFFFF8E1);
  const whiteAmber = Color(0xFFFFFBF3);
  const darkBrown = Color(0xFF3E2723);
  const accentTeal = Color(0xFF00796B);
  const accentRed = Color(0xFFC62828);

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
          style: TextStyle(fontSize: 13, color: darkBrown)),
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
                style: TextStyle(fontSize: 13, color: darkBrown)),
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
  print('OverscrollIndicatorNotification deep demo executing');
  print('=' * 60);

  print('\n--- OverscrollIndicatorNotification class ---');
  print('Defined in widgets/overscroll_indicator.dart line 1052');
  print('Extends Notification with ViewportNotificationMixin');
  print('Dispatched before showing overscroll glow/stretch effect');

  print('\n--- Constructor ---');
  print('OverscrollIndicatorNotification({required bool leading})');
  print('leading: whether the indicator is at the leading edge');

  print('\n--- Key members ---');
  print('leading (bool) — true for start/top edge');
  print('paintOffset (double) — defaults to 0.0');
  print('accepted (bool) — defaults to true');
  print('disallowIndicator() — sets accepted = false');

  print('\n--- Usage pattern ---');
  print('NotificationListener<OverscrollIndicatorNotification>(');
  print('  onNotification: (notification) {');
  print('    notification.disallowIndicator();');
  print('    return false;');
  print('  },');
  print(')');

  print('\n${'=' * 60}');
  print('OverscrollIndicatorNotification deep demo completed');

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
              colors: [deepCopper, copper, amber],
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
                  Icon(Icons.swipe_down, size: 28, color: lightAmber),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverscrollIndicatorNotification',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A notification dispatched by overscroll indicator widgets '
                  '(GlowingOverscrollIndicator and StretchingOverscrollIndicator) '
                  'before they paint. Allows listeners to suppress or modify '
                  'the overscroll visual effect.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('extends Notification', copper, Colors.white),
                pill('ViewportNotificationMixin', amber, darkBrown),
                pill('leading', softAmber, darkBrown),
                pill('disallowIndicator()', lightAmber, darkBrown),
                pill('paintOffset', paleAmber, darkBrown),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionHeader('1 \u00b7 What Is OverscrollIndicatorNotification',
            'Notification dispatched before overscroll effect paints',
            deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepCopper.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepCopper.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'class OverscrollIndicatorNotification\n'
                    '    extends Notification\n'
                    '    with ViewportNotificationMixin {\n'
                    '  OverscrollIndicatorNotification({\n'
                    '    required this.leading,\n'
                    '  });\n'
                    '\n'
                    '  final bool leading;\n'
                    '  double paintOffset = 0.0;\n'
                    '  bool accepted = true;\n'
                    '  void disallowIndicator() { accepted = false; }\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepCopper)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'When a scrollable widget overscrolls and an overscroll '
                'indicator (glow or stretch) is about to paint, it dispatches '
                'this notification up the widget tree. Any ancestor can listen '
                'for it, inspect it, and optionally suppress the effect by calling '
                'disallowIndicator().',
                deepCopper,
                paleAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Class hierarchy ───────────────────────────────────────
        sectionHeader('2 \u00b7 Class Hierarchy',
            'Notification system with viewport awareness',
            copper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightAmber),
          ),
          child: Column(
            children: [
              for (final node in [
                (0, 'Notification', 'Base for tree notifications', copper, true),
                (1, 'ViewportNotificationMixin', 'Tracks depth in nested viewports', amber, true),
                (2, 'OverscrollIndicatorNotification', 'Overscroll indicator control', deepCopper, true),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: node.$1 * 20.0, top: 4, bottom: 4),
                  child: Row(
                    children: [
                      if (node.$1 > 0)
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text('\u2514\u2500',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: softAmber)),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: node.$4.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                          border: node.$5
                              ? Border.all(color: node.$4, width: 2)
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(node.$2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: node.$4)),
                            Text(node.$3,
                                style: TextStyle(
                                    fontSize: 9,
                                    fontStyle: FontStyle.italic,
                                    color: node.$4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              infoBox(
                'ViewportNotificationMixin adds a depth counter for nested '
                'scroll views. Each time the notification passes through a '
                'ScrollNotificationObserver or nested viewport, the depth '
                'increments. This lets listeners distinguish inner vs outer '
                'scrollable overscroll.',
                copper,
                paleAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Constructor fields ────────────────────────────────────
        sectionHeader('3 \u00b7 Constructor and Fields',
            'All properties of the notification',
            deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final field in [
                ('leading', 'bool', 'required', 'True if the overscroll is at the '
                    'leading edge (top for vertical, start for horizontal)',
                    deepCopper),
                ('paintOffset', 'double', '0.0', 'Vertical offset where the '
                    'indicator should paint, useful for pinned headers',
                    copper),
                ('accepted', 'bool', 'true', 'Whether the indicator should show. '
                    'Set to false by disallowIndicator()',
                    amber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: field.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: field.$5, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(field.$1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: field.$5)),
                          const SizedBox(width: 8),
                          pill(field.$2, field.$5.withValues(alpha: 0.15),
                              field.$5),
                          const SizedBox(width: 4),
                          pill('default: ${field.$3}',
                              field.$5.withValues(alpha: 0.1), field.$5),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(field.$4,
                          style: TextStyle(
                              fontSize: 11, color: darkBrown)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. leading property visual ───────────────────────────────
        sectionHeader('4 \u00b7 The leading Property',
            'Which edge triggered the overscroll',
            copper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentTeal),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_upward,
                          size: 28, color: accentTeal),
                      const SizedBox(height: 4),
                      Text('leading = true',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: accentTeal)),
                      const Divider(),
                      Text('Overscroll at the top (vertical) or '
                          'start edge (horizontal). User pulled '
                          'down past the beginning of content.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkBrown)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: accentTeal),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      accentTeal.withValues(alpha: 0.5),
                                      accentTeal.withValues(alpha: 0.0),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(5)),
                                ),
                              ),
                            ),
                            Center(
                              child: Text('Content',
                                  style: TextStyle(
                                      fontSize: 9, color: accentTeal)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentRed.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentRed),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.arrow_downward,
                          size: 28, color: accentRed),
                      const SizedBox(height: 4),
                      Text('leading = false',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: accentRed)),
                      const Divider(),
                      Text('Overscroll at the bottom (vertical) or '
                          'end edge (horizontal). User pulled '
                          'up past the end of content.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: darkBrown)),
                      const SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: accentRed),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      accentRed.withValues(alpha: 0.0),
                                      accentRed.withValues(alpha: 0.5),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(5)),
                                ),
                              ),
                            ),
                            Center(
                              child: Text('Content',
                                  style: TextStyle(
                                      fontSize: 9, color: accentRed)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. disallowIndicator() ───────────────────────────────────
        sectionHeader('5 \u00b7 disallowIndicator()',
            'Suppressing the overscroll visual effect',
            deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepCopper.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepCopper.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'void disallowIndicator() {\n'
                    '  accepted = false;\n'
                    '}',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: deepCopper)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Calling disallowIndicator() sets accepted to false, causing '
                'the indicator widget to skip painting entirely for this '
                'overscroll event. This is the primary mechanism for selectively '
                'hiding overscroll glow or stretch effects.',
                deepCopper,
                paleAmber,
              ),
              const SizedBox(height: 8),
              // Flow diagram
              for (var i = 0; i < 4; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: [deepCopper, copper, amber, accentTeal][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: [deepCopper, copper, amber, accentTeal][i]),
                  ),
                  child: Text([
                    'Overscroll detected by ScrollPhysics',
                    'Indicator dispatches OverscrollIndicatorNotification',
                    'Listener calls notification.disallowIndicator()',
                    'Indicator checks accepted, skips paint if false',
                  ][i],
                      style: TextStyle(
                          fontSize: 11,
                          color: [deepCopper, copper, amber, accentTeal][i])),
                ),
                if (i < 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softAmber),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. paintOffset property ──────────────────────────────────
        sectionHeader('6 \u00b7 paintOffset Property',
            'Adjusting indicator painting position',
            copper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: copper),
                ),
                child: Row(
                  children: [
                    // Without offset
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: copper.withValues(alpha: 0.03),
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(7)),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 8,
                                color: amber.withValues(alpha: 0.5),
                              ),
                            ),
                            Positioned(
                              top: 12,
                              left: 4,
                              child: Text('paintOffset = 0',
                                  style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                      color: copper)),
                            ),
                            Positioned(
                              top: 24,
                              left: 4,
                              right: 4,
                              child: Container(
                                height: 18,
                                decoration: BoxDecoration(
                                  color: amber.withValues(alpha: 0.15),
                                  border: Border.all(color: amber),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text('App Bar',
                                      style: TextStyle(
                                          fontSize: 7, color: copper)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 4,
                              right: 4,
                              child: Text('Glow covers\nthe app bar',
                                  style: TextStyle(
                                      fontSize: 7,
                                      color: accentRed)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(width: 1, color: copper),
                    // With offset
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: accentTeal.withValues(alpha: 0.03),
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(7)),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 24,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 8,
                                color: accentTeal.withValues(alpha: 0.5),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              left: 4,
                              child: Text('paintOffset = 56',
                                  style: TextStyle(
                                      fontSize: 7,
                                      fontWeight: FontWeight.bold,
                                      color: accentTeal)),
                            ),
                            Positioned(
                              top: 12,
                              left: 4,
                              right: 4,
                              child: Container(
                                height: 18,
                                decoration: BoxDecoration(
                                  color: accentTeal.withValues(alpha: 0.15),
                                  border: Border.all(color: accentTeal),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Center(
                                  child: Text('App Bar',
                                      style: TextStyle(
                                          fontSize: 7, color: accentTeal)),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 50,
                              left: 4,
                              right: 4,
                              child: Text('Glow starts\nbelow app bar',
                                  style: TextStyle(
                                      fontSize: 7,
                                      color: accentTeal)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              infoBox(
                'The paintOffset property controls where the glow or stretch '
                'effect begins painting. Setting it to the height of a pinned '
                'SliverAppBar (e.g. 56 pixels) causes the effect to appear '
                'below the app bar rather than overlapping it.',
                copper,
                paleAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Indicator types ───────────────────────────────────────
        sectionHeader('7 \u00b7 Indicator Widget Types',
            'Glow vs Stretch overscroll effects',
            deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: amber),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.blur_on, size: 28, color: amber),
                      const SizedBox(height: 4),
                      Text('GlowingOverscroll\nIndicator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: amber)),
                      const Divider(),
                      Text('Classic Material glow effect. Shows a '
                          'colored arc at the overscroll edge. '
                          'Used by default on Android before API 31.',
                          style: TextStyle(
                              fontSize: 10, color: darkBrown)),
                      const SizedBox(height: 4),
                      pill('Material 2', amber, darkBrown),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accentTeal.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: accentTeal),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.open_with, size: 28, color: accentTeal),
                      const SizedBox(height: 4),
                      Text('StretchingOverscroll\nIndicator',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: accentTeal)),
                      const Divider(),
                      Text('Material 3 stretch effect. Stretches the '
                          'content at the edge with a rubber-band feel. '
                          'Default on Android API 31+.',
                          style: TextStyle(
                              fontSize: 10, color: darkBrown)),
                      const SizedBox(height: 4),
                      pill('Material 3', accentTeal, Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. NotificationListener pattern ──────────────────────────
        sectionHeader('8 \u00b7 NotificationListener Pattern',
            'How to listen and respond to these notifications',
            copper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: copper.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: copper.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'NotificationListener<\n'
                    '  OverscrollIndicatorNotification\n'
                    '>(\n'
                    '  onNotification: (notification) {\n'
                    '    // Suppress leading edge only\n'
                    '    if (notification.leading) {\n'
                    '      notification.disallowIndicator();\n'
                    '    }\n'
                    '    return false; // allow propagation\n'
                    '  },\n'
                    '  child: ListView(...),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: copper)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Wrap your scrollable widget in a NotificationListener typed '
                'to OverscrollIndicatorNotification. Return false to let the '
                'notification continue bubbling, or true to stop propagation.',
                copper,
                paleAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Dispatch flow ────────────────────────────────────────
        sectionHeader('9 \u00b7 Notification Dispatch Flow',
            'From scroll physics to indicator paint',
            deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightAmber),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepCopper, copper, amber, softAmber, accentTeal][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepCopper, copper, amber, softAmber, accentTeal][i]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: [deepCopper, copper, amber, softAmber, accentTeal][i],
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
                        child: Text([
                          'User drags past scroll extent',
                          'ScrollPhysics reports overscroll to ScrollPosition',
                          'Overscroll indicator widget receives update',
                          'Indicator creates and dispatches notification',
                          'If accepted, indicator paints glow/stretch',
                        ][i],
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: [deepCopper, copper, amber, softAmber, accentTeal][i])),
                      ),
                    ],
                  ),
                ),
                if (i < 4)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Icon(Icons.arrow_downward,
                        size: 12, color: softAmber),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Common use cases ─────────────────────────────────────
        sectionHeader('10 \u00b7 Common Use Cases',
            'When to suppress or modify the indicator',
            amber, darkBrown),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final useCase in [
                ('Custom refresh header', 'Suppress the default indicator '
                    'when using a custom pull-to-refresh implementation',
                    Icons.refresh, deepCopper),
                ('Nested scrollables', 'Suppress inner scrollable overscroll '
                    'to avoid confusing double-glow effects',
                    Icons.view_stream, copper),
                ('Platform consistency', 'Disable glow on Android to match '
                    'iOS bounce behavior for cross-platform apps',
                    Icons.phone_android, amber),
                ('Fixed headers', 'Adjust paintOffset so the glow appears '
                    'below a pinned app bar or sticky header',
                    Icons.push_pin, softAmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: useCase.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: useCase.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(useCase.$3, size: 18, color: useCase.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(useCase.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: useCase.$4)),
                            Text(useCase.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkBrown)),
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

        // ── 12. ViewportNotificationMixin ─────────────────────────────
        sectionHeader('11 \u00b7 ViewportNotificationMixin',
            'Tracking notification depth in nested scrollables',
            copper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldRow('depth', 'Number of viewports the notification has '
                  'passed through', copper),
              fieldRow('Increments', 'Each time it crosses a '
                  'ScrollNotificationObserver boundary', amber),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: copper.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: copper.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Text('Nested viewport depth tracking',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: copper)),
                    const SizedBox(height: 6),
                    for (final level in [
                      ('Outer ListView', 'depth = 0', copper),
                      ('  Inner ListView', 'depth = 1', amber),
                      ('    Innermost ListView', 'depth = 2', softAmber),
                    ])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(level.$1,
                                  style: TextStyle(
                                      fontFamily: 'monospace',
                                      fontSize: 10,
                                      color: level.$3)),
                            ),
                            pill(level.$2, level.$3, darkBrown),
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

        // ── 13. Relationship to ScrollNotification ──────────────────
        sectionHeader('12 \u00b7 Relationship to Scroll Notifications',
            'How overscroll notifications differ',
            deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightAmber),
          ),
          child: Column(
            children: [
              for (final cmp in [
                ('OverscrollNotification', 'Reports the overscroll amount. '
                    'Part of the scroll notification lifecycle. '
                    'Cannot suppress the indicator.',
                    Icons.notifications, accentTeal),
                ('OverscrollIndicatorNotification', 'Controls the visual '
                    'indicator. Dispatched by the indicator widget itself. '
                    'Can suppress via disallowIndicator().',
                    Icons.format_paint, amber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cmp.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: cmp.$4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(cmp.$3, size: 20, color: cmp.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cmp.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: cmp.$4)),
                            const SizedBox(height: 2),
                            Text(cmp.$2,
                                style: TextStyle(
                                    fontSize: 10, color: darkBrown)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              infoBox(
                'OverscrollNotification and OverscrollIndicatorNotification '
                'are separate notification types. The first reports that overscroll '
                'happened (data). The second controls whether the visual indicator '
                'shows (behavior). They have different purposes and dispatch points.',
                deepCopper,
                paleAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Platform behavior ────────────────────────────────────
        sectionHeader('13 \u00b7 Platform Behavior',
            'How different platforms handle overscroll indicators',
            amber, darkBrown),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final platform in [
                ('Android (< API 31)', 'GlowingOverscrollIndicator',
                    'Shows a colored glow arc', Icons.blur_on, deepCopper),
                ('Android (>= API 31)', 'StretchingOverscrollIndicator',
                    'Shows a rubber-band stretch', Icons.open_with, copper),
                ('iOS', 'No indicator', 'Uses BouncingScrollPhysics '
                    'bounce instead', Icons.phone_iphone, amber),
                ('Web / Desktop', 'Depends on theme', 'Follows the '
                    'TargetPlatform setting', Icons.laptop, softAmber),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: platform.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: platform.$5, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(platform.$4, size: 16, color: platform.$5),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(platform.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: platform.$5)),
                                const SizedBox(width: 6),
                                pill(platform.$2,
                                    platform.$5.withValues(alpha: 0.15),
                                    platform.$5),
                              ],
                            ),
                            Text(platform.$3,
                                style: TextStyle(
                                    fontSize: 10, color: darkBrown)),
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

        // ── 15. ScrollBehavior connection ─────────────────────────────
        sectionHeader('14 \u00b7 ScrollBehavior Connection',
            'How the theme controls which indicator is used',
            copper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteAmber,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: copper.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: copper.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'ScrollBehavior\n'
                    '  .buildOverscrollIndicator(\n'
                    '    context, child, axisDirection\n'
                    '  )\n'
                    '\n'
                    '// Returns either:\n'
                    '// - GlowingOverscrollIndicator\n'
                    '// - StretchingOverscrollIndicator\n'
                    '// - child (no indicator)',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: copper)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'ScrollBehavior.buildOverscrollIndicator() wraps a scrollable '
                'with the appropriate indicator widget. The default depends on '
                'TargetPlatform and useMaterial3. Either way, the indicator '
                'dispatches OverscrollIndicatorNotification before painting.',
                copper,
                paleAmber,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionHeader('15 \u00b7 Summary',
            'Key takeaways', deepCopper, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepCopper, copper],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Notification dispatched before overscroll glow or stretch paints',
                'leading property indicates which edge triggered the overscroll',
                'disallowIndicator() suppresses the visual effect entirely',
                'paintOffset adjusts where the indicator begins painting',
                'Uses ViewportNotificationMixin for nested scroll depth tracking',
                'Dispatched by GlowingOverscrollIndicator and StretchingOverscrollIndicator',
                'Listen with NotificationListener<OverscrollIndicatorNotification>',
                'Different from OverscrollNotification which reports overscroll data',
                'Platform determines which indicator type is used by default',
                'ScrollBehavior.buildOverscrollIndicator() controls indicator creation',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightAmber,
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
