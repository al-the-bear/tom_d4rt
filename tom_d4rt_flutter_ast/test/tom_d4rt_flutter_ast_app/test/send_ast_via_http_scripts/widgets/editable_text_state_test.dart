// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — EditableTextState
// Demonstrates EditableTextState, the State object that manages editable text
// fields. Covers text controllers, selection handling, input formatting,
// keyboard actions, text input connections, and input method interaction.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('EditableTextState Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'What is EditableTextState?',
      'body': 'EditableTextState is the State object for EditableText, '
          'the low-level widget behind TextField and TextFormField. '
          'It manages the text editing lifecycle: connecting to the '
          'platform input method, handling selection, formatting '
          'input, and processing keyboard actions.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Input Method Connection',
      'body': 'EditableTextState implements TextInputClient, which '
          'communicates with the platform\u0027s soft keyboard. It '
          'sends the current editing state (text, selection, '
          'composing region) to the IME and receives user input '
          'back through updateEditingValue.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.select_all,
      'title': 'Selection Management',
      'body': 'Manages text selection: cursor position, selection range, '
          'double-tap word selection, triple-tap line selection. '
          'Coordinates with the system text selection toolbar for '
          'copy, cut, paste, and select all operations.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.auto_fix_high,
      'title': 'Input Formatters',
      'body': 'Applies TextInputFormatter instances to incoming text '
          'before it is displayed. Formatters can restrict input '
          '(digits only), transform text (uppercase), or limit '
          'length. Applied in order, each receiving the previous '
          'formatter\u0027s output.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'textEditingValue',
      'type': 'TextEditingValue',
      'desc': 'The current editing state: text content, selection '
          '(cursor position + range), and composing region '
          '(the text being composed by the input method).',
    },
    {
      'name': 'updateEditingValue()',
      'type': 'void',
      'desc': 'Called by the platform to deliver new editing state. '
          'Applies input formatters, updates the controller, '
          'and triggers a build with the new text.',
    },
    {
      'name': 'performAction()',
      'type': 'void',
      'desc': 'Called when the user presses the keyboard action button '
          '(done, next, go, search). Routes to onEditingComplete '
          'or onSubmitted callbacks.',
    },
    {
      'name': 'connectionClosed()',
      'type': 'void',
      'desc': 'Called when the input connection is closed by the '
          'platform. The soft keyboard dismisses, but the text '
          'field may still be focused.',
    },
    {
      'name': 'showToolbar()',
      'type': 'bool',
      'desc': 'Shows the text selection toolbar (copy, cut, paste). '
          'Returns true if the toolbar was shown. Only works '
          'when there is a selection or the field is focused.',
    },
    {
      'name': 'bringIntoView()',
      'type': 'void',
      'desc': 'Scrolls the viewport to make a specific TextPosition '
          'visible. Called automatically when the cursor moves '
          'out of the visible area.',
    },
    {
      'name': 'renderEditable',
      'type': 'RenderEditable',
      'desc': 'The underlying RenderEditable that performs text layout '
          'and painting. Access it for hit-testing, measuring '
          'text positions, and computing caret rectangles.',
    },
    {
      'name': 'currentAutofillScope',
      'type': 'AutofillScope?',
      'desc': 'The autofill scope this text field belongs to. Groups '
          'related fields (email + password) for platform '
          'autofill support.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.teal.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Lifecycle
  // ============================================================
  print('=== Section 3: Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1. initState',
      'desc': 'Creates the TextEditingController (if not provided), '
          'sets up the FocusNode listener, and registers for '
          'clipboard status changes.',
      'icon': Icons.play_arrow,
      'color': Colors.teal,
    },
    {
      'step': '2. Focus Gained',
      'desc': 'When focus is acquired, opens the input connection to '
          'the platform. The soft keyboard appears (if platform '
          'allows). Sends current editing value to the IME.',
      'icon': Icons.keyboard,
      'color': Colors.blue,
    },
    {
      'step': '3. Text Input',
      'desc': 'User types: platform calls updateEditingValue. Input '
          'formatters run. Controller is updated. Build triggers. '
          'Selection handles and toolbar update.',
      'icon': Icons.edit,
      'color': Colors.green,
    },
    {
      'step': '4. Selection Change',
      'desc': 'User taps/drags to change selection. RenderEditable '
          'calculates new TextSelection from hit-test position. '
          'EditableTextState updates the selection and notifies.',
      'icon': Icons.select_all,
      'color': Colors.orange,
    },
    {
      'step': '5. Action Performed',
      'desc': 'User presses Done/Next/Go. performAction calls '
          'onEditingComplete, then onSubmitted. For '
          'TextInputAction.next, focus moves to next field.',
      'icon': Icons.done,
      'color': Colors.purple,
    },
    {
      'step': '6. Focus Lost',
      'desc': 'Input connection closes. Keyboard dismisses. '
          'Selection handles hide. The text remains in the '
          'controller but editing is inactive.',
      'icon': Icons.visibility_off,
      'color': Colors.red,
    },
  ];

  final lifecycleWidgets = <Widget>[];
  for (var i = 0; i < lifecycleSteps.length; i++) {
    final ls = lifecycleSteps[i];
    final lsColor = ls['color'] as Color;
    print('Lifecycle ${i + 1}: ${ls['step']}');
    lifecycleWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: lsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ls['icon'] as IconData,
                    color: lsColor,
                    size: 18,
                  ),
                ),
                if (i < lifecycleSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: lsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ls['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: lsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ls['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Selection
  // ============================================================
  print('=== Section 4: Selection ===');

  final selectionTopics = <Map<String, dynamic>>[
    {
      'title': 'Cursor Position',
      'desc': 'TextSelection.collapsed(offset: n) represents a cursor '
          'at position n with no selection range. The cursor blinks '
          'at this offset in the text.',
      'color': Colors.teal,
    },
    {
      'title': 'Range Selection',
      'desc': 'TextSelection(baseOffset: a, extentOffset: b) selects '
          'text from position a to b. The extent is where the user '
          'last touched; it moves during drag gestures.',
      'color': Colors.blue,
    },
    {
      'title': 'Word Selection',
      'desc': 'Double-tap selects a word. EditableTextState uses '
          'RenderEditable.getWordAtOffset to find word boundaries. '
          'The selection snaps to word start/end.',
      'color': Colors.green,
    },
    {
      'title': 'Line Selection',
      'desc': 'Triple-tap selects an entire line. Uses the line metrics '
          'from the text layout to determine line boundaries.',
      'color': Colors.orange,
    },
    {
      'title': 'Selection Handles',
      'desc': 'When a range is selected, draggable handles appear at '
          'the base and extent. Dragging a handle calls '
          'onSelectionHandleDragUpdate, which recomputes the '
          'selection from the new position.',
      'color': Colors.purple,
    },
    {
      'title': 'Toolbar Actions',
      'desc': 'Cut removes selected text and copies to clipboard. Copy '
          'copies without removing. Paste inserts clipboard content '
          'at cursor. Select All selects the entire text.',
      'color': Colors.red,
    },
  ];

  final selectionWidgets = <Widget>[];
  for (var i = 0; i < selectionTopics.length; i++) {
    final st = selectionTopics[i];
    final stColor = st['color'] as Color;
    print('Selection ${i + 1}: ${st['title']}');
    selectionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: stColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: stColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: stColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: stColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    st['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: stColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    st['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Formatters
  // ============================================================
  print('=== Section 5: Formatters ===');

  final formatters = <Map<String, dynamic>>[
    {
      'title': 'FilteringTextInputFormatter',
      'desc': 'Restricts characters by regex pattern. allow() keeps '
          'matching characters. deny() removes matching characters. '
          'Common: digitsOnly, singleLineFormatter.',
      'diagram': 'FilteringTextInputFormatter.digitsOnly\n'
          '// Input: "abc123def" -> "123"\n'
          '\n'
          'FilteringTextInputFormatter.deny(\n'
          '  RegExp(r"[^a-zA-Z]"),\n'
          ')\n'
          '// Input: "Hello 123!" -> "Hello"',
      'color': Colors.teal,
    },
    {
      'title': 'LengthLimitingTextInputFormatter',
      'desc': 'Limits the maximum number of characters. Truncates '
          'input that exceeds the limit. Respects composing '
          'text to avoid breaking IME input.',
      'diagram': 'LengthLimitingTextInputFormatter(10)\n'
          '// "Hello World!" -> "Hello Worl"\n'
          '// Max 10 characters',
      'color': Colors.blue,
    },
    {
      'title': 'Custom Formatter',
      'desc': 'Implement TextInputFormatter with formatEditUpdate. '
          'Receives old and new TextEditingValue. Returns the '
          'desired new value. Can transform text freely.',
      'diagram': 'class UpperCaseFormatter\n'
          '    extends TextInputFormatter {\n'
          '  @override\n'
          '  TextEditingValue formatEditUpdate(\n'
          '    TextEditingValue oldValue,\n'
          '    TextEditingValue newValue,\n'
          '  ) {\n'
          '    return newValue.copyWith(\n'
          '      text: newValue.text.toUpperCase(),\n'
          '    );\n'
          '  }\n'
          '}',
      'color': Colors.green,
    },
    {
      'title': 'Chaining Formatters',
      'desc': 'Formatters are applied in list order. Each receives the '
          'output of the previous. Use this to combine filtering '
          'and transformation.',
      'diagram': 'inputFormatters: [\n'
          '  FilteringTextInputFormatter.digitsOnly,\n'
          '  LengthLimitingTextInputFormatter(6),\n'
          '  CreditCardFormatter(),\n'
          ']\n'
          '// Input: "1234567890"\n'
          '// After digits: "1234567890"\n'
          '// After length: "123456"\n'
          '// After format: "1234 56"',
      'color': Colors.orange,
    },
  ];

  final formatterWidgets = <Widget>[];
  for (var i = 0; i < formatters.length; i++) {
    final f = formatters[i];
    final fColor = f['color'] as Color;
    print('Formatter ${i + 1}: ${f['title']}');
    formatterWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: fColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: fColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                f['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: fColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                f['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  f['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Keyboard Actions
  // ============================================================
  print('=== Section 6: Actions ===');

  final actions = <Map<String, dynamic>>[
    {
      'action': 'TextInputAction.done',
      'desc': 'Submits the input and typically closes the keyboard. '
          'Used for single-field forms and search bars.',
      'icon': Icons.done,
      'color': Colors.teal,
    },
    {
      'action': 'TextInputAction.next',
      'desc': 'Moves focus to the next field in the form. Used in '
          'multi-field forms to guide the user through fields '
          'without dismissing the keyboard.',
      'icon': Icons.arrow_forward,
      'color': Colors.blue,
    },
    {
      'action': 'TextInputAction.newline',
      'desc': 'Inserts a newline character. Used for multiline text '
          'fields where Enter should add a line, not submit.',
      'icon': Icons.keyboard_return,
      'color': Colors.green,
    },
    {
      'action': 'TextInputAction.search',
      'desc': 'Shows a Search icon on the keyboard action button. '
          'Triggers onSubmitted, typically starting a search.',
      'icon': Icons.search,
      'color': Colors.orange,
    },
    {
      'action': 'TextInputAction.go',
      'desc': 'Shows a Go icon. Used for URL bars or navigation fields '
          'where the action navigates to a destination.',
      'icon': Icons.open_in_browser,
      'color': Colors.purple,
    },
    {
      'action': 'TextInputAction.send',
      'desc': 'Shows a Send icon. Used for chat/messaging input where '
          'the action sends the typed message.',
      'icon': Icons.send,
      'color': Colors.red,
    },
  ];

  final actionWidgets = <Widget>[];
  for (var i = 0; i < actions.length; i++) {
    final a = actions[i];
    final aColor = a['color'] as Color;
    print('Action ${i + 1}: ${a['action']}');
    actionWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: aColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: aColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: aColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(a['icon'] as IconData, color: aColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: aColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      a['action'] as String,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: aColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    a['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Widget Hierarchy
  // ============================================================
  print('=== Section 7: Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'level': 'EditableText',
      'features': 'TextInputClient, low-level rendering, IME connection, '
          'text layout, selection handles, input formatters',
      'purpose': 'The raw editable text widget. No decoration, hint text, '
          'labels, or error messages. Direct control over rendering.',
      'color': Colors.teal,
    },
    {
      'level': 'TextField',
      'features': 'EditableText + InputDecoration, Material Design, '
          'hint, label, prefix, suffix, error, counter, borders',
      'purpose': 'Material Design text field. Wraps EditableText with '
          'visual decoration and accessibility features.',
      'color': Colors.blue,
    },
    {
      'level': 'TextFormField',
      'features': 'TextField + FormField integration, validation, '
          'onSaved, autovalidateMode, error display',
      'purpose': 'Material text field integrated with Form. Adds '
          'validation and save lifecycle to TextField.',
      'color': Colors.green,
    },
    {
      'level': 'CupertinoTextField',
      'features': 'EditableText + iOS-style decoration, placeholder, '
          'clearButton, Cupertino borders and padding',
      'purpose': 'iOS-style text field. Wraps EditableText with '
          'Cupertino visual design.',
      'color': Colors.orange,
    },
  ];

  final hierarchyWidgets = <Widget>[];
  for (var i = 0; i < hierarchy.length; i++) {
    final hi = hierarchy[i];
    final hiColor = hi['color'] as Color;
    print('Hierarchy ${i + 1}: ${hi['level']}');
    hierarchyWidgets.add(
      Container(
        margin: EdgeInsets.only(
          left: 16 + i * 16.0,
          right: 16,
          top: 4,
          bottom: 4,
        ),
        decoration: BoxDecoration(
          color: hiColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: hiColor.withOpacity(0.3), width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hi['level'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: hiColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                hi['purpose'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: hiColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  hi['features'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: hiColor,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (i < hierarchy.length - 1) {
      hierarchyWidgets.add(
        Padding(
          padding: EdgeInsets.only(left: 32 + i * 16.0),
          child: Icon(
            Icons.arrow_downward,
            color: hiColor.withOpacity(0.4),
            size: 20,
          ),
        ),
      );
    }
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'text': 'EditableTextState is the State behind EditableText, '
          'managing the full text editing lifecycle.',
    },
    {
      'icon': Icons.keyboard,
      'text': 'Implements TextInputClient for platform IME connection, '
          'receiving text input via updateEditingValue.',
    },
    {
      'icon': Icons.select_all,
      'text': 'Handles cursor positioning, range selection, word and '
          'line selection, and selection toolbar operations.',
    },
    {
      'icon': Icons.auto_fix_high,
      'text': 'Applies TextInputFormatter chains to transform and '
          'restrict input before displaying.',
    },
    {
      'icon': Icons.done,
      'text': 'Routes keyboard actions (done, next, search, go, send) '
          'to onEditingComplete and onSubmitted callbacks.',
    },
    {
      'icon': Icons.layers,
      'text': 'EditableText sits below TextField, TextFormField, and '
          'CupertinoTextField in the widget hierarchy.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.teal.shade800,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('EditableTextState'),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.loop), text: 'Lifecycle'),
            Tab(icon: Icon(Icons.select_all), text: 'Selection'),
            Tab(icon: Icon(Icons.auto_fix_high), text: 'Formatters'),
            Tab(icon: Icon(Icons.keyboard), text: 'Actions'),
            Tab(icon: Icon(Icons.layers), text: 'Hierarchy'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'EditableTextState: the state object managing the text '
                  'editing lifecycle for all text fields.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'EditableTextState key methods and properties.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The editing lifecycle from init to focus lost.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...lifecycleWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Text selection: cursor, range, word, line, and toolbar.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...selectionWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Input formatters: filter, limit, and transform text.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...formatterWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Keyboard action types and their behaviors.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...actionWidgets,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.teal.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'EditableText \u2192 TextField \u2192 TextFormField hierarchy.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...hierarchyWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal.withOpacity(0.12),
                      Colors.teal.withOpacity(0.04),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about EditableTextState.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
