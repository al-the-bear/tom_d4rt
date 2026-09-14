// ignore_for_file: avoid_print
// D4rt deep demo: TextInputControl — the abstract class that lets apps
// provide their own text input implementation, bypassing the platform's
// default keyboard system for custom in-app input experiences.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Amber / Gold palette ───
  const Color amber = Color(0xFFD97706);
  const Color gold = Color(0xFFF59E0B);
  const Color deepAmber = Color(0xFF78350F);
  const Color paleYellow = Color(0xFFFFFBEB);
  const Color honey = Color(0xFFEAB308);
  const Color cream = Color(0xFFFEF3C7);
  const Color bronze = Color(0xFF92400E);
  const Color saffron = Color(0xFFFBBF24);
  const Color wheat = Color(0xFFFDE68A);
  const Color ochre = Color(0xFFB45309);

  print('===== TEXT INPUT CONTROL DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepAmber, bronze],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepAmber.withValues(alpha: 0.35),
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
              color: amber,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: gold, width: 1.5),
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
        color: paleYellow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cream),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepAmber.withValues(alpha: 0.9),
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
        border: Border.all(color: cream),
        boxShadow: [
          BoxShadow(
            color: amber.withValues(alpha: 0.07),
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
              color: paleYellow,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepAmber)),
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
                    color: deepAmber)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: bronze)),
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
                  color: deepAmber.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepAmber),
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
              Text(label,
                  style: TextStyle(fontSize: 11, color: deepAmber)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: wheat,
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

  Widget keyboardKey(String label, double width, Color bg) {
    return Container(
      width: width,
      height: 40,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: deepAmber.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: deepAmber.withValues(alpha: 0.1),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: deepAmber)),
      ),
    );
  }

  // ─── Section 1: Overview & Purpose ───
  print('[Section 1] Overview & Purpose');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'TextInputControl is an abstract class that lets Flutter apps '
          'provide their own text input implementation, completely bypassing '
          'the platform\'s native keyboard. By registering a custom '
          'TextInputControl, apps can create in-app keyboards, PIN pads, '
          'game chat inputs, or any custom text entry mechanism while still '
          'integrating with Flutter\'s TextInputClient system.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Abstract class'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Custom text input implementation'),
              dataRow('Registration', 'TextInput.setInputControl(ctrl)'),
              dataRow('Restoring default', 'TextInput.restorePlatformInputControl()'),
            ],
          )),
      infoCard(
          'Why Use It',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Custom keyboards', 'In-app soft keyboards'),
              dataRow('Kiosk mode', 'No access to system keyboard'),
              dataRow('Game input', 'Themed game chat entry'),
              dataRow('Accessibility', 'Specialized input methods'),
              dataRow('Embedded devices', 'No platform keyboard available'),
            ],
          )),
    ],
  );

  // ─── Section 2: Abstract API ───
  print('[Section 2] Abstract API');

  final apiMethods = <Map<String, String>>[
    {'method': 'show()', 'purpose': 'Called when keyboard should appear', 'response': 'Display your custom input'},
    {'method': 'hide()', 'purpose': 'Called when keyboard should dismiss', 'response': 'Hide your custom input'},
    {'method': 'setEditingState()', 'purpose': 'Current text state from client', 'response': 'Sync your input UI state'},
    {'method': 'setClient()', 'purpose': 'Client connection established', 'response': 'Store client reference'},
    {'method': 'setCaretRect()', 'purpose': 'Cursor position reported', 'response': 'Position input near cursor'},
    {'method': 'setComposingRect()', 'purpose': 'Composing area reported', 'response': 'Position IME overlay'},
    {'method': 'setStyle()', 'purpose': 'Text style information', 'response': 'Match font in your input'},
  ];

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Abstract API'),
      noteBox(
          'TextInputControl defines several methods that the framework '
          'calls when text input events occur. Your implementation '
          'responds to these by managing your custom input UI.'),
      for (final api in apiMethods)
        infoCard(
            api['method']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Method', api['method']!),
                dataRow('Called when', api['purpose']!),
                dataRow('Your response', api['response']!),
              ],
            )),
    ],
  );

  // ─── Section 3: Custom Keyboard Concept ───
  print('[Section 3] Custom Keyboard Concept');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Custom Keyboard Concept'),
      noteBox(
          'A custom in-app keyboard built with TextInputControl renders '
          'its own key buttons in the Flutter widget tree. When the user '
          'taps a key, the control updates the editing value and sends '
          'it back through the TextInputClient.'),
      infoCard(
          'Keyboard Layout Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  keyboardKey('Q', 32, cream),
                  keyboardKey('W', 32, cream),
                  keyboardKey('E', 32, cream),
                  keyboardKey('R', 32, cream),
                  keyboardKey('T', 32, cream),
                  keyboardKey('Y', 32, cream),
                  keyboardKey('U', 32, cream),
                  keyboardKey('I', 32, cream),
                  keyboardKey('O', 32, cream),
                  keyboardKey('P', 32, cream),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  keyboardKey('A', 32, cream),
                  keyboardKey('S', 32, cream),
                  keyboardKey('D', 32, cream),
                  keyboardKey('F', 32, cream),
                  keyboardKey('G', 32, cream),
                  keyboardKey('H', 32, cream),
                  keyboardKey('J', 32, cream),
                  keyboardKey('K', 32, cream),
                  keyboardKey('L', 32, cream),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  keyboardKey('Shift', 50, wheat),
                  keyboardKey('Z', 32, cream),
                  keyboardKey('X', 32, cream),
                  keyboardKey('C', 32, cream),
                  keyboardKey('V', 32, cream),
                  keyboardKey('B', 32, cream),
                  keyboardKey('N', 32, cream),
                  keyboardKey('M', 32, cream),
                  keyboardKey('Del', 50, wheat),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  keyboardKey('Space', 200, saffron),
                  keyboardKey('Done', 60, amber),
                ],
              ),
            ],
          )),
      infoCard(
          'How This Works',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Key press', 'Widget onTap handler fires'),
              dataRow('Text update', 'Build new TextEditingValue'),
              dataRow('Send to client', 'Via updateEditingValue()'),
              dataRow('Widget rebuild', 'Client triggers rebuild'),
            ],
          )),
    ],
  );

  // ─── Section 4: Registration & Lifecycle ───
  print('[Section 4] Registration & Lifecycle');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Registration & Lifecycle'),
      noteBox(
          'To activate a custom TextInputControl, register it with '
          'TextInput.setInputControl(). Once registered, all text input '
          'connections will use your control instead of the platform\'s. '
          'Restore the default with TextInput.restorePlatformInputControl().'),
      infoCard(
          'Registration Steps',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Step 1', 'Create your TextInputControl subclass'),
              dataRow('Step 2', 'Call TextInput.setInputControl(mine)'),
              dataRow('Step 3', 'All TextFields now use your control'),
              dataRow('Step 4', 'Restore with restorePlatformInputControl'),
            ],
          )),
      infoCard(
          'Lifecycle Events',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setClient()', 'New TextInputClient connected'),
              dataRow('show()', 'Keyboard requested to appear'),
              dataRow('setEditingState()', 'Text state synchronized'),
              dataRow('hide()', 'Keyboard requested to hide'),
              dataRow('setClient(null)', 'Client disconnected'),
            ],
          )),
      infoCard(
          'Scope & Persistence',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('App-wide', 'Affects all text input globally'),
              dataRow('Persistent', 'Stays until explicitly restored'),
              dataRow('Hot reload safe', 'Survives hot reload'),
              dataRow('No per-field', 'Cannot set per-TextField'),
            ],
          )),
    ],
  );

  // ─── Section 5: Editing Value Management ───
  print('[Section 5] Editing Value Management');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Editing Value Management'),
      noteBox(
          'Your TextInputControl receives the current editing state via '
          'setEditingState() and produces new states when the user '
          'interacts with your custom input. This bidirectional flow '
          'keeps the TextField and your input synchronized.'),
      infoCard(
          'Receiving State',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setEditingState()', 'Framework sends current value'),
              dataRow('text property', 'Full text content'),
              dataRow('selection', 'Cursor position / selection range'),
              dataRow('composing', 'IME composing region'),
            ],
          )),
      infoCard(
          'Sending Updates',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('updateEditingValue()', 'Send new value to client'),
              dataRow('Character insert', 'Append char at cursor pos'),
              dataRow('Backspace', 'Remove char before cursor'),
              dataRow('Selection move', 'Update selection range'),
              dataRow('Full replace', 'Replace entire text content'),
            ],
          )),
      infoCard(
          'State Flow Diagram',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('User taps key', 'Your UI detects tap'),
              dataRow('Build new value', 'Insert char at selection'),
              dataRow('updateEditingValue()', 'Send to client'),
              dataRow('Client processes', 'Applies formatters, etc.'),
              dataRow('setEditingState()', 'Client resyncs possibly modified'),
            ],
          )),
    ],
  );

  // ─── Section 6: PIN Pad Example ───
  print('[Section 6] PIN Pad Example');

  Widget pinKey(String digit) {
    return Container(
      width: 64,
      height: 56,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cream,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: gold.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: amber.withValues(alpha: 0.15),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(digit,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: deepAmber)),
      ),
    );
  }

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'PIN Pad Example'),
      noteBox(
          'A common use case for TextInputControl is a numeric PIN pad '
          'for banking or security apps. The PIN pad replaces the system '
          'keyboard with a secure, themed numeric input shown directly '
          'in the app.'),
      infoCard(
          'PIN Pad Layout',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [pinKey('1'), pinKey('2'), pinKey('3')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [pinKey('4'), pinKey('5'), pinKey('6')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [pinKey('7'), pinKey('8'), pinKey('9')],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [pinKey(''), pinKey('0'), pinKey('⌫')],
              ),
            ],
          )),
      infoCard(
          'PIN Pad Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Digit tap', 'Appends digit to PIN field'),
              dataRow('Backspace tap', 'Removes last digit'),
              dataRow('Length limit', 'Enforced by input formatter'),
              dataRow('Auto-submit', 'Triggers action at max length'),
            ],
          )),
      infoCard(
          'Security Benefits',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No system keyboard', 'Avoids keylogger attacks'),
              dataRow('Custom layout', 'Can randomize key positions'),
              dataRow('No IME leakage', 'PIN never enters IME history'),
              dataRow('Visual feedback', 'Controlled by the app'),
            ],
          )),
    ],
  );

  // ─── Section 7: Game Chat Input ───
  print('[Section 7] Game Chat Input');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Game Chat Input'),
      noteBox(
          'Games often want themed text input that matches their visual '
          'style. TextInputControl lets game developers build keyboards '
          'with custom fonts, colors, and animated key effects that feel '
          'native to the game\'s aesthetic.'),
      infoCard(
          'Game Keyboard Features',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Themed keys', 'Match game art style'),
              dataRow('Sound effects', 'Key press sounds'),
              dataRow('Animations', 'Key press scale/glow effects'),
              dataRow('Quick phrases', 'Pre-built game chat phrases'),
              dataRow('Emoji shortcuts', 'Game-specific emoji palette'),
            ],
          )),
      infoCard(
          'Implementation Approach',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Overlay', 'Show keyboard as overlay widget'),
              dataRow('Swipe typing', 'Custom gesture detection'),
              dataRow('Predictive text', 'Game-vocabulary autocomplete'),
              dataRow('Voice input', 'Speech-to-text integration'),
            ],
          )),
    ],
  );

  // ─── Section 8: Kiosk Mode ───
  print('[Section 8] Kiosk Mode');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Kiosk Mode'),
      noteBox(
          'Kiosk applications run on dedicated devices without access to '
          'a system keyboard. TextInputControl is essential for these '
          'apps, providing an on-screen keyboard that works within the '
          'app\'s locked-down environment.'),
      infoCard(
          'Kiosk Use Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Self-service check-in', 'Airport / hotel lobbies'),
              dataRow('Point of sale', 'Retail lookup terminals'),
              dataRow('Museum guide', 'Information search kiosks'),
              dataRow('Restaurant ordering', 'Custom item search'),
              dataRow('Library catalog', 'Book search terminals'),
            ],
          )),
      infoCard(
          'Kiosk Keyboard Requirements',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Large keys', 'Touch-friendly (48pt minimum)'),
              dataRow('High contrast', 'Visible in varied lighting'),
              dataRow('Multi-language', 'Language switch button'),
              dataRow('Auto-timeout', 'Clear after inactivity'),
              dataRow('Accessibility', 'VoiceOver / TalkBack compat'),
            ],
          )),
    ],
  );

  // ─── Section 9: Vs Platform Input ───
  print('[Section 9] Vs Platform Input');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Vs Platform Input'),
      noteBox(
          'TextInputControl replaces the platform input system entirely. '
          'Here is a comparison of what you gain and what you lose by '
          'using a custom control instead of the default platform input.'),
      infoCard(
          'Advantages of Custom Control',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Full visual control', 'Any keyboard design'),
              dataRow('Consistent cross-platform', 'Same on all OSes'),
              dataRow('Integrated theming', 'Matches app design system'),
              dataRow('Custom gestures', 'Swipe, drag, multi-touch'),
              dataRow('No system dependency', 'Works without soft keyboard'),
            ],
          )),
      infoCard(
          'Disadvantages',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No autocorrect', 'Must implement yourself'),
              dataRow('No IME support', 'CJK input requires extra work'),
              dataRow('No dictionary', 'No word suggestions'),
              dataRow('Accessibility', 'Must build from scratch'),
              dataRow('Maintenance', 'Ongoing layout updates'),
            ],
          )),
      infoCard(
          'When to Use Which',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Standard forms', 'Use platform keyboard'),
              dataRow('PIN / OTP', 'Custom control is better'),
              dataRow('Game chat', 'Custom control with theme'),
              dataRow('Kiosk', 'Custom control (no choice)'),
              dataRow('CJK text', 'Platform keyboard required'),
            ],
          )),
    ],
  );

  // ─── Section 10: Focus Integration ───
  print('[Section 10] Focus Integration');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Focus Integration'),
      noteBox(
          'Custom TextInputControl must work correctly with Flutter\'s '
          'focus system. When a TextField gains focus, your control\'s '
          'show() is called. When focus leaves, hide() is called. '
          'Proper focus handling prevents ghost keyboards.'),
      infoCard(
          'Focus → Show Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('User taps TextField', 'FocusNode gains focus'),
              dataRow('Framework calls', 'TextInput.attach(client, config)'),
              dataRow('Your control', 'setClient(config) called'),
              dataRow('Then', 'show() called — display keyboard'),
            ],
          )),
      infoCard(
          'Blur → Hide Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('User taps elsewhere', 'FocusNode loses focus'),
              dataRow('Framework calls', 'connection.close()'),
              dataRow('Your control', 'hide() called — dismiss keyboard'),
              dataRow('Then', 'setClient(null) — no active client'),
            ],
          )),
      infoCard(
          'Multi-Field Focus',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tab between fields', 'hide() + setClient + show()'),
              dataRow('Keyboard stays up', 'If your impl keeps it visible'),
              dataRow('Config change', 'New config per field (type, action)'),
              dataRow('State sync', 'setEditingState with new text'),
            ],
          )),
    ],
  );

  // ─── Section 11: Desktop Considerations ───
  print('[Section 11] Desktop Considerations');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Desktop Considerations'),
      noteBox(
          'On desktop platforms, the system keyboard is physical. Custom '
          'TextInputControl is less common here but can be useful for '
          'virtual keyboards in remote desktop apps, accessibility tools, '
          'or specialized input methods.'),
      infoCard(
          'Desktop Use Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Virtual keyboard', 'Remote desktop apps'),
              dataRow('On-screen keyboard', 'Accessibility assistive tool'),
              dataRow('Emoji picker', 'Custom emoji palette keyboard'),
              dataRow('Symbol input', 'Math/science symbol keyboard'),
              dataRow('Macro keyboard', 'Programmable shortcut pad'),
            ],
          )),
      infoCard(
          'Physical Key Interaction',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Physical keys', 'Still work normally'),
              dataRow('Custom control', 'Supplements, not replaces'),
              dataRow('Conflict handling', 'Both can send input'),
              dataRow('Priority', 'Physical keys bypass your control'),
            ],
          )),
    ],
  );

  // ─── Section 12: Web Platform ───
  print('[Section 12] Web Platform');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Web Platform'),
      noteBox(
          'On the web, TextInputControl replaces the browser\'s native '
          'text input handling. This can be useful for rich text editors '
          'or apps that need consistent input across browsers.'),
      infoCard(
          'Web-Specific Challenges',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Browser variations', 'Each browser differs'),
              dataRow('Accessibility', 'ARIA attributes needed'),
              dataRow('Mobile web', 'Must still allow device keyboard'),
              dataRow('Clipboard', 'Custom paste handling needed'),
            ],
          )),
      infoCard(
          'Implementation Strategy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Desktop browser', 'Virtual keyboard useful'),
              dataRow('Mobile browser', 'Use platform keyboard instead'),
              dataRow('Detection', 'Check platform in your control'),
              dataRow('Fallback', 'Restore platform input on mobile'),
            ],
          )),
    ],
  );

  // ─── Section 13: Composing Support ───
  print('[Section 13] Composing Support');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Composing Support'),
      noteBox(
          'If your custom keyboard needs to support composing (multi-step '
          'input like CJK), you must manage the composing region in '
          'TextEditingValue yourself — there is no automatic IME support '
          'when using a custom TextInputControl.'),
      infoCard(
          'Composing Basics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('composing range', 'Set on TextEditingValue'),
              dataRow('Visual hint', 'Render underline/highlight'),
              dataRow('Candidate list', 'Show popup with choices'),
              dataRow('Commit', 'Clear composing, update text'),
            ],
          )),
      infoCard(
          'When Composing Matters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Swipe keyboard', 'Build word before commit'),
              dataRow('Handwriting input', 'Recognize before inserting'),
              dataRow('Auto-complete', 'Show suggestion inline'),
              dataRow('Multi-tap', 'T9-style character selection'),
            ],
          )),
    ],
  );

  // ─── Section 14: Error Handling & Robustness ───
  print('[Section 14] Error Handling & Robustness');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Error Handling & Robustness'),
      noteBox(
          'Custom TextInputControl implementations must be robust against '
          'lifecycle edge cases. The framework may call methods in '
          'unexpected orders — your control must handle this gracefully.'),
      infoCard(
          'Edge Cases to Handle',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('show() before setClient', 'Guard with null check'),
              dataRow('hide() when already hidden', 'Should be idempotent'),
              dataRow('setClient() while shown', 'New field, keep showing'),
              dataRow('Rapid show/hide', 'Debounce or queue requests'),
              dataRow('Hot restart', 'Lost state — reinitialize'),
            ],
          )),
      infoCard(
          'Defensive Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Non-null client check', 'Before sending updates'),
              dataRow('isVisible flag', 'Track keyboard visibility state'),
              dataRow('Timer cleanup', 'Cancel timers in hide()'),
              dataRow('OverlayEntry removal', 'Ensure overlay is removed'),
            ],
          )),
    ],
  );

  // ─── Section 15: Accessibility ───
  print('[Section 15] Accessibility');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Accessibility'),
      noteBox(
          'When bypassing the platform keyboard, you also bypass its '
          'accessibility features. Your custom input must provide '
          'equivalent accessibility — screen reader labels, focus '
          'traversal, and sizing for motor impairments.'),
      infoCard(
          'Accessibility Requirements',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Semantics labels', 'Every key needs a label'),
              dataRow('Focus traversal', 'Tab/arrow through keys'),
              dataRow('Min target 48px', 'WCAG touch target size'),
              dataRow('Color contrast', '4.5:1 ratio minimum'),
              dataRow('Screen reader', 'Announce key presses'),
            ],
          )),
      infoCard(
          'Common Mistakes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Missing semantics', 'Keys are invisible to SR'),
              dataRow('Small keys', 'Hard to tap for motor impaired'),
              dataRow('No sound feedback', 'Haptic/sound on key press'),
              dataRow('No visual focus', 'No highlight on focused key'),
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
      noteBox('Complete overview of the TextInputControl deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Amber', amber),
              colorSwatch('Gold', gold),
              colorSwatch('Deep Amber', deepAmber),
              colorSwatch('Pale Yellow', paleYellow),
              colorSwatch('Honey', honey),
              colorSwatch('Cream', cream),
              colorSwatch('Bronze', bronze),
              colorSwatch('Saffron', saffron),
              colorSwatch('Wheat', wheat),
              colorSwatch('Ochre', ochre),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, amber),
              progressBar('Abstract API', 1.0, gold),
              progressBar('Custom Keyboard', 1.0, honey),
              progressBar('Registration & Lifecycle', 1.0, ochre),
              progressBar('Editing Value Mgmt', 1.0, saffron),
              progressBar('PIN Pad Example', 1.0, amber),
              progressBar('Game Chat Input', 1.0, gold),
              progressBar('Kiosk Mode', 1.0, honey),
              progressBar('Vs Platform Input', 1.0, ochre),
              progressBar('Focus Integration', 1.0, saffron),
              progressBar('Desktop', 1.0, amber),
              progressBar('Web Platform', 1.0, gold),
              progressBar('Composing Support', 1.0, honey),
              progressBar('Error Handling', 1.0, ochre),
              progressBar('Accessibility', 1.0, saffron),
              progressBar('Dashboard', 1.0, amber),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Amber / Gold'),
              dataRow('Palette colors', '10'),
              dataRow('API methods', '${apiMethods.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('TextInputControl', amber, Colors.white),
          tag('Custom Keyboard', gold, Colors.white),
          tag('PIN Pad', honey, deepAmber),
          tag('Kiosk', ochre, Colors.white),
          tag('Game Input', saffron, deepAmber),
          tag('Accessibility', bronze, Colors.white),
        ],
      ),
    ],
  );

  print('===== END TEXT INPUT CONTROL DEEP DEMO =====');

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
