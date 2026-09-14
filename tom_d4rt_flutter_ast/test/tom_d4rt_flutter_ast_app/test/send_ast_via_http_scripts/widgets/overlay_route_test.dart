// ignore_for_file: avoid_print
// D4rt deep demo: OverlayRoute — abstract base for overlay-based routes
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Teal / Jade ───────────────────────────────────────────
  const deepTeal = Color(0xFF004D40);
  const teal = Color(0xFF00695C);
  const jade = Color(0xFF00897B);
  const softTeal = Color(0xFF26A69A);
  const lightJade = Color(0xFFB2DFDB);
  const paleJade = Color(0xFFE0F2F1);
  const whiteJade = Color(0xFFF0FAF8);
  const darkForest = Color(0xFF002419);
  const accentOrange = Color(0xFFE65100);
  const accentIndigo = Color(0xFF283593);

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
          style: TextStyle(fontSize: 13, color: darkForest)),
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
                style: TextStyle(fontSize: 13, color: darkForest)),
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
  print('OverlayRoute deep demo executing');
  print('=' * 60);

  print('\n--- OverlayRoute abstract class ---');
  print('Defined in widgets/routes.dart line 55');
  print('abstract class OverlayRoute<T> extends Route<T>');
  print('Base for all routes that display via Overlay');

  print('\n--- Key members ---');
  print('createOverlayEntries() — abstract factory for overlay entries');
  print('overlayEntries — getter for internal _overlayEntries list');
  print('finishedWhenPopped — controls auto-finalization');
  print('install() — creates and installs overlay entries');
  print('dispose() — disposes and clears overlay entries');

  print('\n--- Route hierarchy ---');
  print('Route -> OverlayRoute -> TransitionRoute -> ModalRoute');
  print('  -> PageRoute -> MaterialPageRoute / CupertinoPageRoute');

  print('\n--- Lifecycle ---');
  print('Navigator.push -> install() -> createOverlayEntries()');
  print('Navigator.pop -> didPop() -> finalizeRoute() -> dispose()');

  print('\n${'=' * 60}');
  print('OverlayRoute deep demo completed');

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
              colors: [deepTeal, teal, jade],
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
                  Icon(Icons.route, size: 28, color: lightJade),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverlayRoute<T>',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('The abstract base class for routes that display their '
                  'content through the Navigator\u0027s Overlay. Every '
                  'visible route in Flutter — MaterialPageRoute, dialogs, '
                  'bottom sheets — ultimately extends OverlayRoute.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('abstract class', teal, Colors.white),
                pill('extends Route<T>', jade, Colors.white),
                pill('createOverlayEntries()', softTeal, darkForest),
                pill('install()', lightJade, darkForest),
                pill('dispose()', paleJade, darkForest),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionHeader('1 \u00b7 What Is OverlayRoute',
            'The foundation of all visible routes',
            deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepTeal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepTeal.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'abstract class OverlayRoute<T> extends Route<T> {\n'
                    '  OverlayRoute({\n'
                    '    RouteSettings? settings,\n'
                    '    bool requestFocus,\n'
                    '  });\n'
                    '\n'
                    '  @factory\n'
                    '  Iterable<OverlayEntry> createOverlayEntries();\n'
                    '\n'
                    '  List<OverlayEntry> get overlayEntries;\n'
                    '  bool get finishedWhenPopped;\n'
                    '  void install();\n'
                    '  void dispose();\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepTeal)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'OverlayRoute bridges the Route system and the Overlay system. '
                'When a route is pushed onto the Navigator, install() is called '
                'which invokes createOverlayEntries() to create OverlayEntry '
                'objects. These entries are then inserted into the Navigator\u0027s '
                'Overlay, making the route visible.',
                deepTeal,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. Route hierarchy ───────────────────────────────────────
        sectionHeader('2 \u00b7 Route Class Hierarchy',
            'From abstract Route to concrete page routes',
            teal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightJade),
          ),
          child: Column(
            children: [
              for (final node in [
                (0, 'Route<T>', 'Abstract base — no visual', deepTeal, true),
                (1, 'OverlayRoute<T>', 'Adds Overlay integration', teal, true),
                (2, 'TransitionRoute<T>', 'Adds enter/exit animations', jade, true),
                (3, 'ModalRoute<T>', 'Adds modal barrier + scope', softTeal, true),
                (4, 'PageRoute<T>', 'Adds fullscreenDialog option', accentIndigo, true),
                (5, 'MaterialPageRoute', 'Material slide transition', accentIndigo, false),
                (5, 'CupertinoPageRoute', 'iOS slide-from-right', accentIndigo, false),
                (5, 'PageRouteBuilder', 'Custom callback transition', accentIndigo, false),
              ])
                Padding(
                  padding: EdgeInsets.only(
                      left: node.$1 * 14.0, top: 3, bottom: 3),
                  child: Row(
                    children: [
                      if (node.$1 > 0)
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text('\u2514\u2500',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: softTeal)),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: node.$4.withValues(alpha: node.$5 ? 0.1 : 0.05),
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
              const SizedBox(height: 8),
              infoBox(
                'OverlayRoute is the second level in this hierarchy. It adds the '
                'crucial connection between the Route system (which manages '
                'navigation history) and the Overlay (which manages visual '
                'rendering). Without OverlayRoute, a Route has no way to '
                'display anything on screen.',
                teal,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 4. Lifecycle visual ──────────────────────────────────────
        sectionHeader('3 \u00b7 Route Lifecycle',
            'From push to pop to dispose',
            deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 6; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepTeal, teal, jade, softTeal, accentOrange, accentIndigo][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepTeal, teal, jade, softTeal, accentOrange, accentIndigo][i]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: [deepTeal, teal, jade, softTeal, accentOrange, accentIndigo][i],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text([
                              'Navigator.push(route)',
                              'route.install()',
                              'createOverlayEntries()',
                              'Route is visible',
                              'Navigator.pop(result)',
                              'route.dispose()',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: [deepTeal, teal, jade, softTeal, accentOrange, accentIndigo][i])),
                            Text([
                              'Navigator receives the route and begins installation',
                              'Calls createOverlayEntries() and inserts into Overlay',
                              'Subclass returns OverlayEntry list (the visual content)',
                              'Users see the route, can interact with it',
                              'didPop() is called, triggers finalization if finishedWhenPopped',
                              'OverlayEntries are disposed and removed from Overlay',
                            ][i],
                                style: TextStyle(
                                    fontSize: 10,
                                    color: darkForest)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 5)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.arrow_downward,
                        size: 14,
                        color: softTeal),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. createOverlayEntries ──────────────────────────────────
        sectionHeader('4 \u00b7 createOverlayEntries()',
            'The abstract factory method',
            jade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: jade.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: jade.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '@factory\n'
                    'Iterable<OverlayEntry> createOverlayEntries();',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: jade)),
              ),
              const SizedBox(height: 8),
              fieldRow('Returns', 'Iterable<OverlayEntry>', jade),
              fieldRow('Called by', 'install() method', teal),
              fieldRow('Override in', 'Concrete subclasses', deepTeal),
              const SizedBox(height: 8),
              // What each route type creates
              for (final entry in [
                ('TransitionRoute', '2 entries — barrier + page content',
                    teal),
                ('ModalRoute', '2 entries — modal barrier + builder',
                    jade),
                ('PageRoute', '2 entries — scrim barrier + page scaffold',
                    softTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: entry.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: entry.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(entry.$1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: entry.$3)),
                      ),
                      Expanded(
                        child: Text(entry.$2,
                            style: TextStyle(
                                fontSize: 11, color: darkForest)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Overlay entries visual ────────────────────────────────
        sectionHeader('5 \u00b7 Overlay Entry Stack',
            'How multiple routes create overlapping overlay entries',
            deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightJade),
          ),
          child: Column(
            children: [
              // Visual overlay stack
              Container(
                width: double.infinity,
                height: 200,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: deepTeal.withValues(alpha: 0.03),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepTeal.withValues(alpha: 0.3)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Text('Navigator Overlay',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: deepTeal)),
                    ),
                    // Route 1 entries (bottom)
                    Positioned(
                      top: 20,
                      left: 10,
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                          color: teal.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: teal),
                        ),
                        child: Center(
                          child: Text('Route A — Page Content',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: teal)),
                        ),
                      ),
                    ),
                    // Route 2 barrier
                    Positioned(
                      top: 60,
                      left: 10,
                      child: Container(
                        width: 200,
                        height: 24,
                        decoration: BoxDecoration(
                          color: accentIndigo.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: accentIndigo.withValues(alpha: 0.5)),
                        ),
                        child: Center(
                          child: Text('Route B — Modal Barrier',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: accentIndigo)),
                        ),
                      ),
                    ),
                    // Route 2 content
                    Positioned(
                      top: 88,
                      left: 10,
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                          color: jade.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: jade),
                        ),
                        child: Center(
                          child: Text('Route B — Page Content',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: jade)),
                        ),
                      ),
                    ),
                    // Route 3 barrier
                    Positioned(
                      top: 128,
                      left: 10,
                      child: Container(
                        width: 200,
                        height: 24,
                        decoration: BoxDecoration(
                          color: accentOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: accentOrange.withValues(alpha: 0.5)),
                        ),
                        child: Center(
                          child: Text('Route C — Modal Barrier',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: accentOrange)),
                        ),
                      ),
                    ),
                    // Route 3 content
                    Positioned(
                      top: 156,
                      left: 10,
                      child: Container(
                        width: 200,
                        height: 30,
                        decoration: BoxDecoration(
                          color: softTeal.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: softTeal),
                        ),
                        child: Center(
                          child: Text('Route C — Page Content (TOP)',
                              style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: softTeal)),
                        ),
                      ),
                    ),
                    // Legend arrows
                    Positioned(
                      top: 95,
                      left: 220,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Paint order:',
                              style: TextStyle(
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                  color: deepTeal)),
                          Text('Bottom \u2192 Top',
                              style: TextStyle(
                                  fontSize: 7, color: deepTeal)),
                          Icon(Icons.arrow_downward,
                              size: 12, color: deepTeal),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              infoBox(
                'Each route pushed onto the Navigator creates one or more '
                'OverlayEntry objects. These are stacked in the Overlay. '
                'Modal routes create two entries: a barrier (semi-transparent '
                'scrim) and the page content. The topmost route\u0027s entries '
                'are painted last, appearing on top.',
                deepTeal,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. finishedWhenPopped ────────────────────────────────────
        sectionHeader('6 \u00b7 finishedWhenPopped',
            'Controls auto-finalization behavior',
            teal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
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
                        color: teal.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: teal),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle,
                              size: 24, color: teal),
                          const SizedBox(height: 4),
                          Text('true (default)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: teal)),
                          const Divider(),
                          Text('didPop() immediately calls '
                              'navigator.finalizeRoute()',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkForest)),
                          const SizedBox(height: 4),
                          pill('OverlayRoute', teal, Colors.white),
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
                          Icon(Icons.timer,
                              size: 24, color: accentOrange),
                          const SizedBox(height: 4),
                          Text('false (override)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentOrange)),
                          const Divider(),
                          Text('didPop() does NOT finalize — '
                              'waits for transition to complete',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkForest)),
                          const SizedBox(height: 4),
                          pill('TransitionRoute', accentOrange, Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              infoBox(
                'TransitionRoute overrides finishedWhenPopped to return false. '
                'This allows the exit animation to play before the route is '
                'finalized and disposed. OverlayRoute\u0027s default is true, '
                'meaning routes without transitions are cleaned up immediately.',
                teal,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. install() and dispose() ───────────────────────────────
        sectionHeader('7 \u00b7 install() and dispose()',
            'Entry creation and cleanup',
            jade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: jade.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: jade),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.play_arrow, size: 24, color: jade),
                      Text('install()',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: jade)),
                      const Divider(),
                      Text('1. Calls super.install()\n'
                          '2. Calls createOverlayEntries()\n'
                          '3. Adds entries to _overlayEntries\n'
                          '4. Entries inserted into Overlay',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: darkForest)),
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
                      Icon(Icons.stop, size: 24, color: accentOrange),
                      Text('dispose()',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: accentOrange)),
                      const Divider(),
                      Text('1. For each entry: dispose()\n'
                          '2. _overlayEntries.clear()\n'
                          '3. Calls super.dispose()\n'
                          '4. Entries removed from Overlay',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: darkForest)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Navigator + Overlay interaction ───────────────────────
        sectionHeader('8 \u00b7 Navigator \u2194 Overlay Interaction',
            'How Navigator manages OverlayRoute entries',
            deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightJade),
          ),
          child: Column(
            children: [
              // Two-column: Navigator and Overlay
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: deepTeal.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: deepTeal),
                      ),
                      child: Column(
                        children: [
                          Text('Navigator',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: deepTeal)),
                          const Divider(),
                          for (final task in [
                            'Manages route history stack',
                            'Calls route.install()',
                            'Calls route.didPop()',
                            'Calls route.dispose()',
                            'Owns the Overlay widget',
                          ])
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Text('\u2022 $task',
                                  style: TextStyle(
                                      fontSize: 9, color: darkForest)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 30),
                    child: Icon(Icons.sync_alt,
                        size: 20, color: softTeal),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: jade.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: jade),
                      ),
                      child: Column(
                        children: [
                          Text('Overlay',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: jade)),
                          const Divider(),
                          for (final task in [
                            'Renders OverlayEntry stack',
                            'Manages entry paint order',
                            'Handles entry insertion',
                            'Handles entry removal',
                            'Supports opaque entries',
                          ])
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 1),
                              child: Text('\u2022 $task',
                                  style: TextStyle(
                                      fontSize: 9, color: darkForest)),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              infoBox(
                'The Navigator owns an Overlay widget. When it pushes an '
                'OverlayRoute, the route\u0027s createOverlayEntries() provides '
                'entries that are inserted into that Overlay. The Navigator '
                'controls the lifecycle; the Overlay controls the rendering.',
                deepTeal,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Concrete subclasses ──────────────────────────────────
        sectionHeader('9 \u00b7 Concrete Subclasses',
            'Routes you actually use in code',
            teal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final sub in [
                ('MaterialPageRoute', 'Platform-adaptive page transition. '
                    'Slide-up on Android, slide-right on iOS.',
                    Icons.phone_android, teal),
                ('CupertinoPageRoute', 'iOS-style slide-from-right transition '
                    'with parallax on the previous route.',
                    Icons.phone_iphone, jade),
                ('PageRouteBuilder', 'Build custom transitions with callbacks. '
                    'Fully configurable enter/exit animations.',
                    Icons.build, softTeal),
                ('DialogRoute', 'Shows a dialog as a modal route with a '
                    'dismissible barrier overlay.',
                    Icons.chat_bubble_outline, accentIndigo),
                ('ModalBottomSheetRoute', 'Shows a bottom sheet as a modal '
                    'route with drag-to-dismiss support.',
                    Icons.vertical_align_bottom, accentOrange),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: sub.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: sub.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(sub.$3, size: 18, color: sub.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sub.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: sub.$4)),
                            Text(sub.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkForest)),
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

        // ── 11. OverlayEntry details ─────────────────────────────────
        sectionHeader('10 \u00b7 OverlayEntry Anatomy',
            'What each overlay entry contains',
            jade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: jade.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: jade.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'OverlayEntry({\n'
                    '  required WidgetBuilder builder,\n'
                    '  bool opaque = false,\n'
                    '  bool maintainState = false,\n'
                    '  bool canSizeOverlay = false,\n'
                    '})',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: jade)),
              ),
              const SizedBox(height: 8),
              fieldRow('builder', 'Builds the widget for this entry', jade),
              fieldRow('opaque', 'If true, entries below are not built', teal),
              fieldRow('maintainState', 'Keep state even when covered', deepTeal),
              fieldRow('canSizeOverlay', 'Entry can size the Overlay itself', softTeal),
              const SizedBox(height: 8),
              infoBox(
                'When OverlayRoute.createOverlayEntries() is called, each '
                'returned OverlayEntry wraps a builder function. For a modal '
                'route, entry 1 builds the barrier (a semi-transparent scrim) '
                'and entry 2 builds the actual page content.',
                jade,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Modal barrier ────────────────────────────────────────
        sectionHeader('11 \u00b7 The Modal Barrier',
            'First overlay entry of ModalRoute',
            deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: deepTeal),
                ),
                child: Stack(
                  children: [
                    // Previous page
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: teal.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text('Previous Route Content',
                            style: TextStyle(
                                fontSize: 10, color: teal)),
                      ),
                    ),
                    // Barrier overlay
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Modal Barrier',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withValues(alpha: 0.9))),
                            Text('Overlay Entry #1',
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.white.withValues(alpha: 0.7))),
                          ],
                        ),
                      ),
                    ),
                    // Dialog content (smaller)
                    Positioned(
                      top: 25,
                      left: 50,
                      right: 50,
                      bottom: 25,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: darkForest.withValues(alpha: 0.2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Route Content',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: deepTeal)),
                              Text('Overlay Entry #2',
                                  style: TextStyle(
                                      fontSize: 8, color: softTeal)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              infoBox(
                'ModalRoute (a subclass of OverlayRoute via TransitionRoute) '
                'creates two overlay entries. Entry #1 is the modal barrier — a '
                'semi-transparent scrim that blocks interaction with previous '
                'routes. Entry #2 is the actual page or dialog content.',
                deepTeal,
                paleJade,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Route settings ───────────────────────────────────────
        sectionHeader('12 \u00b7 RouteSettings',
            'Configuration passed to OverlayRoute',
            teal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldRow('name', 'Route name for identification (e.g., "/home")', teal),
              fieldRow('arguments', 'Optional arguments Object passed to the route', jade),
              const Divider(),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: teal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: teal.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'Navigator.push(context,\n'
                    '  MaterialPageRoute(\n'
                    '    settings: RouteSettings(\n'
                    '      name: "/details",\n'
                    '      arguments: {"id": 42},\n'
                    '    ),\n'
                    '    builder: (ctx) => DetailsPage(),\n'
                    '  ),\n'
                    ');',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: teal)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Comparison table ─────────────────────────────────────
        sectionHeader('13 \u00b7 Route Type Comparison',
            'What each level of the hierarchy adds',
            jade, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
              4: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: jade),
                children: [
                  for (final h in ['Feature', 'Overlay\nRoute', 'Transition\nRoute', 'Modal\nRoute', 'Page\nRoute'])
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(h,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 8)),
                    ),
                ],
              ),
              for (final row in [
                ('Overlay entries', '\u2713', '\u2713', '\u2713', '\u2713'),
                ('Animations', '\u2717', '\u2713', '\u2713', '\u2713'),
                ('Modal barrier', '\u2717', '\u2717', '\u2713', '\u2713'),
                ('Scoped navigator', '\u2717', '\u2717', '\u2713', '\u2713'),
                ('fullscreenDialog', '\u2717', '\u2717', '\u2717', '\u2713'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: deepTeal)),
                    ),
                    for (final cell in [row.$2, row.$3, row.$4, row.$5])
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(cell,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 9,
                                color: cell == '\u2713'
                                    ? jade
                                    : accentOrange)),
                      ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance ──────────────────────────────────────────
        sectionHeader('14 \u00b7 Performance Notes',
            'Lightweight by design', deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteJade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('Lazy entry building', 'Overlay entries only build their '
                    'widgets when visible', Icons.visibility, teal),
                ('Opaque optimization', 'Entries below an opaque entry skip '
                    'building entirely', Icons.layers_clear, jade),
                ('Immediate cleanup', 'dispose() releases all overlay entry '
                    'resources promptly', Icons.delete_sweep, deepTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: perf.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: perf.$4, width: 2)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(perf.$3, size: 16, color: perf.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: '${perf.$1}: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: perf.$4)),
                            TextSpan(
                                text: perf.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkForest)),
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
            'Key takeaways', deepTeal, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepTeal, teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Abstract base class bridging Route system and Overlay rendering',
                'createOverlayEntries() is the factory for visual content',
                'install() creates entries; dispose() cleans them up',
                'finishedWhenPopped controls immediate vs deferred finalization',
                'TransitionRoute overrides finishedWhenPopped for animation support',
                'Every visible route (pages, dialogs, sheets) extends OverlayRoute',
                'Navigator manages the route stack; Overlay renders the entries',
                'Modal routes create 2 entries: barrier + content',
                'Opaque entries prevent building of entries below them',
                'Foundation class — rarely used directly, always inherited',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightJade,
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
