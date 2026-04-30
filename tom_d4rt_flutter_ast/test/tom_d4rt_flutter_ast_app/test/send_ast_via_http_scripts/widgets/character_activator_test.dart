// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — CharacterActivator
// Demonstrates CharacterActivator — a ShortcutActivator that triggers
// a shortcut when a specific character is typed. Unlike SingleActivator
// which matches physical/logical keys, CharacterActivator matches the
// actual character produced after all platform-level text composition.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CharacterActivator Deep Demo executing');

  // ============================================================
  // SECTION 1: What is CharacterActivator?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.text_fields,
      'title': 'Character-Based Shortcut Trigger',
      'body': 'CharacterActivator is a ShortcutActivator that matches '
          'on the character produced by a key press, not the physical '
          'or logical key itself. It activates when the user types a '
          'specific character — for example, "?" or "/" — regardless '
          'of which key combination produced that character on the '
          'user\'s keyboard layout.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.keyboard_alt,
      'title': 'Layout-Independent',
      'body': 'A "/" character might be produced by different keys on '
          'different keyboard layouts (QWERTY, AZERTY, Dvorak). '
          'CharacterActivator fires when the character appears, '
          'not when a specific key is pressed. This makes it ideal '
          'for character-based commands like search ("/"), help ("?"), '
          'or command palette (":"). ',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'vs SingleActivator',
      'body': 'SingleActivator matches specific key + modifier combos '
          '(e.g., Ctrl+S). CharacterActivator matches the resulting '
          'character (e.g., "?"). SingleActivator is for key-level '
          'shortcuts; CharacterActivator is for character-level '
          'shortcuts. Both implement ShortcutActivator.',
      'accent': Colors.cyan[600]!,
    },
    {
      'icon': Icons.check_circle,
      'title': 'Simple API',
      'body': 'Construction is straightforward: CharacterActivator("?") '
          'creates an activator that fires when the user types "?". '
          'The string must be exactly one character. It is compared '
          'against the character property of RawKeyEvent or '
          'KeyEvent after platform text composition.',
      'accent': Colors.teal[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: CharacterActivator vs SingleActivator
  // ============================================================
  print('=== Section 2: Comparison ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'aspect': 'Activation trigger',
      'character': 'Character produced after text composition',
      'single': 'Logical/physical key + modifiers',
    },
    {
      'aspect': 'Layout-independent',
      'character': 'Yes — fires when character appears regardless of key',
      'single': 'No — bound to specific LogicalKeyboardKey',
    },
    {
      'aspect': 'Modifier awareness',
      'character': 'Implicit — modifiers produce different characters',
      'single': 'Explicit — specify control, shift, alt, meta',
    },
    {
      'aspect': 'Construction',
      'character': 'CharacterActivator("?")',
      'single': 'SingleActivator(LogicalKeyboardKey.keyS, control: true)',
    },
    {
      'aspect': 'Best for',
      'character': 'Search (/), help (?), single-key commands',
      'single': 'Ctrl+S, Ctrl+Z, Alt+F4, key combos',
    },
    {
      'aspect': 'Works in text fields',
      'character': 'Use with care — may conflict with typing',
      'single': 'Modifier combos avoid text field conflicts',
    },
  ];

  print('  Prepared ${comparisonRows.length} comparison rows');

  // ============================================================
  // SECTION 3: Properties
  // ============================================================
  print('=== Section 3: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'character',
      'type': 'String',
      'icon': Icons.abc,
      'color': Colors.cyan[700]!,
      'description': 'The character that activates this shortcut. Must '
          'be exactly one character long. Compared against the '
          'character property of the key event after platform '
          'text composition has been applied.',
    },
    {
      'name': 'triggers',
      'type': 'Iterable<LogicalKeyboardKey>?',
      'icon': Icons.keyboard,
      'color': Colors.teal[700]!,
      'description': 'Optional set of logical keys that can trigger '
          'this activator. If null, any key that produces the '
          'specified character will trigger activation. If set, '
          'only keys in this set are considered.',
    },
    {
      'name': 'accepts(event, state)',
      'type': 'bool (method)',
      'icon': Icons.check,
      'color': Colors.cyan[600]!,
      'description': 'Returns true when the key event produces the '
          'matching character. Inherited from ShortcutActivator. '
          'Called by the Shortcuts widget during key event '
          'processing.',
    },
    {
      'name': 'debugDescribeKeys()',
      'type': 'String (method)',
      'icon': Icons.bug_report,
      'color': Colors.teal[600]!,
      'description': 'Returns a debug description of this activator '
          'for diagnostics. Shows the character this activator '
          'matches, e.g., \'CharacterActivator("?")\'.',
    },
  ];

  print('  Prepared ${properties.length} properties');

  // ============================================================
  // SECTION 4: Common Characters
  // ============================================================
  print('=== Section 4: Common Characters ===');

  final commonChars = <Map<String, dynamic>>[
    {
      'char': '/',
      'name': 'Forward Slash',
      'color': Colors.cyan[700]!,
      'apps': 'Search (Gmail, YouTube, Unix shells, Vim)',
      'note': 'The most common character shortcut. Nearly universal '
          'for "start searching."',
    },
    {
      'char': '?',
      'name': 'Question Mark',
      'color': Colors.teal[700]!,
      'apps': 'Help/shortcuts panel (GitHub, Gmail, Slack)',
      'note': 'Shows a keyboard shortcuts reference or help overlay.',
    },
    {
      'char': ':',
      'name': 'Colon',
      'color': Colors.cyan[600]!,
      'apps': 'Command palette (Vim, VS Code via Ctrl+:)',
      'note': 'Opens a command input. In Vim, ":" enters command mode.',
    },
    {
      'char': '.',
      'name': 'Period',
      'color': Colors.teal[600]!,
      'apps': 'Repeat last action (Vim), GitHub (open web editor)',
      'note': 'Repeats the previous command or opens quick action.',
    },
    {
      'char': 'g',
      'name': 'Letter G',
      'color': Colors.cyan[500]!,
      'apps': 'Go to top (Gmail gg), navigation (Vim)',
      'note': 'Often used as a prefix for "go to" commands.',
    },
    {
      'char': 'j',
      'name': 'Letter J',
      'color': Colors.teal[500]!,
      'apps': 'Down (Gmail, Vim, YouTube, Twitter)',
      'note': 'Vim-style navigation: j=down, k=up, h=left, l=right.',
    },
    {
      'char': 'k',
      'name': 'Letter K',
      'color': Colors.cyan[500]!,
      'apps': 'Up (Gmail, Vim, YouTube, Twitter)',
      'note': 'Vim-style navigation counterpart to j.',
    },
  ];

  print('  Prepared ${commonChars.length} common characters');

  // ============================================================
  // SECTION 5: How It Works Under the Hood
  // ============================================================
  print('=== Section 5: Under the Hood ===');

  final mechanismSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Physical Key Pressed',
      'color': Colors.cyan[700]!,
      'detail': 'The user presses a physical key on their keyboard. '
          'The OS generates a low-level key event with the physical '
          'key code and any active modifiers (Shift, Ctrl, etc.).',
    },
    {
      'step': 2,
      'title': 'Platform Text Composition',
      'color': Colors.teal[700]!,
      'detail': 'The platform (OS + keyboard layout) resolves the '
          'pressed key into an actual character. Shift+/ on QWERTY '
          'produces "?". The same character may come from different '
          'key combos on different layouts.',
    },
    {
      'step': 3,
      'title': 'Flutter Receives KeyEvent',
      'color': Colors.cyan[600]!,
      'detail': 'Flutter receives a KeyEvent with both the logical '
          'key (LogicalKeyboardKey) and the produced character '
          '(a String). The Shortcuts widget begins checking '
          'registered ShortcutActivators.',
    },
    {
      'step': 4,
      'title': 'CharacterActivator.accepts() Called',
      'color': Colors.teal[600]!,
      'detail': 'For each registered CharacterActivator, the accepts() '
          'method is called. It compares the event\'s character '
          'property against the activator\'s character field. If '
          'they match, the activator reports a match.',
    },
    {
      'step': 5,
      'title': 'Intent Dispatched via Actions',
      'color': Colors.cyan[500]!,
      'detail': 'If accepted, the Shortcuts widget creates the mapped '
          'Intent and dispatches it through the Actions system. The '
          'corresponding Action handles the intent, completing the '
          'shortcut invocation.',
    },
  ];

  print('  Prepared ${mechanismSteps.length} mechanism steps');

  // ============================================================
  // SECTION 6: Use Cases
  // ============================================================
  print('=== Section 6: Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Search with "/" Key',
      'icon': Icons.search,
      'color': Colors.cyan[700]!,
      'description': 'Map "/" to a SearchIntent that opens or focuses '
          'a search bar. Works on any keyboard layout because it '
          'matches the "/" character, not the physical key.',
      'pattern': 'CharacterActivator("/") → SearchIntent()',
    },
    {
      'title': 'Keyboard Shortcuts Help with "?"',
      'icon': Icons.help,
      'color': Colors.teal[700]!,
      'description': 'Map "?" to a ShowShortcutsIntent that displays '
          'a help overlay showing available keyboard shortcuts. '
          'Common in web apps like GitHub, Gmail, and Slack.',
      'pattern': 'CharacterActivator("?") → ShowShortcutsIntent()',
    },
    {
      'title': 'Vim-Style Navigation',
      'icon': Icons.keyboard_double_arrow_down,
      'color': Colors.cyan[600]!,
      'description': 'Map "j" and "k" to NavigateDownIntent and '
          'NavigateUpIntent for keyboard-driven list navigation. '
          'Users familiar with Vim can navigate without arrow keys.',
      'pattern': 'CharacterActivator("j") → NavigateDownIntent()',
    },
    {
      'title': 'Command Mode with ":"',
      'icon': Icons.terminal,
      'color': Colors.teal[600]!,
      'description': 'Map ":" to an OpenCommandPaletteIntent that '
          'opens a text input for commands. Users type ":quit", '
          '":save", ":goto 42", etc. Vim and terminal inspired.',
      'pattern': 'CharacterActivator(":") → CommandPaletteIntent()',
    },
    {
      'title': 'Quick Reply with "r"',
      'icon': Icons.reply,
      'color': Colors.cyan[500]!,
      'description': 'In a messaging or email UI, map "r" to a '
          'ReplyIntent that activates the reply input field. '
          'Common in Gmail-style keyboard-centric email clients.',
      'pattern': 'CharacterActivator("r") → ReplyIntent()',
    },
  ];

  print('  Prepared ${useCases.length} use cases');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Code Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic: "/" for Search',
      'color': Colors.cyan[700]!,
      'code': '// Press "/" to open search\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    CharacterActivator("/")\n'
          '        : const SearchIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: <Type, Action<Intent>>{\n'
          '      SearchIntent: CallbackAction(\n'
          '        onInvoke: (_) {\n'
          '          _searchFocus.requestFocus();\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '    },\n'
          '    child: _buildMainContent(),\n'
          '  ),\n'
          ')',
    },
    {
      'title': '"?" for Help Overlay',
      'color': Colors.teal[700]!,
      'code': '// Press "?" to show shortcuts help\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    CharacterActivator("?")\n'
          '        : const ShowHelpIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: <Type, Action<Intent>>{\n'
          '      ShowHelpIntent: CallbackAction(\n'
          '        onInvoke: (_) {\n'
          '          showDialog(\n'
          '            context: context,\n'
          '            builder: (_) =>\n'
          '                ShortcutsHelpDialog(),\n'
          '          );\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '    },\n'
          '    child: _buildContent(),\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Multiple Character Shortcuts',
      'color': Colors.cyan[600]!,
      'code': '// Map multiple characters\n'
          'Shortcuts(\n'
          '  shortcuts: <ShortcutActivator, Intent>{\n'
          '    CharacterActivator("/")\n'
          '        : const SearchIntent(),\n'
          '    CharacterActivator("?")\n'
          '        : const HelpIntent(),\n'
          '    CharacterActivator(":")\n'
          '        : const CommandIntent(),\n'
          '    CharacterActivator("j")\n'
          '        : const DownIntent(),\n'
          '    CharacterActivator("k")\n'
          '        : const UpIntent(),\n'
          '  },\n'
          '  child: Actions(\n'
          '    actions: <Type, Action<Intent>>{\n'
          '      SearchIntent: _searchAction,\n'
          '      HelpIntent: _helpAction,\n'
          '      CommandIntent: _cmdAction,\n'
          '      DownIntent: _downAction,\n'
          '      UpIntent: _upAction,\n'
          '    },\n'
          '    child: _buildApp(),\n'
          '  ),\n'
          ')',
    },
    {
      'title': 'Guard Against Text Fields',
      'color': Colors.teal[600]!,
      'code': '// Only activate when NOT in a\n'
          '// text field. Use an Action that\n'
          '// checks focus before acting.\n'
          'CallbackAction<SearchIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final focused =\n'
          '        FocusManager\n'
          '            .instance.primaryFocus;\n'
          '    // Check if an EditableText\n'
          '    // ancestor exists\n'
          '    final inTextField = focused\n'
          '            ?.context\n'
          '            ?.findAncestorWidgetOf\n'
          '                ExactType<\n'
          '                    EditableText>() !=\n'
          '        null;\n'
          '    if (!inTextField) {\n'
          '      _openSearch();\n'
          '    }\n'
          '    return null;\n'
          '  },\n'
          ')',
    },
  ];

  print('  Prepared ${codePatterns.length} code patterns');

  // ============================================================
  // SECTION 8: Keyboard Layout Diagram
  // ============================================================
  print('=== Section 8: Layout Independence ===');

  final layoutExamples = <Map<String, dynamic>>[
    {
      'layout': 'US QWERTY',
      'color': Colors.cyan[700]!,
      'mappings': [
        '/ → Slash key (no modifier)',
        '? → Shift + Slash key',
        ': → Shift + Semicolon key',
      ],
    },
    {
      'layout': 'German QWERTZ',
      'color': Colors.teal[700]!,
      'mappings': [
        '/ → Shift + 7 key',
        '? → Shift + ß key',
        ': → Shift + Period key',
      ],
    },
    {
      'layout': 'French AZERTY',
      'color': Colors.cyan[600]!,
      'mappings': [
        '/ → Shift + Colon key',
        '? → Shift + Comma key',
        ': → Period key (no modifier)',
      ],
    },
  ];

  print('  Prepared ${layoutExamples.length} layout examples');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Avoid Conflict with Text Input',
      'body': 'CharacterActivator fires on character input, which '
          'conflicts with text fields. Ensure character shortcuts '
          'are only active when focus is NOT in an editable field. '
          'Check the focus tree or use a FocusScope guard.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Single Character Only',
      'body': 'The character parameter must be exactly one character '
          'long. You cannot use CharacterActivator for multi-key '
          'sequences like "gg" (go to top in Vim). For sequences, '
          'you need a custom ShortcutActivator with state tracking.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Prefer for Cross-Layout Shortcuts',
      'body': 'When the shortcut concept is character-based (e.g., '
          '"press ?" for help), CharacterActivator is the correct '
          'choice. When the concept is key-based (e.g., "press '
          'Ctrl+S" for save), use SingleActivator.',
      'severity': 'tip',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Works with the triggers Parameter',
      'body': 'The optional triggers parameter lets you restrict '
          'which logical keys can trigger the activator. If you '
          'only want "/" from the slash key (not from keypads or '
          'dead keys), specify triggers explicitly.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Case-Sensitive',
      'body': 'CharacterActivator("a") and CharacterActivator("A") '
          'are different. "a" fires when the user types lowercase '
          'a; "A" fires when Shift+a produces uppercase A. Be '
          'explicit about which case you want. Or register both.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test on Multiple Platforms',
      'body': 'Platform text composition differs between Windows, '
          'macOS, Linux, and web. Test that your character shortcuts '
          'work correctly on all target platforms, especially for '
          'special characters that require different key combos.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('CharacterActivator'),
      backgroundColor: Colors.cyan[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[700]!, Colors.teal[700]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.text_fields, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'CharacterActivator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A ShortcutActivator that triggers shortcuts based '
                  'on the character produced by a key press, not the '
                  'physical or logical key itself. Ideal for layout-'
                  'independent character commands like "/" for search '
                  'or "?" for help.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _caHead('1', 'What is CharacterActivator?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Comparison ──
          _caHead('2', 'CharacterActivator vs SingleActivator'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.cyan[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                      width: 80,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('CharacterActivator',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                  Expanded(
                      child: Text('SingleActivator',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 9))),
                ]),
              ),
              ...comparisonRows.asMap().entries.map((entry) {
                final r = entry.value;
                final isEven = entry.key.isEven;
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 5),
                  color: isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 80,
                          child: Text(r['aspect'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: Colors.grey[800]))),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Text(r['character'] as String,
                            style: TextStyle(
                                fontSize: 8,
                                color: Colors.cyan[700])),
                      )),
                      Expanded(
                          child: Text(r['single'] as String,
                              style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600]))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 3: Properties ──
          _caHead('3', 'Properties'),
          SizedBox(height: 12),
          ...properties.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  fontFamily: 'monospace')),
                        ),
                        _caTag(p['type'] as String,
                            p['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Text(p['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Common Characters ──
          _caHead('4', 'Common Character Shortcuts'),
          SizedBox(height: 12),
          ...commonChars.map((cc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: cc['color'] as Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(cc['char'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace')),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(cc['name'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(cc['apps'] as String,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Colors.grey[500])),
                              ),
                            ]),
                            SizedBox(height: 3),
                            Text(cc['note'] as String,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Under the Hood ──
          _caHead('5', 'How It Works Under the Hood'),
          SizedBox(height: 12),
          ...mechanismSteps.map((ms) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ms['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: ms['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${ms['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(ms['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(ms['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Use Cases ──
          _caHead('6', 'Use Cases'),
          SizedBox(height: 12),
          ...useCases.map((uc) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: uc['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(uc['icon'] as IconData,
                            color: uc['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(uc['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(uc['description'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(uc['pattern'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.cyan[200])),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _caHead('7', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Keyboard Layouts ──
          _caHead('8', 'Layout Independence'),
          SizedBox(height: 8),
          Text(
            'The same character is produced by different key combos '
            'on different keyboard layouts. CharacterActivator handles '
            'this automatically.',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          SizedBox(height: 12),
          ...layoutExamples.map((le) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: le['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(le['layout'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: le['color'] as Color)),
                      SizedBox(height: 6),
                      ...(le['mappings'] as List<String>).map(
                        (m) => Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Row(children: [
                            Text('  • ',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[400])),
                            Expanded(
                              child: Text(m,
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'monospace',
                                      color: Colors.grey[700])),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _caHead('9', 'Tips & Best Practices'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),
          Center(
            child: Text(
              'End of CharacterActivator Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _caHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.cyan[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Type tag
// ──────────────────────────────────────────────────────────
Widget _caTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
