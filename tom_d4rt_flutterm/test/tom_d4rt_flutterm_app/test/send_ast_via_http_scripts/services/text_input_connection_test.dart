// ignore_for_file: avoid_print
// D4rt deep demo: TextInputConnection — the bidirectional communication
// channel between a TextInputClient and the platform's text input system,
// managing keyboard attachment, editing state, and IME configuration.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Teal / Cyan palette ───
  const Color teal = Color(0xFF0D9488);
  const Color cyan = Color(0xFF06B6D4);
  const Color deepTeal = Color(0xFF134E4A);
  const Color paleMint = Color(0xFFF0FDFA);
  const Color aqua = Color(0xFF14B8A6);
  const Color seafoam = Color(0xFFCCFBF1);
  const Color darkCyan = Color(0xFF155E75);
  const Color turquoise = Color(0xFF2DD4BF);
  const Color iceBlue = Color(0xFFE0F2FE);
  const Color lagoon = Color(0xFF0891B2);

  print('===== TEXT INPUT CONNECTION DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepTeal, darkCyan],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withValues(alpha: 0.35),
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
              color: teal,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: turquoise, width: 1.5),
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
        color: paleMint,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: seafoam),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepTeal.withValues(alpha: 0.9),
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
        border: Border.all(color: seafoam),
        boxShadow: [
          BoxShadow(
            color: teal.withValues(alpha: 0.07),
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
              color: paleMint,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepTeal)),
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
                    color: deepTeal)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: darkCyan)),
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
                  color: deepTeal.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepTeal),
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
                  style: TextStyle(fontSize: 11, color: deepTeal)),
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
              color: iceBlue,
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

  Widget lifecycleArrow(String from, String to, String note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: teal,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(from,
                style: const TextStyle(
                    fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.arrow_forward, size: 16, color: lagoon),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: cyan,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(to,
                style: const TextStyle(
                    fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(note,
                style: TextStyle(fontSize: 10, color: darkCyan, fontStyle: FontStyle.italic)),
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
          'TextInputConnection is the channel between a TextInputClient and '
          'the platform\'s text input system. Once a client attaches via '
          'TextInput.attach(), it receives a TextInputConnection that '
          'allows it to send editing state, show/hide the keyboard, and '
          'configure the input method. This is the primary mechanism that '
          'makes text editing work across all Flutter platforms.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Class'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Bidirectional platform text channel'),
              dataRow('Created by', 'TextInput.attach(client, config)'),
              dataRow('Lifecycle', 'Attach → use → close'),
            ],
          )),
      infoCard(
          'What It Communicates',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('To platform', 'Editing state, cursor rect, style'),
              dataRow('From platform', 'Updated text, actions, content'),
              dataRow('Configuration', 'Input type, action, flags'),
              dataRow('Keyboard', 'Show/hide virtual keyboard'),
            ],
          )),
    ],
  );

  // ─── Section 2: Connection Lifecycle ───
  print('[Section 2] Connection Lifecycle');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Connection Lifecycle'),
      noteBox(
          'A TextInputConnection goes through a well-defined lifecycle: '
          'attachment, configuration, active editing, and eventual close. '
          'Understanding this lifecycle is critical for custom text input '
          'implementations.'),
      infoCard(
          'Lifecycle Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lifecycleArrow('Idle', 'Attached', 'TextInput.attach()'),
              lifecycleArrow('Attached', 'Visible', 'connection.show()'),
              lifecycleArrow('Visible', 'Editing', 'State exchanges begin'),
              lifecycleArrow('Editing', 'Hidden', 'connection.hide()'),
              lifecycleArrow('Hidden', 'Closed', 'connection.close()'),
            ],
          )),
      infoCard(
          'Lifecycle Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('attached', 'True after attach, false after close'),
              dataRow('scribbleInProgress', 'Apple Pencil writing active'),
              dataRow('connectionClosedReceived',
                  'Platform initiated close'),
            ],
          )),
    ],
  );

  // ─── Section 3: Attaching to Platform ───
  print('[Section 3] Attaching to Platform');

  final attachConfigs = <Map<String, String>>[
    {'field': 'inputType', 'value': 'TextInputType.text', 'effect': 'Standard text keyboard'},
    {'field': 'inputAction', 'value': 'TextInputAction.done', 'effect': 'Done button on keyboard'},
    {'field': 'obscureText', 'value': 'true', 'effect': 'Password field masking'},
    {'field': 'autocorrect', 'value': 'true', 'effect': 'Platform auto-correction'},
    {'field': 'smartDashesType', 'value': 'SmartDashesType.enabled', 'effect': 'Auto typographic dashes'},
    {'field': 'smartQuotesType', 'value': 'SmartQuotesType.enabled', 'effect': 'Auto curly quotes'},
    {'field': 'enableSuggestions', 'value': 'true', 'effect': 'Keyboard suggestions bar'},
    {'field': 'enableIMEPersonalized', 'value': 'false', 'effect': 'Disable IME learning'},
  ];

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Attaching to Platform'),
      noteBox(
          'TextInput.attach() creates the connection with a configuration '
          'that tells the platform what kind of text input to provide. The '
          'TextInputConfiguration object carries all the parameters that '
          'affect keyboard appearance and behavior.'),
      for (final cfg in attachConfigs)
        infoCard(
            cfg['field']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Field', cfg['field']!),
                dataRow('Example value', cfg['value']!),
                dataRow('Effect', cfg['effect']!),
              ],
            )),
    ],
  );

  // ─── Section 4: Setting Editing State ───
  print('[Section 4] Setting Editing State');

  final editingStates = <Map<String, String>>[
    {'scenario': 'Initial empty', 'text': '', 'selection': 'collapsed at 0', 'composing': 'empty'},
    {'scenario': 'Typed "Hello"', 'text': 'Hello', 'selection': 'collapsed at 5', 'composing': 'empty'},
    {'scenario': 'Composing 日本', 'text': '日本', 'selection': 'collapsed at 2', 'composing': '0..2'},
    {'scenario': 'Selected all', 'text': 'Hello World', 'selection': 'extent 0..11', 'composing': 'empty'},
    {'scenario': 'Cursor in middle', 'text': 'Flutter', 'selection': 'collapsed at 4', 'composing': 'empty'},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Setting Editing State'),
      noteBox(
          'setEditingState() sends the current TextEditingValue from the '
          'client to the platform. This synchronizes the platform\'s view '
          'of the text with the widget\'s internal state. It should be '
          'called whenever the client programmatically changes text.'),
      for (final es in editingStates)
        infoCard(
            es['scenario']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Scenario', es['scenario']!),
                dataRow('Text', es['text']!.isEmpty ? '(empty)' : '"${es['text']}"'),
                dataRow('Selection', es['selection']!),
                dataRow('Composing', es['composing']!),
              ],
            )),
    ],
  );

  // ─── Section 5: Keyboard Show & Hide ───
  print('[Section 5] Keyboard Show & Hide');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Keyboard Show & Hide'),
      noteBox(
          'The connection provides show() and hide() to control virtual '
          'keyboard visibility. On desktop platforms with physical keyboards, '
          'show() may have no visible effect but still activates the input '
          'channel.'),
      infoCard(
          'show() Method',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Request virtual keyboard display'),
              dataRow('Mobile', 'Slides keyboard up from bottom'),
              dataRow('Desktop', 'Activates input processing'),
              dataRow('Web', 'Browser virtual keyboard (if device)'),
              dataRow('Precondition', 'Connection must be attached'),
            ],
          )),
      infoCard(
          'hide() Method',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Dismiss virtual keyboard'),
              dataRow('Does not close', 'Connection remains active'),
              dataRow('Re-showable', 'Can call show() again later'),
              dataRow('Focus effect', 'May or may not affect focus'),
            ],
          )),
      infoCard(
          'Platform Differences',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iOS', 'Animated slide up/down'),
              dataRow('Android', 'System-controlled with insets'),
              dataRow('Web (touch)', 'Browser-managed popup'),
              dataRow('Web (desktop)', 'No virtual keyboard shown'),
              dataRow('macOS / Linux', 'No visual keyboard'),
              dataRow('Windows', 'Touch keyboard if available'),
            ],
          )),
    ],
  );

  // ─── Section 6: Cursor & Caret Updates ───
  print('[Section 6] Cursor & Caret Updates');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Cursor & Caret Updates'),
      noteBox(
          'The connection allows the client to report the cursor\'s '
          'position and dimensions to the platform. This enables the '
          'platform to position autocomplete popups, IME candidate '
          'windows, and other overlays near the cursor.'),
      infoCard(
          'setCaretRect()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Report caret position to platform'),
              dataRow('Data type', 'Rect in local coordinates'),
              dataRow('Used by', 'IME candidate window positioning'),
              dataRow('When to call', 'Every time cursor moves'),
            ],
          )),
      infoCard(
          'setComposingRect()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Position for composing UI overlay'),
              dataRow('CJK input', 'Positions candidate list popup'),
              dataRow('Autocorrect', 'Positions autocorrect bar'),
              dataRow('Difference', 'May differ from caret rect'),
            ],
          )),
      infoCard(
          'setSelectionRects()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Report all character positions'),
              dataRow('Apple Pencil', 'Required for Scribble feature'),
              dataRow('Data', 'List<SelectionRect> for all chars'),
              dataRow('Performance', 'Can be expensive for large text'),
            ],
          )),
      infoCard(
          'setStyle()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Font info for IME rendering'),
              dataRow('Font family', 'Helps IME match font style'),
              dataRow('Font size', 'IME candidate text sizing'),
              dataRow('Text direction', 'LTR or RTL for layout'),
            ],
          )),
    ],
  );

  // ─── Section 7: Platform Method Channels ───
  print('[Section 7] Platform Method Channels');

  final channels = <Map<String, String>>[
    {'method': 'TextInput.attach', 'direction': 'Client → Platform', 'data': 'Configuration JSON'},
    {'method': 'TextInput.setEditingState', 'direction': 'Client → Platform', 'data': 'TextEditingValue'},
    {'method': 'TextInput.show', 'direction': 'Client → Platform', 'data': '(none)'},
    {'method': 'TextInput.hide', 'direction': 'Client → Platform', 'data': '(none)'},
    {'method': 'TextInput.setCaretRect', 'direction': 'Client → Platform', 'data': 'Rect'},
    {'method': 'TextInputClient.updateEditingState', 'direction': 'Platform → Client', 'data': 'TextEditingValue'},
    {'method': 'TextInputClient.performAction', 'direction': 'Platform → Client', 'data': 'TextInputAction'},
    {'method': 'TextInput.close', 'direction': 'Client → Platform', 'data': 'Connection ID'},
  ];

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Platform Method Channels'),
      noteBox(
          'Under the hood, TextInputConnection communicates through the '
          'SystemChannels.textInput method channel. Each operation maps '
          'to a specific platform message.'),
      for (final ch in channels)
        infoCard(
            ch['method']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Method', ch['method']!),
                dataRow('Direction', ch['direction']!),
                dataRow('Payload', ch['data']!),
              ],
            )),
    ],
  );

  // ─── Section 8: Close & Cleanup ───
  print('[Section 8] Close & Cleanup');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Close & Cleanup'),
      noteBox(
          'Closing a connection informs the platform that the client no '
          'longer wants text input. This hides the keyboard if showing '
          'and releases platform resources. There are two close paths: '
          'client-initiated and platform-initiated.'),
      infoCard(
          'Client-Initiated Close',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('How', 'connection.close()'),
              dataRow('When', 'Widget loses focus or is disposed'),
              dataRow('Effect', 'Keyboard dismissed, channel closed'),
              dataRow('After close', 'attached returns false'),
            ],
          )),
      infoCard(
          'Platform-Initiated Close',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('How', 'connectionClosed() on client'),
              dataRow('When', 'System closes input (e.g. rotating)'),
              dataRow('Client response', 'Should open new connection'),
              dataRow('Recovery', 'Re-attach if still focused'),
            ],
          )),
      infoCard(
          'Disposal Best Practices',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Always close', 'In dispose() or deactivate()'),
              dataRow('Check attached', 'Before calling methods'),
              dataRow('Null safety', 'Guard against closed connection'),
              dataRow('Re-entrance', 'Closing twice is safe'),
            ],
          )),
    ],
  );

  // ─── Section 9: Scribble Support ───
  print('[Section 9] Scribble Support');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Scribble Support (iPadOS)'),
      noteBox(
          'Apple Pencil Scribble lets users write directly into text fields. '
          'TextInputConnection tracks the scribble state and provides '
          'character rects so iPadOS can recognize handwriting over the '
          'correct text positions.'),
      infoCard(
          'Scribble Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('scribbleInProgress', 'True during handwriting'),
              dataRow('setSelectionRects()', 'Required for hit-testing'),
              dataRow('setEditableSizeAndTransform()', 'Field geometry'),
            ],
          )),
      infoCard(
          'Platform Requirements',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iPadOS 14+', 'Scribble introduced'),
              dataRow('Apple Pencil', 'Required hardware'),
              dataRow('Text field size', 'Minimum 48pt for detection'),
              dataRow('Other platforms', 'These calls are no-ops'),
            ],
          )),
    ],
  );

  // ─── Section 10: Autofill Integration ───
  print('[Section 10] Autofill Integration');

  final autofillHints = <Map<String, String>>[
    {'hint': 'AutofillHints.email', 'use': 'Email address fields'},
    {'hint': 'AutofillHints.password', 'use': 'Password fields'},
    {'hint': 'AutofillHints.name', 'use': 'Full name fields'},
    {'hint': 'AutofillHints.telephoneNumber', 'use': 'Phone number fields'},
    {'hint': 'AutofillHints.postalCode', 'use': 'ZIP / postal code'},
    {'hint': 'AutofillHints.creditCardNumber', 'use': 'Card number fields'},
  ];

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Autofill Integration'),
      noteBox(
          'TextInputConnection carries autofill hints to the platform, '
          'enabling password managers and system autofill to suggest '
          'values for text fields. The hints are part of the '
          'TextInputConfiguration sent during attach.'),
      for (final hint in autofillHints)
        infoCard(
            hint['hint']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Hint', hint['hint']!),
                dataRow('Used for', hint['use']!),
              ],
            )),
    ],
  );

  // ─── Section 11: Multiple Connections ───
  print('[Section 11] Multiple Connections');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Multiple Connections'),
      noteBox(
          'Only one TextInputConnection can be active at a time on any '
          'platform. When a new connection is attached, the previous one '
          'becomes defunct. The framework manages this seamlessly through '
          'the focus system.'),
      infoCard(
          'Single Active Rule',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Active connections', 'Exactly 1 (or 0)'),
              dataRow('New attach', 'Closes previous connection'),
              dataRow('Old conn state', 'attached becomes false'),
              dataRow('Old client', 'connectionClosed() is called'),
            ],
          )),
      infoCard(
          'Focus-Driven Switching',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Focus gained', 'Widget opens connection'),
              dataRow('Focus lost', 'Widget closes connection'),
              dataRow('Tab navigation', 'Close old, open new'),
              dataRow('Overlay dismiss', 'Close connection on blur'),
            ],
          )),
      infoCard(
          'Edge Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Rapid switches', 'Framework queues orderly'),
              dataRow('Back-to-back focus', 'Debounced to avoid flicker'),
              dataRow('Alert dialog', 'May steal keyboard connection'),
              dataRow('Dropdown overlay', 'Preserves underlying conn'),
            ],
          )),
    ],
  );

  // ─── Section 12: Delta Text Input ───
  print('[Section 12] Delta Text Input');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Delta Text Input'),
      noteBox(
          'TextInputConnection has a counterpart for delta-based input: '
          'when a DeltaTextInputClient attaches, the connection sends '
          'incremental text deltas instead of full TextEditingValue '
          'snapshots. This is more efficient for rich text editors.'),
      infoCard(
          'Delta vs Full State',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Full state', 'Entire text on every change'),
              dataRow('Delta', 'Only the diff (insert/delete/replace)'),
              dataRow('Performance', 'Delta wins for long documents'),
              dataRow('Complexity', 'Full state is simpler to handle'),
            ],
          )),
      infoCard(
          'Delta Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextEditingDeltaInsertion', 'Text added'),
              dataRow('TextEditingDeltaDeletion', 'Text removed'),
              dataRow('TextEditingDeltaReplacement', 'Text swapped'),
              dataRow('TextEditingDeltaNonTextUpdate', 'Selection only'),
            ],
          )),
    ],
  );

  // ─── Section 13: Content Insertion ───
  print('[Section 13] Content Insertion');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Content Insertion'),
      noteBox(
          'Modern keyboards can insert rich content — images, GIFs, '
          'stickers. The connection forwards these through the '
          'insertContent callback. The content insertion configuration '
          'specifies which MIME types are accepted.'),
      infoCard(
          'Configuration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('allowedMimeTypes', 'List of accepted MIME types'),
              dataRow('onContentInserted', 'Callback for rich content'),
              dataRow('Example MIME', 'image/png, image/gif'),
              dataRow('Availability', 'Android API 25+, iOS 15+'),
            ],
          )),
      infoCard(
          'Keyboard Content Sources',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('GIF keyboards', 'Giphy, Tenor integration'),
              dataRow('Sticker packs', 'Platform sticker integration'),
              dataRow('Clipboard images', 'Rich paste from clipboard'),
              dataRow('Camera capture', 'Direct photo insert (some)'),
            ],
          )),
    ],
  );

  // ─── Section 14: Testing Connections ───
  print('[Section 14] Testing Connections');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Testing Connections'),
      noteBox(
          'Flutter provides TestTextInput and tester.testTextInput for '
          'simulating text input in widget tests. These intercept the '
          'platform channel and simulate connection behavior.'),
      infoCard(
          'Widget Test Tools',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('tester.enterText()', 'Type into focused field'),
              dataRow('tester.testTextInput', 'Access mock connection'),
              dataRow('tester.showKeyboard()', 'Trigger keyboard show'),
              dataRow('TestTextInput', 'Full connection simulation'),
            ],
          )),
      infoCard(
          'Integration Test Tools',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('enterText()', 'Real platform text entry'),
              dataRow('tap() on field', 'Opens real keyboard connection'),
              dataRow('Key events', 'Simulate physical key presses'),
              dataRow('IME simulation', 'Not available in integration'),
            ],
          )),
    ],
  );

  // ─── Section 15: Common Pitfalls ───
  print('[Section 15] Common Pitfalls');

  final pitfalls = <Map<String, String>>[
    {'pitfall': 'Using closed connection', 'fix': 'Check attached before calling methods'},
    {'pitfall': 'Not closing in dispose', 'fix': 'Always close in widget dispose()'},
    {'pitfall': 'State mismatch', 'fix': 'Call setEditingState after programmatic changes'},
    {'pitfall': 'Missing show()', 'fix': 'Keyboard won\'t appear without explicit show()'},
    {'pitfall': 'Stale composing region', 'fix': 'Clear composing when replacing text'},
  ];

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Common Pitfalls'),
      noteBox(
          'Working with TextInputConnection directly (outside of '
          'TextField/EditableText) requires careful state management. '
          'Here are common mistakes and their solutions.'),
      for (final p in pitfalls)
        infoCard(
            p['pitfall']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Pitfall', p['pitfall']!),
                dataRow('Fix', p['fix']!),
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
      noteBox('Complete overview of TextInputConnection deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Teal', teal),
              colorSwatch('Cyan', cyan),
              colorSwatch('Deep Teal', deepTeal),
              colorSwatch('Pale Mint', paleMint),
              colorSwatch('Aqua', aqua),
              colorSwatch('Seafoam', seafoam),
              colorSwatch('Dark Cyan', darkCyan),
              colorSwatch('Turquoise', turquoise),
              colorSwatch('Ice Blue', iceBlue),
              colorSwatch('Lagoon', lagoon),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, teal),
              progressBar('Connection Lifecycle', 1.0, cyan),
              progressBar('Attaching to Platform', 1.0, aqua),
              progressBar('Setting Editing State', 1.0, lagoon),
              progressBar('Keyboard Show & Hide', 1.0, turquoise),
              progressBar('Cursor & Caret', 1.0, teal),
              progressBar('Method Channels', 1.0, cyan),
              progressBar('Close & Cleanup', 1.0, aqua),
              progressBar('Scribble Support', 1.0, lagoon),
              progressBar('Autofill Integration', 1.0, turquoise),
              progressBar('Multiple Connections', 1.0, teal),
              progressBar('Delta Text Input', 1.0, cyan),
              progressBar('Content Insertion', 1.0, aqua),
              progressBar('Testing', 1.0, lagoon),
              progressBar('Common Pitfalls', 1.0, turquoise),
              progressBar('Dashboard', 1.0, teal),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Teal / Cyan'),
              dataRow('Palette colors', '10'),
              dataRow('Config fields', '${attachConfigs.length}'),
              dataRow('Editing states', '${editingStates.length}'),
              dataRow('Channel methods', '${channels.length}'),
              dataRow('Autofill hints', '${autofillHints.length}'),
              dataRow('Pitfalls', '${pitfalls.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('TextInputConnection', teal, Colors.white),
          tag('Platform Channel', cyan, Colors.white),
          tag('Keyboard', aqua, Colors.white),
          tag('IME', lagoon, Colors.white),
          tag('Editing State', turquoise, Colors.white),
          tag('Scribble', deepTeal, Colors.white),
          tag('Autofill', darkCyan, Colors.white),
        ],
      ),
    ],
  );

  print('===== END TEXT INPUT CONNECTION DEEP DEMO =====');

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
