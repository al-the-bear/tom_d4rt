// ignore_for_file: avoid_print
// D4rt deep demo: KeyEventResult — an enum that communicates whether a
// KeyEvent was handled, ignored, or should be skipped by the focus system.
// When a key event propagates through the focus tree, each handler returns
// a KeyEventResult to tell the framework what to do next.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Rose / Blush palette ───
  const Color rose = Color(0xFFE11D48);
  const Color blush = Color(0xFFFB7185);
  const Color deepRuby = Color(0xFF881337);
  const Color palePetal = Color(0xFFFFF1F2);
  const Color raspberry = Color(0xFFBE123C);
  const Color cotton = Color(0xFFFFE4E6);
  const Color garnet = Color(0xFF9F1239);
  const Color rouge = Color(0xFFFDA4AF);
  const Color petal = Color(0xFFFECDD3);
  const Color wine = Color(0xFF4C0519);

  print('===== KEY EVENT RESULT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepRuby, wine],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepRuby.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: rose,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: blush, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: palePetal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: petal),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepRuby.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: petal),
        boxShadow: [
          BoxShadow(
            color: rose.withValues(alpha: 0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: cotton,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepRuby)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepRuby)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: wine)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepRuby.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepRuby),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: deepRuby)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: petal.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget enumValue(String name, String description, IconData icon,
      Color color, bool highlighted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlighted ? color.withValues(alpha: 0.08) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: highlighted ? color : petal,
          width: highlighted ? 2 : 1,
        ),
        boxShadow: highlighted
            ? [
                BoxShadow(
                    color: color.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ]
            : [],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: highlighted
                  ? color.withValues(alpha: 0.15)
                  : petal.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, size: 18, color: highlighted ? color : rouge),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: highlighted ? color : deepRuby)),
                const SizedBox(height: 2),
                Text(description,
                    style: TextStyle(
                        fontSize: 11,
                        color: highlighted
                            ? color.withValues(alpha: 0.75)
                            : wine.withValues(alpha: 0.6),
                        height: 1.3)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget focusNode(String name, String result, bool active, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active ? color : petal,
          width: active ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            active ? Icons.keyboard : Icons.keyboard_outlined,
            size: 16,
            color: active ? color : petal,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(name,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                    color: active ? color : deepRuby)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: active ? color : rouge,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(result,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: active ? Colors.white : deepRuby)),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'KeyEventResult is an enum with three values that tell the Flutter '
          'focus system what happened when a focus node processed a key event. '
          'It controls whether the event continues propagating or stops.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'enum KeyEventResult'),
              dataRow('Package', 'flutter/widgets (focus_manager)'),
              dataRow('Values', 'handled, ignored, skipRemainingHandlers'),
              dataRow('Used by', 'FocusNode.onKeyEvent callback'),
              dataRow('Purpose', 'Control key event propagation'),
            ],
          )),
    ],
  );

  // ─── Section 2: Enum Values ───
  print('[Section 2] Enum Values');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Enum Values'),
      noteBox(
          'Each value communicates a different intent to the focus system '
          'about how the key event should be processed downstream.'),
      enumValue(
          'KeyEventResult.handled',
          'The event was consumed by this handler. Stop propagating — no '
              'other handlers will receive it. The platform is told the key '
              'was handled.',
          Icons.check_circle,
          rose,
          true),
      enumValue(
          'KeyEventResult.ignored',
          'This handler chose not to process the event. Continue propagating '
              'to the next handler in the focus chain. If no handler claims '
              'it, the platform receives it as unhandled.',
          Icons.remove_circle_outline,
          garnet,
          false),
      enumValue(
          'KeyEventResult.skipRemainingHandlers',
          'Stop propagating to remaining handlers but tell the platform the '
              'event was NOT handled. Useful for preventing framework '
              'default behavior while letting the OS handle it.',
          Icons.skip_next,
          raspberry,
          false),
    ],
  );

  // ─── Section 3: Focus Tree Propagation ───
  print('[Section 3] Focus Tree Propagation');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Focus Tree Propagation'),
      noteBox(
          'Key events propagate from the primary focus node up through '
          'ancestor focus scopes. Each node\'s handler returns a '
          'KeyEventResult that controls the journey.'),
      infoCard(
          'Propagation Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              focusNode('FocusScope (root)', 'Not reached', false, garnet),
              focusNode('FocusScope (page)', 'Not reached', false, garnet),
              focusNode('FocusNode (parent)', 'handled', true, rose),
              focusNode('FocusNode (primary)', 'ignored', false, raspberry),
            ],
          )),
      infoCard(
          'Propagation Rules',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Start', 'Primary focus node'),
              dataRow('Direction', 'Upward through ancestors'),
              dataRow('Stop on handled', 'No more handlers called'),
              dataRow('Stop on skip', 'No more handlers called'),
              dataRow('Continue on ignored', 'Next ancestor processes'),
            ],
          )),
    ],
  );

  // ─── Section 4: handled in Detail ───
  print('[Section 4] handled in Detail');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'handled in Detail'),
      noteBox(
          'Returning handled means "I consumed this event, nobody else '
          'needs to see it, and the platform should consider it processed."'),
      infoCard(
          'When to Return handled',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Keyboard shortcut', 'Ctrl+S save triggered'),
              dataRow('Arrow navigation', 'Moved selection in list'),
              dataRow('Enter key', 'Submitted form'),
              dataRow('Escape key', 'Closed dialog or menu'),
              dataRow('Custom binding', 'App-specific action taken'),
            ],
          )),
      infoCard(
          'Effects of handled',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Propagation', 'Stops immediately'),
              dataRow('Platform response', 'Marked as handled'),
              dataRow('Text input', 'Character NOT inserted'),
              dataRow('Default behavior', 'Suppressed'),
            ],
          )),
    ],
  );

  // ─── Section 5: ignored in Detail ───
  print('[Section 5] ignored in Detail');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'ignored in Detail'),
      noteBox(
          'Returning ignored means "I don\'t care about this event, pass it '
          'along to the next handler."'),
      infoCard(
          'When to Return ignored',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Wrong key', 'Handler only cares about Escape'),
              dataRow('Wrong modifier', 'Needs Ctrl but none pressed'),
              dataRow('Inactive state', 'Feature currently disabled'),
              dataRow('Default', 'Most handlers ignore most keys'),
            ],
          )),
      infoCard(
          'Effects of ignored',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Propagation', 'Continues up the tree'),
              dataRow('Next handler', 'Parent FocusNode gets event'),
              dataRow('Platform fallback', 'Unhandled if all ignore'),
              dataRow('Text input', 'Character may be inserted'),
            ],
          )),
    ],
  );

  // ─── Section 6: skipRemainingHandlers in Detail ───
  print('[Section 6] skipRemainingHandlers in Detail');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'skipRemainingHandlers in Detail'),
      noteBox(
          'The most nuanced value — stops handler propagation but reports '
          'to the platform that the event was NOT handled. This lets the '
          'OS perform its default action.'),
      infoCard(
          'When to Return skipRemainingHandlers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tab key', 'Let OS handle tab focus natively'),
              dataRow('System shortcuts', 'Cmd+Q, Alt+F4 pass through'),
              dataRow('Accessibility', 'Screen reader keys pass through'),
              dataRow('IME control', 'Input method keys handled by OS'),
            ],
          )),
      infoCard(
          'Effects of skipRemainingHandlers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Propagation', 'Stops — no more handlers'),
              dataRow('Platform response', 'Marked as NOT handled'),
              dataRow('OS action', 'Platform may process the key'),
              dataRow('Difference', 'vs handled: platform gets key'),
            ],
          )),
    ],
  );

  // ─── Section 7: Decision Matrix ───
  print('[Section 7] Decision Matrix');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Decision Matrix'),
      noteBox(
          'A quick reference for choosing which KeyEventResult to return.'),
      infoCard(
          'Decision Table',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Consumed by app?', 'handled'),
              dataRow('Not my concern?', 'ignored'),
              dataRow('Stop propagation,\nlet OS handle?', 'skipRemainingHandlers'),
              dataRow('Default / unsure?', 'ignored (safest)'),
            ],
          )),
      infoCard(
          'Comparison Grid',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('', 'handled | ignored | skip'),
              dataRow('Stops propagation', 'Yes | No | Yes'),
              dataRow('Platform handled', 'Yes | Per chain | No'),
              dataRow('OS default action', 'No | Maybe | Yes'),
              dataRow('Text insertion', 'No | Maybe | Yes'),
            ],
          )),
    ],
  );

  // ─── Section 8: FocusNode onKeyEvent ───
  print('[Section 8] FocusNode onKeyEvent');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'FocusNode onKeyEvent'),
      noteBox(
          'The primary consumer of KeyEventResult is the onKeyEvent '
          'callback set on FocusNode.'),
      infoCard(
          'Callback Signature',
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: deepRuby.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: petal),
            ),
            child: Text(
                'FocusNode(\n'
                '  onKeyEvent: (FocusNode node, KeyEvent event) {\n'
                '    if (event is KeyDownEvent &&\n'
                '        event.logicalKey == LogicalKeyboardKey.escape) {\n'
                '      closeMenu();\n'
                '      return KeyEventResult.handled;\n'
                '    }\n'
                '    return KeyEventResult.ignored;\n'
                '  },\n'
                ')',
                style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: deepRuby,
                    height: 1.4)),
          )),
      infoCard(
          'Callback Parameters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('FocusNode node', 'The node that fired'),
              dataRow('KeyEvent event', 'The key event object'),
              dataRow('Return', 'KeyEventResult enum value'),
            ],
          )),
    ],
  );

  // ─── Section 9: Shortcuts & Actions ───
  print('[Section 9] Shortcuts & Actions');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Shortcuts & Actions Integration'),
      noteBox(
          'The Shortcuts and Actions system also produces KeyEventResult '
          'internally — handled when an action fires, ignored otherwise.'),
      infoCard(
          'Shortcuts Pipeline',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Key event arrives', 'From platform'),
              dataRow('2. Shortcuts widget', 'Matches key combination'),
              dataRow('3. Intent created', 'From ShortcutActivator'),
              dataRow('4. Action invoked', 'Action.invoke(intent)'),
              dataRow('5. Result: handled', 'Event consumed'),
              dataRow('No match', 'Result: ignored'),
            ],
          )),
    ],
  );

  // ─── Section 10: KeyEvent Types ───
  print('[Section 10] KeyEvent Types');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'KeyEvent Types'),
      noteBox(
          'KeyEventResult is returned for all KeyEvent subtypes — down, '
          'up, and repeat events.'),
      infoCard(
          'Event Subtypes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              enumValue('KeyDownEvent', 'Key pressed down — most common to handle',
                  Icons.arrow_downward, rose, true),
              enumValue('KeyUpEvent', 'Key released — rarely handled directly',
                  Icons.arrow_upward, garnet, false),
              enumValue('KeyRepeatEvent', 'Key held down — auto-repeat',
                  Icons.repeat, raspberry, false),
            ],
          )),
      infoCard(
          'Handler Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('KeyDown only', 'Most handlers check KeyDownEvent'),
              dataRow('KeyDown + Repeat', 'Continuous actions (scroll)'),
              dataRow('KeyUp', 'Release-triggered actions'),
              dataRow('Same result type', 'All return KeyEventResult'),
            ],
          )),
    ],
  );

  // ─── Section 11: Platform Interaction ───
  print('[Section 11] Platform Interaction');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Platform Interaction'),
      noteBox(
          'The combined result from all focus handlers is reported back '
          'to the platform, affecting whether the OS processes the key.'),
      infoCard(
          'Platform Communication',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('All ignored', 'Platform: key NOT handled'),
              dataRow('Any handled', 'Platform: key WAS handled'),
              dataRow('skipRemaining', 'Platform: key NOT handled'),
              dataRow('Platform effect', 'OS may insert character, beep, etc.'),
            ],
          )),
      infoCard(
          'Platform-Specific Impact',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('macOS', 'Unhandled → system beep'),
              dataRow('Windows', 'Unhandled → default OS action'),
              dataRow('Linux', 'Unhandled → window manager action'),
              dataRow('Web', 'Unhandled → browser default'),
              dataRow('Mobile', 'IME handles unhandled keys'),
            ],
          )),
    ],
  );

  // ─── Section 12: Common Patterns ───
  print('[Section 12] Common Patterns');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Common Patterns'),
      noteBox(
          'Typical patterns for returning KeyEventResult in real applications.'),
      infoCard(
          'Pattern: Claim or Pass',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Check key', 'Is this my key?'),
              dataRow('Yes → handled', 'Perform action, claim event'),
              dataRow('No → ignored', 'Let someone else handle it'),
            ],
          )),
      infoCard(
          'Pattern: Conditional Handling',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Check state', 'Is the menu open?'),
              dataRow('Open + Escape', 'Close menu → handled'),
              dataRow('Closed + Escape', 'Not my concern → ignored'),
              dataRow('Open + other key', 'Navigate menu → handled'),
            ],
          )),
      infoCard(
          'Pattern: Modifier Key Guard',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Check modifier', 'Is Ctrl pressed?'),
              dataRow('Ctrl+S', 'Save → handled'),
              dataRow('Ctrl+Z', 'Undo → handled'),
              dataRow('No modifier', 'All → ignored'),
            ],
          )),
    ],
  );

  // ─── Section 13: Testing KeyEventResult ───
  print('[Section 13] Testing');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Testing KeyEventResult'),
      noteBox(
          'Testing key handlers involves simulating key events and '
          'verifying the correct KeyEventResult is returned.'),
      infoCard(
          'Test Approaches',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('sendKeyEvent', 'Simulate key press in tests'),
              dataRow('tester.sendKeyDownEvent', 'WidgetTester helper'),
              dataRow('Check return', 'Verify handled/ignored'),
              dataRow('Verify action', 'Check side effect occurred'),
              dataRow('Verify propagation', 'Check parent received/not'),
            ],
          )),
    ],
  );

  // ─── Section 14: Debugging Key Handling ───
  print('[Section 14] Debugging');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Debugging Key Handling'),
      noteBox(
          'When key handling doesn\'t work as expected, these techniques '
          'help identify problems.'),
      infoCard(
          'Debug Techniques',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Print result', 'Log what handler returns'),
              dataRow('Focus debugging', 'FocusManager.instance.primaryFocus'),
              dataRow('Event logging', 'Print event.logicalKey'),
              dataRow('Propagation trace', 'Print at each handler level'),
            ],
          )),
      infoCard(
          'Common Issues',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Key not caught', 'Focus not on expected node'),
              dataRow('Double action', 'Handled by child AND parent'),
              dataRow('Platform beep', 'Returning ignored incorrectly'),
              dataRow('Text insertion', 'Forgot to return handled'),
            ],
          )),
    ],
  );

  // ─── Section 15: Relationship to RawKeyEvent ───
  print('[Section 15] RawKeyEvent Relationship');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Relationship to RawKeyEvent (Legacy)'),
      noteBox(
          'The older RawKeyEvent system used a similar but different result '
          'mechanism. KeyEventResult is the modern replacement used with '
          'KeyEvent.'),
      infoCard(
          'Migration Summary',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Legacy', 'RawKeyEvent + onKey callback'),
              dataRow('Modern', 'KeyEvent + onKeyEvent callback'),
              dataRow('Legacy result', 'bool (handled = true)'),
              dataRow('Modern result', 'KeyEventResult enum (3 values)'),
              dataRow('Advantage', 'skipRemainingHandlers is new'),
            ],
          )),
      infoCard(
          'Why the Change',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Bool limitation', 'Only handled/not — no skip'),
              dataRow('Platform control', 'Needed finer platform signaling'),
              dataRow('Consistency', 'Matches other result enums'),
              dataRow('Future-proof', 'Room for new values if needed'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the KeyEventResult deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Rose', rose),
              colorSwatch('Blush', blush),
              colorSwatch('Deep Ruby', deepRuby),
              colorSwatch('Pale Petal', palePetal),
              colorSwatch('Raspberry', raspberry),
              colorSwatch('Cotton', cotton),
              colorSwatch('Garnet', garnet),
              colorSwatch('Rouge', rouge),
              colorSwatch('Petal', petal),
              colorSwatch('Wine', wine),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, rose),
              progressBar('Enum Values', 1.0, garnet),
              progressBar('Focus Propagation', 1.0, raspberry),
              progressBar('handled Detail', 1.0, wine),
              progressBar('ignored Detail', 1.0, rose),
              progressBar('skipRemaining Detail', 1.0, garnet),
              progressBar('Decision Matrix', 1.0, raspberry),
              progressBar('FocusNode onKeyEvent', 1.0, wine),
              progressBar('Shortcuts & Actions', 1.0, rose),
              progressBar('KeyEvent Types', 1.0, garnet),
              progressBar('Platform Interaction', 1.0, raspberry),
              progressBar('Common Patterns', 1.0, wine),
              progressBar('Testing', 1.0, rose),
              progressBar('Debugging', 1.0, garnet),
              progressBar('RawKeyEvent Legacy', 1.0, raspberry),
              progressBar('Dashboard', 1.0, wine),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Rose / Blush'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('KeyEventResult', rose, Colors.white),
          tag('Focus System', garnet, Colors.white),
          tag('Event Propagation', raspberry, Colors.white),
          tag('Keyboard Handling', wine, Colors.white),
          tag('Platform Bridge', blush, deepRuby),
          tag('Shortcuts', rouge, deepRuby),
        ],
      ),
    ],
  );

  print('===== END KEY EVENT RESULT DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
