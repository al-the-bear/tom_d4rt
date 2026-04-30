// ignore_for_file: avoid_print
// D4rt deep demo: OverlayPortalController — show/hide/toggle overlay visibility
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Wine / Rose ───────────────────────────────────────────
  const deepWine = Color(0xFF880E4F);
  const wine = Color(0xFFAD1457);
  const rose = Color(0xFFC2185B);
  const softWine = Color(0xFFD81B60);
  const lightRose = Color(0xFFF8BBD0);
  const paleWine = Color(0xFFFCE4EC);
  const whiteRose = Color(0xFFFFF0F3);
  const darkBurgundy = Color(0xFF4A0028);
  const accentTeal = Color(0xFF00695C);
  const accentGold = Color(0xFFF57F17);

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
          style: TextStyle(fontSize: 13, color: darkBurgundy)),
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
                style: TextStyle(fontSize: 13, color: darkBurgundy)),
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
  print('OverlayPortalController deep demo executing');
  print('=' * 60);

  print('\n--- OverlayPortalController class ---');
  print('Defined in widgets/overlay.dart line 1618');
  print('Constructor: OverlayPortalController({String? debugLabel})');
  print('Methods: show(), hide(), toggle()');
  print('Getter: isShowing');

  print('\n--- show() ---');
  print('Makes the overlay child visible');
  print('Can be called before controller is attached');

  print('\n--- hide() ---');
  print('Makes the overlay child invisible');
  print('Can be called before controller is attached');

  print('\n--- toggle() ---');
  print('Switches visibility: show -> hide, hide -> show');

  print('\n--- isShowing ---');
  print('Returns true if the overlay child is currently visible');

  print('\n--- Key behaviors ---');
  print('Uses monotonically increasing _wallTime for z-ordering');
  print('show() calls always put overlay on top of others');
  print('Can be called before attachment (deferred)');

  print('\n${'=' * 60}');
  print('OverlayPortalController deep demo completed');

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
              colors: [deepWine, wine, rose],
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
                  Icon(Icons.toggle_on, size: 28, color: lightRose),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('OverlayPortalController',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('A controller that manages the visibility of an '
                  'OverlayPortal\u0027s overlay child. Provides show(), '
                  'hide(), toggle(), and isShowing for imperative '
                  'overlay control.',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                pill('class', wine, Colors.white),
                pill('show()', rose, Colors.white),
                pill('hide()', softWine, Colors.white),
                pill('toggle()', lightRose, darkBurgundy),
                pill('isShowing', paleWine, darkBurgundy),
              ]),
            ],
          ),
        ),

        // ── 2. Constructor ───────────────────────────────────────────
        sectionHeader('1 \u00b7 Constructor',
            'Creating an OverlayPortalController',
            deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepWine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepWine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'OverlayPortalController({\n'
                    '  String? debugLabel,\n'
                    '})',
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'monospace',
                        color: deepWine)),
              ),
              const SizedBox(height: 8),
              fieldRow('debugLabel', 'Optional label for diagnostics', deepWine),
              fieldRow('Initial state', 'Not showing (isShowing = false)', wine),
              fieldRow('Attachment', 'Pass to OverlayPortal.controller', rose),
              const SizedBox(height: 8),
              infoBox(
                'Create the controller in initState() or as a final field. '
                'The debugLabel appears in error messages and aids debugging '
                'when you have multiple controllers.',
                deepWine,
                paleWine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 3. API methods ───────────────────────────────────────────
        sectionHeader('2 \u00b7 API Methods & Getter',
            'show(), hide(), toggle(), isShowing',
            wine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final method in [
                ('show()', 'void', 'Makes the overlay child visible. '
                    'If already showing, still updates z-order '
                    '(re-brings to top). Increments internal _wallTime.',
                    Icons.visibility, wine),
                ('hide()', 'void', 'Makes the overlay child invisible. '
                    'No-op if already hidden.',
                    Icons.visibility_off, rose),
                ('toggle()', 'void', 'Switches between showing and hidden. '
                    'Equivalent to: isShowing ? hide() : show().',
                    Icons.swap_horiz, softWine),
                ('isShowing', 'bool (getter)', 'Returns true if the overlay '
                    'child is currently visible. Read-only.',
                    Icons.info_outline, deepWine),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: method.$5.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: method.$5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(method.$4, size: 22, color: method.$5),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(method.$1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        fontFamily: 'monospace',
                                        color: method.$5)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: method.$5.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(method.$2,
                                      style: TextStyle(
                                          fontSize: 9,
                                          color: method.$5)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(method.$3,
                                style: TextStyle(
                                    fontSize: 12, color: darkBurgundy)),
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

        // ── 4. Lifecycle visual ──────────────────────────────────────
        sectionHeader('3 \u00b7 Controller Lifecycle',
            'Create \u2192 attach \u2192 use \u2192 dispose',
            deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightRose),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: [deepWine, wine, rose, softWine][i]
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: [deepWine, wine, rose, softWine][i]),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: [deepWine, wine, rose, softWine][i],
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
                              'Create controller',
                              'Pass to OverlayPortal',
                              'Call show/hide/toggle',
                              'Dispose with State',
                            ][i],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: [deepWine, wine, rose, softWine][i])),
                            Text([
                              'final controller = OverlayPortalController();',
                              'OverlayPortal(controller: controller, ...)',
                              'controller.show(); controller.toggle();',
                              'Controller is automatically cleaned up',
                            ][i],
                                style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'monospace',
                                    color: darkBurgundy)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (i < 3)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Icon(Icons.arrow_downward,
                        size: 16, color: softWine),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 5. State machine ─────────────────────────────────────────
        sectionHeader('4 \u00b7 State Machine',
            'Two states with three transitions',
            wine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Hidden state
                  Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: rose.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: rose, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility_off,
                            size: 18, color: rose),
                        Text('Hidden',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: rose)),
                        Text('isShowing: false',
                            style: TextStyle(
                                fontSize: 8, color: darkBurgundy)),
                      ],
                    ),
                  ),
                  // Arrows
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('show()',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: wine)),
                          Icon(Icons.arrow_forward,
                              size: 14, color: wine),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.arrow_back,
                              size: 14, color: rose),
                          Text('hide()',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: rose)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: softWine.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('toggle()',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: softWine)),
                      ),
                    ],
                  ),
                  // Showing state
                  Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: wine.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: wine, width: 2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.visibility,
                            size: 18, color: wine),
                        Text('Showing',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: wine)),
                        Text('isShowing: true',
                            style: TextStyle(
                                fontSize: 8, color: darkBurgundy)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              infoBox(
                'toggle() is a convenience that calls show() when hidden '
                'or hide() when showing. Calling show() when already '
                'showing re-pushes the overlay to the top of the z-stack.',
                wine,
                paleWine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 6. Z-ordering behavior ───────────────────────────────────
        sectionHeader('5 \u00b7 Z-Ordering Behavior',
            'show() always brings to top via _wallTime',
            deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepWine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepWine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Internal implementation concept\n'
                    'static int _wallTime = 0;\n'
                    '\n'
                    'void show() {\n'
                    '  _zOrderIndex = _wallTime++;\n'
                    '  _isShowing = true;\n'
                    '  // Triggers rebuild, overlay sorts by z-index\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepWine)),
              ),
              const SizedBox(height: 8),
              // Visual z-stack
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: wine.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: wine),
                ),
                child: Column(
                  children: [
                    Text('Z-Stack After Multiple show() Calls',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: wine)),
                    const SizedBox(height: 6),
                    for (final layer in [
                      ('Controller C (show at t=3)', wine, true),
                      ('Controller A (show at t=2)', rose, false),
                      ('Controller B (show at t=1)', softWine, false),
                    ])
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: layer.$2.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: layer.$2,
                              width: layer.$3 ? 2 : 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(layer.$1,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: layer.$3
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: layer.$2)),
                            ),
                            if (layer.$3)
                              Text('TOP',
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: layer.$2)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              infoBox(
                'Each show() call increments a global monotonic counter. '
                'Overlay children are painted in order of their counter '
                'value. Calling show() on an already-visible controller '
                're-raises it to the top.',
                deepWine,
                paleWine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Pre-attachment calls ──────────────────────────────────
        sectionHeader('6 \u00b7 Pre-Attachment Behavior',
            'Calling show()/hide() before the controller is attached',
            rose, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: rose.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: rose.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Valid: show before build tree attaches\n'
                    'final controller = OverlayPortalController();\n'
                    'controller.show(); // OK — saved, applied on attach\n'
                    '\n'
                    '// Later in build:\n'
                    'OverlayPortal(\n'
                    '  controller: controller,\n'
                    '  // Overlay child is immediately visible\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: rose)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'The controller queues show/hide state changes internally. '
                'When the OverlayPortal is finally attached (during build), '
                'it reads the current state. This allows you to set initial '
                'visibility in initState before the widget tree builds.',
                rose,
                paleWine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Usage code pattern ────────────────────────────────────
        sectionHeader('7 \u00b7 Complete Usage Pattern',
            'Typical OverlayPortal + Controller code',
            wine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: wine.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: wine.withValues(alpha: 0.3)),
            ),
            child: Text(
                'class MyDropdown extends StatefulWidget {\n'
                '  State<MyDropdown> createState() =>\n'
                '    _MyDropdownState();\n'
                '}\n'
                '\n'
                'class _MyDropdownState\n'
                '    extends State<MyDropdown> {\n'
                '  final _ctrl = OverlayPortalController();\n'
                '\n'
                '  Widget build(BuildContext context) {\n'
                '    return OverlayPortal(\n'
                '      controller: _ctrl,\n'
                '      overlayChildBuilder: (ctx) {\n'
                '        return Positioned(\n'
                '          top: 48,\n'
                '          child: Card(\n'
                '            child: Text("Dropdown"),\n'
                '          ),\n'
                '        );\n'
                '      },\n'
                '      child: ElevatedButton(\n'
                '        onPressed: _ctrl.toggle,\n'
                '        child: Text("Open"),\n'
                '      ),\n'
                '    );\n'
                '  }\n'
                '}',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'monospace',
                    color: wine)),
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Comparison: show vs toggle vs hide ────────────────────
        sectionHeader('8 \u00b7 show() vs toggle() vs hide()',
            'When to use each method',
            deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final method in [
                ('show()', 'Opening overlay from a known closed state',
                    'Button click to open menu, programmatic open on data load',
                    wine),
                ('hide()', 'Closing overlay from a known open state',
                    'Dismiss on outside tap, close on navigation, timeout close',
                    rose),
                ('toggle()', 'Switching state when current state is unknown',
                    'Toggle button, FAB action, keyboard shortcut handler',
                    softWine),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: method.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: method.$4, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(method.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontFamily: 'monospace',
                              color: method.$4)),
                      Text(method.$2,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: darkBurgundy)),
                      Text(method.$3,
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: method.$4)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Multiple controllers ─────────────────────────────────
        sectionHeader('9 \u00b7 Multiple Controllers',
            'Managing several overlays independently',
            wine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: wine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: wine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'final menuCtrl = OverlayPortalController(\n'
                    '  debugLabel: "menu");\n'
                    'final tooltipCtrl = OverlayPortalController(\n'
                    '  debugLabel: "tooltip");\n'
                    'final searchCtrl = OverlayPortalController(\n'
                    '  debugLabel: "search");',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: wine)),
              ),
              const SizedBox(height: 8),
              // Visual: three overlays
              Row(
                children: [
                  for (final ctrl in [
                    ('Menu', Icons.menu, wine),
                    ('Tooltip', Icons.chat_bubble, rose),
                    ('Search', Icons.search, softWine),
                  ])
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ctrl.$3.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ctrl.$3),
                        ),
                        child: Column(
                          children: [
                            Icon(ctrl.$2, size: 20, color: ctrl.$3),
                            const SizedBox(height: 4),
                            Text(ctrl.$1,
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: ctrl.$3)),
                            const SizedBox(height: 2),
                            Text('Independent',
                                style: TextStyle(
                                    fontSize: 8,
                                    color: darkBurgundy)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              infoBox(
                'Each OverlayPortalController manages exactly one '
                'OverlayPortal. Use separate controllers for independent '
                'overlays. The debugLabel helps identify controllers in '
                'error messages and DevTools.',
                wine,
                paleWine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Mutual exclusion pattern ─────────────────────────────
        sectionHeader('10 \u00b7 Mutual Exclusion Pattern',
            'Closing one overlay when another opens',
            deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepWine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepWine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'void openMenu() {\n'
                    '  tooltipCtrl.hide();  // close others first\n'
                    '  searchCtrl.hide();\n'
                    '  menuCtrl.show();     // then open target\n'
                    '}\n'
                    '\n'
                    'void closeAll() {\n'
                    '  menuCtrl.hide();\n'
                    '  tooltipCtrl.hide();\n'
                    '  searchCtrl.hide();\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepWine)),
              ),
              const SizedBox(height: 8),
              infoBox(
                'There is no built-in mutual exclusion. To ensure only one '
                'overlay is visible at a time, hide all other controllers '
                'before calling show() on the target controller.',
                deepWine,
                paleWine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. Dismissal patterns ───────────────────────────────────
        sectionHeader('11 \u00b7 Dismissal Patterns',
            'Common ways to hide an overlay',
            rose, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final dismiss in [
                ('Tap outside', 'Wrap overlay child in TapRegion or use '
                    'GestureDetector on a barrier widget',
                    Icons.touch_app, wine),
                ('Back button', 'Use PopScope in the overlay child to '
                    'intercept back navigation',
                    Icons.arrow_back, rose),
                ('Timeout', 'Start a Timer in overlayChildBuilder, call '
                    'controller.hide() when it fires',
                    Icons.timer, softWine),
                ('Navigation', 'Listen to NavigatorObserver or route '
                    'changes, hide on route transition',
                    Icons.exit_to_app, deepWine),
                ('Programmatic', 'Call hide() directly from any event '
                    'handler or callback',
                    Icons.code, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: dismiss.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: dismiss.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(dismiss.$3, size: 18, color: dismiss.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(dismiss.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: dismiss.$4)),
                            Text(dismiss.$2,
                                style: TextStyle(
                                    fontSize: 11, color: darkBurgundy)),
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

        // ── 13. Comparison with other controllers ────────────────────
        sectionHeader('12 \u00b7 vs Other Flutter Controllers',
            'How it differs from common controller patterns',
            wine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: wine),
                children: [
                  for (final h in ['Aspect', 'OverlayPortal\nController', 'Animation\nController', 'TextEditing\nController'])
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
                ('Extends', 'Object', 'Animation<T>', 'ValueNotifier'),
                ('dispose()', 'No', 'Yes', 'Yes'),
                ('Listeners', 'No', 'Yes', 'Yes'),
                ('States', '2 (bool)', 'Continuous', 'String'),
                ('Rebuild', 'Automatic', 'Manual', 'Manual'),
              ])
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 8,
                              color: deepWine)),
                    ),
                    for (final cell in [row.$2, row.$3, row.$4])
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text(cell,
                            style: TextStyle(
                                fontSize: 8, color: darkBurgundy)),
                      ),
                  ],
                ),
            ],
          ),
        ),
        infoBox(
          'Unlike most Flutter controllers, OverlayPortalController does '
          'not extend ChangeNotifier and has no dispose() method. It '
          'manages only a boolean state (showing/hidden) and triggers '
          'rebuilds automatically through OverlayPortal.',
          wine,
          paleWine,
        ),
        const SizedBox(height: 14),

        // ── 14. Error handling ───────────────────────────────────────
        sectionHeader('13 \u00b7 Error Scenarios',
            'Common errors and how to avoid them',
            deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final error in [
                ('Multiple OverlayPortals',
                    'A controller can only be attached to one OverlayPortal '
                    'at a time. Attaching to a second throws an assertion error.',
                    accentGold),
                ('No Overlay ancestor',
                    'OverlayPortal requires an Overlay ancestor in the tree. '
                    'MaterialApp provides one; standalone widgets may not.',
                    accentGold),
                ('Build-phase show/hide',
                    'Calling show() or hide() during build is allowed — '
                    'the state is applied after the current frame.',
                    accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: error.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: error.$3, width: 3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(error.$1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: error.$3)),
                      Text(error.$2,
                          style: TextStyle(
                              fontSize: 11, color: darkBurgundy)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Performance ──────────────────────────────────────────
        sectionHeader('14 \u00b7 Performance Characteristics',
            'Lightweight imperatively-driven overlay control',
            wine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteRose,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final perf in [
                ('No ChangeNotifier', 'No listener list overhead — direct '
                    'state management', Icons.flash_on, wine),
                ('Boolean state', 'Single bool flip — minimal work per '
                    'show/hide call', Icons.toggle_on, rose),
                ('No dispose needed', 'No cleanup bookkeeping — no listener '
                    'leak risk', Icons.delete_outline, deepWine),
                ('Automatic rebuild', 'Only the OverlayPortal widget rebuilds '
                    'when state changes', Icons.refresh, softWine),
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
                                    fontSize: 11, color: darkBurgundy)),
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
            'Key takeaways', deepWine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepWine, wine],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Controls overlay visibility for exactly one OverlayPortal',
                'Constructor takes optional debugLabel for diagnostics',
                'show() makes overlay visible and pushes to top z-order',
                'hide() makes overlay invisible (no-op if already hidden)',
                'toggle() convenience: isShowing ? hide() : show()',
                'isShowing getter reports current visibility state',
                'Can call show/hide before attachment (deferred state)',
                'Uses monotonic _wallTime counter for z-ordering',
                'Does not extend ChangeNotifier — no dispose needed',
                'One controller per OverlayPortal — no sharing',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightRose,
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
