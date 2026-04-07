// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PrioritizedAction
// Demonstrates PrioritizedAction: a stateless Action that works with
// PrioritizedIntents to implement fallback chains. It iterates the intent's
// orderedIntents list and invokes the first one whose mapped action is enabled.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PrioritizedAction Deep Demo executing');

  // ============================================================
  // SECTION 1: What PrioritizedAction Is — Concept
  // ============================================================
  print('=== Section 1: PrioritizedAction Concept ===');

  // PrioritizedAction is a STATELESS Action<PrioritizedIntents>.
  // It does not hold inner actions itself. Instead, PrioritizedIntents
  // holds a list of Intent objects in priority order. When invoked,
  // PrioritizedAction iterates through those intents, looks up each
  // one's mapped Action in the widget tree (via Actions.find), and
  // invokes the first one whose isEnabled returns true.
  //
  // Key insight: The action resolution happens through the Actions
  // widget tree, not through a list of Action objects.
  //
  // Flow:
  //   PrioritizedIntents([IntentA, IntentB, IntentC])
  //   → PrioritizedAction.invoke()
  //   → Find Action for IntentA → enabled? → invoke!
  //   → if not: Find Action for IntentB → enabled? → invoke!
  //   → if not: Find Action for IntentC → ...

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE65100), Color(0xFFBF360C)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepOrange.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.sort_by_alpha, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PrioritizedAction',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends Action<PrioritizedIntents>',
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
          'A stateless Action that works with PrioritizedIntents to implement '
          'keyboard shortcut fallback chains. Does NOT hold inner actions — '
          'instead, PrioritizedIntents holds a list of Intent objects. '
          'PrioritizedAction looks up each intent\'s handler in the widget '
          'tree and invokes the first enabled one.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Architecture diagram
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.list_alt, color: Colors.amberAccent, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'PrioritizedIntents',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '← holds ordered intent list',
                    style: TextStyle(fontSize: 10.0, color: Colors.white60),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  SizedBox(width: 24.0),
                  Icon(Icons.arrow_downward, color: Colors.white38, size: 14.0),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.play_circle_outline, color: Colors.greenAccent, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'PrioritizedAction',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '← stateless, no constructor args',
                    style: TextStyle(fontSize: 10.0, color: Colors.white60),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Row(
                children: [
                  SizedBox(width: 24.0),
                  Icon(Icons.arrow_downward, color: Colors.white38, size: 14.0),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Icon(Icons.search, color: Colors.lightBlueAccent, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Actions.find()',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '← looks up Actions in widget tree',
                    style: TextStyle(fontSize: 10.0, color: Colors.white60),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created concept overview');

  // ============================================================
  // SECTION 2: Two-Part Architecture — Intent + Action
  // ============================================================
  print('=== Section 2: Two-Part Architecture ===');

  // PrioritizedAction is unique because it splits the "what to try"
  // from the "how to try it":
  //   PrioritizedIntents = the ordered list of intents to attempt
  //   PrioritizedAction = the stateless executor that iterates them

  final architectureSection = Container(
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
          'Two-Part Architecture',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Unlike typical Action subclasses, PrioritizedAction separates '
          '"what to try" (PrioritizedIntents) from "how to try it" '
          '(PrioritizedAction). This is a deliberate design.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        // Part 1: PrioritizedIntents
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade200,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'PART 1',
                      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'PrioritizedIntents',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Colors.amber.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Extends Intent. Contains an orderedIntents list '
                'that defines which intents to attempt and in what order.',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'const PrioritizedIntents({\n'
                  '  required List<Intent> orderedIntents,\n'
                  '})',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.amber.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Arrow between parts
        Center(
          child: Column(
            children: [
              Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 20.0),
              Text(
                'Invoking PrioritizedAction with PrioritizedIntents',
                style: TextStyle(fontSize: 9.0, color: Colors.grey.shade500),
              ),
              Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 20.0),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Part 2: PrioritizedAction
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.deepOrange.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange.shade200,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'PART 2',
                      style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade900),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'PrioritizedAction',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      color: Colors.deepOrange.shade900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Extends Action<PrioritizedIntents>. Stateless — takes no '
                'constructor parameters. Iterates the intent\'s orderedIntents, '
                'looks up each one in the Actions widget tree, and invokes '
                'the first enabled handler.',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'class PrioritizedAction\n'
                  '    extends Action<PrioritizedIntents> {\n'
                  '  // No constructor params!\n'
                  '  // Uses intent.orderedIntents\n'
                  '}',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.deepOrange.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created two-part architecture section');

  // ============================================================
  // SECTION 3: Priority Cascade Visualization
  // ============================================================
  print('=== Section 3: Priority Cascade — First Enabled Wins ===');

  // Visualize how PrioritizedAction selects which action to run

  final cascadeScenarios = [
    {
      'title': 'Scenario A: First intent\'s action enabled',
      'intents': [
        {'name': 'UndoTextIntent', 'enabled': true, 'selected': true},
        {'name': 'UndoCanvasIntent', 'enabled': true, 'selected': false},
        {'name': 'UndoGlobalIntent', 'enabled': true, 'selected': false},
      ],
      'result': 'UndoTextIntent handler runs (highest priority)',
      'color': Colors.blue,
    },
    {
      'title': 'Scenario B: First disabled, second runs',
      'intents': [
        {'name': 'UndoTextIntent', 'enabled': false, 'selected': false},
        {'name': 'UndoCanvasIntent', 'enabled': true, 'selected': true},
        {'name': 'UndoGlobalIntent', 'enabled': true, 'selected': false},
      ],
      'result': 'UndoCanvasIntent handler runs (UndoText skipped)',
      'color': Colors.teal,
    },
    {
      'title': 'Scenario C: Only last intent has enabled action',
      'intents': [
        {'name': 'UndoTextIntent', 'enabled': false, 'selected': false},
        {'name': 'UndoCanvasIntent', 'enabled': false, 'selected': false},
        {'name': 'UndoGlobalIntent', 'enabled': true, 'selected': true},
      ],
      'result': 'UndoGlobalIntent handler runs (fallback)',
      'color': Colors.purple,
    },
    {
      'title': 'Scenario D: No intent has enabled action',
      'intents': [
        {'name': 'UndoTextIntent', 'enabled': false, 'selected': false},
        {'name': 'UndoCanvasIntent', 'enabled': false, 'selected': false},
        {'name': 'UndoGlobalIntent', 'enabled': false, 'selected': false},
      ],
      'result': 'Nothing happens (no enabled handler found)',
      'color': Colors.grey,
    },
  ];

  final cascadeCards = <Widget>[];
  for (final scenario in cascadeScenarios) {
    final color = scenario['color'] as MaterialColor;
    final intents = scenario['intents'] as List<Map<String, Object>>;

    final intentChips = <Widget>[];
    for (var i = 0; i < intents.length; i++) {
      final intent = intents[i];
      final enabled = intent['enabled'] as bool;
      final selected = intent['selected'] as bool;

      intentChips.add(
        Container(
          margin: EdgeInsets.only(right: 6.0, bottom: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: selected
                ? color.shade100
                : enabled
                    ? Colors.grey.shade100
                    : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: selected
                  ? color.shade400
                  : enabled
                      ? Colors.grey.shade300
                      : Colors.grey.shade200,
              width: selected ? 2.0 : 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${i + 1}',
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: selected ? color.shade700 : Colors.grey.shade500,
                ),
              ),
              SizedBox(width: 4.0),
              Text(
                intent['name'] as String,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  color: enabled ? Colors.grey.shade800 : Colors.grey.shade400,
                  decoration: enabled ? null : TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 4.0),
              Icon(
                selected
                    ? Icons.play_circle_filled
                    : enabled
                        ? Icons.radio_button_unchecked
                        : Icons.cancel_outlined,
                size: 12.0,
                color: selected
                    ? color.shade600
                    : enabled
                        ? Colors.grey.shade400
                        : Colors.red.shade300,
              ),
            ],
          ),
        ),
      );
    }

    cascadeCards.add(
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
              scenario['title'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(children: intentChips),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.shade50,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '→ ${scenario['result']}',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: color.shade700,
                ),
              ),
            ),
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
          'Priority Cascade: First Enabled Wins',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'PrioritizedAction iterates orderedIntents. For each intent, it '
          'looks up the mapped Action in the Actions widget tree. The first '
          'one whose isEnabled returns true gets invoked.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...cascadeCards,
      ],
    ),
  );

  print('Created ${cascadeCards.length} priority cascade scenarios');

  // ============================================================
  // SECTION 4: Actions/Shortcuts Framework Context
  // ============================================================
  print('=== Section 4: In the Shortcuts Framework ===');

  final frameworkDiagram = Container(
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
          'Where PrioritizedAction Fits',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'The Actions/Shortcuts framework maps key combos to intents, '
          'then intents to actions. PrioritizedAction + PrioritizedIntents '
          'add fallback chains to this pipeline.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Framework flow
        _buildFrameworkStep(
          '1',
          'Shortcuts Widget',
          'Maps key combinations → Intent types\n'
          'e.g. Ctrl+Z → PrioritizedIntents([UndoText, UndoCanvas])',
          Icons.keyboard,
          Colors.blue,
        ),
        _buildFrameworkArrow(),
        _buildFrameworkStep(
          '2',
          'Actions Widget',
          'Maps PrioritizedIntents → PrioritizedAction\n'
          'The Actions widget dispatches to PrioritizedAction',
          Icons.play_circle,
          Colors.green,
        ),
        _buildFrameworkArrow(),
        _buildFrameworkStep(
          '3',
          'PrioritizedAction.invoke()',
          'Iterates intent.orderedIntents:\n'
          '  #1 UndoText → Actions.find → enabled? → RUN\n'
          '  #2 UndoCanvas → Actions.find → enabled? → RUN',
          Icons.sort,
          Colors.deepOrange,
        ),
        _buildFrameworkArrow(),
        _buildFrameworkStep(
          '4',
          'Selected Action Executes',
          'The first enabled action runs.\n'
          'Remaining intents are never checked.',
          Icons.done_all,
          Colors.purple,
        ),
      ],
    ),
  );

  print('Created framework context diagram');

  // ============================================================
  // SECTION 5: Real-World Use Cases
  // ============================================================
  print('=== Section 5: Real-World Use Cases ===');

  final useCases = [
    {
      'title': 'Multi-Editor Undo',
      'scenario': 'Ctrl+Z shortcut maps to PrioritizedIntents with text undo, '
          'canvas undo, and global undo intents. The active editor determines '
          'which intent\'s action is enabled.',
      'intents': ['UndoTextIntent', 'UndoCanvasIntent', 'UndoGlobalIntent'],
      'icon': Icons.undo,
      'color': Colors.blue,
    },
    {
      'title': 'Contextual Delete',
      'scenario': 'Delete key triggers PrioritizedIntents checking list deletion '
          'first, then text deletion as a fallback, depending on which '
          'widget has focus.',
      'intents': ['DeleteListItemIntent', 'DeleteTextIntent'],
      'icon': Icons.delete,
      'color': Colors.red,
    },
    {
      'title': 'Escape Key Chain',
      'scenario': 'Escape triggers PrioritizedIntents to close a modal first, '
          'deselect items second, or unfocus the search bar as a last resort.',
      'intents': ['CloseModalIntent', 'DeselectAllIntent', 'UnfocusSearchIntent'],
      'icon': Icons.close,
      'color': Colors.purple,
    },
    {
      'title': 'Save Cascade',
      'scenario': 'Ctrl+S triggers PrioritizedIntents with an active-editor save '
          'intent first, then a workspace-wide auto-save as fallback.',
      'intents': ['SaveActiveEditorIntent', 'AutoSaveAllIntent'],
      'icon': Icons.save,
      'color': Colors.green,
    },
    {
      'title': 'Copy with Priorities',
      'scenario': 'Ctrl+C tries to copy selected table cells first, then '
          'selected text, then a row reference as a last resort.',
      'intents': ['CopyCellsIntent', 'CopyTextIntent', 'CopyRowRefIntent'],
      'icon': Icons.content_copy,
      'color': Colors.teal,
    },
  ];

  final useCaseCards = <Widget>[];
  for (final uc in useCases) {
    final color = uc['color'] as MaterialColor;
    final intents = uc['intents'] as List<String>;

    final intentChips = <Widget>[];
    for (var i = 0; i < intents.length; i++) {
      intentChips.add(
        Container(
          margin: EdgeInsets.only(right: 4.0, bottom: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: color.shade50,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.shade200),
          ),
          child: Text(
            '#${i + 1} ${intents[i]}',
            style: TextStyle(
              fontSize: 9.0,
              fontWeight: FontWeight.w600,
              color: color.shade700,
              fontFamily: 'monospace',
            ),
          ),
        ),
      );
    }

    useCaseCards.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: color.shade100,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Icon(uc['icon'] as IconData, color: color.shade600, size: 22.0),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uc['title'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    uc['scenario'] as String,
                    style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
                  ),
                  SizedBox(height: 6.0),
                  Wrap(children: intentChips),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final section5 = Container(
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
        Text(
          'Real-World Use Cases',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'PrioritizedAction shines when multiple subsystems can handle the '
          'same keyboard shortcut depending on context and focus.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        ...useCaseCards,
      ],
    ),
  );

  print('Created ${useCaseCards.length} use case cards');

  // ============================================================
  // SECTION 6: PrioritizedAction API Deep Dive
  // ============================================================
  print('=== Section 6: API Deep Dive ===');

  final apiSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.brown.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.brown.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PrioritizedAction API',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        _buildApiProperty(
          'Constructor',
          'PrioritizedAction()',
          'No parameters. PrioritizedAction is stateless. All configuration '
          'comes from the PrioritizedIntents passed to invoke/isEnabled.',
          Colors.deepOrange,
        ),
        SizedBox(height: 10.0),
        _buildApiProperty(
          'isEnabled(intent)',
          'bool',
          'Returns true if ANY intent in intent.orderedIntents has an '
          'enabled Action mapped in the widget tree. Iterates and returns '
          'true at the first enabled one.',
          Colors.green,
        ),
        SizedBox(height: 10.0),
        _buildApiProperty(
          'invoke(intent)',
          'Object?',
          'Iterates intent.orderedIntents. For each, calls '
          'Actions.maybeFind to look up the Action, checks isEnabled, '
          'and invokes the first enabled one.',
          Colors.blue,
        ),
        SizedBox(height: 14.0),
        // PrioritizedIntents API
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PrioritizedIntents API',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
              SizedBox(height: 8.0),
              _buildApiProperty(
                'orderedIntents',
                'List<Intent>',
                'The priority-ordered list of intents. First = highest '
                'priority. Each intent maps to an Action in the widget tree.',
                Colors.orange,
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        // Constructor signatures
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '// PrioritizedAction — no params\n'
                'PrioritizedAction()\n'
                '\n'
                '// PrioritizedIntents — the intent list\n'
                'const PrioritizedIntents({\n'
                '  required List<Intent> orderedIntents,\n'
                '})',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.greenAccent.shade200,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created API deep dive section');

  // ============================================================
  // SECTION 7: PrioritizedAction in a Widget Tree
  // ============================================================
  print('=== Section 7: PrioritizedAction in Widget Tree ===');

  // Build a real Actions widget tree with PrioritizedAction
  // registered for PrioritizedIntents

  final treeSection = Actions(
    actions: <Type, Action<Intent>>{
      PrioritizedIntents: PrioritizedAction(),
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.cyan.shade50,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: Colors.cyan.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Live Widget Tree with PrioritizedAction',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'This section is wrapped in a real Actions widget with '
            'PrioritizedAction registered for PrioritizedIntents. '
            'The tree maps PrioritizedIntents → PrioritizedAction().',
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 14.0),
          // Widget tree visualization
          _buildTreeNode('Shortcuts', 'Key combo → PrioritizedIntents', Colors.blue, 0),
          _buildTreeConnector(),
          _buildTreeNode('Actions', 'PrioritizedIntents → PrioritizedAction()', Colors.green, 0),
          _buildTreeConnector(),
          _buildTreeNode('PrioritizedAction', 'Iterates orderedIntents', Colors.orange, 1),
          _buildTreeConnector(),
          Row(
            children: [
              SizedBox(width: 40.0),
              Expanded(
                child: Column(
                  children: [
                    _buildTreeNode('#1 IntentA', 'Highest priority', Colors.red, 2),
                    SizedBox(height: 4.0),
                    _buildTreeNode('#2 IntentB', 'Fallback', Colors.purple, 2),
                    SizedBox(height: 4.0),
                    _buildTreeNode('#3 IntentC', 'Last resort', Colors.grey, 2),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          // Key insight
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
                    'Key: PrioritizedAction is registered once for '
                    'PrioritizedIntents. Individual intents (IntentA, B, C) '
                    'must have their OWN actions registered elsewhere in '
                    'the widget tree for lookup to succeed.',
                    style: TextStyle(fontSize: 10.0, color: Colors.amber.shade900),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          // Actions for inner intents
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '// Registration pattern:\n'
              'Actions(\n'
              '  actions: {\n'
              '    PrioritizedIntents: PrioritizedAction(),\n'
              '    IntentA: MyActionA(), // must exist\n'
              '    IntentB: MyActionB(), // must exist\n'
              '    IntentC: MyActionC(), // must exist\n'
              '  },\n'
              ')',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Colors.cyanAccent.shade200,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Created live widget tree section');

  // ============================================================
  // SECTION 8: PrioritizedAction vs Single Action Comparison
  // ============================================================
  print('=== Section 8: PrioritizedAction vs Single Action ===');

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
                color: Colors.deepOrange.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'PrioritizedAction',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange.shade800,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Text('vs', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500)),
            SizedBox(width: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'Single Action',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildComparisonRow(
          'State Model',
          'Stateless — config in PrioritizedIntents',
          'Often stateful — owns its data',
        ),
        _buildComparisonRow(
          'Fallback',
          'Built-in priority chain',
          'No fallback — single handler',
        ),
        _buildComparisonRow(
          'Intent Type',
          'PrioritizedIntents (wraps list)',
          'Custom Intent subclass',
        ),
        _buildComparisonRow(
          'isEnabled',
          'True if ANY inner intent\'s action enabled',
          'Single boolean check',
        ),
        _buildComparisonRow(
          'Registration',
          'One entry + all inner intent actions',
          'One entry per intent',
        ),
        _buildComparisonRow(
          'Use Case',
          'Context-dependent shortcuts',
          'Fixed single-purpose handler',
        ),
      ],
    ),
  );

  print('Created comparison section');

  // ============================================================
  // ASSEMBLY
  // ============================================================
  print('=== Assembling PrioritizedAction Deep Demo ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFFBF360C),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Text(
                'PrioritizedAction Deep Demo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Stateless priority-ordered fallback chains • Actions/Shortcuts',
                style: TextStyle(fontSize: 11.0, color: Colors.white60),
              ),
            ],
          ),
        ),
        conceptCard,
        architectureSection,
        section3,
        frameworkDiagram,
        section5,
        apiSection,
        treeSection,
        comparisonSection,
        SizedBox(height: 30.0),
      ],
    ),
  );

  print('PrioritizedAction Deep Demo complete: 8 sections');
  return result;
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildFrameworkStep(
  String step,
  String title,
  String description,
  IconData icon,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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
                  fontSize: 12.0,
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
        Icon(icon, color: color.shade400, size: 22.0),
      ],
    ),
  );
}

Widget _buildFrameworkArrow() {
  return Container(
    height: 16.0,
    alignment: Alignment.center,
    child: Icon(Icons.arrow_downward, size: 14.0, color: Colors.grey.shade400),
  );
}

Widget _buildApiProperty(
  String name,
  String type,
  String description,
  MaterialColor color,
) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                color: color.shade800,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.shade50,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: color.shade600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700),
        ),
      ],
    ),
  );
}

Widget _buildTreeNode(String name, String desc, MaterialColor color, int depth) {
  return Container(
    margin: EdgeInsets.only(left: depth * 20.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.shade300),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color.shade600,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: color.shade800,
              ),
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTreeConnector() {
  return Container(
    margin: EdgeInsets.only(left: 23.0),
    height: 10.0,
    width: 2.0,
    color: Colors.grey.shade400,
  );
}

Widget _buildComparisonRow(String aspect, String prioritized, String single) {
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
                  color: Colors.deepOrange.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  prioritized,
                  style: TextStyle(fontSize: 9.0, color: Colors.deepOrange.shade700),
                ),
              ),
            ),
            SizedBox(width: 6.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  single,
                  style: TextStyle(fontSize: 9.0, color: Colors.blue.shade700),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
