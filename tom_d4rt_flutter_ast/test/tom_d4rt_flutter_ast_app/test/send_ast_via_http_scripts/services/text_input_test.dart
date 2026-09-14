// ignore_for_file: avoid_print
// D4rt deep demo: TextInput — the static class that serves as the central
// entry point for Flutter's text input system, coordinating connections
// between clients and the platform's input method engine.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Indigo / Violet palette ───
  const Color indigo = Color(0xFF4F46E5);
  const Color violet = Color(0xFF7C3AED);
  const Color deepIndigo = Color(0xFF312E81);
  const Color paleLavender = Color(0xFFF5F3FF);
  const Color iris = Color(0xFF6366F1);
  const Color lilac = Color(0xFFEDE9FE);
  const Color plum = Color(0xFF5B21B6);
  const Color periwinkle = Color(0xFF818CF8);
  const Color thistle = Color(0xFFDDD6FE);
  const Color amethyst = Color(0xFF8B5CF6);

  print('===== TEXT INPUT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepIndigo, plum],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepIndigo.withValues(alpha: 0.35),
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
              color: indigo,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: periwinkle, width: 1.5),
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
        color: paleLavender,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: lilac),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepIndigo.withValues(alpha: 0.9),
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
        border: Border.all(color: lilac),
        boxShadow: [
          BoxShadow(
            color: indigo.withValues(alpha: 0.07),
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
              color: paleLavender,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepIndigo)),
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
                    color: deepIndigo)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: plum)),
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
                  color: deepIndigo.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepIndigo),
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
                  style: TextStyle(fontSize: 11, color: deepIndigo)),
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
              color: thistle,
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

  Widget flowStep(String step, String description, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(step,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: deepIndigo)),
              Text(description,
                  style: TextStyle(fontSize: 11, color: plum)),
            ],
          ),
        ],
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
          'TextInput is the static class that serves as the central '
          'coordination point for Flutter\'s entire text input system. '
          'It provides static methods to attach clients, manage input '
          'controls, configure scribble, and finalize autofill groups. '
          'It is the glue between TextInputClient, TextInputConnection, '
          'TextInputControl, and the platform method channel.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Static class (non-instantiable)'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Text input system entry point'),
              dataRow('Instantiation', 'Cannot be instantiated'),
              dataRow('Pattern', 'Singleton static API'),
            ],
          )),
      infoCard(
          'Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Client management', 'Track active input client'),
              dataRow('Connection broker', 'Create TextInputConnection'),
              dataRow('Control routing', 'Route to platform or custom'),
              dataRow('Scribble support', 'Manage Scribble interactions'),
              dataRow('Autofill', 'Finalize autofill groups'),
            ],
          )),
    ],
  );

  // ─── Section 2: Static Methods Gallery ───
  print('[Section 2] Static Methods Gallery');

  final staticMethods = <Map<String, String>>[
    {'method': 'attach()', 'signature': 'TextInputConnection attach(client, config)', 'purpose': 'Create a new text input connection'},
    {'method': 'setInputControl()', 'signature': 'void setInputControl(TextInputControl?)', 'purpose': 'Replace platform input with custom'},
    {'method': 'restorePlatformInputControl()', 'signature': 'void restorePlatformInputControl()', 'purpose': 'Revert to default platform input'},
    {'method': 'finishAutofillContext()', 'signature': 'void finishAutofillContext({shouldSave})', 'purpose': 'Complete or cancel autofill session'},
    {'method': 'setChannel()', 'signature': 'void setChannel(MethodChannel)', 'purpose': 'Override the platform channel (testing)'},
    {'method': 'ensureInitialized()', 'signature': 'void ensureInitialized()', 'purpose': 'Initialize text input subsystem'},
  ];

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Static Methods Gallery'),
      noteBox(
          'TextInput provides a small but powerful set of static methods. '
          'Each method controls a different aspect of the text input '
          'system. Most app code only ever calls attach() indirectly '
          'through TextField.'),
      for (final m in staticMethods)
        infoCard(
            m['method']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Method', m['method']!),
                dataRow('Signature', m['signature']!),
                dataRow('Purpose', m['purpose']!),
              ],
            )),
    ],
  );

  // ─── Section 3: attach() In Depth ───
  print('[Section 3] attach() In Depth');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'attach() In Depth'),
      noteBox(
          'TextInput.attach() is the most important method — it creates '
          'the connection between a TextInputClient and the platform. '
          'Only one connection can be active at a time. Attaching a new '
          'client automatically detaches the previous one.'),
      infoCard(
          'Attach Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flowStep('1. Client requests', 'TextInput.attach(client, config)',
                  Icons.input, indigo),
              flowStep('2. Detach previous', 'Old connection is closed',
                  Icons.link_off, violet),
              flowStep('3. Create connection', 'New TextInputConnection made',
                  Icons.link, iris),
              flowStep('4. Configure platform', 'Send config via channel',
                  Icons.settings, amethyst),
              flowStep('5. Return connection', 'Client uses it to communicate',
                  Icons.check, periwinkle),
            ],
          )),
      infoCard(
          'Configuration Parameters',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('inputType', 'TextInputType for keyboard layout'),
              dataRow('inputAction', 'TextInputAction for action button'),
              dataRow('obscureText', 'Password masking'),
              dataRow('autocorrect', 'Auto-correction toggle'),
              dataRow('autofillConfiguration', 'Autofill hints'),
              dataRow('smartDashesType', 'Typography en/em dashes'),
              dataRow('smartQuotesType', 'Typography curly quotes'),
              dataRow('enableSuggestions', 'Keyboard suggestions'),
              dataRow('enableDeltaModel', 'Use delta-based input'),
            ],
          )),
    ],
  );

  // ─── Section 4: Input Control System ───
  print('[Section 4] Input Control System');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Input Control System'),
      noteBox(
          'TextInput allows replacing the platform\'s text input with a '
          'custom TextInputControl. This is the mechanism behind custom '
          'in-app keyboards, PIN pads, and other specialized input methods.'),
      infoCard(
          'Control Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Default', 'Platform input control'),
              dataRow('Custom', 'Your TextInputControl subclass'),
              dataRow('Restore', 'restorePlatformInputControl()'),
              dataRow('Scope', 'App-wide, all TextFields'),
            ],
          )),
      infoCard(
          'setInputControl() Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Null argument', 'Not allowed, use restore'),
              dataRow('Immediate effect', 'Next attach uses new control'),
              dataRow('Active connection', 'Existing stays on old control'),
              dataRow('Thread safety', 'Must call from main isolate'),
            ],
          )),
      infoCard(
          'Control Routing',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('show()', 'Routed to active control'),
              dataRow('hide()', 'Routed to active control'),
              dataRow('setEditingState()', 'Routed to active control'),
              dataRow('setCaretRect()', 'Routed to active control'),
            ],
          )),
    ],
  );

  // ─── Section 5: Platform Channel ───
  print('[Section 5] Platform Channel');

  final channelMethods = <Map<String, String>>[
    {'name': 'TextInput.setClient', 'dir': '→ Platform', 'data': 'Client ID + config JSON'},
    {'name': 'TextInput.show', 'dir': '→ Platform', 'data': '(empty)'},
    {'name': 'TextInput.setEditingState', 'dir': '→ Platform', 'data': 'TextEditingValue'},
    {'name': 'TextInput.clearClient', 'dir': '→ Platform', 'data': '(empty)'},
    {'name': 'TextInput.hide', 'dir': '→ Platform', 'data': '(empty)'},
    {'name': 'TextInputClient.updateEditingState', 'dir': '← Platform', 'data': 'TextEditingValue'},
    {'name': 'TextInputClient.performAction', 'dir': '← Platform', 'data': 'Action string'},
    {'name': 'TextInputClient.updateEditingStateWithDeltas', 'dir': '← Platform', 'data': 'Delta list'},
  ];

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Platform Channel'),
      noteBox(
          'TextInput communicates with the platform through '
          'SystemChannels.textInput — a MethodChannel. The channel carries '
          'JSON-encoded messages for all text input operations.'),
      for (final ch in channelMethods)
        infoCard(
            ch['name']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Method', ch['name']!),
                dataRow('Direction', ch['dir']!),
                dataRow('Payload', ch['data']!),
              ],
            )),
    ],
  );

  // ─── Section 6: Autofill Management ───
  print('[Section 6] Autofill Management');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Autofill Management'),
      noteBox(
          'TextInput.finishAutofillContext() tells the platform whether to '
          'save or discard the autofill data from the current autofill '
          'group. This is typically called after a login form is submitted, '
          'letting the password manager store credentials.'),
      infoCard(
          'finishAutofillContext()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('shouldSave: true', 'Offer to save credentials'),
              dataRow('shouldSave: false', 'Discard autofill data'),
              dataRow('Typical use', 'After successful login'),
              dataRow('Platform behavior', 'Shows save password dialog'),
            ],
          )),
      infoCard(
          'Autofill Group Lifecycle',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flowStep('1. User fills form', 'AutofillGroup wraps fields',
                  Icons.edit, indigo),
              flowStep('2. Fields connected', 'Each has autofillHints',
                  Icons.link, violet),
              flowStep('3. User submits', 'App processes credentials',
                  Icons.send, iris),
              flowStep('4. Finish context', 'finishAutofillContext(save: true)',
                  Icons.save, amethyst),
              flowStep('5. Platform offers', 'Save to password manager?',
                  Icons.key, periwinkle),
            ],
          )),
    ],
  );

  // ─── Section 7: Scribble Integration ───
  print('[Section 7] Scribble Integration');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Scribble Integration'),
      noteBox(
          'TextInput manages Scribble interactions on iPadOS where Apple '
          'Pencil can write directly into text fields. It coordinates '
          'handwriting recognition with the text input system.'),
      infoCard(
          'Scribble Support',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Platform', 'iPadOS 14+ with Apple Pencil'),
              dataRow('Registration', 'Scribble-enabled fields register'),
              dataRow('Recognition', 'Platform converts ink to text'),
              dataRow('Focus', 'Pencil tap opens text field'),
            ],
          )),
      infoCard(
          'Scribble Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('registerScribbleElement', 'Register for handwriting'),
              dataRow('unregisterScribbleElement', 'Deregister element'),
              dataRow('scribbleInProgress', 'Track writing state'),
              dataRow('setSelectionRects', 'Provide character rects'),
            ],
          )),
    ],
  );

  // ─── Section 8: ensureInitialized() ───
  print('[Section 8] ensureInitialized()');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'ensureInitialized()'),
      noteBox(
          'TextInput.ensureInitialized() sets up the method channel handler '
          'for incoming messages from the platform. It is called automatically '
          'when needed, but can be called explicitly to guarantee that the '
          'text input system is ready before any interactions.'),
      infoCard(
          'Initialization Details',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Auto-called', 'First time attach() is used'),
              dataRow('Idempotent', 'Safe to call multiple times'),
              dataRow('What it does', 'Registers method call handler'),
              dataRow('Handler role', 'Routes platform callbacks'),
            ],
          )),
      infoCard(
          'When to Call Explicitly',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Custom testing', 'Before setting up mock channel'),
              dataRow('Plugin init', 'Plugins that intercept text input'),
              dataRow('Debugging', 'Ensure handler is registered'),
              dataRow('Not needed for', 'Normal app development'),
            ],
          )),
    ],
  );

  // ─── Section 9: setChannel() for Testing ───
  print('[Section 9] setChannel() for Testing');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'setChannel() for Testing'),
      noteBox(
          'TextInput.setChannel() replaces the method channel used for '
          'text input communication. This is primarily a testing API '
          'that allows test frameworks to intercept and mock all text '
          'input messages.'),
      infoCard(
          'Testing Use Case',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Intercept platform messages'),
              dataRow('Test framework', 'flutter_test uses this'),
              dataRow('Mock channel', 'Captures attach/show/hide calls'),
              dataRow('Verification', 'Assert correct message sequence'),
            ],
          )),
      infoCard(
          'TestTextInput Integration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TestTextInput', 'Built-in mock text input'),
              dataRow('Registration', 'Replaces channel in setUp'),
              dataRow('Simulation', 'enterText(), showKeyboard()'),
              dataRow('Assertions', 'Verify editing state updates'),
            ],
          )),
    ],
  );

  // ─── Section 10: Focus System Integration ───
  print('[Section 10] Focus System Integration');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Focus System Integration'),
      noteBox(
          'TextInput is deeply integrated with Flutter\'s focus system. '
          'When a text field gains focus, attach() is called. When focus '
          'leaves, the connection is closed. This automatic management '
          'ensures the keyboard appears and disappears correctly.'),
      infoCard(
          'Focus → TextInput Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flowStep('1. Tap TextField', 'FocusNode.requestFocus()',
                  Icons.touch_app, indigo),
              flowStep('2. Focus granted', 'onFocusChange(true)',
                  Icons.center_focus_strong, violet),
              flowStep('3. Attach client', 'TextInput.attach()',
                  Icons.link, iris),
              flowStep('4. Show keyboard', 'connection.show()',
                  Icons.keyboard, amethyst),
              flowStep('5. Begin editing', 'State flows back and forth',
                  Icons.edit, periwinkle),
            ],
          )),
      infoCard(
          'Unfocus → Close Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              flowStep('1. Tap elsewhere', 'FocusNode loses focus',
                  Icons.touch_app, indigo),
              flowStep('2. Focus lost', 'onFocusChange(false)',
                  Icons.blur_on, violet),
              flowStep('3. Close connection', 'connection.close()',
                  Icons.link_off, iris),
              flowStep('4. Keyboard hides', 'Platform dismisses keyboard',
                  Icons.keyboard_hide, amethyst),
            ],
          )),
    ],
  );

  // ─── Section 11: Cross-Platform Behavior ───
  print('[Section 11] Cross-Platform Behavior');

  final platforms = <Map<String, String>>[
    {'platform': 'Android', 'keyboard': 'System soft keyboard', 'ime': 'Full IME support', 'special': 'Content commitment API'},
    {'platform': 'iOS', 'keyboard': 'System soft keyboard', 'ime': 'Full IME support', 'special': 'Scribble + Floating cursor'},
    {'platform': 'Web', 'keyboard': 'Browser input element', 'ime': 'Browser-dependent', 'special': 'Hidden input strategy'},
    {'platform': 'macOS', 'keyboard': 'Physical + IME', 'ime': 'Native IME', 'special': 'Selector-based actions'},
    {'platform': 'Linux', 'keyboard': 'Physical + IBus/Fcitx', 'ime': 'Through GTK/IBus', 'special': 'IME framework dependent'},
    {'platform': 'Windows', 'keyboard': 'Physical + IME', 'ime': 'Windows IME', 'special': 'Touch keyboard support'},
  ];

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Cross-Platform Behavior'),
      noteBox(
          'TextInput abstracts platform differences, but each platform '
          'has unique text input capabilities and limitations. '
          'Understanding these helps build robust text editing experiences.'),
      for (final p in platforms)
        infoCard(
            p['platform']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Platform', p['platform']!),
                dataRow('Keyboard', p['keyboard']!),
                dataRow('IME support', p['ime']!),
                dataRow('Special', p['special']!),
              ],
            )),
    ],
  );

  // ─── Section 12: Delta Model ───
  print('[Section 12] Delta Model');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Delta Model'),
      noteBox(
          'When enableDeltaModel is set in the configuration during attach, '
          'the platform sends incremental text deltas instead of full state '
          'snapshots. This is managed through TestInput\'s routing to the '
          'DeltaTextInputClient protocol.'),
      infoCard(
          'Delta vs Snapshot',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Snapshot model', 'Full TextEditingValue every time'),
              dataRow('Delta model', 'Only changes (insert/delete/replace)'),
              dataRow('Best for short', 'Snapshot — simpler logic'),
              dataRow('Best for long', 'Delta — less data transferred'),
            ],
          )),
      infoCard(
          'Configuration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('enableDeltaModel', 'true in TextInputConfiguration'),
              dataRow('Client type', 'Must implement DeltaTextInputClient'),
              dataRow('Callback', 'updateEditingValueWithDeltas()'),
              dataRow('Fallback', 'Framework adapts if delta unavailable'),
            ],
          )),
    ],
  );

  // ─── Section 13: Error Scenarios ───
  print('[Section 13] Error Scenarios');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Error Scenarios'),
      noteBox(
          'TextInput has several defensive checks and error scenarios '
          'that developers should be aware of. These typically surface '
          'as assertions in debug mode.'),
      infoCard(
          'Common Errors',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No active client', 'Message arrives with no client'),
              dataRow('Wrong client ID', 'Platform sends stale client ID'),
              dataRow('Close on closed', 'Closing already-closed connection'),
              dataRow('State mismatch', 'Platform and framework disagree'),
            ],
          )),
      infoCard(
          'Debug Assertions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Client attached', 'assert(_currentConnection != null)'),
              dataRow('Valid state', 'TextEditingValue validated'),
              dataRow('Channel ready', 'Method channel initialized'),
              dataRow('Single active', 'Only one connection permitted'),
            ],
          )),
    ],
  );

  // ─── Section 14: Relationship Map ───
  print('[Section 14] Relationship Map');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Relationship Map'),
      noteBox(
          'TextInput sits at the center of a web of related classes. '
          'Understanding these relationships is key to understanding '
          'Flutter\'s text input architecture.'),
      infoCard(
          'Direct Dependencies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextInputClient', 'The widget receiving input'),
              dataRow('TextInputConnection', 'The communication channel'),
              dataRow('TextInputControl', 'The input implementation'),
              dataRow('TextInputConfiguration', 'Keyboard settings'),
              dataRow('SystemChannels.textInput', 'Platform channel'),
            ],
          )),
      infoCard(
          'Indirect Users',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextField', 'Material text field widget'),
              dataRow('CupertinoTextField', 'Cupertino text field'),
              dataRow('EditableText', 'Core editable text widget'),
              dataRow('EditableTextState', 'Implements TextInputClient'),
              dataRow('FocusNode', 'Triggers attach/close'),
            ],
          )),
    ],
  );

  // ─── Section 15: Best Practices ───
  print('[Section 15] Best Practices');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Best Practices'),
      noteBox(
          'While most developers interact with TextInput indirectly through '
          'TextField, those building custom text editors or input systems '
          'should follow these practices.'),
      infoCard(
          'Do',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Use TextField', 'For standard text entry'),
              dataRow('Close connections', 'Always in dispose()'),
              dataRow('Handle reconnection', 'In connectionClosed()'),
              dataRow('Test with TestTextInput', 'For widget tests'),
            ],
          )),
      infoCard(
          'Avoid',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Direct attach()', 'Unless building custom editor'),
              dataRow('Multiple connections', 'Only one can be active'),
              dataRow('Skipping close()', 'Causes leaked connections'),
              dataRow('setChannel() in prod', 'Testing API only'),
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
      noteBox('Complete overview of the TextInput deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Indigo', indigo),
              colorSwatch('Violet', violet),
              colorSwatch('Deep Indigo', deepIndigo),
              colorSwatch('Pale Lavender', paleLavender),
              colorSwatch('Iris', iris),
              colorSwatch('Lilac', lilac),
              colorSwatch('Plum', plum),
              colorSwatch('Periwinkle', periwinkle),
              colorSwatch('Thistle', thistle),
              colorSwatch('Amethyst', amethyst),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, indigo),
              progressBar('Static Methods', 1.0, violet),
              progressBar('attach() In Depth', 1.0, iris),
              progressBar('Input Control System', 1.0, amethyst),
              progressBar('Platform Channel', 1.0, periwinkle),
              progressBar('Autofill Management', 1.0, indigo),
              progressBar('Scribble Integration', 1.0, violet),
              progressBar('ensureInitialized()', 1.0, iris),
              progressBar('setChannel() Testing', 1.0, amethyst),
              progressBar('Focus Integration', 1.0, periwinkle),
              progressBar('Cross-Platform', 1.0, indigo),
              progressBar('Delta Model', 1.0, violet),
              progressBar('Error Scenarios', 1.0, iris),
              progressBar('Relationship Map', 1.0, amethyst),
              progressBar('Best Practices', 1.0, periwinkle),
              progressBar('Dashboard', 1.0, indigo),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Indigo / Violet'),
              dataRow('Palette colors', '10'),
              dataRow('Static methods', '${staticMethods.length}'),
              dataRow('Channel methods', '${channelMethods.length}'),
              dataRow('Platforms covered', '${platforms.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('TextInput', indigo, Colors.white),
          tag('Static API', violet, Colors.white),
          tag('Method Channel', iris, Colors.white),
          tag('Focus', amethyst, Colors.white),
          tag('Autofill', periwinkle, Colors.white),
          tag('Scribble', plum, Colors.white),
          tag('Cross-Platform', deepIndigo, Colors.white),
        ],
      ),
    ],
  );

  print('===== END TEXT INPUT DEEP DEMO =====');

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
