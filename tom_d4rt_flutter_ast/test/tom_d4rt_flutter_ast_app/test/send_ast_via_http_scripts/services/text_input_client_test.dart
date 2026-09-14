// ignore_for_file: avoid_print
// D4rt deep demo: TextInputClient — the abstract mixin that defines the
// contract between Flutter's text input system and widgets that accept
// keyboard input, handling editing state, actions, and IME composition.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Slate / Graphite palette ───
  const Color slate = Color(0xFF334155);
  const Color graphite = Color(0xFF64748B);
  const Color deepSlate = Color(0xFF1E293B);
  const Color paleGray = Color(0xFFF8FAFC);
  const Color charcoal = Color(0xFF475569);
  const Color silver = Color(0xFFCBD5E1);
  const Color obsidian = Color(0xFF0F172A);
  const Color pewter = Color(0xFF94A3B8);
  const Color cloud = Color(0xFFE2E8F0);
  const Color iron = Color(0xFF78909C);

  print('===== TEXT INPUT CLIENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [obsidian, deepSlate],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: obsidian.withValues(alpha: 0.35),
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
              color: slate,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: graphite, width: 1.5),
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
        color: paleGray,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: obsidian.withValues(alpha: 0.9),
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
        border: Border.all(color: cloud),
        boxShadow: [
          BoxShadow(
            color: slate.withValues(alpha: 0.07),
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
              color: paleGray,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: slate)),
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
            width: 150,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepSlate)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: obsidian)),
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
                  color: obsidian.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepSlate),
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
                  style: TextStyle(fontSize: 11, color: deepSlate)),
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
              color: cloud,
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

  // ─── Section 1: Overview & Purpose ───
  print('[Section 1] Overview & Purpose');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'TextInputClient is the foundational abstract mixin that defines '
          'the contract between Flutter\'s text input system and any widget '
          'that receives keyboard input. It is the heart of text editing in '
          'Flutter — every TextField, EditableText, and custom text input '
          'ultimately relies on this interface to communicate with the '
          'platform\'s input method engine.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Abstract mixin class'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Platform text input integration'),
              dataRow('Key implementer', 'EditableTextState'),
            ],
          )),
      infoCard(
          'Central Role',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Input reception', 'Receives text from platform'),
              dataRow('State management', 'Manages TextEditingValue'),
              dataRow('Action handling', 'Responds to input actions'),
              dataRow('IME support', 'Handles composition state'),
            ],
          )),
    ],
  );

  // ─── Section 2: Callback API ───
  print('[Section 2] Callback API');

  final callbacks = <Map<String, String>>[
    {'method': 'updateEditingValue', 'purpose': 'Receive new text state from platform'},
    {'method': 'performAction', 'purpose': 'Handle keyboard action (done, go, etc.)'},
    {'method': 'updateFloatingCursor', 'purpose': 'Track floating cursor on iOS'},
    {'method': 'showAutocorrectionPromptRect', 'purpose': 'Show autocorrection UI'},
    {'method': 'connectionClosed', 'purpose': 'Platform closed the input connection'},
    {'method': 'performSelector', 'purpose': 'Handle macOS selector actions'},
    {'method': 'insertContent', 'purpose': 'Receive rich content (images, etc.)'},
    {'method': 'performPrivateCommand', 'purpose': 'Custom IME commands'},
  ];

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Callback API'),
      noteBox(
          'The mixin defines multiple callback methods that the platform '
          'invokes when text input events occur. Each callback corresponds '
          'to a specific type of input system event.'),
      for (final cb in callbacks)
        infoCard(
            cb['method']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Method', cb['method']!),
                dataRow('Purpose', cb['purpose']!),
              ],
            )),
    ],
  );

  // ─── Section 3: TextEditingValue Flow ───
  print('[Section 3] TextEditingValue Flow');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'TextEditingValue Flow'),
      noteBox(
          'TextEditingValue is the core data structure that flows between '
          'the platform input system and the TextInputClient. It carries '
          'the text content, selection, and composing region.'),
      infoCard(
          'TextEditingValue Components',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('text', 'The full text content as a String'),
              dataRow('selection', 'TextSelection (base + extent)'),
              dataRow('composing', 'TextRange of IME composition'),
            ],
          )),
      infoCard(
          'Flow Direction',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Platform → Client', 'updateEditingValue callback'),
              dataRow('Client → Platform', 'TextInputConnection.setEditingState'),
              dataRow('Synchronization', 'Client is source of truth'),
              dataRow('Conflict', 'Client value wins over platform'),
            ],
          )),
      infoCard(
          'Immutability',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Pattern', 'Every edit creates new value'),
              dataRow('Comparison', 'Value equality (not reference)'),
              dataRow('Optimization', 'Skip update if unchanged'),
              dataRow('History', 'Easy undo — store value stack'),
            ],
          )),
    ],
  );

  // ─── Section 4: IME Composition ───
  print('[Section 4] IME Composition');

  final imeExamples = <Map<String, String>>[
    {'language': 'Japanese', 'engine': 'Kana/Romaji → Kanji', 'style': 'Multi-step composition'},
    {'language': 'Chinese', 'engine': 'Pinyin → Hanzi', 'style': 'Candidate selection'},
    {'language': 'Korean', 'engine': 'Jamo → Hangul', 'style': 'Block composition'},
    {'language': 'Hindi', 'engine': 'Transliteration', 'style': 'Script mapping'},
    {'language': 'Thai', 'engine': 'Tone marks', 'style': 'Combining characters'},
  ];

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'IME Composition'),
      noteBox(
          'Input Method Editors (IMEs) for CJK and other complex scripts '
          'compose text in stages. The composing region in TextEditingValue '
          'tracks which text is still being composed and not yet committed.'),
      for (final ime in imeExamples)
        infoCard(
            '${ime['language']} IME',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Language', ime['language']!),
                dataRow('Engine', ime['engine']!),
                dataRow('Style', ime['style']!),
              ],
            )),
      infoCard(
          'Composing Region Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Active', 'composing range is non-empty'),
              dataRow('Visual', 'Underline or highlight on composing text'),
              dataRow('Commit', 'composing becomes empty on confirm'),
              dataRow('Cancel', 'composing text removed'),
            ],
          )),
    ],
  );

  // ─── Section 5: Input Actions ───
  print('[Section 5] Input Actions');

  final inputActions = <Map<String, String>>[
    {'action': 'TextInputAction.done', 'keyboard': 'Done / Return', 'behavior': 'Submit and close'},
    {'action': 'TextInputAction.go', 'keyboard': 'Go', 'behavior': 'Navigate to URL'},
    {'action': 'TextInputAction.send', 'keyboard': 'Send', 'behavior': 'Send message'},
    {'action': 'TextInputAction.search', 'keyboard': 'Search', 'behavior': 'Execute search'},
    {'action': 'TextInputAction.next', 'keyboard': 'Next', 'behavior': 'Move to next field'},
    {'action': 'TextInputAction.newline', 'keyboard': 'Return', 'behavior': 'Insert newline'},
  ];

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Input Actions'),
      noteBox(
          'TextInputAction defines the action button shown on the software '
          'keyboard. When the user taps it, performAction is called on the '
          'client with the corresponding action value.'),
      for (final action in inputActions)
        infoCard(
            action['action']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Action', action['action']!),
                dataRow('Keyboard button', action['keyboard']!),
                dataRow('Typical behavior', action['behavior']!),
              ],
            )),
    ],
  );

  // ─── Section 6: Connection Lifecycle ───
  print('[Section 6] Connection Lifecycle');

  final connectionPhases = <Map<String, String>>[
    {'phase': 'Attach', 'detail': 'TextInput.attach with configuration'},
    {'phase': 'Show keyboard', 'detail': 'TextInput.show request'},
    {'phase': 'Set state', 'detail': 'Send initial TextEditingValue'},
    {'phase': 'Active editing', 'detail': 'Bidirectional state updates'},
    {'phase': 'Hide keyboard', 'detail': 'TextInput.hide request'},
    {'phase': 'Close', 'detail': 'connectionClosed callback'},
  ];

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Connection Lifecycle'),
      noteBox(
          'The TextInputClient connects to the platform through a '
          'TextInputConnection. The connection lifecycle follows a '
          'well-defined sequence from attach through active editing to close.'),
      for (final phase in connectionPhases)
        infoCard(
            'Phase: ${phase['phase']}',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Phase', phase['phase']!),
                dataRow('Detail', phase['detail']!),
              ],
            )),
    ],
  );

  // ─── Section 7: Floating Cursor (iOS) ───
  print('[Section 7] Floating Cursor (iOS)');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Floating Cursor (iOS)'),
      noteBox(
          'On iOS, users can long-press the space bar to activate a floating '
          'cursor that glides over text for precise cursor positioning. '
          'The updateFloatingCursor callback tracks this interaction.'),
      infoCard(
          'Floating Cursor States',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Start', 'User begins long-press on space bar'),
              dataRow('Update', 'Finger moves — cursor position updates'),
              dataRow('End', 'Finger lifts — cursor placed at position'),
            ],
          )),
      infoCard(
          'RawFloatingCursorPoint',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('state', 'FloatingCursorDragState enum'),
              dataRow('offset', 'Offset from original position'),
              dataRow('startLocation', 'Where the drag began'),
            ],
          )),
      infoCard(
          'Platform Specifics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iOS', 'Full support since iOS 12'),
              dataRow('Android', 'Not available'),
              dataRow('Desktop', 'Not applicable'),
              dataRow('Web', 'Not available'),
            ],
          )),
    ],
  );

  // ─── Section 8: Rich Content Insertion ───
  print('[Section 8] Rich Content Insertion');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Rich Content Insertion'),
      noteBox(
          'The insertContent callback enables receiving rich content like '
          'images, GIFs, and stickers from the keyboard. This is used by '
          'messaging apps that accept inline media from keyboard extensions.'),
      infoCard(
          'KeyboardInsertedContent',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('mimeType', 'MIME type (image/gif, image/png)'),
              dataRow('uri', 'Content URI for the inserted media'),
              dataRow('data', 'Raw bytes (if available)'),
              dataRow('hasData', 'Whether raw bytes are included'),
            ],
          )),
      infoCard(
          'Supported Content Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Images', 'PNG, JPEG, GIF, WebP'),
              dataRow('Stickers', 'Platform sticker packs'),
              dataRow('GIFs', 'Animated GIFs from keyboard'),
              dataRow('Custom', 'IME-specific content types'),
            ],
          )),
      infoCard(
          'Implementation Notes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Configuration', 'Set contentInsertionConfiguration'),
              dataRow('MIME filter', 'Specify accepted types'),
              dataRow('Callback', 'insertContent with content object'),
              dataRow('Android API', 'Requires API 25+ (commitContent)'),
            ],
          )),
    ],
  );

  // ─── Section 9: macOS Selectors ───
  print('[Section 9] macOS Selectors');

  final selectors = <Map<String, String>>[
    {'selector': 'moveLeft:', 'action': 'Move cursor left'},
    {'selector': 'moveRight:', 'action': 'Move cursor right'},
    {'selector': 'deleteBackward:', 'action': 'Delete before cursor'},
    {'selector': 'insertNewline:', 'action': 'Insert line break'},
    {'selector': 'cancelOperation:', 'action': 'Cancel current operation'},
    {'selector': 'selectAll:', 'action': 'Select all text'},
  ];

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'macOS Selectors'),
      noteBox(
          'On macOS, many text editing operations are expressed as Objective-C '
          'selectors. The performSelector callback receives these selectors '
          'when the user invokes keyboard shortcuts or menu commands.'),
      for (final sel in selectors)
        infoCard(
            sel['selector']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Selector', sel['selector']!),
                dataRow('Action', sel['action']!),
              ],
            )),
    ],
  );

  // ─── Section 10: Private Commands ───
  print('[Section 10] Private Commands');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Private Commands'),
      noteBox(
          'performPrivateCommand receives custom commands from IME engines '
          'that go beyond standard text input. This is an escape hatch for '
          'IME-specific behavior.'),
      infoCard(
          'Command Structure',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('action', 'String identifier for the command'),
              dataRow('data', 'Map<String, dynamic> payload'),
              dataRow('Source', 'IME or keyboard extension'),
              dataRow('Handling', 'App-specific interpretation'),
            ],
          )),
      infoCard(
          'Use Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Voice typing', 'IME sends voice-to-text metadata'),
              dataRow('Handwriting', 'Pen input shape context'),
              dataRow('Emoji replace', 'IME suggests emoji for text'),
              dataRow('Custom IME', 'App-specific input extensions'),
            ],
          )),
    ],
  );

  // ─── Section 11: EditableTextState Implementation ───
  print('[Section 11] EditableTextState Implementation');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'EditableTextState Implementation'),
      noteBox(
          'EditableTextState is the primary implementer of TextInputClient '
          'in the Flutter framework. It bridges the gap between the raw '
          'platform input system and the widget tree rendering.'),
      infoCard(
          'Key Overrides',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('updateEditingValue', 'Applies text changes to state'),
              dataRow('performAction', 'Handles submit / dismiss'),
              dataRow('updateFloatingCursor', 'Renders iOS floating cursor'),
              dataRow('connectionClosed', 'Reconnects if needed'),
            ],
          )),
      infoCard(
          'State Synchronization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Widget → Platform', 'setEditingState on change'),
              dataRow('Platform → Widget', 'updateEditingValue callback'),
              dataRow('Conflict resolution', 'Widget state is authoritative'),
              dataRow('Throttling', 'Batch updates to reduce overhead'),
            ],
          )),
      infoCard(
          'TextInputConfiguration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('inputType', 'Keyboard type (text, number, etc.)'),
              dataRow('inputAction', 'Action button type'),
              dataRow('autocorrect', 'Enable auto-correction'),
              dataRow('enableIMEPersonalizedLearning', 'Privacy control'),
            ],
          )),
    ],
  );

  // ─── Section 12: Testing TextInputClient ───
  print('[Section 12] Testing TextInputClient');

  final testStrategies = <Map<String, String>>[
    {'strategy': 'enterText()', 'description': 'Simulates typing text in widget tests'},
    {'strategy': 'testTextInput', 'description': 'Mock text input for unit tests'},
    {'strategy': 'showKeyboard()', 'description': 'Simulates keyboard appearance'},
    {'strategy': 'FakeTextInputConnection', 'description': 'Custom mock connection'},
    {'strategy': 'Integration test', 'description': 'Real platform keyboard input'},
  ];

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Testing TextInputClient'),
      noteBox(
          'Flutter provides comprehensive tools for testing text input '
          'clients, from simple typing simulation to full mock connections '
          'that verify all callback interactions.'),
      for (final ts in testStrategies)
        infoCard(
            ts['strategy']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Strategy', ts['strategy']!),
                dataRow('Description', ts['description']!),
              ],
            )),
    ],
  );

  // ─── Section 13: Performance Considerations ───
  print('[Section 13] Performance Considerations');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Performance Considerations'),
      noteBox(
          'Text input performance is critical for user experience. Laggy '
          'text entry feels terrible, so the client implementation must '
          'be efficient in processing platform callbacks.'),
      infoCard(
          'Latency Budget',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Platform channel', 0.10, slate),
              progressBar('updateEditingValue', 0.15, charcoal),
              progressBar('Widget rebuild', 0.25, graphite),
              progressBar('Layout + paint', 0.35, iron),
            ],
          )),
      infoCard(
          'Optimization Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Skip unchanged', 'Compare values before rebuild'),
              dataRow('Batch updates', 'Group multiple state changes'),
              dataRow('Minimal rebuild', 'Only rebuild affected subtree'),
              dataRow('Async processing', 'Defer non-critical work'),
            ],
          )),
    ],
  );

  // ─── Section 14: Security & Privacy ───
  print('[Section 14] Security & Privacy');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Security & Privacy'),
      noteBox(
          'The text input client handles potentially sensitive text — '
          'passwords, personal information, financial data. Several '
          'configuration options help protect user privacy.'),
      infoCard(
          'Privacy Controls',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('obscureText', 'Hides password characters'),
              dataRow('enableIMEPersonalized', 'Disable IME learning'),
              dataRow('autocorrect: false', 'Prevent text from being analyzed'),
              dataRow('enableSuggestions', 'Control keyboard suggestions'),
            ],
          )),
      infoCard(
          'Sensitive Field Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Passwords', 'obscureText + no autocorrect'),
              dataRow('Credit cards', 'Number keyboard + no learning'),
              dataRow('SSN / ID', 'No suggestions + no autocorrect'),
              dataRow('2FA codes', 'Number pad + no IME learning'),
            ],
          )),
    ],
  );

  // ─── Section 15: Comparison with Related Clients ───
  print('[Section 15] Comparison with Related Clients');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Comparison with Related Clients'),
      noteBox(
          'TextInputClient is one of several client mixins in the Flutter '
          'services layer. Each handles a specific aspect of platform '
          'interaction for text editing.'),
      infoCard(
          'Client Mixin Family',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextInputClient', 'Core text input callbacks'),
              dataRow('DeltaTextInputClient', 'Incremental text deltas'),
              dataRow('ScribbleClient', 'Stylus handwriting input'),
              dataRow('UndoManagerClient', 'Platform undo/redo'),
            ],
          )),
      infoCard(
          'DeltaTextInputClient',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Alternative to', 'TextInputClient'),
              dataRow('Advantage', 'Receives diffs, not full state'),
              dataRow('Performance', 'Better for long documents'),
              dataRow('Complexity', 'Harder to implement correctly'),
            ],
          )),
      infoCard(
          'Choosing Between Them',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Short text', 'TextInputClient (simpler)'),
              dataRow('Long documents', 'DeltaTextInputClient (efficient)'),
              dataRow('Rich editing', 'DeltaTextInputClient (granular)'),
              dataRow('Simple forms', 'TextInputClient (standard)'),
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
      noteBox('Comprehensive overview of the TextInputClient deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Slate', slate),
              colorSwatch('Graphite', graphite),
              colorSwatch('Deep Slate', deepSlate),
              colorSwatch('Pale Gray', paleGray),
              colorSwatch('Charcoal', charcoal),
              colorSwatch('Silver', silver),
              colorSwatch('Obsidian', obsidian),
              colorSwatch('Pewter', pewter),
              colorSwatch('Cloud', cloud),
              colorSwatch('Iron', iron),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, slate),
              progressBar('Callback API', 1.0, charcoal),
              progressBar('TextEditingValue Flow', 1.0, graphite),
              progressBar('IME Composition', 1.0, iron),
              progressBar('Input Actions', 1.0, pewter),
              progressBar('Connection Lifecycle', 1.0, slate),
              progressBar('Floating Cursor', 1.0, charcoal),
              progressBar('Rich Content', 1.0, graphite),
              progressBar('macOS Selectors', 1.0, iron),
              progressBar('Private Commands', 1.0, pewter),
              progressBar('EditableTextState', 1.0, slate),
              progressBar('Testing', 1.0, charcoal),
              progressBar('Performance', 1.0, graphite),
              progressBar('Security & Privacy', 1.0, iron),
              progressBar('Related Clients', 1.0, pewter),
              progressBar('Dashboard', 1.0, slate),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Slate / Graphite'),
              dataRow('Palette colors', '10'),
              dataRow('Callbacks documented', '${callbacks.length}'),
              dataRow('IME examples', '${imeExamples.length}'),
              dataRow('Input actions', '${inputActions.length}'),
              dataRow('Connection phases', '${connectionPhases.length}'),
              dataRow('macOS selectors', '${selectors.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('TextInputClient', slate, Colors.white),
          tag('IME', charcoal, Colors.white),
          tag('EditableText', graphite, Colors.white),
          tag('Services', iron, Colors.white),
          tag('Keyboard', obsidian, Colors.white),
          tag('Composition', deepSlate, Colors.white),
          tag('Platform', pewter, Colors.white),
          tag('TextEditing', slate.withValues(alpha: 0.8), Colors.white),
        ],
      ),
    ],
  );

  print('===== END TEXT INPUT CLIENT DEEP DEMO =====');

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
