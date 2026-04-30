// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — TextField
// Demonstrates the TextField widget, Flutter\'s primary text input component.
// Covers decoration, input types, validation, controllers, focus, obscure text,
// character limits, multi-line, auto-correct, read-only, and styling options.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextField Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'What is TextField?',
      'body': 'TextField is Flutter\'s primary widget for text input. It '
          'wraps an EditableText with Material Design decoration, '
          'providing underline or outlined borders, labels, hints, '
          'icons, and error states out of the box.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.format_size,
      'title': 'InputDecoration',
      'body': 'Every TextField has an InputDecoration that controls its '
          'visual appearance: label text, hint text, prefix/suffix '
          'icons, error text, helper text, counter, borders, and '
          'fill colors. This is the most customized parameter.',
      'accent': Colors.purple,
    },
    {
      'icon': Icons.keyboard,
      'title': 'TextInputType',
      'body': 'The keyboardType parameter determines which keyboard layout '
          'appears: text, number, email, phone, URL, multiline, or '
          'datetime. Each type optimizes the virtual keyboard for '
          'the expected input.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.edit_note,
      'title': 'TextEditingController',
      'body': 'A controller provides programmatic access to the text '
          'content and selection. It notifies listeners on changes, '
          'enabling reactive UI updates. Always dispose controllers '
          'when no longer needed.',
      'accent': Colors.teal,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final e = conceptItems[i];
    final accent = e['accent'] as Color;
    print('Concept ${i + 1}: ${e['title']}');
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
                child: Icon(e['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
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
  // SECTION 2: Decoration Styles
  // ============================================================
  print('=== Section 2: Decoration ===');

  final decoStyles = <Map<String, dynamic>>[
    {
      'name': 'Underline (Default)',
      'desc': 'A simple underline that highlights on focus. The default '
          'border style for Material Design. Minimal visual weight.',
      'border': 'underline',
      'color': Colors.indigo,
    },
    {
      'name': 'Outlined',
      'desc': 'A full border surrounding the field. Provides a clear '
          'boundary. Popular in Material Design 3 and form-heavy UIs.',
      'border': 'outline',
      'color': Colors.purple,
    },
    {
      'name': 'Filled',
      'desc': 'The field has a semi-transparent background fill with no '
          'border. Softer visual style that works well on colored '
          'backgrounds.',
      'border': 'filled',
      'color': Colors.teal,
    },
    {
      'name': 'Custom Rounded',
      'desc': 'Fully rounded corners with a thick outline border. Shows '
          'that InputDecoration borders can be heavily customized for '
          'unique branding.',
      'border': 'rounded',
      'color': Colors.deepOrange,
    },
  ];

  final decoWidgets = <Widget>[];
  for (var i = 0; i < decoStyles.length; i++) {
    final ds = decoStyles[i];
    final dsColor = ds['color'] as Color;
    print('Deco ${i + 1}: ${ds['name']}');

    InputDecoration deco;
    if (ds['border'] == 'underline') {
      deco = InputDecoration(
        labelText: 'Username',
        hintText: 'Enter username',
        prefixIcon: Icon(Icons.person, color: dsColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: dsColor.withOpacity(0.4)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: dsColor, width: 2),
        ),
      );
    } else if (ds['border'] == 'outline') {
      deco = InputDecoration(
        labelText: 'Email',
        hintText: 'you@example.com',
        prefixIcon: Icon(Icons.email, color: dsColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dsColor.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: dsColor, width: 2),
        ),
      );
    } else if (ds['border'] == 'filled') {
      deco = InputDecoration(
        labelText: 'Notes',
        hintText: 'Enter notes here',
        prefixIcon: Icon(Icons.notes, color: dsColor),
        filled: true,
        fillColor: dsColor.withOpacity(0.06),
        border: InputBorder.none,
      );
    } else {
      deco = InputDecoration(
        labelText: 'Search',
        hintText: 'Type to search...',
        prefixIcon: Icon(Icons.search, color: dsColor),
        suffixIcon: Icon(Icons.clear, color: dsColor.withOpacity(0.4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: dsColor.withOpacity(0.4), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: dsColor, width: 2.5),
        ),
      );
    }

    decoWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: dsColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dsColor.withOpacity(0.15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ds['name'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: dsColor,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: deco,
                readOnly: true,
              ),
              const SizedBox(height: 8),
              Text(
                ds['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Input Types
  // ============================================================
  print('=== Section 3: Input Types ===');

  final inputTypes = <Map<String, dynamic>>[
    {
      'type': 'TextInputType.text',
      'label': 'Standard Text',
      'desc': 'Default keyboard with auto-correct and suggestions. Used '
          'for names, messages, and general text input.',
      'color': Colors.indigo,
    },
    {
      'type': 'TextInputType.number',
      'label': 'Number',
      'desc': 'Numeric keyboard with digits 0-9. Used for quantities, '
          'ages, PIN codes. No decimal or sign by default.',
      'color': Colors.blue,
    },
    {
      'type': 'TextInputType.emailAddress',
      'label': 'Email Address',
      'desc': 'Keyboard includes @ and . prominently. No auto-correct. '
          'Optimized for email entry with domain suggestions.',
      'color': Colors.teal,
    },
    {
      'type': 'TextInputType.phone',
      'label': 'Phone Number',
      'desc': 'Phone dialer keyboard with +, *, #, and digits. '
          'No letters. Used for phone number entry.',
      'color': Colors.green,
    },
    {
      'type': 'TextInputType.url',
      'label': 'URL',
      'desc': 'Keyboard includes / and .com shortcuts. No auto-correct '
          'or auto-capitalize. Optimized for web addresses.',
      'color': Colors.orange,
    },
    {
      'type': 'TextInputType.multiline',
      'label': 'Multiline',
      'desc': 'Return key inserts a newline instead of submitting. '
          'Used with maxLines > 1 for paragraphs or comments.',
      'color': Colors.deepOrange,
    },
  ];

  final inputTypeWidgets = <Widget>[];
  for (var i = 0; i < inputTypes.length; i++) {
    final it = inputTypes[i];
    final itColor = it['color'] as Color;
    print('InputType ${i + 1}: ${it['label']}');
    inputTypeWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: itColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: itColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: itColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.keyboard, color: itColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        it['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: itColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: itColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          it['type'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 9,
                            color: itColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    it['desc'] as String,
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
  // SECTION 4: Validation
  // ============================================================
  print('=== Section 4: Validation ===');

  final validationExamples = <Map<String, dynamic>>[
    {
      'label': 'Required Field',
      'error': 'This field is required',
      'hint': 'Enter your name',
      'desc': 'Error text appears below the field in red. The border '
          'changes to the error color. This is the most basic '
          'validation pattern.',
      'color': Colors.red,
    },
    {
      'label': 'Email Validation',
      'error': 'Please enter a valid email address',
      'hint': 'user@domain.com',
      'desc': 'Pattern-based validation checks format before submission. '
          'The error border and text guide the user to correct input.',
      'color': Colors.deepOrange,
    },
    {
      'label': 'Min Length',
      'error': 'Password must be at least 8 characters',
      'hint': 'Enter password',
      'desc': 'Length validation ensures minimum data quality. Can be '
          'combined with a counter to show current vs required length.',
      'color': Colors.orange,
    },
    {
      'label': 'Custom Pattern',
      'error': 'Only alphanumeric characters allowed',
      'hint': 'Enter username',
      'desc': 'Regular expression validation for specific character sets. '
          'Common for usernames, codes, and formatted inputs.',
      'color': Colors.amber,
    },
  ];

  final validationWidgets = <Widget>[];
  for (var i = 0; i < validationExamples.length; i++) {
    final ve = validationExamples[i];
    final veColor = ve['color'] as Color;
    print('Validation ${i + 1}: ${ve['label']}');
    validationWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: veColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: veColor.withOpacity(0.15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ve['label'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: veColor,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: ve['hint'] as String,
                  errorText: ve['error'] as String,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: veColor),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: veColor, width: 2),
                  ),
                  prefixIcon: Icon(Icons.warning_amber, color: veColor),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ve['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Special Modes
  // ============================================================
  print('=== Section 5: Special Modes ===');

  final specialModes = <Map<String, dynamic>>[
    {
      'mode': 'Obscure Text (Password)',
      'desc': 'Characters are replaced with dots or bullets. Used for '
          'passwords, PINs, and sensitive data. The obscureText '
          'property toggles this behavior. Often combined with a '
          'visibility toggle suffix icon.',
      'icon': Icons.visibility_off,
      'color': Colors.indigo,
    },
    {
      'mode': 'Read-Only',
      'desc': 'The field displays text but does not accept input. '
          'Useful for showing computed values, system-generated IDs, '
          'or locked form fields. Text can still be selected and '
          'copied.',
      'icon': Icons.lock,
      'color': Colors.grey,
    },
    {
      'mode': 'Enabled: false',
      'desc': 'The field is visually dimmed and ignores all interaction. '
          'Unlike readOnly, the text cannot be selected. Use for '
          'fields that depend on other form state.',
      'icon': Icons.block,
      'color': Colors.brown,
    },
    {
      'mode': 'Max Lines / Expanding',
      'desc': 'Set maxLines to null for expandable text areas. Set to '
          'a fixed number for scrollable areas. Combine with '
          'TextInputType.multiline for newline support.',
      'icon': Icons.expand,
      'color': Colors.teal,
    },
    {
      'mode': 'Max Length with Counter',
      'desc': 'Limits input to a maximum character count and displays '
          'a counter (e.g., "23/100") below the field. By default, '
          'enforcement prevents typing beyond the limit.',
      'icon': Icons.pin,
      'color': Colors.deepOrange,
    },
    {
      'mode': 'Autocorrect & Suggestions',
      'desc': 'Controls whether the keyboard shows auto-corrections '
          'and predictive suggestions. Disable for code, URLs, '
          'passwords, and technical input where suggestions are '
          'unhelpful.',
      'icon': Icons.auto_fix_high,
      'color': Colors.blue,
    },
  ];

  final specialWidgets = <Widget>[];
  for (var i = 0; i < specialModes.length; i++) {
    final sm = specialModes[i];
    final smColor = sm['color'] as Color;
    print('Mode ${i + 1}: ${sm['mode']}');
    specialWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: smColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: smColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: smColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(sm['icon'] as IconData, color: smColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sm['mode'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: smColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      sm['desc'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 6: Controller & Focus
  // ============================================================
  print('=== Section 6: Controller & Focus ===');

  final controllerItems = <Map<String, dynamic>>[
    {
      'title': 'TextEditingController',
      'desc': 'Provides read/write access to the text value and '
          'selection. Listen to changes with addListener(). '
          'Use controller.text to get/set content. Use '
          'controller.selection to manipulate selection.',
      'code': 'final ctrl = TextEditingController();\n'
          'ctrl.text = "Hello";\n'
          'ctrl.selection = TextSelection(\n'
          '  baseOffset: 0,\n'
          '  extentOffset: 5,\n'
          ');',
      'color': Colors.indigo,
    },
    {
      'title': 'FocusNode',
      'desc': 'Manages keyboard focus for the field. Request focus '
          'programmatically with focusNode.requestFocus(). '
          'Check hasFocus to determine state. Listen to '
          'focus changes via addListener().',
      'code': 'final focus = FocusNode();\n'
          'focus.requestFocus();\n'
          'print(focus.hasFocus); // true\n'
          'focus.unfocus();',
      'color': Colors.purple,
    },
    {
      'title': 'onChanged Callback',
      'desc': 'Called whenever the user modifies the text content. '
          'Receives the new string value. Ideal for live search, '
          'character counting, or real-time validation.',
      'code': 'TextField(\n'
          '  onChanged: (value) {\n'
          '    print("New text: \$value");\n'
          '    setState(() => count = value.length);\n'
          '  },\n'
          ')',
      'color': Colors.teal,
    },
    {
      'title': 'onSubmitted Callback',
      'desc': 'Called when the user presses the keyboard action button '
          '(Enter/Done/Search). Receives the final text value. '
          'Use for form submission or search execution.',
      'code': 'TextField(\n'
          '  textInputAction: TextInputAction.search,\n'
          '  onSubmitted: (value) {\n'
          '    performSearch(value);\n'
          '  },\n'
          ')',
      'color': Colors.blue,
    },
  ];

  final controllerWidgets = <Widget>[];
  for (var i = 0; i < controllerItems.length; i++) {
    final ci = controllerItems[i];
    final ciColor = ci['color'] as Color;
    print('Controller ${i + 1}: ${ci['title']}');
    controllerWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ciColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ciColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ci['title'] as String,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: ciColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ci['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ci['code'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
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
  // SECTION 7: Styling
  // ============================================================
  print('=== Section 7: Styling ===');

  final stylingOptions = <Map<String, dynamic>>[
    {
      'title': 'Text Style',
      'desc': 'The style property controls the input text\'s font size, '
          'weight, color, and family. Different from label/hint styles.',
      'property': 'style: TextStyle(fontSize: 18, color: Colors.indigo)',
      'color': Colors.indigo,
    },
    {
      'title': 'Cursor Customization',
      'desc': 'cursorColor, cursorWidth, cursorHeight, and cursorRadius '
          'let you match the cursor to your theme.',
      'property': 'cursorColor: Colors.purple, cursorWidth: 3.0',
      'color': Colors.purple,
    },
    {
      'title': 'Selection Theme',
      'desc': 'The text selection highlight color is set via '
          'selectionColor on textSelectionTheme or directly on TextField.',
      'property': 'selectionHeightStyle: BoxHeightStyle.max',
      'color': Colors.teal,
    },
    {
      'title': 'Content Padding',
      'desc': 'contentPadding in InputDecoration controls the internal '
          'spacing between text and the field borders.',
      'property': 'contentPadding: EdgeInsets.all(20)',
      'color': Colors.deepOrange,
    },
    {
      'title': 'isDense',
      'desc': 'When true, reduces vertical padding for a compact layout. '
          'Useful in dense forms or table cells where space is limited.',
      'property': 'isDense: true',
      'color': Colors.green,
    },
  ];

  final stylingWidgets = <Widget>[];
  for (var i = 0; i < stylingOptions.length; i++) {
    final so = stylingOptions[i];
    final soColor = so['color'] as Color;
    print('Style ${i + 1}: ${so['title']}');
    stylingWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: soColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: soColor.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  so['title'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: soColor,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: soColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    so['property'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 8,
                      color: soColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              so['desc'] as String,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'text': 'TextField is Flutter\'s primary text input widget, wrapping '
          'EditableText with Material Design decoration.',
    },
    {
      'icon': Icons.brush,
      'text': 'InputDecoration provides extensive customization: labels, '
          'hints, icons, errors, borders, fills, and counters.',
    },
    {
      'icon': Icons.keyboard,
      'text': 'TextInputType optimizes the virtual keyboard for text, '
          'numbers, emails, phones, URLs, or multiline.',
    },
    {
      'icon': Icons.security,
      'text': 'obscureText hides input for passwords. readOnly and '
          'enabled control interaction states.',
    },
    {
      'icon': Icons.edit_note,
      'text': 'TextEditingController and FocusNode give programmatic '
          'control over content, selection, and keyboard focus.',
    },
    {
      'icon': Icons.check_circle,
      'text': 'Validation via errorText and callbacks. maxLength with '
          'counter for character limits.',
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
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo,
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
        title: const Text('TextField'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.palette), text: 'Decoration'),
            Tab(icon: Icon(Icons.keyboard), text: 'Input Types'),
            Tab(icon: Icon(Icons.check), text: 'Validation'),
            Tab(icon: Icon(Icons.tune), text: 'Modes'),
            Tab(icon: Icon(Icons.edit_note), text: 'Controller'),
            Tab(icon: Icon(Icons.brush), text: 'Styling'),
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextField: Flutter\'s primary text input widget with '
                  'Material Design decoration.',
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'InputDecoration border and fill styles for different TextField looks.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...decoWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'TextInputType variants and the keyboards they invoke.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...inputTypeWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Error text and validation patterns for form input.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...validationWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Special TextField modes: password, read-only, multiline, etc.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...specialWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Programmatic control with TextEditingController and FocusNode.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...controllerWidgets,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Visual styling options for text, cursors, and layout.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...stylingWidgets,
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
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about TextField.',
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
