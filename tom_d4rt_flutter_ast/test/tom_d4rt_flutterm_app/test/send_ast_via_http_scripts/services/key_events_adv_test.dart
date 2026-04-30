// ignore_for_file: avoid_print
// D4rt deep demo: TextInputConnection — the connection bridge between
// Flutter widgets and the platform's text input system (IME / keyboard).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Teal / Mint palette ───
  const Color teal = Color(0xFF009688);
  const Color mint = Color(0xFF80CBC4);
  const Color deepTeal = Color(0xFF00695C);
  const Color paleTeal = Color(0xFFE0F2F1);
  const Color darkTeal = Color(0xFF004D40);
  const Color seafoam = Color(0xFFB2DFDB);
  const Color aqua = Color(0xFF4DB6AC);
  const Color ocean = Color(0xFF00796B);
  const Color frost = Color(0xFFF0FFFE);
  const Color jade = Color(0xFF00897B);

  print('[tc] ===== TEXT INPUT CONNECTION DEEP DEMO =====');

  // ─── Local helpers ───

  Widget tcBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [darkTeal, deepTeal],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: darkTeal.withValues(alpha: 0.35),
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
              border: Border.all(color: mint, width: 1.5),
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

  Widget tcNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleTeal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: seafoam),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: darkTeal.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget tcCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: seafoam.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: darkTeal.withValues(alpha: 0.06),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: teal.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: darkTeal)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget tcRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? teal.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: seafoam.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? darkTeal : deepTeal)),
          );
        }).toList(),
      ),
    );
  }

  Widget tcFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? darkTeal : deepTeal,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: teal),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is TextInputConnection? ━━━━━━
  print('[tc-01] Section 1: What is TextInputConnection?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('01', 'What Is TextInputConnection?'),
      tcNote(
        'TextInputConnection is the live link between a Flutter widget '
        'that accepts text input and the platform\'s input method editor '
        '(IME). When a TextField gains focus, Flutter calls TextInput.attach() '
        'which returns a TextInputConnection. Through this connection the '
        'widget tells the platform about editing state, caret position, '
        'composing regions, and keyboard visibility.',
      ),
      tcCard(
        'Connection in the Input Stack',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tcFlow(['TextField', 'EditableText', 'TextInput.attach()',
                'TextInputConnection', 'Platform IME']),
            const SizedBox(height: 10),
            _tcRoleItem('attach()', 'Creates connection to platform', teal),
            _tcRoleItem('show()', 'Raises the soft keyboard', aqua),
            _tcRoleItem('setEditingState()', 'Pushes editing value', ocean),
            _tcRoleItem('close()', 'Tears down the connection', deepTeal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: Creating a connection ━━━━━━
  print('[tc-02] Section 2: Creating a connection');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('02', 'Creating a Connection via TextInput.attach()'),
      tcNote(
        'TextInput.attach(client, config) returns a TextInputConnection. '
        'The client is usually an EditableTextState that implements '
        'TextInputClient. The config describes keyboard type, autocorrect, '
        'autofill hints, input action, and other settings.',
      ),
      tcCard(
        'TextInputConfiguration Fields',
        Column(
          children: [
            tcRow(['Field', 'Type', 'Purpose'], isHeader: true),
            tcRow(['inputType', 'TextInputType', 'Keyboard layout (text, number, email…)']),
            tcRow(['obscureText', 'bool', 'Password masking']),
            tcRow(['autocorrect', 'bool', 'Enable auto-correction']),
            tcRow(['inputAction', 'TextInputAction', 'Enter key behavior (done, go, search…)']),
            tcRow(['keyboardAppearance', 'Brightness', 'Light or dark keyboard']),
            tcRow(['enableSuggestions', 'bool', 'Show prediction bar']),
            tcRow(['autofillConfiguration', 'AutofillConfig', 'Autofill hints']),
          ],
        ),
      ),
      tcCard(
        'Keyboard Types Visual',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _tcKeyboardChip('text', Icons.abc, teal),
            _tcKeyboardChip('multiline', Icons.notes, aqua),
            _tcKeyboardChip('number', Icons.dialpad, ocean),
            _tcKeyboardChip('phone', Icons.phone, jade),
            _tcKeyboardChip('datetime', Icons.calendar_today, deepTeal),
            _tcKeyboardChip('emailAddress', Icons.email, darkTeal),
            _tcKeyboardChip('url', Icons.link, teal),
            _tcKeyboardChip('visiblePassword', Icons.visibility, aqua),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: Connection lifecycle ━━━━━━
  print('[tc-03] Section 3: Connection lifecycle');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('03', 'Connection Lifecycle'),
      tcNote(
        'A TextInputConnection transitions through states: created → open → '
        'closed. Once closed, it cannot be reopened — a new attach() call '
        'is needed. The connected property tells you if the connection is '
        'still the current active one.',
      ),
      tcCard(
        'Lifecycle State Machine',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frost,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _tcLifecycleStep('1. TextInput.attach()', 'Connection created, becomes current', teal, true),
              _tcLifecycleArrow(),
              _tcLifecycleStep('2. connection.show()', 'Keyboard shown, ready for input', aqua, true),
              _tcLifecycleArrow(),
              _tcLifecycleStep('3. setEditingState()', 'Active text editing', ocean, true),
              _tcLifecycleArrow(),
              _tcLifecycleStep('4. connection.close()', 'Connection destroyed', deepTeal, false),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Showing / hiding keyboard ━━━━━━
  print('[tc-04] Section 4: Showing / hiding keyboard');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('04', 'Showing and Hiding the Keyboard'),
      tcNote(
        'connection.show() requests the platform to show the soft keyboard. '
        'connection.close() hides it and tears down the connection. On '
        'desktop platforms, show() may be a no-op since hardware keyboards '
        'are always present.',
      ),
      tcCard(
        'Platform Keyboard Behavior',
        Column(
          children: [
            tcRow(['Platform', 'show() Effect', 'close() Effect'], isHeader: true),
            tcRow(['Android', 'Opens soft keyboard', 'Hides keyboard']),
            tcRow(['iOS', 'Opens soft keyboard', 'Hides keyboard']),
            tcRow(['Web', 'Focuses input element', 'Blurs input element']),
            tcRow(['macOS', 'No-op (hardware KB)', 'Closes connection']),
            tcRow(['Windows', 'No-op (hardware KB)', 'Closes connection']),
            tcRow(['Linux', 'No-op (hardware KB)', 'Closes connection']),
          ],
        ),
      ),
      tcCard(
        'Keyboard States',
        Row(
          children: [
            Expanded(
              child: _tcStateBox('Hidden', Icons.keyboard_hide, Colors.grey, false),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _tcStateBox('Showing', Icons.keyboard, teal, true),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _tcStateBox('Closed', Icons.close, deepTeal, false),
            ),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: TextEditingValue updates ━━━━━━
  print('[tc-05] Section 5: TextEditingValue updates');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('05', 'TextEditingValue Updates'),
      tcNote(
        'The TextEditingValue holds the complete text state: the text '
        'string, the selection, and the composing range. Both sides '
        '(widget and platform) can update it. The connection synchronizes '
        'changes bidirectionally.',
      ),
      tcCard(
        'TextEditingValue Anatomy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcValueField('text', '"Hello, Flutter!"', 'The full text string', teal),
            _tcValueField('selection', 'TextSelection(start: 7, end: 14)', 'Selected range', aqua),
            _tcValueField('composing', 'TextRange(start: 0, end: 5)', 'IME composing region', ocean),
          ],
        ),
      ),
      tcCard(
        'Value Flow',
        Column(
          children: [
            tcRow(['Direction', 'Method', 'What'], isHeader: true),
            tcRow(['Widget → Platform', 'setEditingState()', 'Push new value']),
            tcRow(['Platform → Widget', 'updateEditingValue()', 'IME sends update']),
            tcRow(['Widget → Platform', 'setComposingRect()', 'Composing position']),
            tcRow(['Platform → Widget', 'performAction()', 'User pressed action']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Composing range ━━━━━━
  print('[tc-06] Section 6: Composing range');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('06', 'Composing Range and IME'),
      tcNote(
        'The composing range marks text that is being composed by the IME '
        '(e.g., pinyin input, Japanese kana-to-kanji). Text in the composing '
        'range may be replaced by the IME. The underline decoration in '
        'text fields shows this region.',
      ),
      tcCard(
        'Composing Visualization',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: frost,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _tcTextSegment('Hello ', darkTeal, false),
                  _tcTextSegment('こんにち', teal, true),
                  _tcTextSegment(' world', darkTeal, false),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: teal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('= Composing (underlined)',
                      style: TextStyle(fontSize: 10, color: darkTeal)),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: darkTeal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('= Committed',
                      style: TextStyle(fontSize: 10, color: darkTeal)),
                ],
              ),
            ],
          ),
        ),
      ),
      tcCard(
        'Composing Methods',
        Column(
          children: [
            tcRow(['Method', 'Purpose'], isHeader: true),
            tcRow(['setComposingRect()', 'Tell platform where composing text is drawn']),
            tcRow(['setCaretRect()', 'Tell platform where the caret is']),
            tcRow(['setSelectionRects()', 'Provide rects for each character']),
            tcRow(['setStyle()', 'Font information for platform rendering']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: Text selection ━━━━━━
  print('[tc-07] Section 7: Text selection');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('07', 'Text Selection via Connection'),
      tcNote(
        'The TextSelection in TextEditingValue specifies cursor position '
        '(collapsed selection) or a range of selected text. The connection '
        'synchronizes selection changes so the platform can position '
        'handles and show the selection toolbar.',
      ),
      tcCard(
        'Selection Scenarios',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcSelectionDemo('Cursor only', 'Hello|', 'baseOffset=5, extentOffset=5', teal),
            _tcSelectionDemo('Word selected', 'He[llo]', 'baseOffset=2, extentOffset=5', aqua),
            _tcSelectionDemo('All selected', '[Hello]', 'baseOffset=0, extentOffset=5', ocean),
            _tcSelectionDemo('Reverse selection', 'He]llo[', 'affinity: upstream', jade),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: setEditingState ━━━━━━
  print('[tc-08] Section 8: setEditingState');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('08', 'setEditingState() Deep Dive'),
      tcNote(
        'setEditingState(TextEditingValue) pushes the widget\'s current '
        'editing state to the platform. This is called after programmatic '
        'changes (formatting, clearing text). It must not be called during '
        'an updateEditingValue() callback — that would cause an infinite loop.',
      ),
      tcCard(
        'When to Call setEditingState',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcWhenItem('Programmatic text change', 'TextController.text = "new"', true, teal),
            _tcWhenItem('Format on input', 'Apply number formatting', true, aqua),
            _tcWhenItem('Clear field', 'Reset to empty', true, ocean),
            _tcWhenItem('During updateEditingValue', 'Platform pushing to us', false, Colors.red),
            _tcWhenItem('After connection closed', 'No longer active', false, Colors.red),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Geometry methods ━━━━━━
  print('[tc-09] Section 9: Geometry methods');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('09', 'Geometry: Caret, Composing, Selection Rects'),
      tcNote(
        'The connection provides geometry to the platform so it can position '
        'the IME window, candidate bar, and selection handles. '
        'setCaretRect, setComposingRect, and setSelectionRects communicate '
        'the position and size of text regions.',
      ),
      tcCard(
        'Geometry Methods',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: frost,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              _tcGeomItem('setCaretRect(Rect)', 'Caret blink position', Icons.edit, teal),
              _tcGeomItem('setComposingRect(Rect)', 'Underline region', Icons.text_format, aqua),
              _tcGeomItem('setSelectionRects(List<Rect>)', 'Per-character rects', Icons.select_all, ocean),
              _tcGeomItem('setEditableSizeAndTransform(...)', 'Full editable area', Icons.crop, jade),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: TextInputAction ━━━━━━
  print('[tc-10] Section 10: TextInputAction');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('10', 'TextInputAction Handling'),
      tcNote(
        'When the user presses the action button on the soft keyboard, '
        'the platform sends performAction(TextInputAction). The action '
        'depends on TextInputConfiguration.inputAction setting. Common '
        'actions: done, go, search, send, next, previous, newline.',
      ),
      tcCard(
        'Available Actions',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _tcActionChip('done', Icons.check, teal),
            _tcActionChip('go', Icons.arrow_forward, aqua),
            _tcActionChip('search', Icons.search, ocean),
            _tcActionChip('send', Icons.send, jade),
            _tcActionChip('next', Icons.navigate_next, deepTeal),
            _tcActionChip('previous', Icons.navigate_before, darkTeal),
            _tcActionChip('newline', Icons.keyboard_return, teal),
            _tcActionChip('continueAction', Icons.play_arrow, aqua),
            _tcActionChip('join', Icons.group_add, ocean),
            _tcActionChip('route', Icons.directions, jade),
            _tcActionChip('emergencyCall', Icons.local_phone, Colors.red),
            _tcActionChip('unspecified', Icons.help_outline, Colors.grey),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Autofill integration ━━━━━━
  print('[tc-11] Section 11: Autofill integration');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('11', 'Autofill Integration'),
      tcNote(
        'TextInputConnection supports autofill through AutofillConfiguration '
        'in the TextInputConfiguration. The connection groups related '
        'fields (e.g., username + password) via AutofillGroup so platforms '
        'can fill all fields in a form at once.',
      ),
      tcCard(
        'Autofill Hints',
        Column(
          children: [
            tcRow(['Hint', 'Platform Use', 'Field Type'], isHeader: true),
            tcRow(['username', 'Login form', 'ID / email']),
            tcRow(['password', 'Credential store', 'Masked field']),
            tcRow(['email', 'Email autofill', 'Email address']),
            tcRow(['name', 'Name autofill', 'Full name']),
            tcRow(['telephoneNumber', 'Phone autofill', 'Phone']),
            tcRow(['postalAddress', 'Address fill', 'Street address']),
            tcRow(['creditCardNumber', 'Payment fill', 'Card number']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Connection state transitions ━━━━━━
  print('[tc-12] Section 12: Connection state transitions');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('12', 'Connection State Transitions'),
      tcNote(
        'Only one TextInputConnection can be active at a time. When a new '
        'attach() is called, the previous connection becomes inactive. The '
        'connected property returns false if the connection has been '
        'superseded or closed.',
      ),
      tcCard(
        'Multi-Field Scenario',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: frost,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              _tcFieldState('Name field', 'Active ★', teal, true),
              const SizedBox(height: 4),
              Icon(Icons.swap_vert, color: deepTeal, size: 20),
              const SizedBox(height: 4),
              _tcFieldState('Email field', 'Inactive', Colors.grey, false),
              const SizedBox(height: 4),
              Icon(Icons.swap_vert, color: deepTeal, size: 20),
              const SizedBox(height: 4),
              _tcFieldState('Password field', 'Inactive', Colors.grey, false),
              const SizedBox(height: 10),
              Text('Only one connection is active — the most recent attach()',
                  style: TextStyle(fontSize: 10, color: darkTeal),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Platform interaction ━━━━━━
  print('[tc-13] Section 13: Platform interaction');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('13', 'Platform Channel Interaction'),
      tcNote(
        'TextInputConnection communicates with the platform via the '
        'SystemChannels.textInput MethodChannel. Messages include '
        'TextInput.setClient, TextInput.show, TextInput.setEditingState, '
        'and TextInput.clearClient, with replies coming as '
        'TextInputClient.updateEditingValue and performAction.',
      ),
      tcCard(
        'Channel Messages',
        Column(
          children: [
            tcRow(['Direction', 'Message', 'Data'], isHeader: true),
            tcRow(['→ Platform', 'TextInput.setClient', 'config JSON']),
            tcRow(['→ Platform', 'TextInput.show', '(none)']),
            tcRow(['→ Platform', 'TextInput.setEditingState', 'value JSON']),
            tcRow(['→ Platform', 'TextInput.clearClient', '(none)']),
            tcRow(['← Widget', 'updateEditingValue', 'value JSON']),
            tcRow(['← Widget', 'performAction', 'action string']),
            tcRow(['← Widget', 'updateFloatingCursor', 'point data']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: TextInputClient callbacks ━━━━━━
  print('[tc-14] Section 14: TextInputClient callbacks');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('14', 'TextInputClient Callbacks'),
      tcNote(
        'The TextInputClient interface (implemented by EditableTextState) '
        'receives callbacks from the platform through the connection: '
        'updateEditingValue, performAction, updateFloatingCursor, '
        'showAutocorrectionPromptRect, and more.',
      ),
      tcCard(
        'Client Interface Methods',
        Column(
          children: [
            tcRow(['Method', 'When called', 'Typical use'], isHeader: true),
            tcRow(['updateEditingValue', 'Text changed by IME', 'Update controller']),
            tcRow(['performAction', 'Action key pressed', 'Submit form']),
            tcRow(['updateFloatingCursor', 'Long-press drag', 'Reposition cursor']),
            tcRow(['showAutocorrectionPrompt', 'Autocorrect suggestion', 'Show underline']),
            tcRow(['connectionClosed', 'Connection ended', 'Cleanup state']),
            tcRow(['insertTextPlaceholder', 'Placeholder insert', 'Image slot']),
            tcRow(['removeTextPlaceholder', 'Placeholder gone', 'Remove slot']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Debugging text input ━━━━━━
  print('[tc-15] Section 15: Debugging');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('15', 'Debugging Text Input Issues'),
      tcNote(
        'Common text input issues: keyboard not appearing (connection not '
        'shown), typing ignored (wrong connection active), IME composing '
        'glitches (setEditingState during updateEditingValue). Use '
        'debugPrintPlatformMessages to trace channel messages.',
      ),
      tcCard(
        'Debug Checklist',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _tcCheckItem('connection.connected == true?', 'Connection still active', teal),
            _tcCheckItem('show() called after attach()?', 'Keyboard requested', aqua),
            _tcCheckItem('setEditingState timing?', 'Not in updateEditingValue', ocean),
            _tcCheckItem('Only one focus at a time?', 'No competing connections', jade),
            _tcCheckItem('TextInputConfiguration correct?', 'Right keyboard type', deepTeal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[tc-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      tcBanner('16', 'Summary Dashboard'),
      tcCard(
        'TextInputConnection — Complete',
        Column(
          children: [
            tcRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            tcRow(['What', 'S01', 'Bridge to platform text input']),
            tcRow(['Create', 'S02', 'TextInput.attach() with config']),
            tcRow(['Lifecycle', 'S03', 'Create → open → close']),
            tcRow(['Keyboard', 'S04', 'show() / close() methods']),
            tcRow(['Value', 'S05', 'TextEditingValue sync']),
            tcRow(['Composing', 'S06', 'IME composing underline']),
            tcRow(['Selection', 'S07', 'Cursor / range selection']),
            tcRow(['setEditing', 'S08', 'Push state to platform']),
            tcRow(['Geometry', 'S09', 'Caret / composing / selection rects']),
            tcRow(['Action', 'S10', 'done/go/search actions']),
            tcRow(['Autofill', 'S11', 'Grouped field filling']),
            tcRow(['State', 'S12', 'Single active connection']),
            tcRow(['Channel', 'S13', 'MethodChannel messages']),
            tcRow(['Client', 'S14', 'Callbacks from platform']),
            tcRow(['Debug', 'S15', 'Common troubleshooting']),
          ],
        ),
      ),
      tcCard(
        'Teal / Mint Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _tcColorSwatch('Teal', teal),
            _tcColorSwatch('Mint', mint),
            _tcColorSwatch('Aqua', aqua),
            _tcColorSwatch('Ocean', ocean),
            _tcColorSwatch('Jade', jade),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [darkTeal, deepTeal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('TextInputConnection — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From attaching to the platform, managing editing state, '
              'syncing composing and selection, through geometry and '
              'autofill — the full text input connection story.',
              style: TextStyle(color: mint, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[tc] palette: $jade, $frost, $seafoam');
  print('[tc] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TextInputConnection — Platform Text Bridge'),
        backgroundColor: darkTeal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF0FAF8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _tcRoleItem(String method, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Text(method,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _tcKeyboardChip(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color)),
      ],
    ),
  );
}

Widget _tcLifecycleStep(String label, String desc, Color color, bool active) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: active ? color.withValues(alpha: 0.08) : Colors.grey.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: active ? color.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(active ? Icons.check_circle : Icons.cancel,
            size: 16, color: active ? color : Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold, color: color)),
              Text(desc, style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _tcLifecycleArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Center(
      child: Icon(Icons.arrow_downward, size: 14, color: const Color(0xFF004D40)),
    ),
  );
}

Widget _tcValueField(String name, String value, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border(left: BorderSide(color: color, width: 3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('.$name', style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold,
                fontFamily: 'monospace', color: color)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(value, style: TextStyle(
                  fontSize: 10, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.7))),
            ),
          ],
        ),
        Text(desc, style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.6))),
      ],
    ),
  );
}

Widget _tcTextSegment(String text, Color color, bool composing) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      border: composing
          ? Border(bottom: BorderSide(color: color, width: 2))
          : null,
    ),
    child: Text(text,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: color)),
  );
}

Widget _tcSelectionDemo(String label, String visual, String spec, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        SizedBox(
          width: 60,
          child: Text(visual,
              style: TextStyle(
                  fontSize: 11, fontFamily: 'monospace', color: color)),
        ),
        Expanded(
          child: Text(spec,
              style: TextStyle(
                  fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _tcWhenItem(String scenario, String detail, bool safe, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(safe ? Icons.check_circle : Icons.dangerous,
            size: 14, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(scenario,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(detail,
                  style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _tcGeomItem(String method, String desc, IconData icon, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(method,
              style: TextStyle(
                  fontSize: 10, fontWeight: FontWeight.bold,
                  fontFamily: 'monospace', color: color)),
        ),
        Expanded(
          flex: 2,
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _tcActionChip(String label, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(
                fontSize: 9, fontWeight: FontWeight.w600, color: color)),
      ],
    ),
  );
}

Widget _tcCheckItem(String question, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Icon(Icons.rule, size: 14, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(question,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.bold, color: color)),
              Text(detail,
                  style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _tcStateBox(String label, IconData icon, Color color, bool active) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: active ? color.withValues(alpha: 0.08) : Colors.grey.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
          color: active ? color.withValues(alpha: 0.3) : Colors.grey.withValues(alpha: 0.15)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 24, color: active ? color : Colors.grey),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600,
                color: active ? color : Colors.grey)),
      ],
    ),
  );
}

Widget _tcFieldState(String label, String status, Color color, bool active) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: active ? color.withValues(alpha: 0.08) : Colors.grey.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
          color: active ? color.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.1)),
    ),
    child: Row(
      children: [
        Icon(active ? Icons.text_fields : Icons.text_fields,
            size: 14, color: active ? color : Colors.grey),
        const SizedBox(width: 8),
        Text(label,
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600,
                color: active ? color : Colors.grey)),
        const Spacer(),
        Text(status,
            style: TextStyle(
                fontSize: 9,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? color : Colors.grey)),
      ],
    ),
  );
}

Widget _tcColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
