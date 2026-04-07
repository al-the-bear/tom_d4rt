// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — RadioGroup
// Demonstrates RadioGroup<T>: a widget that provides groupValue and
// onChanged to all descendant Radio<T> widgets through an inherited scope.
// Eliminates the need to pass groupValue/onChanged to every Radio individually.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RadioGroup Deep Demo executing');

  // ============================================================
  // SECTION 1: What RadioGroup Is — Concept
  // ============================================================
  print('=== Section 1: RadioGroup Concept ===');

  // RadioGroup<T> is a widget that wraps one or more Radio<T> widgets.
  // It provides the groupValue and onChanged callback via an inherited
  // widget scope, meaning descendant Radio widgets do NOT need their
  // own groupValue or onChanged — they inherit them from RadioGroup.
  //
  // Before RadioGroup:
  //   Radio(value: 1, groupValue: selected, onChanged: (v) => ...)
  //   Radio(value: 2, groupValue: selected, onChanged: (v) => ...)
  //   Radio(value: 3, groupValue: selected, onChanged: (v) => ...)
  //
  // With RadioGroup:
  //   RadioGroup(groupValue: selected, onChanged: (v) => ...,
  //     child: Column(children: [
  //       Radio(value: 1),  // inherits groupValue + onChanged
  //       Radio(value: 2),
  //       Radio(value: 3),
  //     ]),
  //   )

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF6A1B9A), Color(0xFF4A148C)],
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.3),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(Icons.radio_button_checked, color: Colors.white, size: 30.0),
            SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RadioGroup<T>',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'extends StatelessWidget',
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
          'Provides groupValue and onChanged to all descendant Radio<T> '
          'widgets through an InheritedWidget scope. Eliminates repetition '
          'when you have multiple Radio buttons sharing the same group state. '
          'Radio widgets inside RadioGroup inherit configuration automatically.',
          style: TextStyle(
            fontSize: 13.0,
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
          ),
        ),
        SizedBox(height: 16.0),
        // Key benefit
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Icon(Icons.auto_fix_high, color: Colors.amberAccent, size: 22.0),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Benefit',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Define groupValue and onChanged once on RadioGroup, '
                      'instead of repeating on every Radio widget.',
                      style: TextStyle(fontSize: 10.0, color: Colors.white70),
                    ),
                  ],
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
  // SECTION 2: Before vs After RadioGroup
  // ============================================================
  print('=== Section 2: Before vs After RadioGroup ===');

  final comparisonSection = Container(
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
          'Before vs After RadioGroup',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        // BEFORE
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cancel, color: Colors.red.shade600, size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    'BEFORE: Without RadioGroup',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'Column(children: [\n'
                  '  Radio<int>(\n'
                  '    value: 1,\n'
                  '    groupValue: selected,  // repeated\n'
                  '    onChanged: (v) => ..., // repeated\n'
                  '  ),\n'
                  '  Radio<int>(\n'
                  '    value: 2,\n'
                  '    groupValue: selected,  // repeated\n'
                  '    onChanged: (v) => ..., // repeated\n'
                  '  ),\n'
                  '  Radio<int>(\n'
                  '    value: 3,\n'
                  '    groupValue: selected,  // repeated\n'
                  '    onChanged: (v) => ..., // repeated\n'
                  '  ),\n'
                  '])',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                    color: Colors.red.shade200,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'groupValue and onChanged repeated 3 times!',
                style: TextStyle(
                  fontSize: 9.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        // Arrow
        Center(
          child: Icon(Icons.arrow_downward, color: Colors.grey.shade400, size: 24.0),
        ),
        SizedBox(height: 12.0),
        // AFTER
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade600, size: 16.0),
                  SizedBox(width: 6.0),
                  Text(
                    'AFTER: With RadioGroup',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'RadioGroup<int>(\n'
                  '  groupValue: selected,  // once!\n'
                  '  onChanged: (v) => ..., // once!\n'
                  '  child: Column(children: [\n'
                  '    Radio<int>(value: 1), // just value\n'
                  '    Radio<int>(value: 2), // just value\n'
                  '    Radio<int>(value: 3), // just value\n'
                  '  ]),\n'
                  ')',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                    color: Colors.greenAccent.shade200,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'groupValue and onChanged defined once, inherited by all Radio children',
                style: TextStyle(
                  fontSize: 9.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created before/after comparison');

  // ============================================================
  // SECTION 3: Live RadioGroup Examples
  // ============================================================
  print('=== Section 3: Live RadioGroup Examples ===');

  // Example 1: Simple 3-option group
  final simpleGroup = RadioGroup<int>(
    groupValue: 2,
    onChanged: (int? value) {
      print('Simple group selected: $value');
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio<int>(value: 1),
            SizedBox(width: 4.0),
            Text('Option A', style: TextStyle(fontSize: 12.0)),
          ],
        ),
        Row(
          children: [
            Radio<int>(value: 2),
            SizedBox(width: 4.0),
            Text('Option B (selected)', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Radio<int>(value: 3),
            SizedBox(width: 4.0),
            Text('Option C', style: TextStyle(fontSize: 12.0)),
          ],
        ),
      ],
    ),
  );

  // Example 2: String-typed group
  final stringGroup = RadioGroup<String>(
    groupValue: 'dark',
    onChanged: (String? value) {
      print('Theme selected: $value');
    },
    child: Row(
      children: [
        Radio<String>(value: 'light'),
        Text('Light', style: TextStyle(fontSize: 11.0)),
        SizedBox(width: 16.0),
        Radio<String>(value: 'dark'),
        Text('Dark', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),
        SizedBox(width: 16.0),
        Radio<String>(value: 'system'),
        Text('System', style: TextStyle(fontSize: 11.0)),
      ],
    ),
  );

  // Example 3: Null groupValue (nothing selected)
  final noneSelectedGroup = RadioGroup<int>(
    groupValue: null,
    onChanged: (int? value) {
      print('None-selected group: $value');
    },
    child: Row(
      children: [
        Radio<int>(value: 1),
        Text('A', style: TextStyle(fontSize: 11.0)),
        SizedBox(width: 8.0),
        Radio<int>(value: 2),
        Text('B', style: TextStyle(fontSize: 11.0)),
        SizedBox(width: 8.0),
        Radio<int>(value: 3),
        Text('C', style: TextStyle(fontSize: 11.0)),
      ],
    ),
  );

  final liveExamples = Container(
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
          'Live RadioGroup Instances',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Real RadioGroup widgets rendered with different configurations.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Example 1
        _buildLiveExample(
          'Integer Group (groupValue: 2)',
          'RadioGroup<int> with 3 options in a Column. Option B selected.',
          simpleGroup,
          Colors.blue,
        ),
        SizedBox(height: 10.0),
        // Example 2
        _buildLiveExample(
          'String Group (groupValue: "dark")',
          'RadioGroup<String> with horizontal layout. Dark theme selected.',
          stringGroup,
          Colors.teal,
        ),
        SizedBox(height: 10.0),
        // Example 3
        _buildLiveExample(
          'Null Selection (groupValue: null)',
          'RadioGroup<int> with no option selected. All radio buttons unfilled.',
          noneSelectedGroup,
          Colors.orange,
        ),
      ],
    ),
  );

  print('Created 3 live RadioGroup examples');

  // ============================================================
  // SECTION 4: RadioGroup API Properties
  // ============================================================
  print('=== Section 4: RadioGroup API ===');

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
          'RadioGroup<T> API',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.brown.shade800,
          ),
        ),
        SizedBox(height: 14.0),
        _buildApiProperty(
          'groupValue',
          'T?',
          'The currently selected value. Radio widgets whose value '
          'matches this will appear filled. null = no selection.',
          Colors.purple,
        ),
        SizedBox(height: 10.0),
        _buildApiProperty(
          'onChanged',
          'ValueChanged<T?>',
          'Called when a descendant Radio is tapped. Receives the new '
          'value. Required — RadioGroup always needs a change handler.',
          Colors.blue,
        ),
        SizedBox(height: 10.0),
        _buildApiProperty(
          'child',
          'Widget',
          'The subtree that contains Radio<T> widgets. They inherit '
          'groupValue and onChanged from this RadioGroup.',
          Colors.green,
        ),
        SizedBox(height: 14.0),
        // Constructor
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'const RadioGroup<T>({\n'
            '  required T? groupValue,\n'
            '  required ValueChanged<T?> onChanged,\n'
            '  required Widget child,\n'
            '})',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.greenAccent.shade200,
            ),
          ),
        ),
      ],
    ),
  );

  print('Created API section');

  // ============================================================
  // SECTION 5: Inheritance Mechanism
  // ============================================================
  print('=== Section 5: How Inheritance Works ===');

  // RadioGroup uses an InheritedWidget (RadioGroupScope) to
  // propagate groupValue and onChanged down the tree

  final inheritanceSection = Container(
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
          'How Inheritance Works',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'RadioGroup inserts an InheritedWidget into the tree. Descendant '
          'Radio widgets look up the nearest RadioGroup scope to get '
          'their groupValue and onChanged.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Tree diagram
        _buildTreeNode('RadioGroup<int>', 'groupValue: 2, onChanged: fn', Colors.purple, 0),
        _buildTreeConnector(),
        _buildTreeNode('RadioGroupScope', 'InheritedWidget (inserted by RadioGroup)', Colors.indigo, 1),
        _buildTreeConnector(),
        _buildTreeNode('child: Column', 'Your layout widget', Colors.grey, 1),
        _buildTreeConnector(),
        Row(
          children: [
            SizedBox(width: 40.0),
            Expanded(
              child: Column(
                children: [
                  _buildTreeNode('Radio(value: 1)', 'Inherits scope → unfilled', Colors.blue, 2),
                  SizedBox(height: 4.0),
                  _buildTreeNode('Radio(value: 2)', 'Inherits scope → FILLED', Colors.green, 2),
                  SizedBox(height: 4.0),
                  _buildTreeNode('Radio(value: 3)', 'Inherits scope → unfilled', Colors.blue, 2),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        // Rules
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRuleRow(
                Icons.check_circle,
                'Radio inside RadioGroup: inherits groupValue/onChanged',
                Colors.green,
              ),
              SizedBox(height: 6.0),
              _buildRuleRow(
                Icons.check_circle,
                'Radio can override with its own groupValue/onChanged',
                Colors.green,
              ),
              SizedBox(height: 6.0),
              _buildRuleRow(
                Icons.info,
                'Radio outside RadioGroup: needs its own groupValue/onChanged',
                Colors.blue,
              ),
              SizedBox(height: 6.0),
              _buildRuleRow(
                Icons.warning,
                'Depth does not matter — Radio finds nearest ancestor RadioGroup',
                Colors.orange,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created inheritance mechanism section');

  // ============================================================
  // SECTION 6: Nested & Deep Children
  // ============================================================
  print('=== Section 6: Nested and Deep Children ===');

  // Radio widgets can be deeply nested inside RadioGroup —
  // they still inherit through the InheritedWidget scope

  final deepGroup = RadioGroup<String>(
    groupValue: 'b',
    onChanged: (String? v) {
      print('Deep group selected: $v');
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Direct child
        Row(
          children: [
            Radio<String>(value: 'a'),
            Text('Direct child', style: TextStyle(fontSize: 11.0)),
          ],
        ),
        // Nested inside Container
        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Radio<String>(value: 'b'),
              Text('Inside Container (selected)', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        // Deeply nested
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Row(
            children: [
              Radio<String>(value: 'c'),
              Text('Deeply nested', style: TextStyle(fontSize: 11.0)),
            ],
          ),
        ),
      ],
    ),
  );

  final deepSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nested & Deep Children',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Radio widgets at any depth inside RadioGroup still inherit '
          'groupValue and onChanged. The InheritedWidget lookup has '
          'no depth limit.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Live example: Radio at 3 nesting depths',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),
              SizedBox(height: 8.0),
              deepGroup,
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Nesting depth indicators
        _buildDepthIndicator(0, 'Radio(value: "a")', 'Direct child of RadioGroup'),
        SizedBox(height: 4.0),
        _buildDepthIndicator(1, 'Radio(value: "b")', 'Inside Container'),
        SizedBox(height: 4.0),
        _buildDepthIndicator(2, 'Radio(value: "c")', 'Inside Padding > Container'),
      ],
    ),
  );

  print('Created deep nesting section');

  // ============================================================
  // SECTION 7: Type Safety with Generics
  // ============================================================
  print('=== Section 7: Type Safety ===');

  // RadioGroup is generic: RadioGroup<T> pairs with Radio<T>
  // Mismatched types won't find the inherited scope

  final typeSafety = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Type Safety with Generics',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'RadioGroup<T> and Radio<T> must use the same type parameter T. '
          'A Radio<String> inside RadioGroup<int> will not inherit the scope.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 14.0),
        // Correct usage
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade600, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Correct: Matching types',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'RadioGroup<int>(...)   // T = int\n'
                  '  Radio<int>(value: 1) // T = int ✓',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.greenAccent.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Wrong usage
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.cancel, color: Colors.red.shade600, size: 14.0),
                  SizedBox(width: 6.0),
                  Text(
                    'Wrong: Mismatched types',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'RadioGroup<int>(...)      // T = int\n'
                  '  Radio<String>(value: "a") // T = String ✗',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.red.shade200,
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Radio<String> will not find RadioGroup<int> scope. '
                'It will need its own groupValue/onChanged.',
                style: TextStyle(fontSize: 9.0, color: Colors.red.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        // Common types
        Text(
          'Common type parameters:',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: [
            _buildTypeChip('int', 'Numeric options', Colors.blue),
            _buildTypeChip('String', 'Named choices', Colors.green),
            _buildTypeChip('enum', 'Enum variants', Colors.purple),
            _buildTypeChip('bool', 'True/false toggle', Colors.orange),
          ],
        ),
      ],
    ),
  );

  print('Created type safety section');

  // ============================================================
  // SECTION 8: RadioGroup with Disabled State
  // ============================================================
  print('=== Section 8: Disabled RadioGroup ===');

  // Compare a no-op callback vs a real callback

  final disabledGroup = RadioGroup<int>(
    groupValue: 1,
    onChanged: (int? v) {},
    child: Row(
      children: [
        Radio<int>(value: 1),
        Text('A', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
        SizedBox(width: 8.0),
        Radio<int>(value: 2),
        Text('B', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
        SizedBox(width: 8.0),
        Radio<int>(value: 3),
        Text('C', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
      ],
    ),
  );

  final enabledGroup = RadioGroup<int>(
    groupValue: 1,
    onChanged: (int? v) {
      print('Enabled group: $v');
    },
    child: Row(
      children: [
        Radio<int>(value: 1),
        Text('A', style: TextStyle(fontSize: 11.0)),
        SizedBox(width: 8.0),
        Radio<int>(value: 2),
        Text('B', style: TextStyle(fontSize: 11.0)),
        SizedBox(width: 8.0),
        Radio<int>(value: 3),
        Text('C', style: TextStyle(fontSize: 11.0)),
      ],
    ),
  );

  final disabledSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active vs No-Op Callback',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'RadioGroup requires an onChanged callback. Compare a no-op '
          'callback (visual only) vs an active one that prints selections.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 14.0),
        // Enabled
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'ENABLED',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'onChanged: (v) => ...',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              enabledGroup,
            ],
          ),
        ),
        SizedBox(height: 10.0),
        // Disabled
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      'NO-OP',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    'onChanged: (v) {}  // no-op',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              disabledGroup,
              SizedBox(height: 4.0),
              Text(
                'Callback does nothing — radios still rendered but selection has no effect',
                style: TextStyle(
                  fontSize: 9.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  print('Created disabled state section');

  // ============================================================
  // SECTION 9: RadioGroup vs Manual Approach
  // ============================================================
  print('=== Section 9: RadioGroup vs Manual Approach ===');

  final vsSection = Container(
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
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                'RadioGroup',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade800,
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
                'Manual Radio',
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
        _buildVsRow(
          'groupValue',
          'Set once on RadioGroup',
          'Repeated on every Radio',
        ),
        _buildVsRow(
          'onChanged',
          'Set once on RadioGroup',
          'Repeated on every Radio',
        ),
        _buildVsRow(
          'Boilerplate',
          'Minimal — only value per Radio',
          'High — full config per Radio',
        ),
        _buildVsRow(
          'Disable all',
          'Individual Radio togglesEnabled',
          'Set toggleable on each Radio',
        ),
        _buildVsRow(
          'Deep nesting',
          'Works via InheritedWidget',
          'Must thread values manually',
        ),
        _buildVsRow(
          'Flexibility',
          'Radio can still override locally',
          'Full control always',
        ),
      ],
    ),
  );

  print('Created comparison section');

  // ============================================================
  // ASSEMBLY
  // ============================================================
  print('=== Assembling RadioGroup Deep Demo ===');

  final result = SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color(0xFF4A148C),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            children: [
              Text(
                'RadioGroup Deep Demo',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Inherited scope for Radio button groups • Material Design',
                style: TextStyle(fontSize: 11.0, color: Colors.white60),
              ),
            ],
          ),
        ),
        conceptCard,
        comparisonSection,
        liveExamples,
        apiSection,
        inheritanceSection,
        deepSection,
        typeSafety,
        disabledSection,
        vsSection,
        SizedBox(height: 30.0),
      ],
    ),
  );

  print('RadioGroup Deep Demo complete: 9 sections');
  return result;
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildLiveExample(
  String title,
  String description,
  Widget child,
  MaterialColor color,
) {
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
        Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: color.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 8.0),
        child,
      ],
    ),
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

Widget _buildRuleRow(IconData icon, String text, MaterialColor color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, color: color.shade600, size: 14.0),
      SizedBox(width: 6.0),
      Expanded(
        child: Text(
          text,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade800),
        ),
      ),
    ],
  );
}

Widget _buildDepthIndicator(int depth, String name, String location) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 22.0,
          height: 22.0,
          decoration: BoxDecoration(
            color: Colors.teal.shade600,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$depth',
            style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(width: 8.0),
        Text(
          name,
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            location,
            style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTypeChip(String type, String desc, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.shade200),
    ),
    child: Column(
      children: [
        Text(
          type,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
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

Widget _buildVsRow(String aspect, String radioGroup, String manual) {
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
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  radioGroup,
                  style: TextStyle(fontSize: 9.0, color: Colors.purple.shade700),
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
                  manual,
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
