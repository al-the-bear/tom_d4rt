// ignore_for_file: avoid_print
// D4rt test script: Deep demo for RenderAbsorbPointer from rendering
//
// RenderAbsorbPointer is a render object that absorbs pointer events,
// preventing its children from receiving them. When absorbing is true,
// hit testing terminates at this render object and its children never
// see taps, drags, or other pointer interactions.
//
// Key properties:
//   - absorbing: whether to absorb pointer events (bool)
//   - ignoringSemantics: whether to also ignore for accessibility
//
// Related classes:
//   - AbsorbPointer: the widget wrapper for RenderAbsorbPointer
//   - RenderIgnorePointer: similar but does not terminate hit testing
//   - IgnorePointer: widget wrapper for RenderIgnorePointer
//   - HitTestResult: accumulates hit test entries
//
// Use cases:
//   - Disabling interaction during loading states
//   - Overlay areas that block touches
//   - Conditional interactivity toggling
//   - Form disabling during submission
//   - Modal barriers and scrims
//
// This demo visualizes RenderAbsorbPointer behavior and patterns.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF4A148C).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.do_not_touch, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF7B1FA2).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF4A148C), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A148C),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF6A1B9A),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFF263238),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12,
        color: Color(0xFF80CBC4),
        height: 1.5,
      ),
    ),
  );
}

Widget _buildDiagramBox(
  String label,
  Color color, {
  IconData? icon,
  double width = 110,
}) {
  return Container(
    width: width,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color, width: 2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) Icon(icon, color: color, size: 20),
        if (icon != null) SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildArrow({bool vertical = false, Color color = Colors.grey}) {
  if (vertical) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 2, height: 20, color: color),
        Icon(Icons.arrow_drop_down, color: color, size: 20),
      ],
    );
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(width: 20, height: 2, color: color),
      Icon(Icons.arrow_right, color: color, size: 20),
    ],
  );
}

Widget _buildStatusBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

Widget _buildInteractiveCard(
  String title,
  String description,
  bool isAbsorbing,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: isAbsorbing ? Colors.grey.shade100 : color.withAlpha(15),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isAbsorbing ? Colors.grey.shade400 : color,
        width: 1.5,
      ),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Icon(
              isAbsorbing ? Icons.block : Icons.touch_app,
              color: isAbsorbing ? Colors.grey : color,
              size: 22,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isAbsorbing ? Colors.grey.shade600 : color,
                ),
              ),
            ),
            _buildStatusBadge(
              isAbsorbing ? 'ABSORBED' : 'INTERACTIVE',
              isAbsorbing ? Colors.red : Colors.green,
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 12,
            color: isAbsorbing ? Colors.grey.shade500 : Colors.black87,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: RENDER ABSORB POINTER OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildOverviewSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('RenderAbsorbPointer Overview', Icons.info_outline),
        Text(
          'RenderAbsorbPointer is the render object behind the AbsorbPointer '
          'widget. It intercepts hit tests so that pointer events never reach '
          'child render objects when absorbing is enabled.',
          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
        ),
        SizedBox(height: 16),
        _buildInfoRow('Class', 'RenderAbsorbPointer'),
        _buildInfoRow('Extends', 'RenderProxyBox'),
        _buildInfoRow('Library', 'package:flutter/rendering.dart'),
        _buildInfoRow('Widget', 'AbsorbPointer'),
        _buildInfoRow('Default absorbing', 'true'),
        _buildInfoRow('Default ignoringSemantics', 'null (follows absorbing)'),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF7B1FA2)),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Unlike IgnorePointer, AbsorbPointer terminates the hit test '
                  'at itself, so no widgets behind it receive events either.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF4A148C)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                'Hit Test Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 12),
              _buildDiagramBox(
                'Pointer Event',
                Color(0xFF0D47A1),
                icon: Icons.touch_app,
                width: 140,
              ),
              _buildArrow(vertical: true, color: Color(0xFF0D47A1)),
              _buildDiagramBox(
                'RenderAbsorbPointer\n(absorbing: true)',
                Color(0xFFC62828),
                icon: Icons.block,
                width: 180,
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFFFCDD2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'HIT TEST STOPS HERE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC62828),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Icon(Icons.close, color: Colors.red, size: 28),
              _buildDiagramBox(
                'Child Widgets\n(never reached)',
                Colors.grey,
                icon: Icons.widgets_outlined,
                width: 160,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: ABSORBING PROPERTY (TRUE/FALSE COMPARISON)
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildAbsorbingPropertySection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('absorbing Property', Icons.toggle_on),
        Text(
          'The absorbing property controls whether pointer events are absorbed. '
          'When true, the render object claims the hit test and children receive '
          'nothing. When false, events pass through normally.',
          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInteractiveCard(
                'absorbing: true',
                'Button taps, drags, and long presses are all blocked. '
                'The child tree is rendered but untouchable.',
                true,
                Color(0xFFC62828),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildInteractiveCard(
                'absorbing: false',
                'All pointer events flow through to the child tree. '
                'Buttons, gestures, and interactions work normally.',
                false,
                Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          'AbsorbPointer(\n'
          '  absorbing: true,  // blocks all events\n'
          '  child: ElevatedButton(\n'
          '    onPressed: () {},  // never fires\n'
          '    child: Text(\'Blocked\'),\n'
          '  ),\n'
          ')\n'
          '\n'
          'AbsorbPointer(\n'
          '  absorbing: false, // events pass through\n'
          '  child: ElevatedButton(\n'
          '    onPressed: () {},  // fires normally\n'
          '    child: Text(\'Active\'),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Behavior Comparison',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 8),
              _buildComparisonRow('Tap events', 'Blocked', 'Delivered'),
              _buildComparisonRow('Drag events', 'Blocked', 'Delivered'),
              _buildComparisonRow('Long press', 'Blocked', 'Delivered'),
              _buildComparisonRow('Hover events', 'Blocked', 'Delivered'),
              _buildComparisonRow('Hit test result', 'Self only', 'Self + children'),
              _buildComparisonRow('Child rendering', 'Normal', 'Normal'),
              _buildComparisonRow('Layout behavior', 'Unchanged', 'Unchanged'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonRow(
  String label,
  String trueVal,
  String falseVal,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            trueVal,
            style: TextStyle(fontSize: 12, color: Colors.red.shade700),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            falseVal,
            style: TextStyle(fontSize: 12, color: Colors.green.shade700),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: IGNORING SEMANTICS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildIgnoringSemanticsSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('ignoringSemantics', Icons.accessibility_new),
        Text(
          'The ignoringSemantics property controls whether the subtree is also '
          'excluded from the semantics tree used by screen readers and '
          'accessibility services. When null, it defaults to the value of absorbing.',
          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSemanticsRow(
                'null (default)',
                'Follows absorbing value',
                Icons.sync,
                Color(0xFF3F51B5),
              ),
              Divider(),
              _buildSemanticsRow(
                'true',
                'Always excluded from semantics',
                Icons.voice_over_off,
                Colors.red,
              ),
              Divider(),
              _buildSemanticsRow(
                'false',
                'Always included in semantics',
                Icons.record_voice_over,
                Colors.green,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Absorb touch but keep accessible\n'
          'AbsorbPointer(\n'
          '  absorbing: true,\n'
          '  ignoringSemantics: false,\n'
          '  child: Column(\n'
          '    children: [\n'
          '      Text(\'Still read by TalkBack/VoiceOver\'),\n'
          '      ElevatedButton(\n'
          '        onPressed: () {},\n'
          '        child: Text(\'Blocked but announced\'),\n'
          '      ),\n'
          '    ],\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.orange.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.warning_amber, color: Colors.orange.shade700),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Setting ignoringSemantics to true removes elements from the '
                  'accessibility tree entirely. Screen reader users will not know '
                  'the content exists. Use with caution.',
                  style: TextStyle(fontSize: 12, color: Colors.orange.shade900),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSemanticsRow(
  String value,
  String description,
  IconData icon,
  Color color,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(width: 10),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: USE WITH ABSORB POINTER WIDGET
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildWidgetUsageSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('AbsorbPointer Widget', Icons.widgets),
        Text(
          'AbsorbPointer is the widget-level API that creates a '
          'RenderAbsorbPointer. Most code interacts through this widget '
          'rather than the render object directly.',
          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
        ),
        SizedBox(height: 16),
        Center(
          child: Column(
            children: [
              Text(
                'Widget to Render Object Mapping',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDiagramBox(
                    'AbsorbPointer\n(Widget)',
                    Color(0xFF4A148C),
                    icon: Icons.widgets,
                    width: 140,
                  ),
                  _buildArrow(color: Color(0xFF7B1FA2)),
                  _buildDiagramBox(
                    'RenderAbsorbPointer\n(RenderObject)',
                    Color(0xFFC62828),
                    icon: Icons.account_tree,
                    width: 160,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AbsorbPointer Constructor',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 8),
              _buildInfoRow('key', 'Key? - widget key'),
              _buildInfoRow('absorbing', 'bool - default true'),
              _buildInfoRow('ignoringSemantics', 'bool? - default null'),
              _buildInfoRow('child', 'Widget? - child subtree'),
            ],
          ),
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Basic usage\n'
          'AbsorbPointer(\n'
          '  child: MyInteractiveWidget(),\n'
          ')\n'
          '\n'
          '// Conditional absorbing\n'
          'AbsorbPointer(\n'
          '  absorbing: isLoading,\n'
          '  child: Form(\n'
          '    child: Column(\n'
          '      children: [\n'
          '        TextFormField(),\n'
          '        ElevatedButton(\n'
          '          onPressed: _submit,\n'
          '          child: Text(\'Submit\'),\n'
          '        ),\n'
          '      ],\n'
          '    ),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AbsorbPointer vs IgnorePointer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF00695C),
                ),
              ),
              SizedBox(height: 8),
              _buildVsRow('AbsorbPointer', 'Stops hit test at itself'),
              _buildVsRow('IgnorePointer', 'Makes subtree invisible to hit test'),
              SizedBox(height: 8),
              Text(
                'AbsorbPointer: widgets BEHIND cannot receive events.\n'
                'IgnorePointer: widgets BEHIND CAN receive events.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF00695C),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildVsRow(String widget, String behavior) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: Color(0xFF00695C),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '$widget: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Color(0xFF004D40),
          ),
        ),
        Expanded(
          child: Text(
            behavior,
            style: TextStyle(fontSize: 12, color: Color(0xFF00695C)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: NESTED ABSORB / IGNORE SCENARIOS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildNestedScenariosSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Nested Absorb / Ignore Scenarios', Icons.layers),
        Text(
          'When AbsorbPointer and IgnorePointer are nested, the outermost '
          'absorbing or ignoring widget wins. A child cannot become interactive '
          'if an ancestor already blocks events.',
          style: TextStyle(fontSize: 13, color: Colors.black87, height: 1.5),
        ),
        SizedBox(height: 16),
        _buildScenarioCard(
          'Scenario 1: AbsorbPointer > IgnorePointer(false)',
          'Outer absorb wins. Inner ignoring:false has no effect because '
          'the hit test already stopped at the outer AbsorbPointer.',
          Color(0xFFC62828),
          Icons.block,
          'BLOCKED',
        ),
        SizedBox(height: 12),
        _buildScenarioCard(
          'Scenario 2: IgnorePointer > AbsorbPointer',
          'Outer ignore makes subtree invisible to hit testing. '
          'Inner AbsorbPointer is never reached during hit test.',
          Color(0xFFE65100),
          Icons.visibility_off,
          'INVISIBLE',
        ),
        SizedBox(height: 12),
        _buildScenarioCard(
          'Scenario 3: AbsorbPointer(false) > AbsorbPointer(true)',
          'Outer allows pass-through. Inner absorbs. Children of the '
          'inner AbsorbPointer are blocked, but siblings are reachable.',
          Color(0xFF1565C0),
          Icons.filter_list,
          'PARTIAL',
        ),
        SizedBox(height: 12),
        _buildScenarioCard(
          'Scenario 4: Stack with absorbed and interactive layers',
          'In a Stack, an AbsorbPointer layer on top blocks events for '
          'everything below it. Widgets positioned above the absorber '
          'remain interactive.',
          Color(0xFF2E7D32),
          Icons.dynamic_feed,
          'MIXED',
        ),
        SizedBox(height: 16),
        _buildCodeBlock(
          '// Nested scenario example\n'
          'AbsorbPointer(\n'
          '  absorbing: false, // pass-through\n'
          '  child: Column(\n'
          '    children: [\n'
          '      AbsorbPointer(\n'
          '        absorbing: true, // blocks\n'
          '        child: Button1(),\n'
          '      ),\n'
          '      Button2(), // still interactive\n'
          '    ],\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildScenarioCard(
  String title,
  String description,
  Color color,
  IconData icon,
  String badge,
) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: color,
                ),
              ),
            ),
            _buildStatusBadge(badge, color),
          ],
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 6: COMMON PATTERNS (LOADING OVERLAYS, DISABLED AREAS)
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCommonPatternsSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Common Patterns', Icons.pattern),

        _buildPatternCard(
          'Loading Overlay',
          'Wrap content in AbsorbPointer during async operations to prevent '
          'duplicate submissions or navigation while data loads.',
          Icons.hourglass_top,
          Color(0xFF0277BD),
          'AbsorbPointer(\n'
          '  absorbing: isLoading,\n'
          '  child: Stack(\n'
          '    children: [\n'
          '      MyContent(),\n'
          '      if (isLoading)\n'
          '        Center(\n'
          '          child: CircularProgressIndicator(),\n'
          '        ),\n'
          '    ],\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 16),

        _buildPatternCard(
          'Disabled Form Area',
          'Absorb pointer events on form sections that should not be editable '
          'based on application state or user permissions.',
          Icons.edit_off,
          Color(0xFF6A1B9A),
          'AbsorbPointer(\n'
          '  absorbing: !hasEditPermission,\n'
          '  child: Opacity(\n'
          '    opacity: hasEditPermission ? 1.0 : 0.5,\n'
          '    child: FormSection(),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 16),

        _buildPatternCard(
          'Modal Barrier / Scrim',
          'Use AbsorbPointer in a Stack to create a custom modal barrier '
          'that prevents interaction with background content.',
          Icons.layers,
          Color(0xFF00695C),
          'Stack(\n'
          '  children: [\n'
          '    MainContent(),\n'
          '    if (showModal)\n'
          '      AbsorbPointer(\n'
          '        absorbing: true,\n'
          '        child: Container(\n'
          '          color: Colors.black54,\n'
          '        ),\n'
          '      ),\n'
          '    if (showModal)\n'
          '      Center(child: ModalDialog()),\n'
          '  ],\n'
          ')',
        ),
        SizedBox(height: 16),

        _buildPatternCard(
          'Onboarding Spotlight',
          'Block interaction everywhere except a highlighted area during '
          'onboarding tutorials using a combination of AbsorbPointer layers.',
          Icons.school,
          Color(0xFFC62828),
          'Stack(\n'
          '  children: [\n'
          '    AbsorbPointer(\n'
          '      absorbing: isTutorialActive,\n'
          '      child: AppContent(),\n'
          '    ),\n'
          '    if (isTutorialActive)\n'
          '      TutorialHighlight(\n'
          '        target: spotlightTarget,\n'
          '      ),\n'
          '  ],\n'
          ')',
        ),
        SizedBox(height: 16),

        _buildPatternCard(
          'Animated Enable / Disable',
          'Combine AbsorbPointer with AnimatedOpacity to smoothly fade '
          'content between interactive and disabled visual states.',
          Icons.animation,
          Color(0xFFEF6C00),
          'AbsorbPointer(\n'
          '  absorbing: isDisabled,\n'
          '  child: AnimatedOpacity(\n'
          '    opacity: isDisabled ? 0.4 : 1.0,\n'
          '    duration: Duration(milliseconds: 300),\n'
          '    child: InteractiveContent(),\n'
          '  ),\n'
          ')',
        ),
        SizedBox(height: 16),

        _buildPatternCard(
          'Conditional Dismiss Block',
          'Prevent a bottom sheet or drawer from being dismissed by absorbing '
          'drag events on the scrim while an operation is pending.',
          Icons.swipe_down,
          Color(0xFF37474F),
          'AbsorbPointer(\n'
          '  absorbing: isSaving,\n'
          '  child: GestureDetector(\n'
          '    onVerticalDragEnd: (_) {\n'
          '      Navigator.pop(context);\n'
          '    },\n'
          '    child: DismissArea(),\n'
          '  ),\n'
          ')',
        ),
      ],
    ),
  );
}

Widget _buildPatternCard(
  String title,
  String description,
  IconData icon,
  Color color,
  String code,
) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withAlpha(10), color.withAlpha(25)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withAlpha(30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: color,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          description,
          style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
        ),
        SizedBox(height: 10),
        _buildCodeBlock(code),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F0FA),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(
              'RenderAbsorbPointer',
              'Absorbs pointer events, preventing children from receiving them',
            ),
            SizedBox(height: 20),
            _buildOverviewSection(),
            SizedBox(height: 16),
            _buildAbsorbingPropertySection(),
            SizedBox(height: 16),
            _buildIgnoringSemanticsSection(),
            SizedBox(height: 16),
            _buildWidgetUsageSection(),
            SizedBox(height: 16),
            _buildNestedScenariosSection(),
            SizedBox(height: 16),
            _buildCommonPatternsSection(),
            SizedBox(height: 24),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF4A148C), size: 36),
                  SizedBox(height: 8),
                  Text(
                    'RenderAbsorbPointer Deep Demo Complete',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF4A148C),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Pointer absorption, semantics, nesting, and patterns visualized',
                    style: TextStyle(fontSize: 12, color: Color(0xFF7B1FA2)),
                    textAlign: TextAlign.center,
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
