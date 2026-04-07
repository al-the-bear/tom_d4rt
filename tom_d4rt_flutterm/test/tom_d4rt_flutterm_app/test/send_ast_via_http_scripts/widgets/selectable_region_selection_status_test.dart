// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectableRegionSelectionStatus – the enum that
// describes the current state of text selection within a SelectableRegion:
// none (idle), selecting (gesture in progress), and selected (selection made).
// Deep Demo: Visualises the three-state lifecycle, transitions, and practical
// reactive UI patterns for each state value.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableRegionSelectionStatus Deep Demo executing');

  // ============================================================
  // SECTION 1: The Three States
  // ============================================================
  print('=== Section 1: The Three States ===');

  final stateDefinitions = <Map<String, dynamic>>[
    {
      'name': 'none',
      'subtitle': 'Idle – No Active Selection',
      'icon': Icons.radio_button_unchecked,
      'color': Colors.blueGrey,
      'description':
          'The region has no active selection. The user has not started a '
          'selection gesture, or a previous selection was cleared. This is '
          'the resting state.',
      'visual': 0.0,
      'uiHint': 'Default appearance – no overlays, no highlights.',
    },
    {
      'name': 'selecting',
      'subtitle': 'Active – Gesture in Progress',
      'icon': Icons.pan_tool_alt,
      'color': Colors.orange,
      'description':
          'The user is actively dragging to select text. The selection '
          'handles may be moving and the highlight is expanding. This is '
          'a transient state that lasts while the pointer is down.',
      'visual': 0.5,
      'uiHint': 'Show selection highlight, dim surrounding content.',
    },
    {
      'name': 'selected',
      'subtitle': 'Complete – Selection Made',
      'icon': Icons.check_circle_outline,
      'color': Colors.green,
      'description':
          'A selection exists and the user has released the pointer. '
          'Selection handles are visible and the user can copy, share, '
          'or otherwise act on the selected content.',
      'visual': 1.0,
      'uiHint': 'Show context menu / copy button, keep highlight.',
    },
  ];

  final stateCards = <Widget>[];
  for (final def in stateDefinitions) {
    final color = def['color'] as Color;
    final fill = def['visual'] as double;
    print('State: ${def['name']} – ${def['subtitle']}');

    stateCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.12),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(11.0)),
              ),
              child: Row(
                children: [
                  Icon(def['icon'] as IconData, color: color, size: 26.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SelectableRegionSelectionStatus.${def['name']}',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'monospace',
                            color: color,
                          ),
                        ),
                        Text(
                          def['subtitle'] as String,
                          style: TextStyle(fontSize: 11.5, color: color.withValues(alpha: 0.8)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    def['description'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
                  ),
                  const SizedBox(height: 10.0),
                  // Progress bar
                  Row(
                    children: [
                      const Text('Lifecycle: ', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600)),
                      Expanded(
                        child: Container(
                          height: 8.0,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: fill == 0.0 ? 0.03 : fill,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${(fill * 100).toInt()}%',
                        style: TextStyle(fontSize: 11.0, color: color, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.palette, size: 14.0, color: color),
                        const SizedBox(width: 6.0),
                        Text(
                          def['uiHint'] as String,
                          style: TextStyle(fontSize: 11.0, color: color, fontStyle: FontStyle.italic),
                        ),
                      ],
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
  // SECTION 2: State Machine Transitions
  // ============================================================
  print('=== Section 2: State Machine ===');

  final transitions = <Map<String, dynamic>>[
    {
      'from': 'none',
      'to': 'selecting',
      'trigger': 'Pointer down + drag',
      'fromColor': Colors.blueGrey,
      'toColor': Colors.orange,
    },
    {
      'from': 'selecting',
      'to': 'selected',
      'trigger': 'Pointer up (selection made)',
      'fromColor': Colors.orange,
      'toColor': Colors.green,
    },
    {
      'from': 'selected',
      'to': 'none',
      'trigger': 'Tap outside / clear',
      'fromColor': Colors.green,
      'toColor': Colors.blueGrey,
    },
    {
      'from': 'selecting',
      'to': 'none',
      'trigger': 'Pointer up (no selection)',
      'fromColor': Colors.orange,
      'toColor': Colors.blueGrey,
    },
    {
      'from': 'selected',
      'to': 'selecting',
      'trigger': 'Drag handle to resize',
      'fromColor': Colors.green,
      'toColor': Colors.orange,
    },
  ];

  final transitionWidgets = <Widget>[];
  for (var i = 0; i < transitions.length; i++) {
    final t = transitions[i];
    print('Transition ${i + 1}: ${t['from']} → ${t['to']} on ${t['trigger']}');
    transitionWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            // From badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: (t['fromColor'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: (t['fromColor'] as Color).withValues(alpha: 0.4)),
              ),
              child: Text(
                t['from'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: t['fromColor'] as Color,
                ),
              ),
            ),
            // Arrow
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Text(
                    t['trigger'] as String,
                    style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600),
                  ),
                  const Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey),
                ],
              ),
            ),
            // To badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: (t['toColor'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: (t['toColor'] as Color).withValues(alpha: 0.4)),
              ),
              child: Text(
                t['to'] as String,
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: t['toColor'] as Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Visual state machine diagram
  final stateMachineDiagram = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        const Text(
          'Selection Lifecycle State Machine',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black87),
        ),
        const SizedBox(height: 14.0),
        // Visual circles with arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStateBubble('none', Colors.blueGrey, Icons.radio_button_unchecked),
            Column(
              children: [
                const Icon(Icons.arrow_forward, color: Colors.orange, size: 20.0),
                Text('drag', style: TextStyle(fontSize: 9.0, color: Colors.orange.shade700)),
              ],
            ),
            _buildStateBubble('selecting', Colors.orange, Icons.pan_tool_alt),
            Column(
              children: [
                const Icon(Icons.arrow_forward, color: Colors.green, size: 20.0),
                Text('release', style: TextStyle(fontSize: 9.0, color: Colors.green.shade700)),
              ],
            ),
            _buildStateBubble('selected', Colors.green, Icons.check_circle_outline),
          ],
        ),
        const SizedBox(height: 8.0),
        // Return arrow
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.undo, size: 14.0, color: Colors.blueGrey),
              const SizedBox(width: 6.0),
              Text(
                'tap outside → none',
                style: TextStyle(fontSize: 10.0, color: Colors.blueGrey.shade700),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        ...transitionWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Practical UI Reactions per State
  // ============================================================
  print('=== Section 3: UI Reactions ===');

  // Each state has different UI implications
  final uiReactions = <Map<String, dynamic>>[
    {
      'state': 'none',
      'color': Colors.blueGrey,
      'reactions': <Map<String, String>>[
        {'ui': 'Text Highlight', 'behavior': 'None – text appears normal'},
        {'ui': 'Selection Handles', 'behavior': 'Hidden'},
        {'ui': 'Context Menu', 'behavior': 'Hidden'},
        {'ui': 'Surrounding Content', 'behavior': 'Normal opacity'},
        {'ui': 'Toolbar', 'behavior': 'No selection-related actions'},
      ],
    },
    {
      'state': 'selecting',
      'color': Colors.orange,
      'reactions': <Map<String, String>>[
        {'ui': 'Text Highlight', 'behavior': 'Growing/shrinking as drag moves'},
        {'ui': 'Selection Handles', 'behavior': 'Visible at drag point'},
        {'ui': 'Context Menu', 'behavior': 'Hidden during drag'},
        {'ui': 'Surrounding Content', 'behavior': 'Could dim to focus selection'},
        {'ui': 'Toolbar', 'behavior': 'Could show live character count'},
      ],
    },
    {
      'state': 'selected',
      'color': Colors.green,
      'reactions': <Map<String, String>>[
        {'ui': 'Text Highlight', 'behavior': 'Stable highlight on selected text'},
        {'ui': 'Selection Handles', 'behavior': 'Visible and draggable to resize'},
        {'ui': 'Context Menu', 'behavior': 'Shown – copy / share / select all'},
        {'ui': 'Surrounding Content', 'behavior': 'Return to normal or stay dimmed'},
        {'ui': 'Toolbar', 'behavior': 'Show copy button, word count, etc.'},
      ],
    },
  ];

  final reactionTables = <Widget>[];
  for (final ur in uiReactions) {
    final color = ur['color'] as Color;
    final reactions = ur['reactions'] as List<Map<String, String>>;

    reactionTables.add(
      Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(9.0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'Status: ${ur['state']}',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            // Rows
            ...reactions.map((r) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        r['ui']!,
                        style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        r['behavior']!,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: Enum Properties
  // ============================================================
  print('=== Section 4: Enum Properties ===');

  final enumProps = <Map<String, String>>[
    {
      'property': 'index',
      'type': 'int',
      'description': 'Ordinal position in the enum declaration (0, 1, 2)',
    },
    {
      'property': 'name',
      'type': 'String',
      'description': 'Dart 2.17 name getter – returns "none", "selecting", or "selected"',
    },
    {
      'property': 'values',
      'type': 'List<SelectableRegionSelectionStatus>',
      'description': 'Static list of all three enum values in declaration order',
    },
  ];

  final enumPropCards = <Widget>[];
  for (final ep in enumProps) {
    enumPropCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(left: BorderSide(color: Colors.deepPurple, width: 3.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '.${ep['property']}',
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '→ ${ep['type']}',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    ep['description']!,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Enum values table with index
  final enumValuesTable = Container(
    margin: const EdgeInsets.only(top: 10.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Enum Values & Indices',
          style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: const Row(
            children: [
              Expanded(child: Text('Index', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 2, child: Text('Value', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 3, child: Text('.name', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        _buildEnumRow(0, 'none', Colors.blueGrey),
        _buildEnumRow(1, 'selecting', Colors.orange),
        _buildEnumRow(2, 'selected', Colors.green),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Comparison Patterns with Other Flutter Enums
  // ============================================================
  print('=== Section 5: Flutter Enum Patterns ===');

  final analogies = <Map<String, dynamic>>[
    {
      'enum': 'ConnectionState',
      'values': 'none → waiting → active → done',
      'parallel': 'none → selecting → selected',
      'icon': Icons.cloud_outlined,
      'color': Colors.blue,
    },
    {
      'enum': 'AnimationStatus',
      'values': 'dismissed → forward → reverse → completed',
      'parallel': 'none → selecting → selected',
      'icon': Icons.animation,
      'color': Colors.purple,
    },
    {
      'enum': 'AppLifecycleState',
      'values': 'inactive → resumed → paused → detached',
      'parallel': 'idle → active → settled',
      'icon': Icons.phone_android,
      'color': Colors.teal,
    },
  ];

  final analogyCards = <Widget>[];
  for (final a in analogies) {
    final color = a['color'] as Color;
    analogyCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(a['icon'] as IconData, color: color, size: 20.0),
                const SizedBox(width: 8.0),
                Text(
                  a['enum'] as String,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Row(
              children: [
                const SizedBox(width: 28.0),
                Expanded(
                  child: Text(
                    a['values'] as String,
                    style: TextStyle(fontSize: 11.5, fontFamily: 'monospace', color: Colors.grey.shade600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                const SizedBox(width: 28.0),
                Text('≈ ', style: TextStyle(color: Colors.grey.shade500)),
                Text(
                  a['parallel'] as String,
                  style: TextStyle(fontSize: 11.5, fontFamily: 'monospace', color: Colors.deepPurple.shade700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: Live Interactive Demo
  // ============================================================
  print('=== Section 6: Live Demo ===');

  final liveDemo = _SelectionStatusLiveDemo();

  // ============================================================
  // SECTION 7: Switch Pattern
  // ============================================================
  print('=== Section 7: Switch Pattern ===');

  final switchPatternLines = [
    'Widget buildForStatus(SelectableRegionSelectionStatus status) {',
    '  return switch (status) {',
    '    SelectableRegionSelectionStatus.none => const SizedBox.shrink(),',
    '    SelectableRegionSelectionStatus.selecting =>',
    '        const CircularProgressIndicator(),',
    '    SelectableRegionSelectionStatus.selected =>',
    '        const Icon(Icons.check, color: Colors.green),',
    '  };',
    '}',
  ];

  final switchCodeLines = <Widget>[];
  for (var i = 0; i < switchPatternLines.length; i++) {
    final line = switchPatternLines[i];
    final isKey = line.contains('SelectableRegionSelectionStatus.');
    switchCodeLines.add(
      Row(
        children: [
          SizedBox(
            width: 24.0,
            child: Text(
              '${i + 1}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade400),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 1.5),
              color: isKey ? Colors.amber.withValues(alpha: 0.15) : Colors.transparent,
              child: Text(
                line,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: isKey ? Colors.deepPurple.shade800 : Colors.grey.shade800,
                  fontWeight: isKey ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final switchPatternBlock = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.code, size: 18.0, color: Colors.deepPurple),
            const SizedBox(width: 8.0),
            const Text(
              'Dart 3 Switch Expression',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700, color: Colors.deepPurple),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ...switchCodeLines,
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Because SelectableRegionSelectionStatus is a sealed-like enum with '
            'exactly three values, Dart\'s exhaustive switch checks all branches. '
            'No default case needed – the compiler ensures completeness.',
            style: TextStyle(fontSize: 11.5, color: Colors.deepPurple.shade700, height: 1.35),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Visual Status Simulator
  // ============================================================
  print('=== Section 8: Status Simulator ===');

  final statusSimulator = _StatusSimulatorWidget();

  // ============================================================
  // SECTION 9: Relationship to SelectableRegion
  // ============================================================
  print('=== Section 9: Relationship Diagram ===');

  final relationshipDiagram = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How Status Flows Through the System',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 14.0),
        // Flow diagram
        _buildFlowStep('1', 'User Gesture', 'Pointer down + drag begins', Colors.blue, Icons.touch_app),
        _buildFlowArrow(),
        _buildFlowStep('2', 'SelectableRegion', 'Detects gesture, updates internal status', Colors.deepPurple, Icons.account_tree),
        _buildFlowArrow(),
        _buildFlowStep('3', 'StatusScope Updated', 'New SelectableRegionSelectionStatusScope pushed', Colors.indigo, Icons.layers),
        _buildFlowArrow(),
        _buildFlowStep('4', 'Dependants Rebuild', 'Widgets calling maybeOf/of receive new status', Colors.teal, Icons.refresh),
        _buildFlowArrow(),
        _buildFlowStep('5', 'UI Reacts', 'Highlights, menus, and decorations update', Colors.green, Icons.visibility),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The status enum itself is passive data. The SelectableRegion '
                  'is responsible for computing the correct value and pushing it '
                  'through the scope when transitions occur.',
                  style: TextStyle(fontSize: 11.5, color: Colors.amber.shade900, height: 1.35),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.format_list_numbered, 'text': 'Three-value enum: none, selecting, selected'},
    {'icon': Icons.timeline, 'text': 'Models the complete lifecycle of a selection gesture'},
    {'icon': Icons.sync_alt, 'text': 'Transitions driven by user gestures (drag/release/tap)'},
    {'icon': Icons.layers, 'text': 'Exposed via SelectableRegionSelectionStatusScope InheritedWidget'},
    {'icon': Icons.widgets, 'text': 'Enables reactive widgets that adapt to selection state'},
    {'icon': Icons.code, 'text': 'Works with Dart 3 exhaustive switch expressions'},
  ];

  final summaryCards = <Widget>[];
  for (final sp in summaryPoints) {
    summaryCards.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.deepPurple),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUILD FINAL TABBED LAYOUT
  // ============================================================
  print('Building tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SelectableRegionSelectionStatus'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'States'),
            Tab(text: 'Machine'),
            Tab(text: 'UI Reactions'),
            Tab(text: 'Enum API'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Patterns'),
            Tab(text: 'Simulator'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: States
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('Three Selection States',
                    'SelectableRegionSelectionStatus is an enum that describes '
                    'where a selection gesture currently is in its lifecycle.'),
                const SizedBox(height: 14.0),
                ...stateCards,
              ],
            ),
          ),
          // Tab 2: Machine
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('State Machine',
                    'The three states form a simple state machine driven by '
                    'user gestures. Transitions are deterministic.'),
                const SizedBox(height: 14.0),
                stateMachineDiagram,
              ],
            ),
          ),
          // Tab 3: UI Reactions
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('UI Reactions per State',
                    'Each status value suggests different UI behaviours for '
                    'responsive, selection-aware interfaces.'),
                const SizedBox(height: 14.0),
                ...reactionTables,
              ],
            ),
          ),
          // Tab 4: Enum API
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('Enum Properties',
                    'Standard Dart enum properties available on each value.'),
                const SizedBox(height: 14.0),
                ...enumPropCards,
                enumValuesTable,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('Live Selection Tracking',
                    'Select the text below and watch the status indicator '
                    'change in real time.'),
                const SizedBox(height: 14.0),
                liveDemo,
              ],
            ),
          ),
          // Tab 6: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('Usage Patterns',
                    'Idiomatic Dart 3 switch expressions and comparison patterns.'),
                const SizedBox(height: 14.0),
                switchPatternBlock,
                const SizedBox(height: 16.0),
                const Text(
                  'Analogous Flutter Enums',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8.0),
                ...analogyCards,
                const SizedBox(height: 14.0),
                relationshipDiagram,
              ],
            ),
          ),
          // Tab 7: Simulator
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('Status Simulator',
                    'Tap the buttons to simulate status transitions and see '
                    'how a responsive widget would react visually.'),
                const SizedBox(height: 14.0),
                statusSimulator,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet2('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.withValues(alpha: 0.05),
                        Colors.indigo.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryCards,
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

// ---------------------------------------------------------------------------
// Helper: section bullet
// ---------------------------------------------------------------------------
Widget _buildSRSSBullet2(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.deepPurple.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: Colors.deepPurple, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700, color: Colors.deepPurple)),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(body, style: TextStyle(fontSize: 13.0, color: Colors.grey.shade700, height: 1.4)),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: state bubble for diagram
// ---------------------------------------------------------------------------
Widget _buildStateBubble(String label, Color color, IconData icon) {
  return Column(
    children: [
      Container(
        width: 64.0,
        height: 64.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.15),
          border: Border.all(color: color, width: 2.0),
        ),
        child: Center(child: Icon(icon, color: color, size: 24.0)),
      ),
      const SizedBox(height: 4.0),
      Text(label, style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: color)),
    ],
  );
}

// ---------------------------------------------------------------------------
// Helper: enum row
// ---------------------------------------------------------------------------
Widget _buildEnumRow(int index, String name, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$index',
            style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: Colors.grey.shade600),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(width: 8.0, height: 8.0, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 6.0),
              Text(name, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', fontWeight: FontWeight.w600, color: color)),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            '"$name"',
            style: TextStyle(fontSize: 12.0, fontFamily: 'monospace', color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Helper: flow step and arrow
// ---------------------------------------------------------------------------
Widget _buildFlowStep(String num, String title, String desc, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          child: Center(child: Text(num, style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Colors.white))),
        ),
        const SizedBox(width: 10.0),
        Icon(icon, color: color, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: color)),
              Text(desc, style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowArrow() {
  return Padding(
    padding: const EdgeInsets.only(left: 14.0),
    child: Column(
      children: [
        Container(width: 2.0, height: 6.0, color: Colors.grey.shade400),
        Icon(Icons.arrow_drop_down, size: 16.0, color: Colors.grey.shade400),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Selection Demo
// ---------------------------------------------------------------------------
class _SelectionStatusLiveDemo extends StatefulWidget {
  @override
  State<_SelectionStatusLiveDemo> createState() => _SelectionStatusLiveDemoState();
}

class _SelectionStatusLiveDemoState extends State<_SelectionStatusLiveDemo> {
  String _statusLabel = 'none';
  Color _statusColor = Colors.blueGrey;
  int _eventCount = 0;
  final List<String> _history = [];

  void _onSelectionChanged(dynamic content) {
    setState(() {
      _eventCount++;
      if (content != null && (content.plainText as String).isNotEmpty) {
        _statusLabel = 'selected';
        _statusColor = Colors.green;
        final len = (content.plainText as String).length;
        _history.insert(0, '[$_eventCount] selected: $len chars');
      } else {
        _statusLabel = 'none';
        _statusColor = Colors.blueGrey;
        _history.insert(0, '[$_eventCount] cleared');
      }
      if (_history.length > 8) _history.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _statusColor.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(color: _statusColor.withValues(alpha: 0.1), blurRadius: 8.0),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator
          Row(
            children: [
              Container(
                width: 12.0,
                height: 12.0,
                decoration: BoxDecoration(shape: BoxShape.circle, color: _statusColor),
              ),
              const SizedBox(width: 8.0),
              Text(
                'Current: $_statusLabel',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: _statusColor,
                ),
              ),
              const Spacer(),
              Text(
                'events: $_eventCount',
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Selectable content
          SelectionArea(
            onSelectionChanged: _onSelectionChanged,
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: _statusColor.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _statusColor.withValues(alpha: 0.15)),
              ),
              child: const Text(
                'The SelectableRegionSelectionStatus enum is designed as a '
                'lightweight value type that carries no logic of its own. '
                'Its sole purpose is to describe the phase of a selection '
                'gesture: has the user started selecting, is the gesture '
                'ongoing, or has a final selection been made?\n\n'
                'By keeping the enum intentionally minimal, Flutter allows '
                'widgets to react to selection lifecycle events without '
                'coupling to the complex gesture-recognition machinery '
                'inside SelectableRegion.',
                style: TextStyle(fontSize: 13.0, height: 1.6, color: Colors.black87),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          // Event history
          if (_history.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Event History', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w700, color: Colors.grey.shade600)),
                  const SizedBox(height: 4.0),
                  ..._history.map((h) => Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      h,
                      style: TextStyle(fontSize: 10.5, fontFamily: 'monospace', color: Colors.grey.shade600),
                    ),
                  )),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Status Simulator – tap buttons to simulate transitions
// ---------------------------------------------------------------------------
class _StatusSimulatorWidget extends StatefulWidget {
  @override
  State<_StatusSimulatorWidget> createState() => _StatusSimulatorWidgetState();
}

class _StatusSimulatorWidgetState extends State<_StatusSimulatorWidget> {
  String _current = 'none';
  Color _color = Colors.blueGrey;
  IconData _icon = Icons.radio_button_unchecked;
  final List<String> _log = [];

  void _transition(String next) {
    final from = _current;
    setState(() {
      _current = next;
      switch (next) {
        case 'none':
          _color = Colors.blueGrey;
          _icon = Icons.radio_button_unchecked;
        case 'selecting':
          _color = Colors.orange;
          _icon = Icons.pan_tool_alt;
        case 'selected':
          _color = Colors.green;
          _icon = Icons.check_circle_outline;
      }
      _log.insert(0, '$from → $next');
      if (_log.length > 10) _log.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Current state display
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _color.withValues(alpha: 0.15),
              border: Border.all(color: _color, width: 3.0),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_icon, color: _color, size: 32.0),
                  const SizedBox(height: 4.0),
                  Text(
                    _current,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: _color),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          // Transition buttons
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            alignment: WrapAlignment.center,
            children: [
              _simButton('→ none', Colors.blueGrey, () => _transition('none')),
              _simButton('→ selecting', Colors.orange, () => _transition('selecting')),
              _simButton('→ selected', Colors.green, () => _transition('selected')),
            ],
          ),
          const SizedBox(height: 16.0),
          // Reactive mock widget
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: _color.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  _current == 'none'
                      ? Icons.text_fields
                      : _current == 'selecting'
                          ? Icons.highlight_alt
                          : Icons.content_copy,
                  color: _color,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    _current == 'none'
                        ? 'Standard text display – no selection active'
                        : _current == 'selecting'
                            ? 'Selection in progress – highlight expanding...'
                            : 'Selection complete – Copy/Share actions available',
                    style: TextStyle(fontSize: 12.5, color: _color, height: 1.3),
                  ),
                ),
              ],
            ),
          ),
          if (_log.isNotEmpty) ...[
            const SizedBox(height: 12.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Transition Log', style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Colors.grey.shade500)),
                  const SizedBox(height: 4.0),
                  ..._log.map((l) => Text(
                    l,
                    style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.grey.shade600),
                  )),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _simButton(String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: color),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: color),
        ),
      ),
    );
  }
}
