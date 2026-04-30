// ignore_for_file: avoid_print
// D4rt deep demo: NextFocusAction — action that moves focus to the next focusable node
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ── Palette: Tangerine / Apricot ───────────────────────────────────
  const deepTangerine = Color(0xFFE65100);
  const tangerine = Color(0xFFEF6C00);
  const apricot = Color(0xFFF57C00);
  const softTangerine = Color(0xFFFB8C00);
  const lightApricot = Color(0xFFFFB74D);
  const paleTangerine = Color(0xFFFFF3E0);
  const whiteTangerine = Color(0xFFFFFAF5);
  const darkBrown = Color(0xFF3E2723);
  const accentIndigo = Color(0xFF3F51B5);
  const accentGreen = Color(0xFF2E7D32);

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
          style: TextStyle(fontSize: 13, color: darkBrown)),
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
                style: TextStyle(fontSize: 13, color: darkBrown)),
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
  print('NextFocusAction deep demo executing');
  print('=' * 60);

  print('\n--- What is NextFocusAction ---');
  print('An Action that handles NextFocusIntent');
  print('Extends Action<NextFocusIntent>');
  print('Moves focus to the next focusable widget');
  print('Invoked by Tab key by default');

  print('\n--- How it works ---');
  print('1. User presses Tab');
  print('2. WidgetsApp dispatches NextFocusIntent');
  print('3. NextFocusAction.invoke() is called');
  print('4. Calls primaryFocus!.nextFocus()');
  print('5. FocusTraversalPolicy determines next node');
  print('6. Returns true if focus moved, false if at end');

  print('\n--- toKeyEventResult ---');
  print('true (moved) -> KeyEventResult.handled');
  print('false (end) -> KeyEventResult.skipRemainingHandlers');

  print('\n${'=' * 60}');
  print('NextFocusAction deep demo completed');

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
              colors: [deepTangerine, tangerine, apricot],
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
                  Icon(Icons.tab, size: 28, color: paleTangerine),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text('NextFocusAction',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Action<NextFocusIntent> — moves keyboard focus to the next focusable widget in traversal order',
                  style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13)),
              const SizedBox(height: 10),
              Wrap(children: [
                tag('Action', apricot, Colors.white),
                tag('NextFocusIntent', softTangerine, darkBrown),
                tag('Tab key', lightApricot, darkBrown),
                tag('Focus traversal', paleTangerine, darkBrown),
              ]),
            ],
          ),
        ),

        // ── 2. What is it ────────────────────────────────────────────
        sectionBanner('1 \u00b7 What Is NextFocusAction',
            'An Action that advances focus through widget tree',
            deepTangerine, Colors.white),
        noteBox(
          'NextFocusAction is a concrete Action<NextFocusIntent> registered '
          'by default in WidgetsApp. When invoked (typically by pressing Tab), '
          'it calls primaryFocus!.nextFocus() which uses the current '
          'FocusTraversalPolicy to determine the next focusable widget. It '
          'returns a bool — true if focus successfully moved, false if '
          'traversal reached the end of the focus scope.',
          tangerine,
          whiteTangerine,
        ),
        dataRow('Extends', 'Action<NextFocusIntent>', tangerine),
        dataRow('Intent', 'NextFocusIntent (no parameters)', deepTangerine),
        dataRow('Default binding', 'Tab key in WidgetsApp', apricot),
        dataRow('invoke() returns', 'bool — true if focus moved', accentGreen),
        dataRow('Defined in', 'widgets/focus_traversal.dart', darkBrown),
        const SizedBox(height: 14),

        // ── 3. Action / Intent pattern ───────────────────────────────
        sectionBanner('2 \u00b7 The Action / Intent Pattern',
            'How Actions and Intents work together in Flutter',
            tangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightApricot),
          ),
          child: Column(
            children: [
              // Intent
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentIndigo.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentIndigo),
                ),
                child: Row(
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 20,
                        color: accentIndigo),
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
                                  color: accentIndigo)),
                          Text('Describes the intent: "move focus forward"',
                              style: TextStyle(
                                  fontSize: 10, color: darkBrown)),
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
                    Icon(Icons.arrow_downward, size: 16, color: apricot),
                    Text('dispatched to',
                        style: TextStyle(fontSize: 8, color: apricot)),
                  ],
                ),
              ),
              // Action
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tangerine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tangerine, width: 2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.play_circle_fill, size: 20,
                        color: tangerine),
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
                                  color: tangerine)),
                          Text('Executes: primaryFocus!.nextFocus()',
                              style: TextStyle(
                                  fontSize: 10, color: darkBrown)),
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
                    Icon(Icons.arrow_downward, size: 16, color: apricot),
                    Text('uses',
                        style: TextStyle(fontSize: 8, color: apricot)),
                  ],
                ),
              ),
              // Result
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentGreen.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentGreen),
                ),
                child: Row(
                  children: [
                    Icon(Icons.center_focus_strong, size: 20,
                        color: accentGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FocusTraversalPolicy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  color: accentGreen)),
                          Text('Determines the next focusable node',
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

        // ── 4. invoke() method detail ────────────────────────────────
        sectionBanner('3 \u00b7 The invoke() Method',
            'What happens when the action is invoked',
            apricot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepTangerine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepTangerine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '@override\n'
                    'bool invoke(NextFocusIntent intent) {\n'
                    '  return primaryFocus!.nextFocus();\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepTangerine)),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentGreen.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: accentGreen, width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle, size: 22,
                              color: accentGreen),
                          Text('returns true',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: accentGreen)),
                          Text('Focus moved to\nthe next widget',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkBrown)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE53935).withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: const Color(0xFFE53935), width: 2),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.last_page, size: 22,
                              color: const Color(0xFFE53935)),
                          Text('returns false',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: const Color(0xFFE53935))),
                          Text('End of traversal\nNo next focusable',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10, color: darkBrown)),
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

        // ── 5. toKeyEventResult ──────────────────────────────────────
        sectionBanner('4 \u00b7 toKeyEventResult()',
            'Converting invoke result to key event handling',
            deepTangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepTangerine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepTangerine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '@override\n'
                    'KeyEventResult toKeyEventResult(\n'
                    '    NextFocusIntent intent,\n'
                    '    bool invokeResult) {\n'
                    '  return invokeResult\n'
                    '      ? KeyEventResult.handled\n'
                    '      : KeyEventResult.skipRemainingHandlers;\n'
                    '}',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepTangerine)),
              ),
              const SizedBox(height: 8),
              for (final result in [
                ('true \u2192 handled', 'Focus moved. Tab key consumed.',
                    accentGreen, Icons.check),
                ('false \u2192 skipRemainingHandlers',
                    'At end of scope. Don\'t consume — let platform handle.',
                    tangerine, Icons.skip_next),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: result.$3.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(6),
                    border: Border(
                        left: BorderSide(color: result.$3, width: 3)),
                  ),
                  child: Row(
                    children: [
                      Icon(result.$4, size: 18, color: result.$3),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(result.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: result.$3)),
                            Text(result.$2,
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

        // ── 6. Live demo: focus traversal chain ──────────────────────
        sectionBanner('5 \u00b7 Live Demo: Focus Traversal Chain',
            'Multiple focusable widgets showing Tab traversal order',
            tangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightApricot),
          ),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: tangerine,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 14,
                          color: lightApricot),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: tangerine.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: tangerine.withValues(alpha: 0.3)),
                              ),
                              child: Text('Focusable field ${i + 1}',
                                  style: TextStyle(
                                      fontSize: 12, color: darkBrown)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 8),
              noteBox(
                'Tab moves focus 1 \u2192 2 \u2192 3 \u2192 4 \u2192 5 \u2192 back to 1. '
                'Each Tab press invokes NextFocusAction which calls nextFocus(). '
                'The FocusTraversalPolicy determines the order — by default, '
                'it follows the widget reading order.',
                tangerine,
                paleTangerine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 7. Tab key binding ───────────────────────────────────────
        sectionBanner('6 \u00b7 Default Tab Key Binding',
            'How WidgetsApp registers the action',
            apricot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: apricot.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: apricot.withValues(alpha: 0.3)),
                ),
                child: Text(
                    '// In WidgetsApp (simplified)\n'
                    'Shortcuts(\n'
                    '  shortcuts: {\n'
                    '    LogicalKeySet(LogicalKeyboardKey.tab):\n'
                    '        NextFocusIntent(),\n'
                    '    LogicalKeySet(\n'
                    '      LogicalKeyboardKey.tab,\n'
                    '      LogicalKeyboardKey.shift,\n'
                    '    ): PreviousFocusIntent(),\n'
                    '  },\n'
                    '  child: Actions(\n'
                    '    actions: {\n'
                    '      NextFocusIntent: NextFocusAction(),\n'
                    '      PreviousFocusIntent: PreviousFocusAction(),\n'
                    '    },\n'
                    '    child: ...,\n'
                    '  ),\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepTangerine)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'WidgetsApp (and therefore MaterialApp) registers both '
                'NextFocusAction for Tab and PreviousFocusAction for Shift+Tab. '
                'You can override this by providing your own Shortcuts/Actions '
                'widgets higher in the tree.',
                apricot,
                paleTangerine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 8. Focus traversal policies ──────────────────────────────
        sectionBanner('7 \u00b7 Focus Traversal Policies',
            'How the action determines traversal order',
            deepTangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final policy in [
                ('ReadingOrderTraversalPolicy', 'Default. Follows reading '
                    'order (left-to-right, top-to-bottom for LTR locales).',
                    Icons.menu_book, tangerine),
                ('OrderedTraversalPolicy', 'Uses explicit FocusOrder '
                    'values for precise control over traversal sequence.',
                    Icons.sort, apricot),
                ('WidgetOrderTraversalPolicy', 'Follows widget build '
                    'order. Simplest but doesn\'t account for visual layout.',
                    Icons.list, softTangerine),
                ('DirectionalFocusTraversalPolicyMixin',
                    'For directional (arrow key) navigation. Used by '
                    'DirectionalFocusAction, not NextFocusAction.',
                    Icons.arrow_circle_right, lightApricot),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: policy.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: policy.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(policy.$3, size: 20, color: policy.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(policy.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: policy.$4)),
                            Text(policy.$2,
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

        // ── 9. Live demo: form with Tab navigation ───────────────────
        sectionBanner('8 \u00b7 Live Demo: Form Fields',
            'Tab-navigable form using NextFocusAction under the hood',
            tangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: lightApricot),
          ),
          child: Column(
            children: [
              for (final field in [
                ('Name', Icons.person, 1),
                ('Email', Icons.email, 2),
                ('Phone', Icons.phone, 3),
                ('Address', Icons.home, 4),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: tangerine,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Text('${field.$3}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Icon(field.$2, size: 18, color: apricot),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: field.$1,
                            labelStyle: TextStyle(
                                fontSize: 12, color: tangerine),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: lightApricot),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: tangerine, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            isDense: true,
                          ),
                          style: TextStyle(
                              fontSize: 12, color: darkBrown),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 6),
              noteBox(
                'Each TextField is focusable. Tab moves focus 1 \u2192 2 \u2192 3 \u2192 4. '
                'This is NextFocusAction at work — invoked automatically by the '
                'Tab key binding in MaterialApp. No custom code needed.',
                tangerine,
                paleTangerine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 10. Comparison with related actions ──────────────────────
        sectionBanner('9 \u00b7 Related Focus Actions',
            'NextFocusAction in the family of focus actions',
            apricot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
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
                decoration: BoxDecoration(color: deepTangerine),
                children: [
                  for (final h in ['Action', 'Key', 'Direction'])
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
                ('NextFocusAction', 'Tab', 'Forward in order'),
                ('PreviousFocusAction', 'Shift+Tab', 'Backward in order'),
                ('DirectionalFocusAction', 'Arrow keys', 'Spatial direction'),
                ('RequestFocusAction', 'Custom', 'Specific node'),
                ('DismissAction', 'Escape', 'Dismiss / unfocus'),
              ])
                TableRow(
                  decoration: row.$1 == 'NextFocusAction'
                      ? BoxDecoration(
                          color: tangerine.withValues(alpha: 0.08))
                      : null,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$1,
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              fontWeight: row.$1 == 'NextFocusAction'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: row.$1 == 'NextFocusAction'
                                  ? tangerine
                                  : darkBrown)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$2,
                          style: TextStyle(
                              fontSize: 10, color: darkBrown)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(row.$3,
                          style: TextStyle(
                              fontSize: 10, color: darkBrown)),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 11. Overriding the action ────────────────────────────────
        sectionBanner('10 \u00b7 Overriding NextFocusAction',
            'How to customize Tab behavior',
            deepTangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: deepTangerine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: deepTangerine.withValues(alpha: 0.3)),
                ),
                child: Text(
                    'Actions(\n'
                    '  actions: {\n'
                    '    NextFocusIntent: CallbackAction(\n'
                    '      onInvoke: (intent) {\n'
                    '        // Custom logic before focus move\n'
                    '        print("Tab pressed!");\n'
                    '        return primaryFocus?.nextFocus();\n'
                    '      },\n'
                    '    ),\n'
                    '  },\n'
                    '  child: myWidget,\n'
                    ')',
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'monospace',
                        color: deepTangerine)),
              ),
              const SizedBox(height: 8),
              noteBox(
                'You can replace NextFocusAction with a CallbackAction or '
                'custom Action subclass. Place an Actions widget above your '
                'subtree to intercept and customize Tab behavior. This is useful '
                'for analytics, validation, or conditional focus moves.',
                deepTangerine,
                paleTangerine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 12. FocusScope boundaries ────────────────────────────────
        sectionBanner('11 \u00b7 FocusScope Boundaries',
            'How focus scopes affect NextFocusAction traversal',
            tangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tangerine.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tangerine, width: 2),
                ),
                child: Column(
                  children: [
                    Text('FocusScope (form)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: tangerine)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        for (final n in ['A', 'B', 'C'])
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 2),
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: accentGreen.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: accentGreen),
                              ),
                              child: Center(
                                child: Text('Field $n',
                                    style: TextStyle(
                                        fontSize: 10, color: darkBrown)),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Tab: A \u2192 B \u2192 C \u2192 A (wraps)',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: darkBrown)),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              noteBox(
                'Focus scopes create traversal boundaries. NextFocusAction '
                'moves forward within the current scope. When reaching the end, '
                'behavior depends on scope settings — it may wrap or return false.',
                tangerine,
                paleTangerine,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 13. Accessibility benefits ───────────────────────────────
        sectionBanner('12 \u00b7 Accessibility Benefits',
            'Why NextFocusAction matters for keyboard users',
            apricot, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              for (final benefit in [
                ('Keyboard navigation', 'Users who cannot use a mouse rely on '
                    'Tab to navigate between interactive elements.',
                    Icons.keyboard, tangerine),
                ('Screen readers', 'Focus order determines announcement '
                    'sequence. NextFocusAction follows the correct policy.',
                    Icons.record_voice_over, apricot),
                ('Motor impairments', 'Switch devices and mouth sticks '
                    'often use Tab-equivalent input. Consistent focus traversal '
                    'is essential.',
                    Icons.accessibility_new, softTangerine),
                ('Web embedding', 'Flutter web apps must support Tab '
                    'navigation to match web accessibility standards (WCAG 2.1).',
                    Icons.web, accentIndigo),
              ])
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: benefit.$4.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                    border: Border(
                        left: BorderSide(color: benefit.$4, width: 3)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(benefit.$3, size: 20, color: benefit.$4),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(benefit.$1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: darkBrown)),
                            Text(benefit.$2,
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

        // ── 14. Class hierarchy ──────────────────────────────────────
        sectionBanner('13 \u00b7 Class Hierarchy',
            'Inheritance chain', deepTangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final level in [
                ('Object', Colors.grey),
                ('\u2514\u2500 Action<NextFocusIntent>', softTangerine),
                ('    \u2514\u2500 NextFocusAction', tangerine),
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(level.$1,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'monospace',
                          fontWeight: level.$1.contains('NextFocusAction')
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: level.$2)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // ── 15. Class definition ─────────────────────────────────────
        sectionBanner('14 \u00b7 Class Definition',
            'The SDK implementation', tangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: whiteTangerine,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepTangerine.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepTangerine.withValues(alpha: 0.3)),
            ),
            child: Text(
                'class NextFocusAction\n'
                '    extends Action<NextFocusIntent> {\n'
                '  @override\n'
                '  bool invoke(NextFocusIntent intent) {\n'
                '    return primaryFocus!.nextFocus();\n'
                '  }\n'
                '\n'
                '  @override\n'
                '  KeyEventResult toKeyEventResult(\n'
                '      NextFocusIntent intent,\n'
                '      bool invokeResult) {\n'
                '    return invokeResult\n'
                '        ? KeyEventResult.handled\n'
                '        : KeyEventResult\n'
                '            .skipRemainingHandlers;\n'
                '  }\n'
                '}',
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'monospace',
                    color: deepTangerine)),
          ),
        ),
        const SizedBox(height: 14),

        // ── 16. Summary ──────────────────────────────────────────────
        sectionBanner('15 \u00b7 Summary',
            'Key takeaways', deepTangerine, Colors.white),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [deepTangerine, tangerine],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final point in [
                'Extends Action<NextFocusIntent> — handles Tab key focus traversal',
                'invoke() calls primaryFocus!.nextFocus() and returns bool',
                'true = focus moved, false = end of traversal',
                'toKeyEventResult converts to handled/skipRemainingHandlers',
                'Registered by default in WidgetsApp / MaterialApp',
                'Tab = NextFocusIntent, Shift+Tab = PreviousFocusIntent',
                'Uses FocusTraversalPolicy to determine next node',
                'ReadingOrderTraversalPolicy is the default policy',
                'Can be overridden with Actions widget for custom behavior',
                'Essential for keyboard accessibility (WCAG compliance)',
              ])
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('\u2022  ',
                          style: TextStyle(
                              color: lightApricot,
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
