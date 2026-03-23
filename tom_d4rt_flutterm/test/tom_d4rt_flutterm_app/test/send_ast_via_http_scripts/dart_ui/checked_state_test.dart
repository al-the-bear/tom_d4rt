// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for CheckedState from dart:ui
// CheckedState defines tri-state values for checkbox accessibility semantics
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== CheckedState Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CheckedState Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('CheckedState defines tri-state checkbox semantics');
  print('All values: ${ui.CheckedState.values}');
  print('Count: ${ui.CheckedState.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final s in ui.CheckedState.values) {
    print('${s.name}: index=${s.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: unchecked
  // ═══════════════════════════════════════════════════════════════════════════

  final unchecked = ui.CheckedState.isFalse;
  print('\nunchecked: ${unchecked.name}, index=${unchecked.index}');
  print('Represents: Checkbox(value: false)');
  print('Screen reader: "not checked"');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: checked
  // ═══════════════════════════════════════════════════════════════════════════

  final checked = ui.CheckedState.isTrue;
  print('\nchecked: ${checked.name}, index=${checked.index}');
  print('Represents: Checkbox(value: true)');
  print('Screen reader: "checked"');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: mixed
  // ═══════════════════════════════════════════════════════════════════════════

  final mixed = ui.CheckedState.mixed;
  print('\nmixed: ${mixed.name}, index=${mixed.index}');
  print('Represents: Checkbox(value: null, tristate: true)');
  print('Screen reader: "partially checked" or "indeterminate"');
  print('Used for parent checkbox when children have mixed states');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Widget Mapping
  // ═══════════════════════════════════════════════════════════════════════════

  final mappings = <ui.CheckedState, Map<String, String>>{
    unchecked: {
      'widget': 'Checkbox(value: false)',
      'reader': 'not checked',
      'icon': 'empty box',
    },
    checked: {
      'widget': 'Checkbox(value: true)',
      'reader': 'checked',
      'icon': 'check mark',
    },
    mixed: {
      'widget': 'Checkbox(value: null)',
      'reader': 'partially checked',
      'icon': 'dash/minus',
    },
  };

  for (final e in mappings.entries) {
    print('${e.key.name} → ${e.value['widget']} → "${e.value['reader']}"');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: State Transitions
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- State Transitions ---');
  print('Bistate: unchecked → checked → unchecked (cycle)');
  print('Tristate: unchecked → checked → mixed → unchecked (cycle)');
  print('Parent checkbox: mixed when children disagree');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Equality
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Equality ---');
  print('unchecked == unchecked: ${unchecked == ui.CheckedState.isFalse}');
  print('checked == checked: ${checked == ui.CheckedState.isTrue}');
  print('checked == mixed: ${checked == mixed}');
  print('unchecked == mixed: ${unchecked == mixed}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Semantics Context
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Semantics integration ---');
  print('SemanticsNode.checkedState reports this to assistive technology');
  print('Used with SemanticsFlag.hasCheckedState');
  print('Related: Tristate for switch/toggle controls');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  final stateIcons = <ui.CheckedState, IconData>{
    unchecked: Icons.check_box_outline_blank,
    checked: Icons.check_box,
    mixed: Icons.indeterminate_check_box,
  };

  final stateColors = <ui.CheckedState, Color>{
    unchecked: Colors.grey,
    checked: Colors.green,
    mixed: Colors.orange,
  };

  Widget stateCard(ui.CheckedState state) {
    final color = stateColors[state] ?? Colors.grey;
    final icon = stateIcons[state] ?? Icons.help;
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, size: 44, color: color),
          SizedBox(height: 6),
          Text(
            state.name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            'index: ${state.index}',
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget mappingRow(
    String widgetVal,
    String stateName,
    String readerText,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              widgetVal,
              style: TextStyle(fontFamily: 'monospace', fontSize: 11),
            ),
          ),
          Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
          SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: Text(
              stateName,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
          Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
          SizedBox(width: 4),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '"$readerText"',
                style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget transitionArrow(String from, String to, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              from,
              style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward, size: 16, color: color),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              to,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoTile(IconData icon, String title, String content, Color color) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 9, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.teal, Colors.green[700]!]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_box, color: Colors.white, size: 36),
              SizedBox(height: 8),
              Text(
                'CheckedState Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Tri-state checkbox accessibility semantics',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // States overview
        Text(
          '1. All CheckedState Values',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            for (int i = 0; i < ui.CheckedState.values.length; i++) ...[
              if (i > 0) SizedBox(width: 8),
              Expanded(child: stateCard(ui.CheckedState.values[i])),
            ],
          ],
        ),
        SizedBox(height: 16),

        // Widget → State → Screen Reader mapping
        Text(
          '2. Widget → State → Screen Reader',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                mappingRow(
                  'value: false',
                  'unchecked',
                  'not checked',
                  Colors.grey,
                ),
                Divider(height: 1),
                mappingRow('value: true', 'checked', 'checked', Colors.green),
                Divider(height: 1),
                mappingRow(
                  'value: null',
                  'mixed',
                  'partially checked',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // State transitions
        Text(
          '3. State Transitions',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Bistate (tristate: false)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 4),
        transitionArrow('unchecked', 'checked', Colors.green),
        transitionArrow('checked', 'unchecked', Colors.grey),
        SizedBox(height: 8),
        Text(
          'Tristate (tristate: true)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.orange,
          ),
        ),
        SizedBox(height: 4),
        transitionArrow('unchecked', 'checked', Colors.green),
        transitionArrow('checked', 'mixed', Colors.orange),
        transitionArrow('mixed', 'unchecked', Colors.grey),
        SizedBox(height: 16),

        // Parent-child scenario
        Text(
          '4. Parent Checkbox Scenario',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.indeterminate_check_box,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Select All (mixed)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.green, size: 18),
                        SizedBox(width: 4),
                        Text(
                          'Item A (checked)',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.grey,
                          size: 18,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Item B (unchecked)',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.green, size: 18),
                        SizedBox(width: 4),
                        Text(
                          'Item C (checked)',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Parent is .mixed because children disagree',
                style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Equality
        Text(
          '5. Equality',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                for (final pair in [
                  MapEntry(
                    'unchecked == unchecked',
                    '${unchecked == ui.CheckedState.isFalse}',
                  ),
                  MapEntry(
                    'checked == checked',
                    '${checked == ui.CheckedState.isTrue}',
                  ),
                  MapEntry('checked == mixed', '${checked == mixed}'),
                  MapEntry('unchecked == mixed', '${unchecked == mixed}'),
                ])
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(pair.key, style: TextStyle(fontSize: 11)),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: pair.value == 'true'
                                ? Colors.green.withValues(alpha: 0.15)
                                : Colors.red.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            pair.value,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: pair.value == 'true'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Info tiles
        Text(
          '6. Context',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: infoTile(
                Icons.accessibility,
                'Purpose',
                'Screen reader\naccessibility',
                Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: infoTile(
                Icons.check_box,
                'Widget',
                'Checkbox\ntristate mode',
                Colors.green,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: infoTile(
                Icons.hub,
                'Semantics',
                'SemanticsNode\n.checkedState',
                Colors.purple,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.CheckedState.values.length} states: unchecked, checked, mixed • Used by Checkbox and Semantics widgets • Enables tristate accessibility',
                  style: TextStyle(fontSize: 11, color: Colors.teal),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
