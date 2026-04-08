// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ActivateAction
// Demonstrates ActivateAction, the built-in Flutter Action that handles
// ActivateIntent — the intent dispatched when a user presses Enter or Space
// on a focused widget. Covers the Actions/Intents/Shortcuts chain, default
// activation paths for standard widgets, custom overrides, focus traversal,
// and the relationship between ActivateAction and ButtonActivateIntent.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ActivateAction Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is ActivateAction?
  // ============================================================
  print('=== Section 1: Concept — What is ActivateAction? ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'What is ActivateAction?',
      'body': 'ActivateAction is the built-in Action<ActivateIntent> '
          'that Flutter registers globally. When a user presses '
          'Enter or Space on a focused widget (or triggers '
          'ActivateIntent programmatically), ActivateAction '
          'is invoked to "activate" the widget — the exact '
          'same effect as tapping it.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.keyboard,
      'title': 'Keyboard Accessibility',
      'body': 'ActivateAction is a cornerstone of keyboard '
          'accessibility in Flutter. Without it, users who '
          'navigate via Tab/Shift+Tab could focus buttons '
          'but never press them. ActivateAction bridges '
          'keyboard focus and widget interaction.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Actions / Intents / Shortcuts',
      'body': 'Flutter\'s action system has three layers:\n'
          '• Shortcuts — map key combos to Intents\n'
          '• Intents — describe what should happen\n'
          '• Actions — implement the behavior\n'
          'ActivateAction is the Action; ActivateIntent is '
          'the Intent; the Shortcuts widget maps Enter/Space '
          'to ActivateIntent.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.layers,
      'title': 'Scope & Override',
      'body': 'Like all Actions, ActivateAction can be overridden '
          'at any point in the widget tree by wrapping a subtree '
          'in an Actions widget that maps ActivateIntent to your '
          'own custom Action. This lets you intercept activations '
          'for logging, analytics, or conditional gating.',
      'accent': Colors.teal,
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

  // ActivateAction extends Action<ActivateIntent>
  // Key method: invoke(ActivateIntent intent)
  // isEnabled is inherited from Action
  // ActivateAction is abstract — concrete subclasses are provided by widgets
  // that handle activation (buttons, checkboxes, etc.). We demonstrate via
  // CallbackAction<ActivateIntent> which is the common concrete path.
  final concreteActivateAction = CallbackAction<ActivateIntent>(
    onInvoke: (intent) {
      print('  → Concrete ActivateAction invoked!');
      return null;
    },
  );
  final activateActionType = concreteActivateAction.runtimeType.toString();
  final intentType = concreteActivateAction.intentType.toString();

  print('  Concrete action runtimeType: $activateActionType');
  print('  Action.intentType: $intentType');

  final hierarchyItems = <Map<String, String>>[
    {
      'label': 'Class',
      'value': activateActionType,
      'detail': 'Concrete Action for activation',
    },
    {
      'label': 'Extends',
      'value': 'Action<ActivateIntent>',
      'detail': 'Generic Action bound to ActivateIntent',
    },
    {
      'label': 'Intent Type',
      'value': intentType,
      'detail': 'The intent this action responds to',
    },
    {
      'label': 'Key Method',
      'value': 'invoke(ActivateIntent)',
      'detail': 'Performs the activation logic',
    },
    {
      'label': 'isEnabled',
      'value': 'Inherited from Action',
      'detail': 'Returns true if the action can be invoked',
    },
    {
      'label': 'callingAction',
      'value': 'Inherited from Action',
      'detail': 'If non-null, the action that invoked this one',
    },
  ];

  final hierarchyWidgets = hierarchyItems.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.indigo, width: 4),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              item['label']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.indigo,
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
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Default Activation — How Flutter Uses It Internally
  // ============================================================
  print('=== Section 3: Default Activation Paths ===');

  // Flutter internally maps Enter/Space -> ActivateIntent for many widgets.
  // Buttons, switches, checkboxes, radio buttons, dropdown items, etc.
  final defaultActivationPaths = <Map<String, dynamic>>[
    {
      'widget': 'ElevatedButton',
      'icon': Icons.smart_button,
      'description': 'Pressing Enter/Space while focused triggers '
          'onPressed callback via ActivateAction',
      'color': Colors.blue,
    },
    {
      'widget': 'TextButton',
      'icon': Icons.text_fields,
      'description': 'Same activation path — ActivateIntent dispatched '
          'when button has keyboard focus',
      'color': Colors.green,
    },
    {
      'widget': 'IconButton',
      'icon': Icons.radio_button_checked,
      'description': 'IconButton registers its own action handler that '
          'responds to ActivateIntent',
      'color': Colors.orange,
    },
    {
      'widget': 'Checkbox',
      'icon': Icons.check_box,
      'description': 'Toggle state is triggered by ActivateAction '
          'when the checkbox has focus',
      'color': Colors.purple,
    },
    {
      'widget': 'Switch',
      'icon': Icons.toggle_on,
      'description': 'Switch responds to ActivateIntent to toggle '
          'its on/off state via keyboard',
      'color': Colors.teal,
    },
    {
      'widget': 'Radio',
      'icon': Icons.radio_button_on,
      'description': 'Radio selection changes on ActivateAction when '
          'the radio button has keyboard focus',
      'color': Colors.red,
    },
    {
      'widget': 'PopupMenuButton',
      'icon': Icons.more_vert,
      'description': 'Opens the popup menu overlay when activated '
          'via keyboard with ActivateIntent',
      'color': Colors.amber,
    },
    {
      'widget': 'InkWell / GestureDetector',
      'icon': Icons.touch_app,
      'description': 'When wrapped in Focus, can respond to activation '
          'via keyboard Enter/Space',
      'color': Colors.cyan,
    },
  ];

  print('  Documented ${defaultActivationPaths.length} activation paths');

  final activationPathWidgets = defaultActivationPaths.map<Widget>((path) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (path['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (path['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (path['color'] as Color).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(path['icon'] as IconData,
                color: path['color'] as Color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  path['widget'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: path['color'] as Color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  path['description'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: Live Activation Demo — Focusable Widgets
  // ============================================================
  print('=== Section 4: Live Activation Demo ===');

  // Build a set of real focusable widgets.
  // In the interpreter they display; in a running app they respond to keyboard.
  final liveButtons = <Widget>[
    ElevatedButton(
      onPressed: () {
        print('  → ElevatedButton activated!');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text('Activate Me (ElevatedButton)'),
    ),
    const SizedBox(height: 8),
    OutlinedButton(
      onPressed: () {
        print('  → OutlinedButton activated!');
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.indigo,
        side: const BorderSide(color: Colors.indigo),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text('Activate Me (OutlinedButton)'),
    ),
    const SizedBox(height: 8),
    TextButton(
      onPressed: () {
        print('  → TextButton activated!');
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text('Activate Me (TextButton)'),
    ),
    const SizedBox(height: 8),
    FilledButton(
      onPressed: () {
        print('  → FilledButton activated!');
      },
      style: FilledButton.styleFrom(
        backgroundColor: Colors.indigo[700],
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text('Activate Me (FilledButton)'),
    ),
    const SizedBox(height: 8),
    FilledButton.tonal(
      onPressed: () {
        print('  → FilledButton.tonal activated!');
      },
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text('Activate Me (FilledButton.tonal)'),
    ),
  ];

  print('  Created ${liveButtons.where((w) => w is! SizedBox).length} live buttons for activation demo');

  // ============================================================
  // SECTION 5: Custom ActivateAction Override
  // ============================================================
  print('=== Section 5: Custom Override ===');

  // Demonstrate wrapping a subtree with a custom ActivateAction.
  // This pattern is used for logging, analytics, gating, etc.
  final customOverrideCode =
      'Actions(\n'
      '  dispatcher: ActionDispatcher(),\n'
      '  actions: <Type, Action<Intent>>{\n'
      '    ActivateIntent: CallbackAction<ActivateIntent>(\n'
      '      onInvoke: (intent) {\n'
      '        print(\'Custom activate!\');\n'
      '        return null;\n'
      '      },\n'
      '    ),\n'
      '  },\n'
      '  child: ElevatedButton(\n'
      '    onPressed: () => print(\'tap\'),\n'
      '    child: Text(\'Custom-Activated\'),\n'
      '  ),\n'
      ')';

  final overrideUseCases = <Map<String, dynamic>>[
    {
      'title': 'Logging Activation',
      'detail': 'Wrap your app in an Actions widget that maps '
          'ActivateIntent to a custom action which logs every '
          'activation event before delegating to the default behavior.',
      'icon': Icons.description,
      'color': Colors.blue,
    },
    {
      'title': 'Permission Gating',
      'detail': 'Override ActivateAction to check whether the user has '
          'permission to perform the activation. If not, show a '
          'snackbar or dialog instead of performing the action.',
      'icon': Icons.lock,
      'color': Colors.red,
    },
    {
      'title': 'Analytics Tracking',
      'detail': 'Every keyboard-driven activation passes through '
          'ActivateAction, so a global override is a single point '
          'to capture analytics for keyboard accessibility usage.',
      'icon': Icons.analytics,
      'color': Colors.green,
    },
    {
      'title': 'Undo/Redo Integration',
      'detail': 'Capture the activation event and push it onto an '
          'undo stack before performing the action, enabling '
          'undo support for keyboard activations.',
      'icon': Icons.undo,
      'color': Colors.orange,
    },
  ];

  print('  Prepared ${overrideUseCases.length} override use cases');

  final overrideWidgets = overrideUseCases.map<Widget>((uc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (uc['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (uc['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(uc['icon'] as IconData, color: uc['color'] as Color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  uc['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: uc['color'] as Color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  uc['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // Live custom override demo with Actions widget
  final customOverrideWidget = Actions(
    actions: <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (ActivateIntent intent) {
          print('  → Custom ActivateAction override invoked!');
          return null;
        },
      ),
    },
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.amber, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'This subtree has a custom ActivateAction override. '
                  'Keyboard activation here logs to console instead of '
                  'default button activation.',
                  style: TextStyle(
                      fontSize: 12, color: Colors.amber[800], height: 1.3),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            print('  → Button tapped (direct press)');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[700],
            foregroundColor: Colors.white,
          ),
          child: const Text('Button Under Custom ActivateAction'),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Keyboard Shortcut → ActivateIntent Chain
  // ============================================================
  print('=== Section 6: Keyboard Shortcut Chain ===');

  // The chain is: Key press → Shortcuts widget → ActivateIntent → Actions → ActivateAction → invoke()
  final chainSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Key Press Event',
      'detail': 'User presses Enter or Space while a widget has focus',
      'icon': Icons.keyboard_alt,
      'color': Colors.indigo[900]!,
    },
    {
      'step': '2',
      'label': 'Shortcuts Widget',
      'detail': 'WidgetsApp registers default shortcuts mapping '
          'Enter and Space to ActivateIntent',
      'icon': Icons.route,
      'color': Colors.indigo[700]!,
    },
    {
      'step': '3',
      'label': 'ActivateIntent Created',
      'detail': 'The Shortcuts widget creates an ActivateIntent '
          'instance and dispatches it',
      'icon': Icons.send,
      'color': Colors.indigo[600]!,
    },
    {
      'step': '4',
      'label': 'Actions Widget Lookup',
      'detail': 'Flutter walks up the widget tree looking for an '
          'Actions widget with a handler for ActivateIntent',
      'icon': Icons.search,
      'color': Colors.indigo[500]!,
    },
    {
      'step': '5',
      'label': 'ActivateAction Found',
      'detail': 'The nearest Actions widget that maps ActivateIntent '
          'provides the ActivateAction (or a custom override)',
      'icon': Icons.check_circle_outline,
      'color': Colors.indigo[400]!,
    },
    {
      'step': '6',
      'label': 'invoke() Called',
      'detail': 'ActivateAction.invoke(intent) is called, which '
          'activates the focused widget (same as tapping it)',
      'icon': Icons.play_circle_fill,
      'color': Colors.green[600]!,
    },
  ];

  print('  Shortcut chain: ${chainSteps.length} steps');

  final chainWidgets = chainSteps.map<Widget>((step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
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
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
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
  // SECTION 7: ActivateAction vs ButtonActivateIntent
  // ============================================================
  print('=== Section 7: ActivateAction vs ButtonActivateIntent ===');

  // ButtonActivateIntent is a separate intent specifically for button-like
  // elements, while ActivateIntent is more general (also covers checkboxes,
  // switches, etc.)
  final comparisonRows = <Map<String, String>>[
    {
      'aspect': 'Intent Class',
      'activate': 'ActivateIntent',
      'button': 'ButtonActivateIntent',
    },
    {
      'aspect': 'Action Class',
      'activate': 'ActivateAction',
      'button': 'ButtonActivateAction',
    },
    {
      'aspect': 'Default Trigger',
      'activate': 'Enter or Space key',
      'button': 'Enter key only',
    },
    {
      'aspect': 'Scope',
      'activate': 'All focusable widgets',
      'button': 'Button-like widgets only',
    },
    {
      'aspect': 'Typical Use',
      'activate': 'Checkboxes, switches, radio, buttons, custom',
      'button': 'MaterialButton, IconButton, etc.',
    },
    {
      'aspect': 'Registration',
      'activate': 'WidgetsApp global shortcuts',
      'button': 'Material-level widgets',
    },
  ];

  print('  Comparison: ${comparisonRows.length} aspects');

  // Build comparison table header
  final comparisonHeader = Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.indigo[800],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text('Aspect',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        Expanded(
          child: Text('ActivateAction',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
        Expanded(
          child: Text('ButtonActivate',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        ),
      ],
    ),
  );

  final comparisonRowWidgets =
      comparisonRows.asMap().entries.map<Widget>((entry) {
    final idx = entry.key;
    final row = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: idx.isEven
            ? Colors.indigo.withOpacity(0.04)
            : Colors.indigo.withOpacity(0.09),
        border: Border(
          bottom: BorderSide(color: Colors.indigo.withOpacity(0.1)),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(row['aspect']!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 12)),
          ),
          Expanded(
            child: Text(row['activate']!,
                style: const TextStyle(fontSize: 12)),
          ),
          Expanded(
            child: Text(row['button']!,
                style: const TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Multi-Widget Activation Showcase
  // ============================================================
  print('=== Section 8: Multi-Widget Activation Showcase ===');

  // A gallery showing many widget types that respond to ActivateAction.
  // Each widget card shows the widget itself and a note about how it
  // handles activation.

  final activationShowcase = <Map<String, dynamic>>[
    {
      'name': 'ElevatedButton',
      'widget': ElevatedButton(
        onPressed: () => print('  → ElevatedButton activated'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        child: const Text('Elevated'),
      ),
      'note': 'onPressed fires on Enter/Space via ActivateAction',
    },
    {
      'name': 'Checkbox',
      'widget': Checkbox(
        value: true,
        onChanged: (v) => print('  → Checkbox toggled: $v'),
      ),
      'note': 'Toggles checked state on keyboard activation',
    },
    {
      'name': 'Switch',
      'widget': Switch(
        value: false,
        onChanged: (v) => print('  → Switch toggled: $v'),
      ),
      'note': 'Flips on/off when activated via keyboard',
    },
    {
      'name': 'Radio',
      'widget': Radio<int>(
        value: 1,
        groupValue: 0,
        onChanged: (v) => print('  → Radio selected: $v'),
      ),
      'note': 'Selected when focused and activated by keyboard',
    },
    {
      'name': 'IconButton',
      'widget': IconButton(
        icon: const Icon(Icons.star, color: Colors.amber),
        onPressed: () => print('  → IconButton activated'),
      ),
      'note': 'onPressed fires for keyboard-focused activation',
    },
    {
      'name': 'FloatingActionButton',
      'widget': FloatingActionButton.small(
        onPressed: () => print('  → FAB activated'),
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      'note': 'Mini FAB responds to ActivateIntent when focused',
    },
    {
      'name': 'Chip (ActionChip)',
      'widget': ActionChip(
        label: const Text('Action'),
        avatar: const Icon(Icons.bolt, size: 16),
        onPressed: () => print('  → ActionChip activated'),
      ),
      'note': 'Chips respond to keyboard activation when focused',
    },
    {
      'name': 'InkWell',
      'widget': InkWell(
        onTap: () => print('  → InkWell activated'),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text('InkWell', style: TextStyle(fontSize: 13)),
        ),
      ),
      'note': 'onTap fires when activated via keyboard focus',
    },
  ];

  print('  Prepared ${activationShowcase.length} showcase widgets');

  final showcaseWidgets = activationShowcase.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 8),
                item['widget'] as Widget,
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.04),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                item['note'] as String,
                style: TextStyle(
                    fontSize: 11, color: Colors.grey[700], height: 1.3),
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Disabled ActivateAction & isActionEnabled
  // ============================================================
  print('=== Section 9: Disabled ActivateAction ===');

  // When a button's onPressed is null, the widget is disabled.
  // ActivateAction checks isEnabled before invoking.
  // Additionally, Action.isActionEnabled on the Actions widget lets you
  // query whether an action is available.

  final disabledScenarios = <Map<String, dynamic>>[
    {
      'title': 'Null onPressed',
      'description': 'When a button\'s onPressed is null, the button '
          'is disabled. ActivateAction will not invoke because '
          'the underlying widget reports isEnabled = false.',
      'color': Colors.grey,
      'icon': Icons.block,
      'widget': ElevatedButton(
        onPressed: null,
        child: const Text('Disabled Button'),
      ),
    },
    {
      'title': 'Custom isEnabled Override',
      'description': 'You can subclass Action<ActivateIntent> and override '
          'isEnabled(covariant ActivateIntent intent) to '
          'conditionally gate activation based on app state.',
      'color': Colors.orange,
      'icon': Icons.tune,
      'widget': Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.orange.withOpacity(0.3)),
        ),
        child: const Text(
          'class GatedAction extends Action<ActivateIntent> {\n'
          '  bool get isEnabled => userHasPermission;\n'
          '  ...\n'
          '}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
      ),
    },
    {
      'title': 'Actions.maybeFind Check',
      'description': 'Use Actions.maybeFind<ActivateIntent>(context) '
          'to discover if an ActivateAction is available in the '
          'current scope. Returns null if no handler is registered.',
      'color': Colors.blue,
      'icon': Icons.search,
      'widget': Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: const Text(
          'final action = Actions.maybeFind<ActivateIntent>(ctx);\n'
          'if (action != null && action.isEnabled(intent)) {\n'
          '  Actions.of(ctx).invokeAction(action, intent);\n'
          '}',
          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
        ),
      ),
    },
  ];

  print('  ${disabledScenarios.length} disabled/gating scenarios');

  final disabledWidgets = disabledScenarios.map<Widget>((scenario) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (scenario['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (scenario['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(scenario['icon'] as IconData,
                  color: scenario['color'] as Color, size: 22),
              const SizedBox(width: 8),
              Text(
                scenario['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: scenario['color'] as Color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            scenario['description'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          scenario['widget'] as Widget,
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 10: Summary Dashboard
  // ============================================================
  print('=== Section 10: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'Activation paths documented', 'value': '${defaultActivationPaths.length}', 'icon': Icons.route},
    {'label': 'Shortcut chain steps', 'value': '${chainSteps.length}', 'icon': Icons.link},
    {'label': 'Override use cases', 'value': '${overrideUseCases.length}', 'icon': Icons.settings},
    {'label': 'Showcase widgets', 'value': '${activationShowcase.length}', 'icon': Icons.widgets},
    {'label': 'Disabled scenarios', 'value': '${disabledScenarios.length}', 'icon': Icons.block},
    {'label': 'Comparison aspects', 'value': '${comparisonRows.length}', 'icon': Icons.compare},
  ];

  print('  Summary: ${summaryItems.length} metrics');

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo.withOpacity(0.1),
              Colors.indigo.withOpacity(0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData, color: Colors.indigo, size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
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
  // Helper: Section header builder
  // ============================================================
  Widget sectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.indigo[300]!],
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

  print('ActivateAction Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('ActivateAction Deep Demo'),
      backgroundColor: Colors.indigo,
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
                colors: [Colors.indigo, Colors.indigo[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.touch_app, color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'ActivateAction',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The built-in Action that handles keyboard activation '
                  '(Enter/Space) for focused widgets — the bridge between '
                  'keyboard navigation and widget interaction.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Section 1: Concept
          sectionHeader('1', 'What is ActivateAction?', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2: Type Hierarchy
          sectionHeader('2', 'Type Hierarchy & API', Icons.account_tree),
          ...hierarchyWidgets,

          // Section 3: Default Activation Paths
          sectionHeader('3', 'Default Activation Paths', Icons.device_hub),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.06),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Flutter internally uses ActivateAction for many standard '
              'widgets. When any of these has keyboard focus and the user '
              'presses Enter or Space, the same activation path fires as '
              'a touch tap:',
              style: TextStyle(fontSize: 13, height: 1.5),
            ),
          ),
          ...activationPathWidgets,

          // Section 4: Live Activation Demo
          sectionHeader('4', 'Live Activation Buttons', Icons.touch_app),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'These real Flutter buttons respond to ActivateAction. '
                  'In a running app with focus, pressing Enter or Space '
                  'activates the focused button:',
                  style: TextStyle(fontSize: 13, height: 1.4),
                ),
                const SizedBox(height: 12),
                ...liveButtons,
              ],
            ),
          ),

          // Section 5: Custom Override
          sectionHeader('5', 'Custom ActivateAction Override', Icons.build),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Override Pattern:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Text(
                  customOverrideCode,
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
              ],
            ),
          ),
          ...overrideWidgets,
          const SizedBox(height: 8),
          customOverrideWidget,

          // Section 6: Keyboard Shortcut Chain
          sectionHeader('6', 'Key → Intent → Action Chain', Icons.link),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.04),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'When a user presses Enter or Space on a focused widget, '
              'the following chain of events occurs:',
              style: TextStyle(fontSize: 13, height: 1.4),
            ),
          ),
          ...chainWidgets,

          // Section 7: Comparison Table
          sectionHeader('7', 'ActivateAction vs ButtonActivate', Icons.compare),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.indigo.withOpacity(0.2)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                comparisonHeader,
                ...comparisonRowWidgets,
              ],
            ),
          ),

          // Section 8: Multi-Widget Showcase
          sectionHeader(
              '8', 'Widget Activation Showcase', Icons.grid_view),
          ...showcaseWidgets,

          // Section 9: Disabled States
          sectionHeader('9', 'Disabled & Gating', Icons.lock_outline),
          ...disabledWidgets,

          // Section 10: Summary
          sectionHeader('10', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
