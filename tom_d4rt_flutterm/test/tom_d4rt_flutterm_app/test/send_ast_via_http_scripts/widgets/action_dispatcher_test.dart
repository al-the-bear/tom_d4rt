// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ActionDispatcher
// Demonstrates ActionDispatcher, the central routing mechanism in Flutter's
// Actions framework. Covers custom dispatchers, intent/action registration,
// logging, nested action scopes, keyboard shortcut integration, and
// error handling when actions are missing.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ActionDispatcher Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is ActionDispatcher?
  // ============================================================
  print('=== Section 1: Concept — What is ActionDispatcher? ===');

  final conceptData = <Map<String, dynamic>>[
    {
      'icon': Icons.call_split,
      'title': 'What is ActionDispatcher?',
      'body': 'ActionDispatcher is the object that sits at the center '
          'of Flutter\'s Actions framework. When an Intent is '
          'invoked — via a keyboard shortcut, a button, or '
          'programmatic call — the dispatcher decides which '
          'Action to call and executes it. Think of it as a '
          'traffic controller for user interactions.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.layers,
      'title': 'Actions / Intents / Shortcuts',
      'body': 'Flutter\'s action framework has three layers:\n'
          '• Shortcuts — maps key combinations to Intents\n'
          '• Intents — describe what should happen (data objects)\n'
          '• Actions — implement the logic for each Intent\n'
          'ActionDispatcher ties them together by invoking '
          'the correct Action for a given Intent.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.settings_input_component,
      'title': 'Default vs Custom',
      'body': 'Flutter provides a default ActionDispatcher that '
          'simply calls action.invoke(intent). You can subclass '
          'it to add logging, analytics, permissions checks, '
          'undo/redo support, or any cross-cutting concern that '
          'should apply to every action dispatch.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.account_tree,
      'title': 'Scope & Nesting',
      'body': 'Each Actions widget creates a scope. When an intent '
          'is dispatched, Flutter walks up the widget tree looking '
          'for an Action that handles that intent type. The dispatcher '
          'at the nearest enclosing Actions widget performs the '
          'invocation, allowing layered overrides.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptData.length; i++) {
    final c = conceptData[i];
    final accent = c['accent'] as Color;
    print('  Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.14), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.grey.shade800,
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

  print('  Built ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Default ActionDispatcher
  // ============================================================
  print('=== Section 2: Default ActionDispatcher ===');

  // Create a default ActionDispatcher and inspect it
  final defaultDispatcher = ActionDispatcher();
  print('  Default dispatcher type: ${defaultDispatcher.runtimeType}');

  final defaultDispatcherPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade50,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.deepPurple.shade200, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withOpacity(0.12),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'DEFAULT',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'ActionDispatcher',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          'The default ActionDispatcher is created automatically by the '
          'Actions widget. It has a single method — invokeAction — '
          'which takes an Action and an Intent and simply calls '
          'action.invoke(intent).',
          style: TextStyle(
            fontSize: 12.5,
            height: 1.5,
            color: Colors.deepPurple.shade700,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.deepPurple.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Key Method:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.deepPurple.shade600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Object? invokeAction(\n'
                '  Action<Intent> action,\n'
                '  Intent intent, [\n'
                '  BuildContext? context,\n'
                '])',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Icon(Icons.info_outline, size: 16, color: Colors.deepPurple.shade400),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Runtime type: ${defaultDispatcher.runtimeType}',
                style: TextStyle(
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurple.shade500,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Custom ActionDispatcher — Logging Dispatcher
  // ============================================================
  print('=== Section 3: Custom Logging Dispatcher ===');

  // Since we can't subclass ActionDispatcher in a script easily,
  // we demonstrate the concept visually and exercise the API.
  // We create the default dispatcher, invoke actions through it,
  // and display a visual log of what happened.

  final logEntries = <Map<String, dynamic>>[];

  // Define a simple increment action using CallbackAction
  var counter = 0;
  final incrementAction = CallbackAction<Intent>(
    onInvoke: (Intent intent) {
      counter++;
      print('  Increment action invoked. Counter: $counter');
      logEntries.add({
        'action': 'IncrementAction',
        'intent': 'IncrementIntent',
        'result': 'counter = $counter',
        'color': Colors.green,
        'icon': Icons.add_circle,
      });
      return counter;
    },
  );

  // Define a reset action
  final resetAction = CallbackAction<Intent>(
    onInvoke: (Intent intent) {
      final oldValue = counter;
      counter = 0;
      print('  Reset action invoked. Counter reset from $oldValue to 0');
      logEntries.add({
        'action': 'ResetAction',
        'intent': 'ResetIntent',
        'result': 'counter $oldValue → 0',
        'color': Colors.red,
        'icon': Icons.restart_alt,
      });
      return null;
    },
  );

  // Define a double action
  final doubleAction = CallbackAction<Intent>(
    onInvoke: (Intent intent) {
      final oldValue = counter;
      counter = counter * 2;
      print('  Double action invoked. Counter: $oldValue → $counter');
      logEntries.add({
        'action': 'DoubleAction',
        'intent': 'DoubleIntent',
        'result': 'counter $oldValue → $counter',
        'color': Colors.blue,
        'icon': Icons.double_arrow,
      });
      return counter;
    },
  );

  // Dispatch several actions through the default dispatcher
  const intent = ActivateIntent();

  print('  Dispatching increment x3...');
  defaultDispatcher.invokeAction(incrementAction, intent);
  defaultDispatcher.invokeAction(incrementAction, intent);
  defaultDispatcher.invokeAction(incrementAction, intent);

  print('  Dispatching double...');
  defaultDispatcher.invokeAction(doubleAction, intent);

  print('  Dispatching increment x2...');
  defaultDispatcher.invokeAction(incrementAction, intent);
  defaultDispatcher.invokeAction(incrementAction, intent);

  print('  Dispatching reset...');
  defaultDispatcher.invokeAction(resetAction, intent);

  print('  Total dispatches: ${logEntries.length}');

  // Build the dispatch log panel
  final logWidgets = <Widget>[];
  for (var i = 0; i < logEntries.length; i++) {
    final entry = logEntries[i];
    final color = entry['color'] as Color;
    logWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border(
            left: BorderSide(color: color, width: 4),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(entry['icon'] as IconData, color: color, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry['action'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: color,
                    ),
                  ),
                  Text(
                    entry['result'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade700,
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

  final dispatchLogPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.receipt_long, color: Colors.deepPurple.shade600, size: 22),
            const SizedBox(width: 10),
            Text(
              'Dispatch Log (${logEntries.length} events)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Each entry below represents one call to '
          'ActionDispatcher.invokeAction(). A custom dispatcher '
          'could intercept these for logging, analytics, or undo.',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        ...logWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Actions Widget Integration
  // ============================================================
  print('=== Section 4: Actions Widget Integration ===');

  // Show how ActionDispatcher is used within the Actions widget.
  // Build a visual diagram showing the widget tree hierarchy.

  Widget buildTreeNode(
    String label, {
    required Color color,
    required IconData icon,
    double indent = 0,
    String? subtitle,
    bool isHighlighted = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isHighlighted ? color.withOpacity(0.15) : color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(8),
          border: isHighlighted
              ? Border.all(color: color, width: 2)
              : Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
                    color: color,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 10, color: color.withOpacity(0.7)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final treePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Widget Tree: ActionDispatcher in Context',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'The dispatcher lives inside the Actions widget and is '
          'responsible for routing every intent to the right action.',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 14),
        buildTreeNode(
          'MaterialApp',
          color: Colors.grey,
          icon: Icons.phone_android,
          subtitle: 'Root application',
        ),
        buildTreeNode(
          'Actions',
          color: Colors.deepPurple,
          icon: Icons.hub,
          indent: 20,
          subtitle: 'Contains ActionDispatcher + action map',
          isHighlighted: true,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Row(
            children: [
              Container(width: 2, height: 20, color: Colors.deepPurple.shade200),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '→ dispatcher: ActionDispatcher()',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildTreeNode(
          'Shortcuts',
          color: Colors.blue,
          icon: Icons.keyboard,
          indent: 40,
          subtitle: 'Maps key combos → Intents',
        ),
        buildTreeNode(
          'Focus',
          color: Colors.teal,
          icon: Icons.center_focus_strong,
          indent: 60,
          subtitle: 'Receives keyboard input',
        ),
        buildTreeNode(
          'Builder / YourWidget',
          color: Colors.green,
          icon: Icons.widgets,
          indent: 80,
          subtitle: 'Calls Actions.invoke(context, intent)',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Registering Multiple Actions
  // ============================================================
  print('=== Section 5: Registering Multiple Actions ===');

  // Demonstrate how multiple actions are registered with the
  // Actions widget and how the dispatcher selects the right one.

  final actionRegistrations = <Map<String, dynamic>>[
    {
      'intent': 'ActivateIntent',
      'action': 'ActivateAction',
      'description': 'Triggers the primary action of a focused widget (tap/click)',
      'icon': Icons.touch_app,
      'color': Colors.green,
      'shortcut': 'Enter / Space',
    },
    {
      'intent': 'DismissIntent',
      'action': 'DismissAction',
      'description': 'Dismisses the current modal, popup, or selection',
      'icon': Icons.close,
      'color': Colors.red,
      'shortcut': 'Escape',
    },
    {
      'intent': 'ScrollIntent',
      'action': 'ScrollAction',
      'description': 'Scrolls the focused scrollable widget',
      'icon': Icons.swap_vert,
      'color': Colors.blue,
      'shortcut': 'Arrow keys / PgUp / PgDn',
    },
    {
      'intent': 'DirectionalFocusIntent',
      'action': 'DirectionalFocusAction',
      'description': 'Moves focus to the next widget in a given direction',
      'icon': Icons.open_with,
      'color': Colors.orange,
      'shortcut': 'Tab / Shift+Tab / Arrows',
    },
    {
      'intent': 'PrioritizedIntents',
      'action': 'PrioritizedAction',
      'description': 'Tries a list of intents in priority order until one succeeds',
      'icon': Icons.sort,
      'color': Colors.purple,
      'shortcut': 'Various (contextual)',
    },
  ];

  final registrationCards = <Widget>[];
  for (var i = 0; i < actionRegistrations.length; i++) {
    final reg = actionRegistrations[i];
    final color = reg['color'] as Color;
    print('  Registration ${i + 1}: ${reg['intent']} → ${reg['action']}');

    registrationCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(reg['icon'] as IconData, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          reg['intent'] as String,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.arrow_forward, size: 12, color: Colors.grey),
                      ),
                      Text(
                        reg['action'] as String,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reg['description'] as String,
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.keyboard, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        reg['shortcut'] as String,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final registrationPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.app_registration, color: Colors.deepPurple, size: 22),
            const SizedBox(width: 10),
            Text(
              'Built-in Action Registrations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Flutter registers these actions by default in WidgetsApp. '
          'The dispatcher routes each intent to the matching action:',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        ...registrationCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: invokeAction — Step by Step Flow
  // ============================================================
  print('=== Section 6: invokeAction Flow ===');

  final flowSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Intent Created',
      'detail': 'An Intent object describes what action to perform. '
          'For example, ActivateIntent is created when the user '
          'presses Enter on a focused button.',
      'icon': Icons.lightbulb_outline,
      'color': Colors.amber,
    },
    {
      'step': '2',
      'label': 'Action Lookup',
      'detail': 'Flutter walks up the widget tree from the current '
          'BuildContext, checking each Actions widget for a '
          'registered action that handles this intent type.',
      'icon': Icons.search,
      'color': Colors.blue,
    },
    {
      'step': '3',
      'label': 'isEnabled Check',
      'detail': 'Before dispatching, the framework calls '
          'action.isActionEnabled. If false, the action is '
          'skipped and the search continues upward.',
      'icon': Icons.check_circle_outline,
      'color': Colors.teal,
    },
    {
      'step': '4',
      'label': 'Dispatcher.invokeAction()',
      'detail': 'The ActionDispatcher on the Actions widget calls '
          'invokeAction(action, intent, context). This is where '
          'a custom dispatcher can intercept, log, or modify.',
      'icon': Icons.play_circle_outline,
      'color': Colors.deepPurple,
    },
    {
      'step': '5',
      'label': 'Action.invoke()',
      'detail': 'Inside invokeAction, the dispatcher calls '
          'action.invoke(intent). The action performs its work '
          'and optionally returns a result.',
      'icon': Icons.bolt,
      'color': Colors.orange,
    },
    {
      'step': '6',
      'label': 'Result Returned',
      'detail': 'The result travels back through the dispatcher to '
          'the original caller. For Actions.invoke(), the result '
          'is returned directly. For shortcuts, it is discarded.',
      'icon': Icons.keyboard_return,
      'color': Colors.green,
    },
  ];

  final flowWidgets = <Widget>[];
  for (var i = 0; i < flowSteps.length; i++) {
    final step = flowSteps[i];
    final color = step['color'] as Color;
    print('  Flow step ${step['step']}: ${step['label']}');

    flowWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
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
                if (i < flowSteps.length - 1)
                  Container(
                    width: 3,
                    height: 24,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, (flowSteps[i + 1]['color'] as Color)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(step['icon'] as IconData, size: 16, color: color),
                        const SizedBox(width: 8),
                        Text(
                          step['label'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      step['detail'] as String,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.4,
                        color: Colors.grey.shade700,
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

  final flowPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'invokeAction — Step by Step',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        const SizedBox(height: 14),
        ...flowWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Nested Action Scopes
  // ============================================================
  print('=== Section 7: Nested Action Scopes ===');

  // Demonstrate how nested Actions widgets create override layers

  Widget buildScopeBox(
    String label,
    String dispatcher,
    List<String> actions,
    Color color, {
    Widget? child,
  }) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                dispatcher,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...actions.map(
            (a) => Padding(
              padding: const EdgeInsets.only(left: 8, top: 2),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    a,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (child != null) ...[
            const SizedBox(height: 8),
            child,
          ],
        ],
      ),
    );
  }

  final nestedScopePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nested Action Scopes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Inner Actions widgets can override outer actions. The '
          'dispatcher at the nearest scope handles the intent:',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        buildScopeBox(
          'OUTER SCOPE',
          'DefaultDispatcher',
          [
            'ActivateIntent → ActivateAction',
            'DismissIntent → DismissAction',
            'ScrollIntent → ScrollAction',
          ],
          Colors.indigo,
          child: buildScopeBox(
            'INNER SCOPE',
            'LoggingDispatcher',
            [
              'ActivateIntent → CustomActivateAction',
              'CopyIntent → CopyAction',
            ],
            Colors.deepPurple,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green, style: BorderStyle.solid),
              ),
              child: Row(
                children: [
                  Icon(Icons.widgets, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Button here → ActivateIntent uses '
                      'CustomActivateAction via LoggingDispatcher',
                      style: TextStyle(fontSize: 10, color: Colors.green.shade800),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Action Enabled/Disabled States
  // ============================================================
  print('=== Section 8: Action Enabled/Disabled ===');

  // Show how isActionEnabled affects dispatch

  final enabledAction = CallbackAction<Intent>(
    onInvoke: (intent) {
      print('  Enabled action invoked');
      return 'success';
    },
  );

  // Check action enabled state
  final isEnabled = enabledAction.isActionEnabled;
  print('  CallbackAction isEnabled: $isEnabled');

  // Demonstrate consumesKey
  final consumesKey = enabledAction.consumesKey(const ActivateIntent());
  print('  CallbackAction consumesKey: $consumesKey');

  final enabledDisabledCards = <Widget>[];

  final states = [
    {
      'label': 'Enabled Action',
      'enabled': true,
      'description': 'When isActionEnabled returns true, the '
          'dispatcher proceeds to call invoke(). This is the '
          'normal path for most actions.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'label': 'Disabled Action',
      'enabled': false,
      'description': 'When isActionEnabled returns false, the '
          'framework skips this action and continues searching '
          'up the widget tree for another handler. Useful for '
          'conditionally available actions like "paste" when '
          'clipboard is empty.',
      'icon': Icons.block,
      'color': Colors.red,
    },
    {
      'label': 'consumesKey',
      'enabled': true,
      'description': 'An action can declare whether it consumes '
          'the key event that triggered it via consumesKey(). '
          'If false, the key event continues to propagate even '
          'after the action runs. Default is true.',
      'icon': Icons.keyboard_hide,
      'color': Colors.blue,
    },
  ];

  for (var state in states) {
    final color = state['color'] as Color;
    final enabled = state['enabled'] as bool;

    enabledDisabledCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: enabled ? color.withOpacity(0.15) : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                state['icon'] as IconData,
                color: enabled ? color : Colors.grey,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state['description'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.grey.shade700,
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

  final enabledPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.toggle_on, color: Colors.green.shade600, size: 22),
            const SizedBox(width: 10),
            Text(
              'Action Enabled/Disabled States',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'The dispatcher checks these states before invoking:',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        ...enabledDisabledCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Custom Dispatcher Use Cases
  // ============================================================
  print('=== Section 9: Custom Dispatcher Use Cases ===');

  final useCases = <Map<String, dynamic>>[
    {
      'title': 'Logging / Analytics',
      'description': 'Override invokeAction to log every action dispatch. '
          'Track what users do most, measure time per action, '
          'send telemetry to your analytics backend.',
      'icon': Icons.analytics,
      'color': Colors.deepPurple,
      'code': 'class LoggingDispatcher extends ActionDispatcher {\n'
          '  Object? invokeAction(action, intent, [ctx]) {\n'
          '    log("Dispatching: \${intent.runtimeType}");\n'
          '    return super.invokeAction(action, intent, ctx);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Undo / Redo System',
      'description': 'Capture each action invocation and push it onto '
          'an undo stack. When the user presses Ctrl+Z, pop the '
          'last action and invoke its reverse.',
      'icon': Icons.undo,
      'color': Colors.orange,
      'code': 'class UndoDispatcher extends ActionDispatcher {\n'
          '  final undoStack = <UndoableAction>[];\n'
          '  Object? invokeAction(action, intent, [ctx]) {\n'
          '    if (action is UndoableAction) {\n'
          '      undoStack.add(action);\n'
          '    }\n'
          '    return super.invokeAction(action, intent, ctx);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Permission Gate',
      'description': 'Check if the current user has permission to '
          'perform an action before dispatching. Block '
          'unauthorized actions and show a dialog instead.',
      'icon': Icons.security,
      'color': Colors.red,
      'code': 'class SecureDispatcher extends ActionDispatcher {\n'
          '  Object? invokeAction(action, intent, [ctx]) {\n'
          '    if (!user.can(intent.runtimeType)) {\n'
          '      showAccessDenied(ctx);\n'
          '      return null;\n'
          '    }\n'
          '    return super.invokeAction(action, intent, ctx);\n'
          '  }\n'
          '}',
    },
    {
      'title': 'Throttle / Debounce',
      'description': 'Prevent rapid re-dispatch of the same action. '
          'Useful for expensive operations that should not be '
          'triggered faster than once per frame.',
      'icon': Icons.speed,
      'color': Colors.teal,
      'code': 'class ThrottledDispatcher extends ActionDispatcher {\n'
          '  DateTime? _last;\n'
          '  Object? invokeAction(action, intent, [ctx]) {\n'
          '    final now = DateTime.now();\n'
          '    if (_last != null && now.difference(_last!) < limit) {\n'
          '      return null; // skip\n'
          '    }\n'
          '    _last = now;\n'
          '    return super.invokeAction(action, intent, ctx);\n'
          '  }\n'
          '}',
    },
  ];

  final useCaseWidgets = <Widget>[];
  for (var uc in useCases) {
    final color = uc['color'] as Color;
    print('  Use case: ${uc['title']}');

    useCaseWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(uc['icon'] as IconData, color: color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          uc['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          uc['description'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            height: 1.4,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                uc['code'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  height: 1.5,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final useCasePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.deepPurple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.extension, color: Colors.deepPurple, size: 22),
            const SizedBox(width: 10),
            Text(
              'Custom Dispatcher Use Cases',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...useCaseWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Live Actions Widget Demo
  // ============================================================
  print('=== Section 10: Live Actions Widget Demo ===');

  // Build an actual Actions widget with CallbackActions to show
  // how the dispatcher integrates in a real widget tree

  var demoCounter = 0;

  final actionsDemo = Actions(
    dispatcher: ActionDispatcher(),
    actions: <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          demoCounter++;
          print('  Live demo: ActivateAction fired, count=$demoCounter');
          return null;
        },
      ),
      DismissIntent: CallbackAction<DismissIntent>(
        onInvoke: (intent) {
          demoCounter = 0;
          print('  Live demo: DismissAction fired, counter reset');
          return null;
        },
      ),
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.deepPurple.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Actions Widget with Dispatcher',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'This Actions widget is created with an explicit '
            'ActionDispatcher() and two registered action handlers: '
            'ActivateAction (increment) and DismissAction (reset). '
            'In a real app, keyboard shortcuts or button presses '
            'would trigger these via the dispatcher.',
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: Colors.deepPurple.shade700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.touch_app, color: Colors.green, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      'ActivateIntent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.green.shade700,
                      ),
                    ),
                    Text(
                      '→ Increment',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
              Icon(Icons.compare_arrows, color: Colors.deepPurple.shade300, size: 32),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade300),
                ),
                child: Column(
                  children: [
                    Icon(Icons.close, color: Colors.red, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      'DismissIntent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.red.shade700,
                      ),
                    ),
                    Text(
                      '→ Reset',
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // ============================================================
  // SECTION 11: Summary Dashboard
  // ============================================================
  print('=== Section 11: Summary Dashboard ===');

  final summaryItems = [
    {'label': 'Actions Dispatched', 'value': '${logEntries.length}', 'color': Colors.deepPurple},
    {'label': 'Increment Events', 'value': '5', 'color': Colors.green},
    {'label': 'Double Events', 'value': '1', 'color': Colors.blue},
    {'label': 'Reset Events', 'value': '1', 'color': Colors.red},
    {'label': 'Built-in Registrations', 'value': '${actionRegistrations.length}', 'color': Colors.orange},
    {'label': 'Custom Use Cases', 'value': '${useCases.length}', 'color': Colors.teal},
  ];

  final summaryTiles = <Widget>[];
  for (var item in summaryItems) {
    final color = item['color'] as Color;
    summaryTiles.add(
      Container(
        width: 100,
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final summaryPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.deepPurple.shade200, width: 2),
    ),
    child: Column(
      children: [
        Text(
          'ActionDispatcher — Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: WrapAlignment.center,
          children: summaryTiles,
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('=== Assembling final layout ===');

  return Scaffold(
    appBar: AppBar(
      title: const Text('ActionDispatcher Deep Demo'),
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title banner
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.deepPurple.shade50,
            child: Column(
              children: [
                Icon(Icons.call_split, size: 48, color: Colors.deepPurple),
                const SizedBox(height: 10),
                Text(
                  'ActionDispatcher',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The central routing mechanism in Flutter\'s '
                  'Actions framework — dispatches Intents to Actions.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.deepPurple.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Section headers & content
          _sectionHeader('1. Core Concepts'),
          ...conceptCards,

          _sectionHeader('2. Default Dispatcher'),
          defaultDispatcherPanel,

          _sectionHeader('3. Dispatch Log'),
          dispatchLogPanel,

          _sectionHeader('4. Widget Tree Integration'),
          treePanel,

          _sectionHeader('5. Built-in Action Registrations'),
          registrationPanel,

          _sectionHeader('6. invokeAction Flow'),
          flowPanel,

          _sectionHeader('7. Nested Scopes'),
          nestedScopePanel,

          _sectionHeader('8. Enabled / Disabled States'),
          enabledPanel,

          _sectionHeader('9. Custom Dispatcher Patterns'),
          useCasePanel,

          _sectionHeader('10. Live Widget Demo'),
          actionsDemo,

          _sectionHeader('11. Summary'),
          summaryPanel,

          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget _sectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}
