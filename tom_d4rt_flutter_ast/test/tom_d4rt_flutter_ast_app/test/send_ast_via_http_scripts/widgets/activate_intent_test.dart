// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ActivateIntent
// Demonstrates ActivateIntent, the Intent subclass that represents the
// semantic action "activate the currently focused widget". Covers the
// Intent/Action architecture, propagation through the widget tree, the
// family of built-in intents, custom intent creation, and practical
// composition patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ActivateIntent Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is ActivateIntent?
  // ============================================================
  print('=== Section 1: Concept — What is ActivateIntent? ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.send,
      'title': 'What is an Intent?',
      'body': 'In Flutter\'s action framework, an Intent is a '
          'lightweight, immutable object that describes *what* '
          'should happen without specifying *how*. Think of it as '
          'a command message: "please activate the focused widget". '
          'The Action system finds the right handler for the intent.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.touch_app,
      'title': 'ActivateIntent Specifically',
      'body': 'ActivateIntent is the built-in intent meaning '
          '"activate the currently focused widget". It\'s the intent '
          'generated when a user presses Enter or Space on a focused '
          'button, checkbox, switch, or any activatable widget. '
          'It\'s a const singleton — there are no parameters.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.architecture,
      'title': 'Why Separate Intent from Action?',
      'body': 'Separation of intent from action allows:\n'
          '• Multiple triggers for the same intent (keyboard, mouse, code)\n'
          '• Different actions at different tree locations for the same intent\n'
          '• Testable, composable interaction patterns\n'
          '• Clean accessibility: declare what, not how.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.key,
      'title': 'Const & Immutable',
      'body': 'ActivateIntent has a single const constructor and no '
          'fields. It\'s a pure marker class — its mere existence '
          'communicates the intent. It can be stored in const maps, '
          'reused across widgets, and compared by identity.',
      'accent': Colors.deepPurple,
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
  // SECTION 2: Type Hierarchy & API Surface
  // ============================================================
  print('=== Section 2: Type Hierarchy & API Surface ===');

  // ActivateIntent extends Intent
  // It's a const class with zero fields.
  const activateIntent = ActivateIntent();
  final intentRuntimeType = activateIntent.runtimeType.toString();
  print('  ActivateIntent runtimeType: $intentRuntimeType');

  final apiItems = <Map<String, String>>[
    {
      'label': 'Class',
      'value': 'ActivateIntent',
      'detail': 'Concrete, sealed Intent subclass',
    },
    {
      'label': 'Extends',
      'value': 'Intent',
      'detail': 'Base class for all intent objects',
    },
    {
      'label': 'Constructor',
      'value': 'const ActivateIntent()',
      'detail': 'No parameters — pure marker class',
    },
    {
      'label': 'Fields',
      'value': 'None',
      'detail': 'No state, no data, just a type marker',
    },
    {
      'label': 'Runtime Type',
      'value': intentRuntimeType,
      'detail': 'What runtimeType reports for the instance',
    },
    {
      'label': 'Usage Pattern',
      'value': 'const ActivateIntent()',
      'detail': 'Always use const — zero allocation overhead',
    },
  ];

  final apiWidgets = apiItems.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.teal, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              item['label']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.teal,
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
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
  // SECTION 3: Intent vs Action — Two Halves of the Framework
  // ============================================================
  print('=== Section 3: Intent vs Action ===');

  // Visual side-by-side comparison
  final intentSide = <Map<String, String>>[
    {'aspect': 'Role', 'value': 'Describes WHAT should happen'},
    {'aspect': 'Nature', 'value': 'Immutable data object'},
    {'aspect': 'Contains', 'value': 'Zero or few fields'},
    {'aspect': 'Created by', 'value': 'Shortcuts, programmatic code'},
    {'aspect': 'Lifecycle', 'value': 'Const singleton, never changes'},
    {'aspect': 'Example', 'value': 'ActivateIntent, DismissIntent'},
  ];
  final actionSide = <Map<String, String>>[
    {'aspect': 'Role', 'value': 'Implements HOW to do it'},
    {'aspect': 'Nature', 'value': 'Stateful handler object'},
    {'aspect': 'Contains', 'value': 'invoke() method, state'},
    {'aspect': 'Created by', 'value': 'Actions widget, widget internals'},
    {'aspect': 'Lifecycle', 'value': 'Created per scope, may hold state'},
    {'aspect': 'Example', 'value': 'ActivateAction, DismissAction'},
  ];

  print('  Comparison: ${intentSide.length} aspects');

  // Build the two-column visual
  final comparisonWidget = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.teal.withOpacity(0.2)),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.teal[800],
          ),
          child: Row(
            children: [
              SizedBox(
                width: 70,
                child: Text('Aspect',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
              Expanded(
                child: Text('Intent (What)',
                    style: TextStyle(
                        color: Colors.teal[100],
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
              Expanded(
                child: Text('Action (How)',
                    style: TextStyle(
                        color: Colors.orange[100],
                        fontWeight: FontWeight.bold,
                        fontSize: 12)),
              ),
            ],
          ),
        ),
        // Rows
        ...List.generate(intentSide.length, (i) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: i.isEven
                  ? Colors.teal.withOpacity(0.04)
                  : Colors.teal.withOpacity(0.09),
              border: Border(
                bottom: BorderSide(color: Colors.teal.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: Text(intentSide[i]['aspect']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 11)),
                ),
                Expanded(
                  child: Text(intentSide[i]['value']!,
                      style: TextStyle(
                          fontSize: 11, color: Colors.teal[700])),
                ),
                Expanded(
                  child: Text(actionSide[i]['value']!,
                      style: TextStyle(
                          fontSize: 11, color: Colors.orange[800])),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Propagation — How ActivateIntent Travels
  // ============================================================
  print('=== Section 4: ActivateIntent Propagation ===');

  final propagationSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Trigger',
      'detail': 'User presses Enter or Space; or code calls '
          'Actions.invoke(context, const ActivateIntent())',
      'icon': Icons.keyboard,
      'color': Colors.teal[900]!,
    },
    {
      'step': '2',
      'label': 'Shortcuts Match',
      'detail': 'The nearest Shortcuts widget (typically from WidgetsApp) '
          'maps the key event to ActivateIntent',
      'icon': Icons.shortcut,
      'color': Colors.teal[700]!,
    },
    {
      'step': '3',
      'label': 'Tree Walk Up',
      'detail': 'Flutter walks up from the focused widget through '
          'all Actions ancestors looking for one that handles '
          'ActivateIntent',
      'icon': Icons.arrow_upward,
      'color': Colors.teal[600]!,
    },
    {
      'step': '4',
      'label': 'Action Found',
      'detail': 'The nearest Actions widget whose map contains '
          'ActivateIntent provides the Action handler',
      'icon': Icons.check_circle,
      'color': Colors.teal[500]!,
    },
    {
      'step': '5',
      'label': 'isEnabled Check',
      'detail': 'The framework calls action.isEnabled(intent) — '
          'if false, the intent is ignored and bubbles further up',
      'icon': Icons.verified,
      'color': Colors.teal[400]!,
    },
    {
      'step': '6',
      'label': 'invoke()',
      'detail': 'action.invoke(intent) is called. For buttons this '
          'triggers onPressed; for checkboxes it toggles the value',
      'icon': Icons.play_arrow,
      'color': Colors.green[600]!,
    },
    {
      'step': '7',
      'label': 'Result',
      'detail': 'invoke() returns an Object? result (often null). '
          'The widget updates its visual state accordingly',
      'icon': Icons.done_all,
      'color': Colors.green[400]!,
    },
  ];

  print('  Propagation: ${propagationSteps.length} steps');

  final propagationWidgets = propagationSteps.map<Widget>((step) {
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
                    ],
                  ),
                  const SizedBox(height: 3),
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
  // SECTION 5: The Built-In Intent Family
  // ============================================================
  print('=== Section 5: Built-In Intent Family ===');

  // Catalog of the most important intents that ship with Flutter
  final intentFamily = <Map<String, dynamic>>[
    {
      'name': 'ActivateIntent',
      'purpose': 'Activate the focused widget (Enter/Space)',
      'icon': Icons.touch_app,
      'color': Colors.teal,
      'highlight': true,
    },
    {
      'name': 'ButtonActivateIntent',
      'purpose': 'Activate specifically for button widgets (Enter key only)',
      'icon': Icons.smart_button,
      'color': Colors.blue,
      'highlight': false,
    },
    {
      'name': 'DismissIntent',
      'purpose': 'Dismiss/close the focused element (Escape key)',
      'icon': Icons.close,
      'color': Colors.red,
      'highlight': false,
    },
    {
      'name': 'ScrollIntent',
      'purpose': 'Scroll a scrollable in a direction by some amount',
      'icon': Icons.swap_vert,
      'color': Colors.orange,
      'highlight': false,
    },
    {
      'name': 'DirectionalFocusIntent',
      'purpose': 'Move focus in a direction (arrow keys)',
      'icon': Icons.open_with,
      'color': Colors.purple,
      'highlight': false,
    },
    {
      'name': 'NextFocusIntent',
      'purpose': 'Move focus to next widget (Tab key)',
      'icon': Icons.arrow_forward,
      'color': Colors.green,
      'highlight': false,
    },
    {
      'name': 'PreviousFocusIntent',
      'purpose': 'Move focus to previous widget (Shift+Tab)',
      'icon': Icons.arrow_back,
      'color': Colors.brown,
      'highlight': false,
    },
    {
      'name': 'SelectAllTextIntent',
      'purpose': 'Select all text in a text field (Ctrl+A)',
      'icon': Icons.select_all,
      'color': Colors.cyan,
      'highlight': false,
    },
    {
      'name': 'CopySelectionTextIntent',
      'purpose': 'Copy selected text to clipboard (Ctrl+C)',
      'icon': Icons.content_copy,
      'color': Colors.indigo,
      'highlight': false,
    },
    {
      'name': 'PasteTextIntent',
      'purpose': 'Paste clipboard text into a field (Ctrl+V)',
      'icon': Icons.content_paste,
      'color': Colors.pink,
      'highlight': false,
    },
    {
      'name': 'UndoTextIntent',
      'purpose': 'Undo last text edit (Ctrl+Z)',
      'icon': Icons.undo,
      'color': Colors.amber,
      'highlight': false,
    },
    {
      'name': 'RedoTextIntent',
      'purpose': 'Redo undone text edit (Ctrl+Shift+Z)',
      'icon': Icons.redo,
      'color': Colors.lime[700]!,
      'highlight': false,
    },
  ];

  print('  Catalogued ${intentFamily.length} built-in intents');

  final intentFamilyWidgets = intentFamily.map<Widget>((intent) {
    final isHighlighted = intent['highlight'] as bool;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: isHighlighted
            ? (intent['color'] as Color).withOpacity(0.15)
            : (intent['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: (intent['color'] as Color).withOpacity(isHighlighted ? 0.5 : 0.2),
          width: isHighlighted ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (intent['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(intent['icon'] as IconData,
                color: intent['color'] as Color, size: 20),
          ),
          const SizedBox(width: 10),
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
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.teal,
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
                const SizedBox(height: 2),
                Text(
                  intent['purpose'] as String,
                  style: const TextStyle(fontSize: 11, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: Custom Intents — When to Subclass
  // ============================================================
  print('=== Section 6: Custom Intents ===');

  final customIntentPatterns = <Map<String, dynamic>>[
    {
      'title': 'Marker Intent (No Data)',
      'code': 'class SaveDocumentIntent extends Intent {\n'
          '  const SaveDocumentIntent();\n'
          '}',
      'explanation': 'Like ActivateIntent — a pure signal with no payload. '
          'Use when the intent meaning is fully captured by its type.',
      'color': Colors.teal,
      'icon': Icons.flag,
    },
    {
      'title': 'Parameterized Intent',
      'code': 'class NavigateIntent extends Intent {\n'
          '  const NavigateIntent(this.route);\n'
          '  final String route;\n'
          '}',
      'explanation': 'Carries data the Action needs. Use when the same Action '
          'type should behave differently based on parameters.',
      'color': Colors.blue,
      'icon': Icons.data_object,
    },
    {
      'title': 'Reuse ActivateIntent',
      'code': '// Don\'t subclass — just map ActivateIntent\n'
          '// to your own Action in the Actions widget.\n'
          'Actions(\n'
          '  actions: {\n'
          '    ActivateIntent: MyActivateAction(),\n'
          '  },\n'
          '  child: ...\n'
          ')',
      'explanation': 'When you want to customize what activation does in a '
          'subtree, override the Action, not the Intent. ActivateIntent '
          'is already well-known to Flutter\'s accessibility system.',
      'color': Colors.green,
      'icon': Icons.recycling,
    },
    {
      'title': 'Domain-Specific Intent',
      'code': 'class AddToCartIntent extends Intent {\n'
          '  const AddToCartIntent(this.productId, this.quantity);\n'
          '  final String productId;\n'
          '  final int quantity;\n'
          '}',
      'explanation': 'Model your app\'s domain actions as intents for '
          'clean separation of concerns. Map them to actions in an '
          'Actions widget near the relevant part of the tree.',
      'color': Colors.orange,
      'icon': Icons.shopping_cart,
    },
  ];

  print('  ${customIntentPatterns.length} custom intent patterns');

  final customIntentWidgets = customIntentPatterns.map<Widget>((pattern) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (pattern['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (pattern['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(pattern['icon'] as IconData,
                  color: pattern['color'] as Color, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pattern['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: pattern['color'] as Color,
                  ),
                ),
              ),
            ],
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
              pattern['code'] as String,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            pattern['explanation'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Live Actions Widget with ActivateIntent
  // ============================================================
  print('=== Section 7: Live Actions Widget Demo ===');

  // Three different visual regions, each with their own Actions scope
  // mapping ActivateIntent to different behaviors.
  final liveActionsDemo = Column(
    children: [
      // Region 1: Default behavior
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.teal.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('Scope A',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11)),
                ),
                const SizedBox(width: 8),
                const Text('Default activation',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => print('  → Scope A: button pressed normally'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Standard ActivateIntent'),
            ),
          ],
        ),
      ),
      // Region 2: Custom override — logs activation
      Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              print('  → Scope B: custom logging activation!');
              return null;
            },
          ),
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Scope B',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  const SizedBox(width: 8),
                  const Text('Custom logging override',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => print('  → Scope B: direct tap'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Logged ActivateIntent'),
              ),
              const SizedBox(height: 4),
              Text(
                'ActivateIntent here routes to a custom '
                'CallbackAction that logs before executing.',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
      // Region 3: Gated — blocks activation
      Actions(
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              print('  → Scope C: activation blocked by gate!');
              return null;
            },
          ),
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.06),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('Scope C',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11)),
                  ),
                  const SizedBox(width: 8),
                  const Text('Gated activation',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => print('  → Scope C: direct tap'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Gated ActivateIntent'),
              ),
              const SizedBox(height: 4),
              Text(
                'ActivateIntent here routes to a gate action that '
                'blocks activation and logs the attempt.',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 8: Intent Composition — Multiple Intents in One Scope
  // ============================================================
  print('=== Section 8: Intent Composition Patterns ===');

  // Demonstrate how multiple intents coexist in one Actions widget.
  final compositionWidget = Actions(
    actions: <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          print('  → Composition: ActivateIntent handled');
          return null;
        },
      ),
      DismissIntent: CallbackAction<DismissIntent>(
        onInvoke: (intent) {
          print('  → Composition: DismissIntent handled');
          return null;
        },
      ),
      ScrollIntent: CallbackAction<ScrollIntent>(
        onInvoke: (intent) {
          print('  → Composition: ScrollIntent handled');
          return null;
        },
      ),
    },
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Multi-Intent Actions Scope',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          // Intent cards
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.touch_app, color: Colors.teal, size: 18),
                const SizedBox(width: 6),
                const Text('ActivateIntent → Custom handler',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.close, color: Colors.red, size: 18),
                const SizedBox(width: 6),
                const Text('DismissIntent → Custom handler',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.08),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.swap_vert, color: Colors.orange, size: 18),
                const SizedBox(width: 6),
                const Text('ScrollIntent → Custom handler',
                    style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'A single Actions widget can map multiple intent types to '
            'different actions. Each intent type has its own handler. '
            'Intents that aren\'t mapped here bubble up to ancestor '
            'Actions widgets.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => print('  → Activate button pressed'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('Activate', style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () => print('  → Dismiss button pressed'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                child: const Text('Dismiss', style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 9: Common Pitfalls with Intents
  // ============================================================
  print('=== Section 9: Common Pitfalls ===');

  final pitfalls = <Map<String, dynamic>>[
    {
      'title': 'Creating Custom Intent When Built-In Exists',
      'severity': 'Warning',
      'sevColor': Colors.orange,
      'detail': 'Don\'t create MyActivateIntent when ActivateIntent already '
          'exists. The framework and accessibility tools know about '
          'ActivateIntent. Custom intents won\'t trigger from default '
          'keyboard shortcuts.',
      'icon': Icons.warning,
    },
    {
      'title': 'Forgetting const on Intent Constructors',
      'severity': 'Info',
      'sevColor': Colors.blue,
      'detail': 'Intent subclasses should have const constructors. Without '
          'const, you allocate a new object every time a shortcut fires. '
          'Use "const ActivateIntent()" not "ActivateIntent()".',
      'icon': Icons.info,
    },
    {
      'title': 'Not Registering Action for Intent',
      'severity': 'Error',
      'sevColor': Colors.red,
      'detail': 'If you dispatch an ActivateIntent but no ancestor Actions '
          'widget has a handler for it, the intent is silently ignored. '
          'This is common when building custom widget trees without '
          'WidgetsApp.',
      'icon': Icons.error,
    },
    {
      'title': 'Overriding Intent Type Equality',
      'severity': 'Warning',
      'sevColor': Colors.orange,
      'detail': 'Intent lookup is by runtimeType, not by value equality. '
          'Don\'t override operator== on intents expecting it to '
          'change dispatch behavior — it won\'t. Each Intent subclass '
          'type is a unique key.',
      'icon': Icons.warning,
    },
    {
      'title': 'Heavy Logic in Intent',
      'severity': 'Anti-pattern',
      'sevColor': Colors.red,
      'detail': 'Intents should be lightweight data objects. Put logic '
          'in the Action, not the Intent. Intents describe what, '
          'Actions do what.',
      'icon': Icons.do_not_disturb,
    },
  ];

  print('  ${pitfalls.length} pitfalls documented');

  final pitfallWidgets = pitfalls.map<Widget>((pitfall) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (pitfall['sevColor'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (pitfall['sevColor'] as Color).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(pitfall['icon'] as IconData,
                  color: pitfall['sevColor'] as Color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  pitfall['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: pitfall['sevColor'] as Color,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: pitfall['sevColor'] as Color,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  pitfall['severity'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            pitfall['detail'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 10: Summary Dashboard
  // ============================================================
  print('=== Section 10: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Propagation steps', 'value': '${propagationSteps.length}', 'icon': Icons.route},
    {'label': 'Built-in intents', 'value': '${intentFamily.length}', 'icon': Icons.category},
    {'label': 'Custom patterns', 'value': '${customIntentPatterns.length}', 'icon': Icons.build},
    {'label': 'Action scopes shown', 'value': '3', 'icon': Icons.layers},
    {'label': 'Pitfalls documented', 'value': '${pitfalls.length}', 'icon': Icons.warning},
    {'label': 'API properties', 'value': '${apiItems.length}', 'icon': Icons.code},
  ];

  print('  Summary: ${summaryItems.length} metrics');

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
              Colors.teal.withOpacity(0.12),
              Colors.teal.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.teal.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.teal, size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
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
  Widget sectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[700]!, Colors.teal[400]!],
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

  print('ActivateIntent Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('ActivateIntent Deep Demo'),
      backgroundColor: Colors.teal[700],
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
                colors: [Colors.teal[700]!, Colors.teal[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.send, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'ActivateIntent',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The semantic intent that means "activate the currently '
                  'focused widget" — the bridge between keyboard input and '
                  'the Actions framework.',
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
          sectionHeader('1', 'What is ActivateIntent?', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          sectionHeader('2', 'Type Hierarchy & API', Icons.account_tree),
          ...apiWidgets,

          // Section 3
          sectionHeader('3', 'Intent vs Action', Icons.compare_arrows),
          comparisonWidget,

          // Section 4
          sectionHeader('4', 'How ActivateIntent Propagates', Icons.route),
          ...propagationWidgets,

          // Section 5
          sectionHeader('5', 'Built-In Intent Family', Icons.category),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Flutter ships with many built-in Intent subclasses. '
              'ActivateIntent is highlighted — it\'s the focus of this demo:',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          ...intentFamilyWidgets,

          // Section 6
          sectionHeader('6', 'Custom Intents', Icons.build),
          ...customIntentWidgets,

          // Section 7
          sectionHeader('7', 'Live Actions Widget Demo', Icons.play_circle),
          liveActionsDemo,

          // Section 8
          sectionHeader('8', 'Intent Composition', Icons.layers),
          compositionWidget,

          // Section 9
          sectionHeader('9', 'Common Pitfalls', Icons.report_problem),
          ...pitfallWidgets,

          // Section 10
          sectionHeader('10', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
