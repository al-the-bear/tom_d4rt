// ignore_for_file: avoid_print
// D4rt deep demo: NextFocusIntent — intent requesting forward focus traversal
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Pewter / Sterling ─────────────────────────────────────
  const deepPewter = Color(0xFF424242);
  const pewter = Color(0xFF616161);
  const sterling = Color(0xFF9E9E9E);
  const softPewter = Color(0xFFBDBDBD);
  const lightSterling = Color(0xFFE0E0E0);
  const palePewter = Color(0xFFF5F5F5);
  const whitePewter = Color(0xFFFAFAFA);
  const accentBlue = Color(0xFF1565C0);
  const accentTeal = Color(0xFF00897B);
  const accentAmber = Color(0xFFFF8F00);

  // ── Helpers ────────────────────────────────────────────────────────
  Widget sectionBanner(String title, String subtitle, Color bg, Color fg) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bg, bg.withValues(alpha: 0.78)],
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

  Widget noteBox(String text, Color border, Color bg) {
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
          style: TextStyle(fontSize: 13, color: deepPewter)),
    );
  }

  Widget dataRow(String label, String value, Color accent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 170,
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: accent)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 13, color: deepPewter)),
          ),
        ],
      ),
    );
  }

  Widget tag(String text, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 11, color: fg)),
    );
  }

  // ── Print diagnostics ──────────────────────────────────────────────
  print('NextFocusIntent deep demo executing');
  print('=' * 60);

  print('\n--- Intent pattern overview ---');
  print('NextFocusIntent extends Intent');
  print('It carries no data — just "move focus forward"');
  print('const NextFocusIntent() — a simple flag class');
  print('Mapped to Tab key by default in WidgetsApp');

  print('\n--- Intent / Action pairing ---');
  print('NextFocusIntent  ->  NextFocusAction');
  print('PreviousFocusIntent  ->  PreviousFocusAction');
  print('DirectionalFocusIntent  ->  DirectionalFocusAction');
  print('RequestFocusIntent  ->  RequestFocusAction');

  print('\n--- Key bindings ---');
  print('Tab -> NextFocusIntent()');
  print('Shift+Tab -> PreviousFocusIntent()');

  print('\n${'=' * 60}');
  print('NextFocusIntent deep demo completed');

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
              colors: [deepPewter, pewter, sterling],
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
                  Icon(Icons.input, size: 28, color: lightSterling),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NextFocusIntent',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Intent subclass — a declarative request to move keyboard '
                  'focus to the next focusable widget in traversal order',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Intent', sterling, Colors.white),
                tag('const constructor', softPewter, deepPewter),
                tag('Tab key', lightSterling, deepPewter),
                tag('No parameters', palePewter, deepPewter),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NextFocusIntent',
            'A parameter-free intent describing forward focus traversal',
            deepPewter, Colors.white),
        noteBox(
          'NextFocusIntent is a concrete subclass of Intent with a const '
          'constructor taking no arguments. It represents the user\u0027s wish '
          'to move focus to the next focusable widget. By itself it does '
          'nothing — it must be paired with an Action (NextFocusAction) that '
          'interprets it. This separation of what from how is the core of '
          'Flutter\u0027s Intent/Action pattern.',
          pewter,
          whitePewter,
        ),
        dataRow('Extends', 'Intent', pewter),
        dataRow('Constructor', 'const NextFocusIntent()', deepPewter),
        dataRow('Parameters', 'None', sterling),
        dataRow('Paired action', 'NextFocusAction', accentBlue),
        dataRow('Default shortcut', 'Tab key (via WidgetsApp)', accentTeal),
        dataRow('Defined in', 'widgets/focus_traversal.dart', deepPewter),
        const SizedBox(height: 14),

        // ── 3. Intent / Action pattern ───────────────────────────────
        sectionBanner('2 \u00b7 The Intent / Action Design Pattern',
            'Decoupling "what" from "how" in Flutter\u0027s input system',
            pewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSterling),
          ),
          child: Column(
            children: [
              // Shortcut
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentAmber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentAmber),
                ),
                child: Row(
                  children: [
                    Icon(Icons.keyboard, size: 20, color: accentAmber),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Shortcuts widget',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: accentAmber)),
                          Text('Tab key \u2192 NextFocusIntent()',
                              style: TextStyle(
                                  fontSize: 10, color: deepPewter)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 16, color: sterling),
                    Text('creates',
                        style: TextStyle(fontSize: 8, color: sterling)),
                  ],
                ),
              ),
              // Intent
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentBlue.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentBlue, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.input, size: 20, color: accentBlue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NextFocusIntent',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: accentBlue)),
                          Text('What: "move focus forward"',
                              style: TextStyle(
                                  fontSize: 10, color: deepPewter)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Icon(Icons.arrow_downward, size: 16, color: sterling),
                    Text('dispatched to',
                        style: TextStyle(fontSize: 8, color: sterling)),
                  ],
                ),
              ),
              // Action
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentTeal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentTeal),
                ),
                child: Row(
                  children: [
                    Icon(Icons.play_circle_fill, size: 20,
                        color: accentTeal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NextFocusAction',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: accentTeal)),
                          Text('How: primaryFocus!.nextFocus()',
                              style: TextStyle(
                                  fontSize: 10, color: deepPewter)),
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

        // ── 4. Why parameterless ─────────────────────────────────────
        sectionBanner('3 \u00b7 Why No Parameters?',
            'Intent simplicity and the power of convention',
            sterling, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final reason in [
                ('Deterministic', 'The next focusable widget is determined '
                    'by the FocusTraversalPolicy, not by the intent. There '
                    'is nothing to configure.',
                    Icons.gps_fixed, pewter),
                ('Const-able', 'With no parameters, the intent can be '
                    'const-constructed. This is efficient for shortcut maps '
                    'which are rebuilt on every frame.',
                    Icons.flash_on, accentAmber),
                ('Composable', 'If you want a different traversal target, '
                    'you use a different intent (RequestFocusIntent) or a '
                    'different policy — not a different parameter.',
                    Icons.extension, accentBlue),
                ('Self-documenting', 'The class name says everything: '
                    '"move to the next focus." No ambiguity about what '
                    '"next" means — the policy decides.',
                    Icons.description, accentTeal),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: reason.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: reason.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(reason.$3, size: 20, color: reason.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(reason.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepPewter)),
                            Text(reason.$2,
                                style: TextStyle(
                                    fontSize: 11, color: deepPewter)),
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

        // ── 5. Class definition ──────────────────────────────────────
        sectionBanner('4 \u00b7 Class Definition',
            'The SDK source', pewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepPewter.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepPewter.withValues(alpha: 0.3)),
            ),
            child: Text(
                'class NextFocusIntent extends Intent {\n'
                '  const NextFocusIntent();\n'
                '}',
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: deepPewter)),
          ),
        ),
        noteBox(
          'That\u0027s the entire class. Three lines. It extends Intent, provides '
          'a const constructor, and that\u0027s all. The simplicity is intentional '
          '— the Intent is a message, not a behavior. Behavior lives in the '
          'paired Action.',
          pewter,
          palePewter,
        ),
        const SizedBox(height: 14),

        // ── 6. Hierarchy ─────────────────────────────────────────────
        sectionBanner('5 \u00b7 Class Hierarchy',
            'Inheritance chain', deepPewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', Colors.grey),
                ('\u2514\u2500 Intent', sterling),
                ('    \u2514\u2500 NextFocusIntent', deepPewter),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight:
                              level.$1.contains('NextFocusIntent')
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. All focus intents table ───────────────────────────────
        sectionBanner('6 \u00b7 Focus Intent Family',
            'All focus-related intents in Flutter',
            pewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(3),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: deepPewter),
                children: [
                  for (final h in ['Intent', 'Key', 'Params'])
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(h,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10)),
                    ),
                ],
              ),
              for (final row in [
                ('NextFocusIntent', 'Tab', 'None'),
                ('PreviousFocusIntent', 'Shift+Tab', 'None'),
                ('DirectionalFocusIntent', 'Arrow keys',
                    'TraversalDirection'),
                ('RequestFocusIntent', 'Custom', 'FocusNode'),
                ('DismissIntent', 'Escape', 'None'),
              ])
                TableRow(
                  decoration: row.$1 == 'NextFocusIntent'
                      ? BoxDecoration(
                          color: accentBlue.withValues(alpha: 0.06))
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: row.$1 == 'NextFocusIntent'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$1 == 'NextFocusIntent'
                                  ? accentBlue
                                  : deepPewter)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: deepPewter)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: deepPewter)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Default shortcut registration ─────────────────────────
        sectionBanner('7 \u00b7 Default Shortcut Registration',
            'How WidgetsApp connects Tab to NextFocusIntent',
            sterling, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepPewter.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepPewter.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// WidgetsApp default shortcuts (simplified)\n'
                    'final Map<ShortcutActivator, Intent> shortcuts = {\n'
                    '  LogicalKeySet(LogicalKeyboardKey.tab):\n'
                    '      const NextFocusIntent(),\n'
                    '  LogicalKeySet(\n'
                    '    LogicalKeyboardKey.shift,\n'
                    '    LogicalKeyboardKey.tab,\n'
                    '  ): const PreviousFocusIntent(),\n'
                    '};',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepPewter)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'The const keyword is key. Because NextFocusIntent has no '
                'parameters and a const constructor, the same instance is '
                'reused across rebuilds. The Shortcuts widget uses '
                'ShortcutActivator keys (like LogicalKeySet) to map physical '
                'keys to Intent objects.',
                pewter,
                palePewter,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 9. Visual: Tab press lifecycle ───────────────────────────
        sectionBanner('8 \u00b7 Tab Key Press Lifecycle',
            'Step-by-step from keypress to focus move',
            deepPewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSterling),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 6; i++)
                ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: [
                        accentAmber,
                        accentBlue,
                        accentTeal,
                        pewter,
                        deepPewter,
                        Color(0xFF2E7D32),
                      ][i]
                          .withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: [
                        accentAmber,
                        accentBlue,
                        accentTeal,
                        pewter,
                        deepPewter,
                        Color(0xFF2E7D32),
                      ][i]),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: [
                              accentAmber,
                              accentBlue,
                              accentTeal,
                              pewter,
                              deepPewter,
                              Color(0xFF2E7D32),
                            ][i],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('${i + 1}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text([
                            'User presses Tab key',
                            'Shortcuts widget matches LogicalKeySet(tab)',
                            'Creates const NextFocusIntent()',
                            'Actions widget finds NextFocusAction',
                            'NextFocusAction.invoke() calls nextFocus()',
                            'Focus moves to next widget in traversal order',
                          ][i],
                              style: TextStyle(
                                  fontSize: 11, color: deepPewter)),
                        ),
                      ],
                    ),
                  ),
                  if (i < 5)
                    Center(
                      child: Icon(Icons.arrow_downward,
                          size: 14, color: lightSterling),
                    ),
                ],
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Overriding the shortcut ──────────────────────────────
        sectionBanner('9 \u00b7 Overriding the Tab Shortcut',
            'Mapping Tab to a different intent or adding logic',
            pewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepPewter.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepPewter.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Remap Tab to a custom intent\n'
                    'Shortcuts(\n'
                    '  shortcuts: {\n'
                    '    LogicalKeySet(LogicalKeyboardKey.tab):\n'
                    '        MyCustomTabIntent(),\n'
                    '  },\n'
                    '  child: Actions(\n'
                    '    actions: {\n'
                    '      MyCustomTabIntent:\n'
                    '          MyCustomTabAction(),\n'
                    '    },\n'
                    '    child: myWidget,\n'
                    '  ),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepPewter)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'You can override the shortcut by placing a Shortcuts widget '
                'higher in the tree with a new mapping for Tab. The closest '
                'Shortcuts widget to the focused node wins. This is useful for '
                'code editors where Tab should insert spaces rather than '
                'move focus.',
                pewter,
                palePewter,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Intents vs callbacks ─────────────────────────────────
        sectionBanner('10 \u00b7 Why Intents Instead of Callbacks',
            'The design rationale behind Intent/Action',
            sterling, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final point in [
                ('Testability', 'Intents can be dispatched programmatically '
                    'in tests without simulating key events.',
                    Icons.science, accentTeal),
                ('Separation', 'The key binding (Shortcuts), the request '
                    '(Intent), and the handler (Action) are all independent '
                    'and replaceable.',
                    Icons.account_tree, accentBlue),
                ('Discoverability', 'The Actions widget can query isEnabled '
                    'for an intent before invoking, enabling UI to disable '
                    'menu items or buttons.',
                    Icons.search, accentAmber),
                ('Hierarchy', 'Actions walk up the widget tree to find the '
                    'nearest handler. Different subtrees can handle the same '
                    'intent differently.',
                    Icons.layers, pewter),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: point.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: point.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(point.$3, size: 20, color: point.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(point.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepPewter)),
                            Text(point.$2,
                                style: TextStyle(
                                    fontSize: 11, color: deepPewter)),
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

        // ── 12. Live demo: invoking programmatically ─────────────────
        sectionBanner('11 \u00b7 Programmatic Dispatch',
            'Invoking NextFocusIntent from code instead of keyboard',
            deepPewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightSterling),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepPewter.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepPewter.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Move focus forward from code\n'
                    'Actions.invoke(\n'
                    '  context,\n'
                    '  const NextFocusIntent(),\n'
                    ');',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepPewter)),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  Actions.invoke(context, const NextFocusIntent());
                },
                icon: Icon(Icons.arrow_forward, size: 16),
                label: Text('Move Focus Forward',
                    style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: pewter,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              noteBox(
                'This button invokes NextFocusIntent programmatically via '
                'Actions.invoke(). It achieves the same result as pressing Tab '
                '— the Action system finds the nearest NextFocusAction and '
                'calls invoke() on it.',
                pewter,
                palePewter,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. isEnabled check ──────────────────────────────────────
        sectionBanner('12 \u00b7 Checking If Action Is Enabled',
            'Query whether NextFocusIntent can be handled',
            pewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepPewter.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepPewter.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// Check if the intent is handled\n'
                    'final isEnabled = Actions.maybeFind<\n'
                    '    NextFocusIntent>(context) != null;',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepPewter)),
              ),
              const SizedBox(height: 8),
              Builder(builder: (ctx) {
                // Cluster C20e workaround: the d4rt interpreter erases the
                // generic type argument across the bridge boundary, so
                // `Actions.maybeFind<NextFocusIntent>(ctx)` resolves to
                // `T = Intent` inside Flutter and trips the
                // `assert(type != Intent)` check at
                // `package:flutter/src/widgets/actions.dart:866`. Passing a
                // concrete `NextFocusIntent` instance via the optional
                // `intent` parameter pins the runtime type without relying
                // on the erased type argument.
                final action = Actions.maybeFind<NextFocusIntent>(
                  ctx,
                  intent: const NextFocusIntent(),
                );
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: action != null
                        ? Color(0xFF2E7D32).withValues(alpha: 0.06)
                        : Color(0xFFE53935).withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: action != null
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE53935)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                          action != null
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 20,
                          color: action != null
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFE53935)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                            action != null
                                ? 'NextFocusAction is registered in this context'
                                : 'No NextFocusAction found in this context',
                            style: TextStyle(
                                fontSize: 12, color: deepPewter)),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 14. Common patterns ──────────────────────────────────────
        sectionBanner('13 \u00b7 Common Patterns',
            'Where you encounter NextFocusIntent in real apps',
            sterling, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final pattern in [
                ('Form navigation', 'Tab between text fields in a form. '
                    'Most common use — works automatically with TextField.',
                    Icons.edit_note, accentBlue),
                ('Toolbar buttons', 'Tab through a row of toolbar buttons '
                    'or icon actions. ReadingOrderTraversalPolicy handles '
                    'left-to-right order.',
                    Icons.construction, accentTeal),
                ('Dialog focus', 'Tab through dialog body and action '
                    'buttons. FocusScope wrapping the dialog limits traversal.',
                    Icons.open_in_new, accentAmber),
                ('Custom shortcuts', 'Remap Tab for special inputs '
                    '(code editors, spreadsheets) while still using '
                    'NextFocusIntent for adjacent widgets.',
                    Icons.keyboard_alt, pewter),
                ('Accessibility testing', 'Dispatch NextFocusIntent '
                    'programmatically to verify correct Tab order in '
                    'widget tests.',
                    Icons.accessibility, deepPewter),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: pattern.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: pattern.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(pattern.$3, size: 20, color: pattern.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pattern.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: deepPewter)),
                            Text(pattern.$2,
                                style: TextStyle(
                                    fontSize: 11, color: deepPewter)),
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

        // ── 15. Intent comparison ────────────────────────────────────
        sectionBanner('14 \u00b7 Parameter Comparison',
            'NextFocusIntent vs more complex intents',
            deepPewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whitePewter,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              // Simple
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentBlue.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentBlue, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.looks_one, size: 20,
                            color: accentBlue),
                        const SizedBox(width: 8),
                        Text('NextFocusIntent — zero parameters',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: accentBlue)),
                      ],
                    ),
                    Text('const NextFocusIntent()',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: deepPewter)),
                  ],
                ),
              ),
              // With direction
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentTeal.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentTeal),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.looks_two, size: 20,
                            color: accentTeal),
                        const SizedBox(width: 8),
                        Text('DirectionalFocusIntent — direction param',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: accentTeal)),
                      ],
                    ),
                    Text('DirectionalFocusIntent(TraversalDirection.right)',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: deepPewter)),
                  ],
                ),
              ),
              // With node
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentAmber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentAmber),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.looks_3, size: 20,
                            color: accentAmber),
                        const SizedBox(width: 8),
                        Text('RequestFocusIntent — node param',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: accentAmber)),
                      ],
                    ),
                    Text('RequestFocusIntent(specificNode)',
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'monospace',
                            color: deepPewter)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepPewter, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepPewter, pewter],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends Intent — the simplest possible intent class',
                'const NextFocusIntent() — zero parameters, const-constructible',
                'Declares "move focus forward" without specifying how',
                'Paired with NextFocusAction which calls primaryFocus.nextFocus()',
                'Mapped to Tab key by default in WidgetsApp / MaterialApp',
                'Shift+Tab maps to PreviousFocusIntent instead',
                'FocusTraversalPolicy determines actual traversal order',
                'Can be overridden with Shortcuts widget for custom behavior',
                'Dispatchable programmatically via Actions.invoke()',
                'Core of Flutter\u0027s testable, composable input system',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightSterling,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Expanded(
                        child: Text(point,
                            style: TextStyle(
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
