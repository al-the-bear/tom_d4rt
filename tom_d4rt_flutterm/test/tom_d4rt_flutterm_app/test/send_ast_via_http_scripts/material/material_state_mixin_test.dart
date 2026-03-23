// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialStateMixin from material
import 'package:flutter/material.dart';

// Helper: section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.indigo.shade700,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

// Helper: info card
Widget buildInfoCard(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}

// Helper: description text
Widget buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.grey.shade600,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// Helper: colored state chip
Widget buildStateChip(String label, Color color, IconData icon) {
  return Container(
    margin: EdgeInsets.all(4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color, width: 2),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}

// Helper: color swatch display
Widget buildColorSwatch(String label, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black26),
          ),
        ),
        SizedBox(width: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

// Helper: demo card wrapper
Widget buildDemoCard({
  required String title,
  required String description,
  required Widget child,
  Color? accentColor,
}) {
  Color accent = accentColor ?? Colors.indigo;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: accent.withAlpha(60)),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accent.withAlpha(20),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: accent,
                ),
              ),
              SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(12), child: child),
      ],
    ),
  );
}

// Helper: state-to-color resolver row
Widget buildResolvedColorRow(String stateLabel, Color resolvedColor) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: resolvedColor.withAlpha(25),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: resolvedColor.withAlpha(80)),
    ),
    child: Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: resolvedColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black26),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            stateLabel,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== MaterialStateMixin / WidgetStateMixin Deep Demo ===');
  debugPrint(
    'Demonstrating WidgetState, WidgetStateProperty, and state-driven styling',
  );

  // Define a WidgetStateProperty<Color> using resolveWith
  WidgetStateProperty<Color> stateColorProperty =
      WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.error)) return Colors.red.shade600;
        if (states.contains(WidgetState.disabled)) return Colors.grey.shade400;
        if (states.contains(WidgetState.pressed)) return Colors.indigo.shade800;
        if (states.contains(WidgetState.dragged)) return Colors.orange.shade600;
        if (states.contains(WidgetState.selected)) return Colors.green.shade600;
        if (states.contains(WidgetState.focused)) return Colors.blue.shade600;
        if (states.contains(WidgetState.hovered)) return Colors.purple.shade400;
        return Colors.indigo.shade400;
      });

  // Resolve colors for each state
  Color colorNone = stateColorProperty.resolve({});
  Color colorHovered = stateColorProperty.resolve({WidgetState.hovered});
  Color colorFocused = stateColorProperty.resolve({WidgetState.focused});
  Color colorPressed = stateColorProperty.resolve({WidgetState.pressed});
  Color colorDragged = stateColorProperty.resolve({WidgetState.dragged});
  Color colorSelected = stateColorProperty.resolve({WidgetState.selected});
  Color colorDisabled = stateColorProperty.resolve({WidgetState.disabled});
  Color colorError = stateColorProperty.resolve({WidgetState.error});

  debugPrint('Section 1: WidgetState enum values overview');
  debugPrint('Section 2: WidgetStateProperty.resolveWith demo');
  debugPrint('Section 3: WidgetStateProperty.all comparison');
  debugPrint('Section 4: ElevatedButton.styleFrom with state properties');
  debugPrint('Section 5: WidgetStateTextStyle demo');
  debugPrint('Section 6: WidgetStateBorderSide demo');
  debugPrint('Section 7: WidgetStatesController usage');
  debugPrint('Section 8: Full ButtonStyle with multiple state properties');
  debugPrint('Section 9: Checkbox, Switch, Radio state demos');
  debugPrint('Section 10: WidgetStateMouseCursor demo');
  debugPrint('Section 11: State resolution summary');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Page header
        Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade800, Colors.indigo.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MaterialStateMixin / WidgetStateMixin',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Interactive state tracking for Material widgets: '
                'hovered, focused, pressed, dragged, selected, disabled, error',
                style: TextStyle(fontSize: 14, color: Colors.white70),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'WidgetStateMixin provides a Set<WidgetState> and '
                  'updateWidgetState() method on State classes. '
                  'MaterialStateMixin is the legacy alias.',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        // Section 1: WidgetState Enum Values Overview
        buildSectionHeader('1. WidgetState Enum Values'),
        buildDescription(
          'Each WidgetState represents an interactive condition tracked by the mixin',
        ),

        buildDemoCard(
          title: 'All Seven WidgetState Values',
          description: 'Visual representation of each interactive state',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              buildStateChip('hovered', Colors.purple.shade400, Icons.mouse),
              buildStateChip(
                'focused',
                Colors.blue.shade600,
                Icons.center_focus_strong,
              ),
              buildStateChip(
                'pressed',
                Colors.indigo.shade800,
                Icons.touch_app,
              ),
              buildStateChip('dragged', Colors.orange.shade600, Icons.pan_tool),
              buildStateChip(
                'selected',
                Colors.green.shade600,
                Icons.check_circle,
              ),
              buildStateChip('disabled', Colors.grey.shade500, Icons.block),
              buildStateChip('error', Colors.red.shade600, Icons.error),
            ],
          ),
        ),

        buildInfoCard('WidgetState.hovered', 'Mouse cursor is over the widget'),
        buildInfoCard('WidgetState.focused', 'Widget has keyboard focus'),
        buildInfoCard('WidgetState.pressed', 'Widget is being tapped/clicked'),
        buildInfoCard('WidgetState.dragged', 'Widget is being dragged'),
        buildInfoCard('WidgetState.selected', 'Widget is toggled on / checked'),
        buildInfoCard('WidgetState.disabled', 'Widget is non-interactive'),
        buildInfoCard('WidgetState.error', 'Widget is in an error condition'),

        buildDemoCard(
          title: 'States Are Combinable',
          description: 'A widget can be in multiple states simultaneously',
          accentColor: Colors.teal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Example: focused + hovered',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  buildStateChip(
                    'focused',
                    Colors.blue.shade600,
                    Icons.center_focus_strong,
                  ),
                  Text(
                    ' + ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  buildStateChip(
                    'hovered',
                    Colors.purple.shade400,
                    Icons.mouse,
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Example: selected + disabled',
                style: TextStyle(fontSize: 13),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  buildStateChip(
                    'selected',
                    Colors.green.shade600,
                    Icons.check_circle,
                  ),
                  Text(
                    ' + ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  buildStateChip('disabled', Colors.grey.shade500, Icons.block),
                ],
              ),
            ],
          ),
        ),

        // Section 2: WidgetStateProperty.resolveWith
        buildSectionHeader('2. WidgetStateProperty.resolveWith'),
        buildDescription(
          'resolveWith creates a property that maps state sets to values',
        ),

        buildDemoCard(
          title: 'Color Resolution by State',
          description: 'Each state resolves to a different color',
          child: Column(
            children: [
              buildResolvedColorRow('none (default)', colorNone),
              buildResolvedColorRow('hovered', colorHovered),
              buildResolvedColorRow('focused', colorFocused),
              buildResolvedColorRow('pressed', colorPressed),
              buildResolvedColorRow('dragged', colorDragged),
              buildResolvedColorRow('selected', colorSelected),
              buildResolvedColorRow('disabled', colorDisabled),
              buildResolvedColorRow('error', colorError),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Multi-State Resolution Priority',
          description: 'When multiple states active, first match wins',
          accentColor: Colors.deepOrange,
          child: Column(
            children: [
              buildResolvedColorRow(
                'pressed + hovered',
                stateColorProperty.resolve({
                  WidgetState.pressed,
                  WidgetState.hovered,
                }),
              ),
              buildResolvedColorRow(
                'error + focused',
                stateColorProperty.resolve({
                  WidgetState.error,
                  WidgetState.focused,
                }),
              ),
              buildResolvedColorRow(
                'disabled + selected',
                stateColorProperty.resolve({
                  WidgetState.disabled,
                  WidgetState.selected,
                }),
              ),
              buildResolvedColorRow(
                'focused + hovered + pressed',
                stateColorProperty.resolve({
                  WidgetState.focused,
                  WidgetState.hovered,
                  WidgetState.pressed,
                }),
              ),
            ],
          ),
        ),

        // Section 3: WidgetStateProperty.all Comparison
        buildSectionHeader('3. WidgetStateProperty.all vs resolveWith'),
        buildDescription(
          'WidgetStateProperty.all returns the same value for ALL states',
        ),

        buildDemoCard(
          title: 'WidgetStateProperty.all(Colors.teal)',
          description: 'Always returns teal regardless of state',
          accentColor: Colors.teal,
          child: Column(
            children: [
              _buildAllVsResolveRow('none', Colors.teal, colorNone),
              _buildAllVsResolveRow('hovered', Colors.teal, colorHovered),
              _buildAllVsResolveRow('pressed', Colors.teal, colorPressed),
              _buildAllVsResolveRow('disabled', Colors.teal, colorDisabled),
              _buildAllVsResolveRow('error', Colors.teal, colorError),
            ],
          ),
        ),

        buildInfoCard(
          'WidgetStateProperty.all',
          'Returns same value for every state combination',
        ),
        buildInfoCard(
          'resolveWith',
          'Returns different value per state using a callback',
        ),

        // Section 4: ElevatedButton.styleFrom with States
        buildSectionHeader('4. ElevatedButton Styling with States'),
        buildDescription(
          'styleFrom parameters internally create WidgetStateProperty values',
        ),

        buildDemoCard(
          title: 'Enabled vs Disabled Buttons',
          description: 'The mixin tracks disabled state when onPressed is null',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Enabled'),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.grey.shade500,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Disabled'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'Disabled state detected via WidgetStateMixin',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Button with Custom State Colors',
          description: 'Using ButtonStyle with WidgetStateProperty',
          accentColor: Colors.deepPurple,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.deepPurple.shade800;
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.deepPurple.shade600;
                    }
                    return Colors.deepPurple.shade400;
                  }),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                ),
                child: Text('State-Aware Button'),
              ),
              SizedBox(height: 8),
              Text(
                'Hover/press this button to see state changes',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),

        // Section 5: WidgetStateTextStyle
        buildSectionHeader('5. WidgetStateTextStyle Demonstration'),
        buildDescription(
          'WidgetStateTextStyle resolves TextStyle based on widget states',
        ),

        buildDemoCard(
          title: 'TextStyle per State',
          description: 'Different text styles for different interactive states',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextStyleRow(
                'Default',
                TextStyle(fontSize: 16, color: Colors.indigo.shade400),
              ),
              _buildTextStyleRow(
                'Hovered',
                TextStyle(
                  fontSize: 16,
                  color: Colors.purple.shade400,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _buildTextStyleRow(
                'Focused',
                TextStyle(
                  fontSize: 16,
                  color: Colors.blue.shade600,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              _buildTextStyleRow(
                'Pressed',
                TextStyle(
                  fontSize: 16,
                  color: Colors.indigo.shade800,
                  fontWeight: FontWeight.w900,
                ),
              ),
              _buildTextStyleRow(
                'Disabled',
                TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                  fontStyle: FontStyle.italic,
                ),
              ),
              _buildTextStyleRow(
                'Error',
                TextStyle(
                  fontSize: 16,
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),

        // Section 6: WidgetStateBorderSide
        buildSectionHeader('6. WidgetStateBorderSide Demonstration'),
        buildDescription(
          'BorderSide changes based on widget state for OutlinedButton etc.',
        ),

        buildDemoCard(
          title: 'Border Side per State',
          description: 'Different border widths and colors for each state',
          child: Column(
            children: [
              _buildBorderSideRow(
                'Default',
                BorderSide(color: Colors.indigo.shade400, width: 1),
              ),
              _buildBorderSideRow(
                'Hovered',
                BorderSide(color: Colors.purple.shade400, width: 2),
              ),
              _buildBorderSideRow(
                'Focused',
                BorderSide(color: Colors.blue.shade600, width: 3),
              ),
              _buildBorderSideRow(
                'Pressed',
                BorderSide(color: Colors.indigo.shade800, width: 3),
              ),
              _buildBorderSideRow(
                'Disabled',
                BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              _buildBorderSideRow(
                'Error',
                BorderSide(color: Colors.red.shade600, width: 2),
              ),
            ],
          ),
        ),

        buildDemoCard(
          title: 'OutlinedButton with State Borders',
          description: 'Outline changes on interaction',
          accentColor: Colors.teal,
          child: Column(
            children: [
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                  side: WidgetStateProperty.resolveWith<BorderSide>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return BorderSide(color: Colors.teal.shade800, width: 3);
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return BorderSide(color: Colors.teal.shade600, width: 2);
                    }
                    return BorderSide(color: Colors.teal.shade300, width: 1);
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.teal.shade800;
                    }
                    return Colors.teal.shade600;
                  }),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                ),
                child: Text('State-Aware Outline'),
              ),
            ],
          ),
        ),

        // Section 7: WidgetStatesController
        buildSectionHeader('7. WidgetStatesController Usage'),
        buildDescription(
          'WidgetStatesController manages and notifies about state changes',
        ),

        buildDemoCard(
          title: 'Controller Concept',
          description: 'How WidgetStatesController drives widget state',
          accentColor: Colors.amber.shade800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCodeLine('WidgetStatesController controller ='),
              _buildCodeLine('    WidgetStatesController();'),
              SizedBox(height: 8),
              _buildCodeLine('// Add a state'),
              _buildCodeLine('controller.update(WidgetState.selected, true);'),
              SizedBox(height: 8),
              _buildCodeLine('// Remove a state'),
              _buildCodeLine('controller.update(WidgetState.selected, false);'),
              SizedBox(height: 8),
              _buildCodeLine('// Read current states'),
              _buildCodeLine('Set<WidgetState> current = controller.value;'),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  'The controller notifies listeners when states change, '
                  'enabling widgets to rebuild with updated visual properties.',
                  style: TextStyle(fontSize: 12, color: Colors.amber.shade900),
                ),
              ),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Controller with ElevatedButton',
          description: 'Passing a statesController to a button',
          accentColor: Colors.brown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {},
                statesController: WidgetStatesController(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade400,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('Button with Controller'),
              ),
              SizedBox(height: 8),
              Text(
                'statesController allows external state management',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        // Section 8: Full ButtonStyle with Multiple State Props
        buildSectionHeader('8. Full ButtonStyle with State Properties'),
        buildDescription(
          'ButtonStyle with backgroundColor, foregroundColor, elevation, overlayColor, side, padding',
        ),

        buildDemoCard(
          title: 'Comprehensive State-Aware ButtonStyle',
          description: 'Every visual property driven by WidgetStateProperty',
          accentColor: Colors.deepPurple,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey.shade300;
                    }
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.deepPurple.shade900;
                    }
                    if (states.contains(WidgetState.hovered)) {
                      return Colors.deepPurple.shade600;
                    }
                    return Colors.deepPurple.shade400;
                  }),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return Colors.grey.shade500;
                    }
                    return Colors.white;
                  }),
                  elevation: WidgetStateProperty.resolveWith<double>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.pressed)) return 0;
                    if (states.contains(WidgetState.hovered)) return 8;
                    return 4;
                  }),
                  overlayColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.white.withAlpha(30);
                    }
                    return Colors.white.withAlpha(15);
                  }),
                  side: WidgetStateProperty.resolveWith<BorderSide>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.focused)) {
                      return BorderSide(color: Colors.amber, width: 2);
                    }
                    return BorderSide.none;
                  }),
                  padding: WidgetStateProperty.resolveWith<EdgeInsetsGeometry>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return EdgeInsets.symmetric(horizontal: 28, vertical: 10);
                    }
                    return EdgeInsets.symmetric(horizontal: 32, vertical: 14);
                  }),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Text('Full State-Aware Style'),
              ),
              SizedBox(height: 12),
              _buildPropertyRow(
                'backgroundColor',
                'resolveWith: disabled/pressed/hovered/default',
              ),
              _buildPropertyRow(
                'foregroundColor',
                'resolveWith: disabled/default',
              ),
              _buildPropertyRow(
                'elevation',
                'resolveWith: pressed=0, hovered=8, default=4',
              ),
              _buildPropertyRow(
                'overlayColor',
                'resolveWith: pressed/default alpha',
              ),
              _buildPropertyRow('side', 'resolveWith: focused => amber border'),
              _buildPropertyRow('padding', 'resolveWith: pressed => smaller'),
              _buildPropertyRow('shape', 'all: RoundedRectangleBorder(12)'),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Disabled variant',
          description: 'Same style but disabled shows state resolution',
          accentColor: Colors.grey,
          child: ElevatedButton(
            onPressed: null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey.shade300;
                }
                return Colors.deepPurple.shade400;
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey.shade500;
                }
                return Colors.white;
              }),
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            child: Text('Disabled (State Resolved)'),
          ),
        ),

        // Section 9: Checkbox, Switch, Radio
        buildSectionHeader('9. Checkbox, Switch, Radio State Demos'),
        buildDescription(
          'These widgets internally use WidgetStateMixin to track states',
        ),

        buildDemoCard(
          title: 'Checkbox - Selected/Unselected States',
          description:
              'Checkbox uses the mixin for hover, focus, press, selected',
          accentColor: Colors.green,
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(value: true, onChanged: (v) {}),
                  SizedBox(width: 8),
                  Text('Selected (checked)', style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (v) {}),
                  SizedBox(width: 8),
                  Text('Unselected', style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  Checkbox(value: null, tristate: true, onChanged: (v) {}),
                  SizedBox(width: 8),
                  Text(
                    'Tristate (indeterminate)',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: null),
                  SizedBox(width: 8),
                  Text(
                    'Disabled selected',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Checkbox(
                value: true,
                onChanged: (v) {},
                fillColor: WidgetStateProperty.resolveWith<Color>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.green.shade600;
                  }
                  return Colors.grey.shade400;
                }),
                checkColor: Colors.white,
              ),
              Text(
                'Custom fillColor via WidgetStateProperty',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Switch - On/Off States',
          description:
              'Switch tracks selected, disabled, hovered, focused states',
          accentColor: Colors.orange,
          child: Column(
            children: [
              Row(
                children: [
                  Switch(value: true, onChanged: (v) {}),
                  SizedBox(width: 8),
                  Text('On (selected)', style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  Switch(value: false, onChanged: (v) {}),
                  SizedBox(width: 8),
                  Text('Off', style: TextStyle(fontSize: 14)),
                ],
              ),
              Row(
                children: [
                  Switch(value: true, onChanged: null),
                  SizedBox(width: 8),
                  Text(
                    'Disabled on',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Switch(
                value: true,
                onChanged: (v) {},
                thumbColor: WidgetStateProperty.resolveWith<Color>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.orange.shade800;
                  }
                  return Colors.grey.shade400;
                }),
                trackColor: WidgetStateProperty.resolveWith<Color>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.orange.shade200;
                  }
                  return Colors.grey.shade300;
                }),
              ),
              Text(
                'Custom thumb/track via WidgetStateProperty',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Radio - Selection States',
          description: 'Radio buttons track selected and disabled states',
          accentColor: Colors.blue,
          child: Column(
            children: [
              RadioGroup<int>(
                groupValue: 1,
                onChanged: (int? v) {},
                child: Column(
                  children: [
                    Row(
                      children: [
                        Radio<int>(value: 1),
                        SizedBox(width: 8),
                        Text(
                          'Selected (value matches groupValue)',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<int>(value: 2),
                        SizedBox(width: 8),
                        Text('Unselected', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Radio<int>(value: 1, toggleable: true),
                  SizedBox(width: 8),
                  Text(
                    'Standalone (no group)',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8),
              RadioGroup<int>(
                groupValue: 1,
                onChanged: (int? v) {},
                child: Radio<int>(
                  value: 1,
                  fillColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.blue.shade700;
                    }
                    return Colors.grey.shade500;
                  }),
                ),
              ),
              Text(
                'Custom fillColor via WidgetStateProperty',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),

        // Section 10: WidgetStateMouseCursor
        buildSectionHeader('10. WidgetStateMouseCursor Demonstration'),
        buildDescription('Mouse cursor changes based on widget state'),

        buildDemoCard(
          title: 'Mouse Cursor per State',
          description:
              'WidgetStateMouseCursor.clickable / WidgetStateMouseCursor.textable',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCursorRow(
                'WidgetStateMouseCursor.clickable',
                'click for enabled, forbidden for disabled',
              ),
              _buildCursorRow(
                'WidgetStateMouseCursor.textable',
                'text for enabled, forbidden for disabled',
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return SystemMouseCursors.forbidden;
                    }
                    return SystemMouseCursors.click;
                  }),
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.indigo.shade400,
                  ),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                child: Text('Hover for Click Cursor'),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((
                    Set<WidgetState> states,
                  ) {
                    if (states.contains(WidgetState.disabled)) {
                      return SystemMouseCursors.forbidden;
                    }
                    return SystemMouseCursors.click;
                  }),
                  padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                child: Text('Hover for Forbidden Cursor'),
              ),
            ],
          ),
        ),

        // Section 11: State Resolution Summary
        buildSectionHeader('11. State Resolution Hierarchy Summary'),
        buildDescription(
          'Resolution order matters: check highest-priority state first',
        ),

        buildDemoCard(
          title: 'Recommended Resolution Order',
          description: 'Check in this order for predictable behavior',
          accentColor: Colors.blueGrey,
          child: Column(
            children: [
              _buildHierarchyRow(
                1,
                'error',
                Colors.red.shade600,
                'Highest priority',
              ),
              _buildHierarchyRow(
                2,
                'disabled',
                Colors.grey.shade500,
                'Blocks interaction',
              ),
              _buildHierarchyRow(
                3,
                'pressed',
                Colors.indigo.shade800,
                'Active touch/click',
              ),
              _buildHierarchyRow(
                4,
                'dragged',
                Colors.orange.shade600,
                'Being moved',
              ),
              _buildHierarchyRow(
                5,
                'selected',
                Colors.green.shade600,
                'Toggled on',
              ),
              _buildHierarchyRow(
                6,
                'focused',
                Colors.blue.shade600,
                'Keyboard focus',
              ),
              _buildHierarchyRow(
                7,
                'hovered',
                Colors.purple.shade400,
                'Mouse over',
              ),
            ],
          ),
        ),

        buildDemoCard(
          title: 'Integration Summary',
          description: 'How WidgetStateMixin powers the Material library',
          accentColor: Colors.indigo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryItem(
                'Buttons',
                'ElevatedButton, TextButton, OutlinedButton, FilledButton',
              ),
              _buildSummaryItem(
                'Toggles',
                'Checkbox, Switch, Radio, ToggleButtons',
              ),
              _buildSummaryItem(
                'Input',
                'TextField overlayColor, cursor, border states',
              ),
              _buildSummaryItem(
                'Navigation',
                'NavigationBar, NavigationRail indicators',
              ),
              _buildSummaryItem(
                'Properties',
                'WidgetStateProperty<T> for any type',
              ),
              _buildSummaryItem(
                'Controller',
                'WidgetStatesController for external access',
              ),
              _buildSummaryItem(
                'Cursor',
                'WidgetStateMouseCursor for cursor changes',
              ),
              SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Text(
                  'WidgetStateMixin (formerly MaterialStateMixin) is the foundation '
                  'for all interactive state tracking in Material Design 3 widgets.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.indigo.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 32),
      ],
    ),
  );
}

// Private helpers

Widget _buildAllVsResolveRow(
  String stateLabel,
  Color allColor,
  Color resolveColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            stateLabel,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(color: allColor, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(
          '.all',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
        SizedBox(width: 16),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: resolveColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4),
        Text(
          '.resolveWith',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildTextStyleRow(String label, TextStyle style) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
        Text('Sample Text', style: style),
      ],
    ),
  );
}

Widget _buildBorderSideRow(String label, BorderSide side) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: side.color, width: side.width),
    ),
    child: Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        Text(
          'width: ${side.width.toStringAsFixed(0)}',
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildCodeLine(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    margin: EdgeInsets.symmetric(vertical: 1),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontSize: 12,
        fontFamily: 'monospace',
        color: Colors.green.shade300,
      ),
    ),
  );
}

Widget _buildPropertyRow(String property, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            property,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCursorRow(String name, String description) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyRow(
  int priority,
  String state,
  Color color,
  String note,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 3),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Center(
            child: Text(
              '$priority',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 80,
          child: Text(
            state,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            note,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryItem(String category, String details) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.arrow_right, color: Colors.indigo.shade400, size: 18),
        SizedBox(width: 4),
        SizedBox(
          width: 90,
          child: Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.indigo.shade600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            details,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
