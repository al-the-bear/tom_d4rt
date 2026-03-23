// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for OverlayVisibilityMode from cupertino
// OverlayVisibilityMode controls visibility of overlay elements in text fields
// Used for prefix, suffix, and clear button visibility in CupertinoTextField
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║            OVERLAY VISIBILITY MODE DEEP DEMO                      ║');
  print('║      Text Field Overlay Visibility for Cupertino Controls         ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OVERLAY VISIBILITY MODE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: OVERLAY VISIBILITY MODE FUNDAMENTALS                   │');
  print('│ Understanding text field overlay visibility                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('OverlayVisibilityMode controls:');
  print('  • When overlay widgets are visible');
  print('  • Clear button visibility');
  print('  • Prefix/suffix visibility');
  print('  • Based on field state (editing, content)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ALL ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: ALL ENUM VALUES                                        │');
  print('│ Complete list of visibility mode options                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final allValues = OverlayVisibilityMode.values;
  final valueResults = <Map<String, dynamic>>[];
  
  print('OverlayVisibilityMode enum values:');
  print('┌──────────┬───────────────┬────────────────────────────────────────────┐');
  print('│  Index   │     Name      │   Description                              │');
  print('├──────────┼───────────────┼────────────────────────────────────────────┤');
  
  for (final mode in allValues) {
    String description;
    switch (mode) {
      case OverlayVisibilityMode.never:
        description = 'Never show the overlay';
        break;
      case OverlayVisibilityMode.editing:
        description = 'Show only when editing';
        break;
      case OverlayVisibilityMode.notEditing:
        description = 'Show only when not editing';
        break;
      case OverlayVisibilityMode.always:
        description = 'Always show the overlay';
        break;
    }
    valueResults.add({'mode': mode, 'index': mode.index, 'name': mode.name, 'description': description});
    print('│    ${mode.index}     │ ${mode.name.padRight(13)} │ ${description.padRight(38)} │');
  }
  print('└──────────┴───────────────┴────────────────────────────────────────────┘');
  print('');
  print('Total values: ${allValues.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: NEVER MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: NEVER MODE ANALYSIS                                    │');
  print('│ Overlay is never visible                                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final neverMode = OverlayVisibilityMode.never;
  print('OverlayVisibilityMode.never properties:');
  print('  • name: ${neverMode.name}');
  print('  • index: ${neverMode.index}');
  print('  • toString: $neverMode');
  print('');
  print('Behavior:');
  print('  • Overlay always hidden');
  print('  • Regardless of editing state');
  print('  • Regardless of content');
  print('');
  print('Visual:');
  print('  Editing: ┌──────────────────┐    Not Editing: ┌──────────────────┐');
  print('           │ Text here...     │                 │ Text here...     │');
  print('           └──────────────────┘                 └──────────────────┘');
  print('           [No overlay]                          [No overlay]');
  print('');

  print('Use cases for never:');
  print('  • Disable clear button');
  print('  • Hide prefix/suffix permanently');
  print('  • Clean, minimal design');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: EDITING MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: EDITING MODE ANALYSIS                                  │');
  print('│ Overlay visible only during editing                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final editingMode = OverlayVisibilityMode.editing;
  print('OverlayVisibilityMode.editing properties:');
  print('  • name: ${editingMode.name}');
  print('  • index: ${editingMode.index}');
  print('  • toString: $editingMode');
  print('');
  print('Behavior:');
  print('  • Shows when text field has focus');
  print('  • Hides when field loses focus');
  print('  • Common for clear buttons');
  print('');
  print('Visual:');
  print('  Editing (focused):             Not Editing:');
  print('  ┌──────────────────┬───┐      ┌──────────────────┐');
  print('  │ Text here...     │ ⊗ │      │ Text here...     │');
  print('  └──────────────────┴───┘      └──────────────────┘');
  print('  [Clear button visible]         [Clear button hidden]');
  print('');

  print('Use cases for editing:');
  print('  • Clear button (default iOS)');
  print('  • Action buttons during input');
  print('  • Voice input toggle');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: NOT EDITING MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: NOT EDITING MODE ANALYSIS                              │');
  print('│ Overlay visible only when not editing                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final notEditingMode = OverlayVisibilityMode.notEditing;
  print('OverlayVisibilityMode.notEditing properties:');
  print('  • name: ${notEditingMode.name}');
  print('  • index: ${notEditingMode.index}');
  print('  • toString: $notEditingMode');
  print('');
  print('Behavior:');
  print('  • Shows when field is not focused');
  print('  • Hides when user starts typing');
  print('  • Less common usage');
  print('');
  print('Visual:');
  print('  Editing (focused):             Not Editing:');
  print('  ┌──────────────────┐           ┌──────────────────┬───┐');
  print('  │ Text here...     │           │ Text here...     │ ℹ │');
  print('  └──────────────────┘           └──────────────────┴───┘');
  print('  [Icon hidden]                  [Info icon visible]');
  print('');

  print('Use cases for notEditing:');
  print('  • Info/status indicators');
  print('  • Validation result icons');
  print('  • Read-only field decorations');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ALWAYS MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: ALWAYS MODE ANALYSIS                                   │');
  print('│ Overlay always visible                                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final alwaysMode = OverlayVisibilityMode.always;
  print('OverlayVisibilityMode.always properties:');
  print('  • name: ${alwaysMode.name}');
  print('  • index: ${alwaysMode.index}');
  print('  • toString: $alwaysMode');
  print('');
  print('Behavior:');
  print('  • Always visible');
  print('  • Regardless of focus state');
  print('  • Consistent appearance');
  print('');
  print('Visual:');
  print('  Editing:                       Not Editing:');
  print('  ┌───┬──────────────────┐      ┌───┬──────────────────┐');
  print('  │ @ │ email@example.com│      │ @ │ email@example.com│');
  print('  └───┴──────────────────┘      └───┴──────────────────┘');
  print('  [Prefix visible]               [Prefix visible]');
  print('');

  print('Use cases for always:');
  print('  • Field type indicators (@ for email)');
  print('  • Currency symbols (\$)');
  print('  • Unit prefix/suffix (kg, %)');
  print('  • Consistent UI elements');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: VISIBILITY STATE MATRIX
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: VISIBILITY STATE MATRIX                                │');
  print('│ Complete state comparison                                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Visibility by mode and state:');
  print('┌──────────────────┬──────────────────────┬──────────────────────┐');
  print('│       Mode       │  When Editing        │  When Not Editing    │');
  print('├──────────────────┼──────────────────────┼──────────────────────┤');
  print('│ never            │   Hidden             │   Hidden             │');
  print('│ editing          │   Visible ✓          │   Hidden             │');
  print('│ notEditing       │   Hidden             │   Visible ✓          │');
  print('│ always           │   Visible ✓          │   Visible ✓          │');
  print('└──────────────────┴──────────────────────┴──────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: ENUM COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: ENUM COMPARISON                                        │');
  print('│ Equality and ordering                                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Equality comparisons:');
  print('┌─────────────────────────────────────┬─────────────────────────────┐');
  print('│          Comparison                 │         Result              │');
  print('├─────────────────────────────────────┼─────────────────────────────┤');
  print('│ never == never                      │ ${neverMode == OverlayVisibilityMode.never}                        │');
  print('│ never == editing                    │ ${neverMode == editingMode}                       │');
  print('│ editing.index < notEditing.index    │ ${editingMode.index < notEditingMode.index}                        │');
  print('│ notEditing.index < always.index     │ ${notEditingMode.index < alwaysMode.index}                        │');
  print('└─────────────────────────────────────┴─────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: WITH CUPERTINO TEXT FIELD
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: WITH CUPERTINO TEXT FIELD                              │');
  print('│ Using visibility mode in text fields                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('CupertinoTextField usage:');
  print('');
  print('  // Clear button only when editing');
  print('  CupertinoTextField(');
  print('    clearButtonMode: OverlayVisibilityMode.editing,');
  print('  )');
  print('');
  print('  // Prefix always visible');
  print('  CupertinoTextField(');
  print('    prefixMode: OverlayVisibilityMode.always,');
  print('    prefix: Text("@"),');
  print('  )');
  print('');
  print('  // Suffix when not editing');
  print('  CupertinoTextField(');
  print('    suffixMode: OverlayVisibilityMode.notEditing,');
  print('    suffix: Icon(CupertinoIcons.check_mark),');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: PRACTICAL USE CASES                                   │');
  print('│ When to use each visibility mode                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('1. Search Field Clear Button → editing');
  print('   Show "X" only when typing');
  print('');

  print('2. Email Field Prefix → always');
  print('   "@" symbol always visible');
  print('');

  print('3. Password Strength → notEditing');
  print('   Show indicator after leaving field');
  print('');

  print('4. Disable Clear Button → never');
  print('   For read-only or required fields');
  print('');

  print('5. Currency Fields → always');
  print('   "\$" prefix always visible');
  print('');

  print('6. Validation Icons → notEditing');
  print('   ✓ or ✗ shown after input');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║           OVERLAY VISIBILITY MODE SUMMARY                         ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('OverlayVisibilityMode key features:');
  print('  • 4 modes: never, editing, notEditing, always');
  print('  • Controls prefix, suffix, clear button');
  print('  • State-dependent visibility');
  print('  • Simple enum-based selection');
  print('');
  print('Mode recommendations:');
  print('  • never: Disabled overlays');
  print('  • editing: Clear buttons (default)');
  print('  • notEditing: Status indicators');
  print('  • always: Type prefixes (@ \$ %)');
  print('');
  print('OverlayVisibilityMode Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'OverlayVisibilityMode',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Text Field Overlay Visibility',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: CupertinoColors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Enum Values
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ENUM VALUES',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  ...valueResults.map((r) => _buildEnumRow(r)),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Demo Text Fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('LIVE DEMOS (tap to edit)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: CupertinoColors.systemGrey)),
            ),
            SizedBox(height: 8),
            
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('clearButtonMode: editing', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 4),
                  CupertinoTextField(
                    placeholder: 'Clear button when editing',
                    clearButtonMode: OverlayVisibilityMode.editing,
                  ),
                  SizedBox(height: 16),
                  
                  Text('prefixMode: always', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 4),
                  CupertinoTextField(
                    placeholder: 'Enter email',
                    prefixMode: OverlayVisibilityMode.always,
                    prefix: Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text('@', style: TextStyle(color: CupertinoColors.systemGrey)),
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  Text('suffixMode: always', style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey)),
                  SizedBox(height: 4),
                  CupertinoTextField(
                    placeholder: 'Enter amount',
                    suffixMode: OverlayVisibilityMode.always,
                    suffix: Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text('\$', style: TextStyle(color: CupertinoColors.systemGrey)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Visibility Matrix
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'VISIBILITY MATRIX',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _buildMatrixRow('Mode', 'Editing', 'Not Editing', true),
                  _buildMatrixRow('never', '✗', '✗', false),
                  _buildMatrixRow('editing', '✓', '✗', false),
                  _buildMatrixRow('notEditing', '✗', '✓', false),
                  _buildMatrixRow('always', '✓', '✓', false),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Summary Stats
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'SUMMARY',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('Values', '${allValues.length}'),
                      _buildSummaryStat('Type', 'Enum'),
                      _buildSummaryStat('Sections', '10'),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Deep Demo • OverlayVisibilityMode • Flutter Cupertino',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.systemGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildEnumRow(Map<String, dynamic> r) {
  final mode = r['mode'] as OverlayVisibilityMode;
  final name = r['name'] as String;
  final description = r['description'] as String;
  
  Color color;
  switch (mode) {
    case OverlayVisibilityMode.never:
      color = CupertinoColors.systemRed;
      break;
    case OverlayVisibilityMode.editing:
      color = CupertinoColors.activeBlue;
      break;
    case OverlayVisibilityMode.notEditing:
      color = CupertinoColors.systemOrange;
      break;
    case OverlayVisibilityMode.always:
      color = CupertinoColors.activeGreen;
      break;
  }
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 75,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: Text(name, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: CupertinoColors.white))),
        ),
        SizedBox(width: 12),
        Expanded(child: Text(description, style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey))),
      ],
    ),
  );
}

Widget _buildMatrixRow(String mode, String editing, String notEditing, bool isHeader) {
  final textStyle = isHeader 
    ? TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF90A4AE))
    : TextStyle(fontSize: 10, color: CupertinoColors.white);
  
  final checkColor = Color(0xFF4CAF50);
  final crossColor = Color(0xFFEF5350);
  
  Widget buildCell(String text) {
    if (!isHeader) {
      return Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: text == '✓' ? checkColor : crossColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return Text(text, style: textStyle);
  }
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 70, child: Text(mode, style: textStyle)),
        Expanded(child: Center(child: buildCell(editing))),
        Expanded(child: Center(child: buildCell(notEditing))),
      ],
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Color(0xFF90A4AE),
        ),
      ),
    ],
  );
}
