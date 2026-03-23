// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for Tristate from dart:ui
// Tristate represents a three-state boolean value (true/false/mixed)
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Tristate Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: Tristate Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('Tristate represents three-state boolean values');
  print('All values: ${Tristate.values}');
  print('Count: ${Tristate.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final state in Tristate.values) {
    print('${state.name}: index=${state.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Understanding Tristate
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Tristate Values ---');
  print('isTrue: Definitely true');
  print('isFalse: Definitely false');
  print('none: Partially true (indeterminate)');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 16),

              // Section 1: Overview
              _buildSectionCard(
                'Tristate Overview',
                Icons.check_box_outlined,
                Colors.indigo,
                [
                  'Represents three-state boolean values',
                  'Used for accessibility and multi-selection states',
                  'Maps to checkbox tristate pattern',
                  'Values: ${Tristate.values.length} states (true/false/mixed)',
                ],
              ),
              SizedBox(height: 16),

              // Section 2: All States
              _buildSectionHeader('ALL TRISTATE VALUES'),
              _buildAllStatesDemo(),
              SizedBox(height: 16),

              // Section 3: Visual Representation
              _buildSectionHeader('VISUAL REPRESENTATION'),
              _buildVisualStatesDemo(),
              SizedBox(height: 16),

              // Section 4: Checkbox Demo
              _buildSectionHeader('CHECKBOX TRISTATE PATTERN'),
              _buildCheckboxDemo(),
              SizedBox(height: 16),

              // Section 5: Parent-Child Selection
              _buildSectionHeader('PARENT-CHILD SELECTION'),
              _buildParentChildDemo(),
              SizedBox(height: 16),

              // Section 6: State Transitions
              _buildSectionHeader('STATE TRANSITIONS'),
              _buildStateTransitionsDemo(),
              SizedBox(height: 16),

              // Section 7: Accessibility
              _buildSectionHeader('ACCESSIBILITY SEMANTICS'),
              _buildAccessibilityDemo(),
              SizedBox(height: 16),

              // Section 8: Use Cases
              _buildSectionHeader('PRACTICAL USE CASES'),
              _buildUseCasesDemo(),
              SizedBox(height: 16),

              // Section 9: Boolean Mapping
              _buildSectionHeader('BOOLEAN MAPPING'),
              _buildBooleanMappingDemo(),
              SizedBox(height: 16),

              // Section 10: Comparison
              _buildSectionHeader('STATE COMPARISON'),
              _buildComparisonTable(),
              SizedBox(height: 32),

              // Footer
              _buildFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF3F51B5), Color(0xFF7986CB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF3F51B5).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.check_box_outlined, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'Tristate',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Three-State Boolean Values',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'dart:ui Enum • ${Tristate.values.length} States',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildSectionCard(
  String title,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points
                .map(
                  (point) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllStatesDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        for (final state in Tristate.values) ...[
          _buildStateRow(state),
          if (state != Tristate.values.last) SizedBox(height: 12),
        ],
      ],
    ),
  );
}

Widget _buildStateRow(Tristate state) {
  final colors = {
    Tristate.isTrue: Colors.green,
    Tristate.isFalse: Colors.red,
    Tristate.none: Colors.orange,
  };
  final icons = {
    Tristate.isTrue: Icons.check_box,
    Tristate.isFalse: Icons.check_box_outline_blank,
    Tristate.none: Icons.indeterminate_check_box,
  };
  final color = colors[state] ?? Colors.grey;
  final icon = icons[state] ?? Icons.help;

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 32),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tristate.${state.name}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                'index: ${state.index}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            state.name.replaceAll('is', '').toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVisualStatesDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildVisualState(Tristate.isFalse, 'Unchecked', Colors.red),
        _buildVisualState(Tristate.none, 'Mixed', Colors.orange),
        _buildVisualState(Tristate.isTrue, 'Checked', Colors.green),
      ],
    ),
  );
}

Widget _buildVisualState(Tristate state, String label, Color color) {
  final icons = {
    Tristate.isTrue: Icons.check_box,
    Tristate.isFalse: Icons.check_box_outline_blank,
    Tristate.none: Icons.indeterminate_check_box,
  };

  return Column(
    children: [
      Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Icon(icons[state], color: color, size: 40),
      ),
      SizedBox(height: 8),
      Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      Text(state.name, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
    ],
  );
}

Widget _buildCheckboxDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Checkbox with tristate: true',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildCheckboxState(false, 'false'),
            _buildCheckboxState(null, 'null'),
            _buildCheckboxState(true, 'true'),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            'Checkbox(tristate: true) cycles: false → true → null → false',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCheckboxState(bool? value, String label) {
  return Column(
    children: [
      Checkbox(value: value, tristate: true, onChanged: (_) {}),
      Text(
        'value: $label',
        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
      ),
    ],
  );
}

Widget _buildParentChildDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parent checkbox with partial child selection:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildParentChildColumn('None selected', [
                false,
                false,
                false,
              ], Tristate.isFalse),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildParentChildColumn('Partial', [
                true,
                false,
                true,
              ], Tristate.none),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildParentChildColumn('All selected', [
                true,
                true,
                true,
              ], Tristate.isTrue),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildParentChildColumn(
  String title,
  List<bool> children,
  Tristate parentState,
) {
  final color = parentState == Tristate.isTrue
      ? Colors.green
      : parentState == Tristate.isFalse
      ? Colors.red
      : Colors.orange;

  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Checkbox(
          value: parentState == Tristate.none
              ? null
              : parentState == Tristate.isTrue,
          tristate: true,
          onChanged: (_) {},
        ),
        Divider(),
        for (final checked in children)
          Checkbox(
            value: checked,
            onChanged: (_) {},
            visualDensity: VisualDensity.compact,
          ),
      ],
    ),
  );
}

Widget _buildStateTransitionsDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTransitionState(Tristate.isFalse, Colors.red),
            _buildArrow(),
            _buildTransitionState(Tristate.isTrue, Colors.green),
            _buildArrow(),
            _buildTransitionState(Tristate.none, Colors.orange),
            _buildArrow(),
            _buildTransitionState(Tristate.isFalse, Colors.red),
          ],
        ),
        SizedBox(height: 12),
        Text(
          'Typical tristate checkbox cycle',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    ),
  );
}

Widget _buildTransitionState(Tristate state, Color color) {
  final icons = {
    Tristate.isTrue: Icons.check_box,
    Tristate.isFalse: Icons.check_box_outline_blank,
    Tristate.none: Icons.indeterminate_check_box,
  };
  return Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(icons[state], color: color, size: 24),
  );
}

Widget _buildArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Icon(Icons.arrow_forward, size: 16, color: Colors.grey[400]),
  );
}

Widget _buildAccessibilityDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Screen readers announce:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        _buildAccessibilityRow(Tristate.isFalse, '"not checked"'),
        SizedBox(height: 8),
        _buildAccessibilityRow(Tristate.isTrue, '"checked"'),
        SizedBox(height: 8),
        _buildAccessibilityRow(Tristate.none, '"mixed" or "partially checked"'),
      ],
    ),
  );
}

Widget _buildAccessibilityRow(Tristate state, String announcement) {
  final color = state == Tristate.isTrue
      ? Colors.green
      : state == Tristate.isFalse
      ? Colors.red
      : Colors.orange;

  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(4),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            state.name,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(Icons.volume_up, size: 16, color: Colors.grey[600]),
        SizedBox(width: 8),
        Text(
          announcement,
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

Widget _buildUseCasesDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildUseCaseCard(
          'Select All',
          'Parent checkbox showing partial selection of children',
          Icons.checklist,
          Colors.blue,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Permission Groups',
          'Some permissions enabled in a category',
          Icons.security,
          Colors.purple,
        ),
        SizedBox(height: 8),
        _buildUseCaseCard(
          'Filter States',
          'Feature partially matching filter criteria',
          Icons.filter_list,
          Colors.teal,
        ),
      ],
    ),
  );
}

Widget _buildUseCaseCard(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildBooleanMappingDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mapping to bool?:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tristate.isTrue  → true',
                style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
              Text(
                'Tristate.isFalse → false',
                style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
              Text(
                'Tristate.none → null',
                style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'State',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'bool?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Meaning',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('isTrue', 'true', 'Fully selected'),
        _buildTableRow('isFalse', 'false', 'Not selected'),
        _buildTableRow('none', 'null', 'Partially selected'),
      ],
    ),
  );
}

Widget _buildTableRow(String state, String boolVal, String meaning) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            state,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            boolVal,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            meaning,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooter() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'Tristate Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${Tristate.values.length} states for three-valued boolean logic. '
          'Essential for parent-child checkbox relationships and accessibility semantics. '
          'Maps to bool? for Flutter checkbox tristate mode.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
