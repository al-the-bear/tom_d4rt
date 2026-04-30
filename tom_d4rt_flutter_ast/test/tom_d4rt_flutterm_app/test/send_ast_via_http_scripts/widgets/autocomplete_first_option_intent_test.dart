// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — AutocompleteFirstOptionIntent
// Demonstrates AutocompleteFirstOptionIntent, the Intent for selecting
// the first option in an Autocomplete widget. Covers the autocomplete
// intent family, RawAutocomplete architecture, keyboard navigation,
// custom action overrides, and live widget demos.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutocompleteFirstOptionIntent Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — Autocomplete Intents
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.auto_awesome,
      'title': 'Autocomplete in Flutter',
      'body': 'Flutter\'s Autocomplete and RawAutocomplete widgets '
          'provide type-ahead suggestion capabilities. As the user '
          'types, matching options appear in a dropdown. The whole '
          'system is driven by Intents and Actions for keyboard '
          'accessibility.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.first_page,
      'title': 'AutocompleteFirstOptionIntent',
      'body': 'This Intent tells the Autocomplete to highlight the '
          'first option in the suggestion list. It is dispatched when '
          'the user presses ArrowDown while no option is selected, or '
          'programmatically to start keyboard navigation through the '
          'options list.',
      'accent': Colors.cyan[800]!,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Why Intent-Driven?',
      'body': 'By using the Intent/Action system, autocomplete '
          'keyboard navigation is accessible, testable, and '
          'customizable. You can override the action to add logging, '
          'change behavior, or integrate with your own navigation '
          'logic — all without subclassing.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.settings_suggest,
      'title': 'Built-in Registration',
      'body': 'RawAutocomplete automatically registers Actions for all '
          'autocomplete intents. You never need to set up this wiring — '
          'just use Autocomplete and keyboard navigation works. Override '
          'only when you need custom behavior.',
      'accent': Colors.indigo,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  // Demonstrate the class itself
  const firstOptionIntent = AutocompleteFirstOptionIntent();

  final apiItems = <Map<String, String>>[
    {
      'label': 'Class',
      'value': 'AutocompleteFirstOptionIntent',
      'detail': 'Extends Intent — the semantic marker for "select first"',
    },
    {
      'label': 'Constructor',
      'value': 'const AutocompleteFirstOptionIntent()',
      'detail': 'No parameters — it\'s a marker intent',
    },
    {
      'label': 'Base Class',
      'value': 'Intent',
      'detail': 'Part of Flutter\'s Actions & Shortcuts framework',
    },
    {
      'label': 'Dispatched By',
      'value': 'RawAutocomplete\'s keyboard handler',
      'detail': 'Triggered on ArrowDown when options are visible',
    },
    {
      'label': 'Handled By',
      'value': 'Internal CallbackAction',
      'detail': 'Registered by RawAutocomplete in its Actions widget',
    },
    {
      'label': 'Result',
      'value': 'Highlights first option',
      'detail': 'Updates the highlighted option index to 0',
    },
  ];

  print('  const instance: $firstOptionIntent');

  final apiWidgets = apiItems.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.cyan.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.cyan[700]!, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              item['label']!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.cyan[800],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['value']!,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  item['detail']!,
                  style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Autocomplete Intent Family
  // ============================================================
  print('=== Section 3: Autocomplete Intent Family ===');

  final intentFamily = <Map<String, dynamic>>[
    {
      'name': 'AutocompleteFirstOptionIntent',
      'purpose': 'Highlight the first option in the list',
      'trigger': 'ArrowDown (no selection), initial focus',
      'icon': Icons.first_page,
      'color': Colors.cyan,
      'highlighted': true,
    },
    {
      'name': 'AutocompleteNextOptionIntent',
      'purpose': 'Move highlight to the next option',
      'trigger': 'ArrowDown (with existing selection)',
      'icon': Icons.keyboard_arrow_down,
      'color': Colors.blue,
      'highlighted': false,
    },
    {
      'name': 'AutocompletePreviousOptionIntent',
      'purpose': 'Move highlight to the previous option',
      'trigger': 'ArrowUp',
      'icon': Icons.keyboard_arrow_up,
      'color': Colors.indigo,
      'highlighted': false,
    },
    {
      'name': 'AutocompleteHighlightedOptionIntent',
      'purpose': 'Select the currently highlighted option',
      'trigger': 'Enter key',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'highlighted': false,
    },
  ];

  print('  ${intentFamily.length} intents in family');

  final familyWidgets = intentFamily.map<Widget>((intent) {
    final isHighlighted = intent['highlighted'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isHighlighted
            ? (intent['color'] as Color).withOpacity(0.15)
            : (intent['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (intent['color'] as Color)
              .withOpacity(isHighlighted ? 0.5 : 0.2),
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: (intent['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(intent['icon'] as IconData,
                color: intent['color'] as Color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      intent['name'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: intent['color'] as Color,
                      ),
                    ),
                    if (isHighlighted) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'THIS DEMO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  intent['purpose'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
                Text(
                  'Trigger: ${intent['trigger']}',
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: RawAutocomplete Architecture
  // ============================================================
  print('=== Section 4: RawAutocomplete Architecture ===');

  final architectureComponents = <Map<String, dynamic>>[
    {
      'name': 'TextEditingController',
      'role': 'Holds the user\'s typed text. Notifies the autocomplete '
          'when the input changes so options can be filtered.',
      'icon': Icons.edit,
      'color': Colors.blue,
    },
    {
      'name': 'optionsBuilder',
      'role': 'A function that receives the TextEditingValue and returns '
          'an Iterable<T> of matching options.',
      'icon': Icons.filter_list,
      'color': Colors.green,
    },
    {
      'name': 'optionsViewBuilder',
      'role': 'Builds the dropdown UI showing the filtered options. '
          'Receives the options list, highlight callback, and selection callback.',
      'icon': Icons.view_list,
      'color': Colors.orange,
    },
    {
      'name': 'Actions Widget (internal)',
      'role': 'RawAutocomplete wraps its children in an Actions widget '
          'that registers handlers for all autocomplete intents. This '
          'enables keyboard navigation without extra setup.',
      'icon': Icons.keyboard,
      'color': Colors.purple,
    },
    {
      'name': 'Shortcuts Widget (internal)',
      'role': 'Maps physical keys (ArrowDown, ArrowUp, Enter) to '
          'the corresponding autocomplete intents.',
      'icon': Icons.shortcut,
      'color': Colors.red,
    },
    {
      'name': 'FocusNode',
      'role': 'Tracks focus state. The options dropdown appears when '
          'focused and disappears when focus is lost.',
      'icon': Icons.center_focus_strong,
      'color': Colors.teal,
    },
  ];

  final archWidgets = architectureComponents.map<Widget>((comp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (comp['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: comp['color'] as Color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (comp['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(comp['icon'] as IconData,
                color: comp['color'] as Color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comp['name'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: comp['color'] as Color,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  comp['role'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Live Autocomplete Widget Demo
  // ============================================================
  print('=== Section 5: Live Autocomplete Demo ===');

  // Build a live Autocomplete widget showing real functionality
  final sampleFruits = <String>[
    'Apple',
    'Apricot',
    'Avocado',
    'Banana',
    'Blueberry',
    'Cherry',
    'Cranberry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Guava',
    'Kiwi',
    'Lemon',
    'Lime',
    'Mango',
    'Melon',
    'Nectarine',
    'Orange',
    'Papaya',
    'Peach',
    'Pear',
    'Pineapple',
    'Plum',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];

  print('  ${sampleFruits.length} sample fruits for autocomplete');

  // The live autocomplete uses Autocomplete<String>
  final liveAutocomplete = Autocomplete<String>(
    optionsBuilder: (TextEditingValue textEditingValue) {
      if (textEditingValue.text.isEmpty) {
        return const Iterable<String>.empty();
      }
      return sampleFruits.where((fruit) => fruit
          .toLowerCase()
          .contains(textEditingValue.text.toLowerCase()));
    },
    fieldViewBuilder: (
      BuildContext context,
      TextEditingController textEditingController,
      FocusNode focusNode,
      VoidCallback onFieldSubmitted,
    ) {
      return TextField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: 'Search fruits...',
          hintText: 'Type to see suggestions',
          prefixIcon: Icon(Icons.search, color: Colors.cyan[700]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.cyan[700]!, width: 2),
          ),
        ),
        onSubmitted: (_) => onFieldSubmitted(),
      );
    },
  );

  // ============================================================
  // SECTION 6: Keyboard Navigation Flow
  // ============================================================
  print('=== Section 6: Keyboard Navigation Flow ===');

  final navSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'User Types',
      'detail': 'Text changes trigger optionsBuilder, which returns '
          'matching options. Dropdown appears with suggestions.',
      'key': 'a, b, c...',
      'icon': Icons.keyboard,
      'color': Colors.cyan[900]!,
    },
    {
      'step': '2',
      'label': 'ArrowDown (First Press)',
      'detail': 'AutocompleteFirstOptionIntent is dispatched. The '
          'first option in the list becomes highlighted.',
      'key': '↓',
      'icon': Icons.first_page,
      'color': Colors.cyan[700]!,
    },
    {
      'step': '3',
      'label': 'ArrowDown (Subsequent)',
      'detail': 'AutocompleteNextOptionIntent is dispatched. The '
          'highlight moves to the next option.',
      'key': '↓',
      'icon': Icons.keyboard_arrow_down,
      'color': Colors.cyan[600]!,
    },
    {
      'step': '4',
      'label': 'ArrowUp',
      'detail': 'AutocompletePreviousOptionIntent is dispatched. '
          'The highlight moves to the previous option.',
      'key': '↑',
      'icon': Icons.keyboard_arrow_up,
      'color': Colors.blue[600]!,
    },
    {
      'step': '5',
      'label': 'Enter',
      'detail': 'AutocompleteHighlightedOptionIntent is dispatched. '
          'The currently highlighted option is selected and the text '
          'field is updated with its value.',
      'key': '↵',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
    },
    {
      'step': '6',
      'label': 'Escape / Focus Lost',
      'detail': 'The dropdown closes. No intent is dispatched — '
          'this is handled by focus mechanics, not the intent system.',
      'key': 'Esc',
      'icon': Icons.close,
      'color': Colors.grey[600]!,
    },
  ];

  final navStepWidgets = navSteps.map<Widget>((step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: step['color'] as Color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step['step'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (step['color'] as Color).withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border(
                  left: BorderSide(
                    color: step['color'] as Color,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(step['icon'] as IconData,
                          size: 16, color: step['color'] as Color),
                      const SizedBox(width: 6),
                      Text(
                        step['label'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: step['color'] as Color,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey[400]!),
                        ),
                        child: Text(
                          step['key'] as String,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step['detail'] as String,
                    style: const TextStyle(fontSize: 12, height: 1.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Custom Action Override
  // ============================================================
  print('=== Section 7: Custom Action Override ===');

  final overrideExamples = <Map<String, dynamic>>[
    {
      'title': 'Logging / Analytics',
      'desc': 'Wrap the default action to log when the user starts '
          'keyboard navigation through autocomplete options.',
      'code': 'Actions(\n'
          '  actions: {\n'
          '    AutocompleteFirstOptionIntent:\n'
          '      CallbackAction<AutocompleteFirstOptionIntent>(\n'
          '        onInvoke: (intent) {\n'
          '          print("User began keyboard nav");\n'
          '          // Let default action handle it\n'
          '          return null;\n'
          '        },\n'
          '      ),\n'
          '  },\n'
          '  child: autocomplete,\n'
          ')',
      'icon': Icons.analytics,
      'color': Colors.cyan[700]!,
    },
    {
      'title': 'Skip Disabled Options',
      'desc': 'Override to skip the first option if it\'s marked as '
          'disabled, jumping to the next available option instead.',
      'code': '// Custom action that skips disabled items\n'
          'CallbackAction<AutocompleteFirstOptionIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    final firstEnabled = options\n'
          '      .firstWhere((o) => !o.isDisabled);\n'
          '    highlightOption(firstEnabled);\n'
          '    return null;\n'
          '  },\n'
          ')',
      'icon': Icons.skip_next,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Haptic Feedback',
      'desc': 'Add haptic feedback when the user enters keyboard '
          'navigation mode on mobile devices.',
      'code': 'CallbackAction<AutocompleteFirstOptionIntent>(\n'
          '  onInvoke: (intent) {\n'
          '    HapticFeedback.lightImpact();\n'
          '    // Invoke default behavior\n'
          '    Actions.maybeInvoke(\n'
          '      context, intent);\n'
          '    return null;\n'
          '  },\n'
          ')',
      'icon': Icons.vibration,
      'color': Colors.purple[700]!,
    },
  ];

  final overrideWidgets = overrideExamples.map<Widget>((example) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (example['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (example['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(example['icon'] as IconData,
                  color: example['color'] as Color, size: 20),
              const SizedBox(width: 8),
              Text(
                example['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: example['color'] as Color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            example['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              example['code'] as String,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Common Patterns and Pitfalls
  // ============================================================
  print('=== Section 8: Common Patterns and Pitfalls ===');

  final patternsAndPitfalls = <Map<String, dynamic>>[
    {
      'type': 'pattern',
      'title': 'Let RawAutocomplete handle navigation',
      'detail': 'Don\'t try to manually manage keyboard navigation. '
          'RawAutocomplete registers all autocomplete intents '
          'automatically. Just provide optionsBuilder and let it work.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Use Autocomplete for common cases',
      'detail': 'The Autocomplete widget wraps RawAutocomplete with '
          'reasonable defaults. Only use RawAutocomplete when you need '
          'full control over the field and options UI.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Debounce expensive optionsBuilder',
      'detail': 'If optionsBuilder calls an API, debounce the input. '
          'The intent system works independently — keyboard navigation '
          'uses the currently displayed options, not fresh fetches.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pitfall',
      'title': 'Don\'t confuse with ActivateIntent',
      'detail': 'AutocompleteFirstOptionIntent is specific to Autocomplete '
          'widgets. ActivateIntent is for generic button/widget activation. '
          'They\'re separate intent hierarchies.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Don\'t wrap Autocomplete in competing Actions',
      'detail': 'If you wrap Autocomplete in an Actions widget that '
          'handles the same intents, the outer one wins. The autocomplete '
          'keyboard navigation will stop working.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Ensure FocusNode is passed correctly',
      'detail': 'In RawAutocomplete, the focusNode must be attached to '
          'the TextField. If it\'s not, keyboard events won\'t reach '
          'the Shortcuts widget and intents won\'t fire.',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'type': 'pitfall',
      'title': 'Empty options list edge case',
      'detail': 'When optionsBuilder returns an empty list, '
          'AutocompleteFirstOptionIntent has nothing to highlight. '
          'The action still fires but has no visible effect.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
  ];

  final patternWidgets = patternsAndPitfalls.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (item['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: item['color'] as Color,
            width: 4,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item['icon'] as IconData,
              color: item['color'] as Color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (item['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (item['type'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: item['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: item['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Autocomplete intents', 'value': '${intentFamily.length}', 'icon': Icons.auto_awesome},
    {'label': 'Architecture components', 'value': '${architectureComponents.length}', 'icon': Icons.architecture},
    {'label': 'Navigation steps', 'value': '${navSteps.length}', 'icon': Icons.keyboard},
    {'label': 'Override examples', 'value': '${overrideExamples.length}', 'icon': Icons.build},
    {'label': 'Patterns & pitfalls', 'value': '${patternsAndPitfalls.length}', 'icon': Icons.lightbulb},
    {'label': 'Sample fruits', 'value': '${sampleFruits.length}', 'icon': Icons.local_grocery_store},
  ];

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.cyan.withOpacity(0.12),
              Colors.cyan.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.cyan[700], size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.cyan[800],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // Helper: Section header
  // ============================================================
  Widget acSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.cyan[800]!, Colors.cyan[400]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('AutocompleteFirstOptionIntent Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('AutocompleteFirstOptionIntent'),
      backgroundColor: Colors.cyan[800],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.cyan[800]!, Colors.cyan[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.first_page, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'AutocompleteFirstOptionIntent',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The Intent that tells an Autocomplete widget to highlight '
                  'its first suggestion. Part of Flutter\'s keyboard-accessible '
                  'autocomplete system, this intent initiates navigation through '
                  'the options list using the Actions & Shortcuts framework.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Section 1
          acSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          acSectionHeader('2', 'API Surface', Icons.code),
          ...apiWidgets,

          // Section 3
          acSectionHeader('3', 'Autocomplete Intent Family', Icons.family_restroom),
          ...familyWidgets,

          // Section 4
          acSectionHeader('4', 'RawAutocomplete Architecture', Icons.architecture),
          ...archWidgets,

          // Section 5
          acSectionHeader('5', 'Live Autocomplete Demo', Icons.play_circle),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Type in the search field below. Use ArrowDown to trigger '
              'AutocompleteFirstOptionIntent (highlights first match), '
              'then ArrowDown/Up to navigate, Enter to select:',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          Container(
            height: 250,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.cyan.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyan.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: liveAutocomplete,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Try: "ap" for Apple/Apricot, "be" for Blueberry, '
                    '"ch" for Cherry — then use arrow keys',
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),

          // Section 6
          acSectionHeader('6', 'Keyboard Navigation Flow', Icons.keyboard),
          ...navStepWidgets,

          // Section 7
          acSectionHeader('7', 'Custom Action Override', Icons.build),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.cyan.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'While RawAutocomplete handles intents automatically, you can '
              'wrap it in an Actions widget to override behavior:',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          ...overrideWidgets,

          // Section 8
          acSectionHeader('8', 'Patterns & Pitfalls', Icons.lightbulb_outline),
          ...patternWidgets,

          // Section 9
          acSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
