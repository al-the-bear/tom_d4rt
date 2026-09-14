// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PrioritizedIntents
// Demonstrates PrioritizedIntents: an Intent subclass that holds an ordered
// list of intents. Used with PrioritizedAction to implement keyboard shortcut
// fallback chains through the Actions/Shortcuts framework.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PrioritizedIntents Deep Demo executing');

  // ============================================================
  // SECTION 1: What PrioritizedIntents Is — Concept
  // ============================================================
  print('=== Section 1: PrioritizedIntents Concept ===');

  // PrioritizedIntents is an Intent subclass that wraps a
  // List<Intent> called orderedIntents. When a keyboard shortcut
  // maps to PrioritizedIntents, and PrioritizedAction handles it,
  // the system iterates the list looking for the first intent whose
  // mapped action is enabled.
  //
  // This is the "data" half of the PrioritizedAction system:
  //   PrioritizedIntents = what intents to try (ordered list)
  //   PrioritizedAction = how to try them (iterate & find enabled)

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF1565C0), Color(0xFF0D47A1)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.list_alt, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PrioritizedIntents',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends Intent',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Text(
          'An Intent subclass that holds an ordered list of intents '
          '(orderedIntents). When paired with PrioritizedAction, the '
          'system tries each intent in order and invokes the first one '
          'whose mapped action is enabled. This enables contextual '
          'keyboard shortcut fallback chains.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Constructor
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Constructor:',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white60,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'const PrioritizedIntents({\n'
                '  required List<Intent> orderedIntents,\n'
                '})',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Key property:',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white60,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'final List<Intent> orderedIntents\n'
                '// First = highest priority',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created concept overview');

  // ============================================================
  // SECTION 2: Creating PrioritizedIntents Instances
  // ============================================================
  print('=== Section 2: Creating PrioritizedIntents ===');

  // Create actual instances to demonstrate the API

  final undoPriority = PrioritizedIntents(
    orderedIntents: [
      UndoTextIntent(SelectionChangedCause.keyboard),
      UndoTextIntent(SelectionChangedCause.tap),
    ],
  );

  print('  orderedIntents.length: ${undoPriority.orderedIntents.length}');
  print('  orderedIntents[0].runtimeType: ${undoPriority.orderedIntents[0].runtimeType}');
  print('  orderedIntents[1].runtimeType: ${undoPriority.orderedIntents[1].runtimeType}');

  final dismissPriority = PrioritizedIntents(
    orderedIntents: [
      DismissIntent(),
      ScrollIntent(direction: AxisDirection.up),
    ],
  );

  print('  dismissPriority.orderedIntents.length: ${dismissPriority.orderedIntents.length}');

  final creationSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Creating PrioritizedIntents',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'PrioritizedIntents is const-constructible. Pass an ordered list '
          'of Intent objects, with the highest-priority intent first.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Instance 1: Undo priority
        _buildIntentInstance(
          'Undo Priority Chain',
          'orderedIntents: [UndoTextIntent(keyboard), UndoTextIntent(tap)]',
          '${undoPriority.orderedIntents.length} intents',
          [
            {'name': 'UndoTextIntent(keyboard)', 'priority': 1},
            {'name': 'UndoTextIntent(tap)', 'priority': 2},
          ],
          Colors.blue,
        ),
        SizedBox(height: 10.0),
        // Instance 2: Dismiss priority
        _buildIntentInstance(
          'Dismiss Priority Chain',
          'orderedIntents: [DismissIntent(), ScrollIntent(up)]',
          '${dismissPriority.orderedIntents.length} intents',
          [
            {'name': 'DismissIntent()', 'priority': 1},
            {'name': 'ScrollIntent(up)', 'priority': 2},
          ],
          Colors.purple,
        ),
        SizedBox(height: 14.0),
        // Const constructibility note
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade700, size: 16.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'PrioritizedIntents can be const-constructed when all inner '
                  'intents are also const. This is efficient for static '
                  'shortcut mappings defined at compile time.',
                  style: TextStyle(fontSize: 10.0, color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created instance creation section');

  // ============================================================
  // SECTION 3: orderedIntents List Order Matters
  // ============================================================
  print('=== Section 3: List Order Matters ===');

  // The position in orderedIntents determines priority

  final orderExamples = [
    {
      'title': 'Undo Chain — Code Editor First',
      'list': ['UndoCodeEdit', 'UndoFormatting', 'UndoGlobal'],
      'explanation': 'When user presses Ctrl+Z, try undoing code edits first '
          '(most specific), then formatting changes, then a global undo.',
      'color': Colors.blue,
    },
    {
      'title': 'Undo Chain — Canvas First',
      'list': ['UndoStroke', 'UndoTransform', 'UndoGlobal'],
      'explanation': 'Same Ctrl+Z, but in a drawing app context. Try undoing '
          'the last stroke first, then transforms, then global.',
      'color': Colors.teal,
    },
    {
      'title': 'Escape Chain — Most Specific First',
      'list': ['ClosePopup', 'CloseDrawer', 'DeselectAll', 'NavigateBack'],
      'explanation': 'Escape should close the most recently opened overlay first, '
          'then close drawers, deselect items, and finally navigate back.',
      'color': Colors.orange,
    },
  ];

  final orderCards = <Widget>[];
  for (final example in orderExamples) {
    final color = example['color'] as MaterialColor;
    final list = example['list'] as List<String>;

    final priorityItems = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      priorityItems.add(
        Container(
          margin: EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: i == 0 ? color.shade600 : color.shade200,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: i == 0 ? Colors.white : color.shade800,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: i == 0 ? color.shade100 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: i == 0 ? color.shade400 : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  list[i],
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'monospace',
                    color: i == 0 ? color.shade800 : Colors.grey.shade600,
                  ),
                ),
              ),
              SizedBox(width: 6.0),
              if (i == 0)
                Text(
                  '← highest priority',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontStyle: FontStyle.italic,
                    color: color.shade600,
                  ),
                ),
              if (i == list.length - 1)
                Text(
                  '← fallback',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    orderCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              example['title'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              example['explanation'] as String,
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 10.0),
            ...priorityItems,
          ],
        ),
      ),
    );
  }

  final section3 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'List Order = Priority Order',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'The position of each intent in orderedIntents determines its '
          'priority. Index 0 = highest. Order your most specific handler '
          'first and the most general fallback last.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...orderCards,
      ],
    ),
  );

  print('Created ${orderCards.length} order examples');

  // ============================================================
  // SECTION 4: PrioritizedIntents in Shortcuts Configuration
  // ============================================================
  print('=== Section 4: In Shortcuts Configuration ===');

  // Show how PrioritizedIntents is mapped in a Shortcuts widget

  final shortcutsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Using PrioritizedIntents in Shortcuts',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'The Shortcuts widget maps key combinations to Intent objects. '
          'Map a key combo to PrioritizedIntents to enable fallback chains.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Code example
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Shortcuts(\n'
            '  shortcuts: {\n'
            '    // Ctrl+Z → try undo intents in order\n'
            '    SingleActivator(LogicalKeyboardKey.keyZ,\n'
            '        control: true):\n'
            '      PrioritizedIntents(\n'
            '        orderedIntents: [\n'
            '          UndoTextIntent(keyboard),\n'
            '          UndoDrawingIntent(),\n'
            '          UndoGlobalIntent(),\n'
            '        ],\n'
            '      ),\n'
            '    // Escape → try dismiss intents in order\n'
            '    SingleActivator(LogicalKeyboardKey.escape):\n'
            '      PrioritizedIntents(\n'
            '        orderedIntents: [\n'
            '          DismissIntent(),\n'
            '          DeselectAllIntent(),\n'
            '        ],\n'
            '      ),\n'
            '  },\n'
            ')',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Colors.greenAccent.shade200,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        // How the chain works
        _buildShortcutChainStep(1, 'Key press', 'Ctrl+Z detected by Shortcuts widget', Colors.blue),
        _buildChainArrow(),
        _buildShortcutChainStep(2, 'PrioritizedIntents', 'Shortcuts maps to PrioritizedIntents([...3 intents...])', Colors.amber),
        _buildChainArrow(),
        _buildShortcutChainStep(3, 'PrioritizedAction', 'Actions widget dispatches to PrioritizedAction', Colors.deepOrange),
        _buildChainArrow(),
        _buildShortcutChainStep(4, 'First enabled', 'Iterates orderedIntents → invokes first enabled', Colors.green),
      ],
    ),
  );

  print('Created shortcuts configuration section');

  // ============================================================
  // SECTION 5: Intent Type Hierarchy
  // ============================================================
  print('=== Section 5: Intent Type Hierarchy ===');

  // Show where PrioritizedIntents sits in the type hierarchy

  final hierarchySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Intent Type Hierarchy',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'PrioritizedIntents extends Intent. Unlike most Intent subclasses '
          'that carry data for a single action, PrioritizedIntents carries '
          'a list of other intents.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Type tree
        _buildTypeNode('Intent', 'Abstract base class for all intents', Colors.grey, 0),
        _buildTypeConnector(0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left branch: regular intents
            Expanded(
              child: Column(
                children: [
                  _buildTypeNode('Regular Intents', 'Single-purpose intents', Colors.blue, 1),
                  _buildTypeConnector(1),
                  _buildTypeNode('DismissIntent', 'Dismiss overlay/route', Colors.blue, 2),
                  SizedBox(height: 4.0),
                  _buildTypeNode('ScrollIntent', 'Scroll by amount', Colors.blue, 2),
                  SizedBox(height: 4.0),
                  _buildTypeNode('ActivateIntent', 'Activate widget', Colors.blue, 2),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            // Right branch: prioritized
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.deepOrange.shade400, width: 2.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'PrioritizedIntents',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange.shade800,
                          ),
                        ),
                        Text(
                          'Wraps List<Intent>',
                          style: TextStyle(fontSize: 9.0, color: Colors.deepOrange.shade600),
                        ),
                      ],
                    ),
                  ),
                  _buildTypeConnector(1),
                  Container(
                    padding: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'orderedIntents:',
                          style: TextStyle(
                            fontSize: 9.0,
                            fontFamily: 'monospace',
                            color: Colors.amber.shade800,
                          ),
                        ),
                        Text('[Intent, Intent, ...]',
                          style: TextStyle(
                            fontSize: 9.0,
                            fontFamily: 'monospace',
                            color: Colors.amber.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Key difference
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Key difference: Regular intents describe ONE action to perform. '
                  'PrioritizedIntents describes MULTIPLE possible actions to '
                  'try in priority order.',
                  style: TextStyle(fontSize: 10.0, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created type hierarchy section');

  // ============================================================
  // SECTION 6: Live Registration Pattern
  // ============================================================
  print('=== Section 6: Live Registration Pattern ===');

  // Demonstrate the full registration — PrioritizedIntents mapped
  // in Shortcuts, PrioritizedAction mapped in Actions, plus inner
  // intent actions

  final liveRegistration = Actions(
    actions: <Type, Action<Intent>>{
      PrioritizedIntents: PrioritizedAction(),
      DismissIntent: CallbackAction<DismissIntent>(
        onInvoke: (intent) {
          print('DismissIntent handler invoked');
          return null;
        },
      ),
      ScrollIntent: CallbackAction<ScrollIntent>(
        onInvoke: (intent) {
          print('ScrollIntent handler invoked');
          return null;
        },
      ),
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Registration Pattern',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'This section is wrapped in a real Actions widget showing '
            'the complete registration pattern. Three entries are needed:',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 14.0),
          // Registration entries
          _buildRegistrationEntry(
            '1',
            'PrioritizedIntents → PrioritizedAction()',
            'Maps the priority intent type to the priority iterator',
            Colors.deepOrange,
            true,
          ),
          SizedBox(height: 8.0),
          _buildRegistrationEntry(
            '2',
            'DismissIntent → CallbackAction<DismissIntent>',
            'Handler for inner intent #1 (looked up by PrioritizedAction)',
            Colors.blue,
            false,
          ),
          SizedBox(height: 8.0),
          _buildRegistrationEntry(
            '3',
            'ScrollIntent → CallbackAction<ScrollIntent>',
            'Handler for inner intent #2 (fallback)',
            Colors.teal,
            false,
          ),
          SizedBox(height: 14.0),
          // Flow diagram
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.green.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dispatch flow:',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade800,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'PrioritizedIntents([DismissIntent, ScrollIntent])\n'
                  '  → PrioritizedAction.invoke()\n'
                  '  → Try DismissIntent → find handler → enabled? → YES → invoke!\n'
                  '  → (ScrollIntent handler never reached)',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                    color: Colors.green.shade700,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('Created live registration section');

  // ============================================================
  // SECTION 7: PrioritizedIntents vs Regular Intent
  // ============================================================
  print('=== Section 7: PrioritizedIntents vs Regular Intent ===');

  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'PrioritizedIntents',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text('vs', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500)),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Regular Intent',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildComparisonRow(
          'Purpose',
          'Carries a LIST of intents to try in order',
          'Carries data for a SINGLE action',
        ),
        _buildComparisonRow(
          'Data',
          'orderedIntents: List<Intent>',
          'Custom fields for specific action',
        ),
        _buildComparisonRow(
          'Handler',
          'Always PrioritizedAction',
          'Custom Action<T> subclass',
        ),
        _buildComparisonRow(
          'Const',
          'Yes — if inner intents are const',
          'Yes — typically const',
        ),
        _buildComparisonRow(
          'Use Case',
          'One key combo, multiple possible handlers',
          'One key combo, one handler',
        ),
        _buildComparisonRow(
          'Complexity',
          'Higher — requires inner intent registrations',
          'Simpler — one registration',
        ),
      ],
    ),
  );

  print('Created comparison section');

  // ============================================================
  // SECTION 8: Common Patterns and Anti-Patterns
  // ============================================================
  print('=== Section 8: Patterns and Anti-Patterns ===');

  final patternsSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Patterns & Anti-Patterns',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        // Good patterns
        _buildPatternCard(
          'Most specific first',
          'Put the most specific handler first in orderedIntents. '
          'The general fallback should be last.',
          true,
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildPatternCard(
          'Register inner intent actions',
          'Each intent in orderedIntents must have a corresponding '
          'Action registered in the widget tree, or it is silently skipped.',
          true,
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildPatternCard(
          'Use const when possible',
          'const PrioritizedIntents with const inner intents. '
          'Efficient for static shortcut maps.',
          true,
          Colors.green,
        ),
        SizedBox(height: 12.0),
        // Anti-patterns
        _buildPatternCard(
          'Empty orderedIntents',
          'An empty list means no intent can ever be resolved. '
          'PrioritizedAction will never find an enabled handler.',
          false,
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildPatternCard(
          'Forgetting PrioritizedAction registration',
          'PrioritizedIntents without a PrioritizedAction in the '
          'Actions widget means the shortcut silently does nothing.',
          false,
          Colors.red,
        ),
        SizedBox(height: 8.0),
        _buildPatternCard(
          'Duplicate intents in list',
          'Adding the same intent type twice wastes lookup cycles. '
          'Each intent type should appear at most once.',
          false,
          Colors.red,
        ),
      ],
    ),
  );

  print('Created patterns section');

  // ============================================================
  // ASSEMBLY
  // ============================================================
  print('=== Assembling PrioritizedIntents Deep Demo ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF0D47A1),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Text(
                'PrioritizedIntents Deep Demo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Priority-ordered intent lists for fallback chains',
                style: TextStyle(fontSize: 11.0, color: Colors.white60),
              ),
            ],
          ),
        ),
        conceptCard,
        creationSection,
        section3,
        shortcutsSection,
        hierarchySection,
        liveRegistration,
        comparisonSection,
        patternsSection,
        SizedBox(height: 30.0),
      ],
    ),
  );

  print('PrioritizedIntents Deep Demo complete: 8 sections');
  return result;
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildIntentInstance(
  String title,
  String constructor,
  String summary,
  List<Map<String, Object>> items,
  MaterialColor color,
) {
  final itemWidgets = <Widget>[];
  for (final item in items) {
    itemWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 4.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: color.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '#${item['priority']}',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
            SizedBox(width: 6.0),
            Text(
              item['name'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: color.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                summary,
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          constructor,
          style: TextStyle(
            fontSize: 9.0,
            fontFamily: 'monospace',
            color: Colors.grey.shade600,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(children: itemWidgets),
      ],
    ),
  );
}

Widget _buildShortcutChainStep(int number, String title, String desc, MaterialColor color) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 26.0,
          height: 26.0,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$number',
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildChainArrow() {
  return Container(
    height: 14.0,
    alignment: Alignment.center,
    child: Icon(Icons.arrow_downward, size: 12.0, color: Colors.grey.shade400),
  );
}

Widget _buildTypeNode(String name, String desc, MaterialColor color, int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 10.0),
    padding: EdgeInsets.all(6.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade300),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
        Text(
          desc,
          style: TextStyle(fontSize: 8.0, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildTypeConnector(int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 10.0 + 20.0),
    height: 8.0,
    width: 2.0,
    color: Colors.grey.shade400,
  );
}

Widget _buildRegistrationEntry(
  String number,
  String mapping,
  String description,
  MaterialColor color,
  bool isPrimary,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: isPrimary ? color.shade50 : Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: isPrimary ? color.shade300 : Colors.grey.shade300,
        width: isPrimary ? 2.0 : 1.0,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mapping,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: color.shade800,
                ),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(String aspect, String prioritized, String regular) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          aspect,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  prioritized,
                  style: TextStyle(fontSize: 9.0, color: Colors.blue.shade700),
                ),
              ),
            ),
            SizedBox(width: 6.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  regular,
                  style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
  String title,
  String description,
  bool isGood,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isGood ? Icons.check_circle : Icons.cancel,
          color: color.shade600,
          size: 18.0,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${isGood ? "DO" : "DONT"}: $title',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color.shade800,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
