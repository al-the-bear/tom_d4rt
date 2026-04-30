// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo of SemanticsUpdate from dart:ui
// SemanticsUpdate is the object produced by SemanticsUpdateBuilder that
// carries accessibility tree information from Flutter to the platform engine.
// It is part of the low-level semantics pipeline that enables screen readers,
// switch access, and other assistive technologies.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

dynamic build(BuildContext context) {
  print('SemanticsUpdate deep demo executing');

  // ============================================================
  // SECTION 1: Semantics Pipeline Overview
  // ============================================================
  print('=== Section 1: Semantics Pipeline Overview ===');

  // The pipeline: Semantics widgets -> SemanticsNode tree ->
  // SemanticsUpdateBuilder -> SemanticsUpdate -> Engine
  Widget suPipelineCard(String stage, String description, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22.0),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stage, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: color)),
                SizedBox(height: 2.0),
                Text(description, style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final suPipelineStages = <Widget>[
    suPipelineCard('Semantics Widget', 'Annotates the widget tree with accessibility labels, actions, and flags', Icons.widgets, Colors.deepOrange.shade700),
    suPipelineCard('SemanticsNode Tree', 'Framework assembles a parallel tree of semantics nodes from annotations', Icons.account_tree, Colors.deepOrange.shade600),
    suPipelineCard('SemanticsUpdateBuilder', 'Serializes changed nodes into a compact update using updateNode()', Icons.build_circle, Colors.deepOrange.shade500),
    suPipelineCard('SemanticsUpdate', 'Immutable payload object produced by builder.build()', Icons.send, Colors.deepOrange.shade400),
    suPipelineCard('Platform Engine', 'Receives the update and notifies the operating system accessibility API', Icons.phone_android, Colors.deepOrange.shade300),
  ];

  print('Pipeline has 5 stages from widget to engine');

  // ============================================================
  // SECTION 2: SemanticsUpdateBuilder Basics
  // ============================================================
  print('=== Section 2: SemanticsUpdateBuilder Basics ===');

  final ui.SemanticsUpdateBuilder builder1 = ui.SemanticsUpdateBuilder();
  print('SemanticsUpdateBuilder created: ${builder1.runtimeType}');

  final ui.SemanticsUpdate update1 = builder1.build();
  print('SemanticsUpdate built: ${update1.runtimeType}');
  print('Empty update (no nodes configured)');
  update1.dispose();
  print('Update disposed');

  Widget suBuilderInfoCard(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepOrange, size: 18.0),
          SizedBox(width: 10.0),
          Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0)),
          Spacer(),
          Text(value, style: TextStyle(color: Colors.deepOrange.shade700, fontFamily: 'monospace', fontSize: 12.0)),
        ],
      ),
    );
  }

  final suBuilderFacts = <Widget>[
    suBuilderInfoCard('Class', 'SemanticsUpdateBuilder', Icons.class_),
    suBuilderInfoCard('Creates', 'SemanticsUpdate', Icons.output),
    suBuilderInfoCard('Key method', 'updateNode()', Icons.settings),
    suBuilderInfoCard('Build method', 'build()', Icons.play_arrow),
    suBuilderInfoCard('Lifecycle', 'dispose() after use', Icons.delete_outline),
  ];

  // ============================================================
  // SECTION 3: Semantics Widget — Basic Labels
  // ============================================================
  print('=== Section 3: Semantics Widget: Basic Labels ===');

  Widget suLabelDemo(String label, String hint, Color chipColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [chipColor.withValues(alpha: 0.1), chipColor.withValues(alpha: 0.04)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: chipColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.label_outline, color: chipColor, size: 18.0),
              SizedBox(width: 8.0),
              Text('label: "$label"', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.0)),
            ],
          ),
          SizedBox(height: 4.0),
          Text('hint: "$hint"', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600)),
          SizedBox(height: 8.0),
          Semantics(
            label: label,
            hint: hint,
            child: Container(
              height: 44.0,
              decoration: BoxDecoration(
                color: chipColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(label, style: TextStyle(color: Color.lerp(chipColor, Colors.black, 0.3), fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('Created label demo widgets with Semantics annotations');

  // ============================================================
  // SECTION 4: Semantics Actions
  // ============================================================
  print('=== Section 4: Semantics Actions ===');

  final suActionList = <Map<String, dynamic>>[
    {'action': SemanticsAction.tap, 'name': 'tap', 'desc': 'Activates the element (click/press)', 'icon': Icons.touch_app},
    {'action': SemanticsAction.longPress, 'name': 'longPress', 'desc': 'Triggers on extended press', 'icon': Icons.pan_tool},
    {'action': SemanticsAction.scrollLeft, 'name': 'scrollLeft', 'desc': 'Scrolls content leftward', 'icon': Icons.arrow_back},
    {'action': SemanticsAction.scrollRight, 'name': 'scrollRight', 'desc': 'Scrolls content rightward', 'icon': Icons.arrow_forward},
    {'action': SemanticsAction.scrollUp, 'name': 'scrollUp', 'desc': 'Scrolls content upward', 'icon': Icons.arrow_upward},
    {'action': SemanticsAction.scrollDown, 'name': 'scrollDown', 'desc': 'Scrolls content downward', 'icon': Icons.arrow_downward},
    {'action': SemanticsAction.increase, 'name': 'increase', 'desc': 'Increments a value (slider, stepper)', 'icon': Icons.add_circle_outline},
    {'action': SemanticsAction.decrease, 'name': 'decrease', 'desc': 'Decrements a value', 'icon': Icons.remove_circle_outline},
    {'action': SemanticsAction.copy, 'name': 'copy', 'desc': 'Copies text to clipboard', 'icon': Icons.copy},
    {'action': SemanticsAction.cut, 'name': 'cut', 'desc': 'Cuts text to clipboard', 'icon': Icons.content_cut},
    {'action': SemanticsAction.paste, 'name': 'paste', 'desc': 'Pastes from clipboard', 'icon': Icons.paste},
    {'action': SemanticsAction.dismiss, 'name': 'dismiss', 'desc': 'Closes or dismisses element', 'icon': Icons.close},
  ];

  for (final a in suActionList) {
    final act = a['action'] as SemanticsAction;
    print('Action: ${a['name']} - index=${act.index}');
  }

  Widget suActionCard(String name, String desc, IconData icon, int idx) {
    final hue = (idx * 25.0) % 360.0;
    final color = HSLColor.fromAHSL(1.0, hue, 0.65, 0.45).toColor();
    return Container(
      width: 155.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16.0),
              SizedBox(width: 6.0),
              Expanded(child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: color))),
            ],
          ),
          SizedBox(height: 4.0),
          Text(desc, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700)),
        ],
      ),
    );
  }

  final suActionWidgets = <Widget>[];
  for (int i = 0; i < suActionList.length; i++) {
    final a = suActionList[i];
    suActionWidgets.add(suActionCard(a['name'] as String, a['desc'] as String, a['icon'] as IconData, i));
  }

  // ============================================================
  // SECTION 5: Semantics Flags (SemanticsFlag)
  // ============================================================
  print('=== Section 5: Semantics Flags ===');

  final suFlagData = <Map<String, dynamic>>[
    {'name': 'hasCheckedState', 'desc': 'Element has a checked/unchecked state (checkbox)', 'color': Colors.teal},
    {'name': 'isChecked', 'desc': 'Element is currently checked', 'color': Colors.green},
    {'name': 'isSelected', 'desc': 'Element is the current selection in a group', 'color': Colors.blue},
    {'name': 'isButton', 'desc': 'Element is a pressable button', 'color': Colors.indigo},
    {'name': 'isLink', 'desc': 'Element is a navigational hyperlink', 'color': Colors.purple},
    {'name': 'isTextField', 'desc': 'Element accepts text input', 'color': Colors.orange},
    {'name': 'isSlider', 'desc': 'Element is a slider control', 'color': Colors.red},
    {'name': 'isReadOnly', 'desc': 'Text field is not editable', 'color': Colors.brown},
    {'name': 'isFocusable', 'desc': 'Element can receive keyboard focus', 'color': Colors.cyan},
    {'name': 'isFocused', 'desc': 'Element currently holds focus', 'color': Colors.lime},
    {'name': 'isHeader', 'desc': 'Element is a heading for a section', 'color': Colors.amber},
    {'name': 'isImage', 'desc': 'Element represents an image', 'color': Colors.pink},
    {'name': 'isHidden', 'desc': 'Element is present but invisible to accessibility', 'color': Colors.grey},
    {'name': 'isObscured', 'desc': 'Text content is obscured (password)', 'color': Colors.blueGrey},
    {'name': 'hasImplicitScrolling', 'desc': 'Element scrolls implicitly', 'color': Colors.deepPurple},
  ];

  Widget suFlagChip(String name, String desc, Color color) {
    return Container(
      margin: EdgeInsets.all(3.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0, color: color)),
          SizedBox(height: 2.0),
          Text(desc, style: TextStyle(fontSize: 9.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  final suFlagWidgets = suFlagData.map((f) => suFlagChip(f['name'] as String, f['desc'] as String, f['color'] as Color)).toList();
  print('15 semantics flags documented');

  // ============================================================
  // SECTION 6: MergeSemantics — Combining Nodes
  // ============================================================
  print('=== Section 6: MergeSemantics ===');

  // MergeSemantics merges child semantics into one node
  Widget suMergeExample = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.deepOrange.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('MergeSemantics Example', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.deepOrange.shade800)),
        SizedBox(height: 8.0),
        Text('Without merge: screen reader reads icon and text separately.', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SizedBox(height: 6.0),
        Row(
          children: [
            Text('Separate: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)),
            Semantics(label: 'Star icon', child: Icon(Icons.star, color: Colors.amber, size: 20.0)),
            SizedBox(width: 4.0),
            Semantics(label: 'Rating text', child: Text('4.5 stars')),
          ],
        ),
        SizedBox(height: 10.0),
        Text('With merge: single announcement "Star icon, 4.5 stars".', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SizedBox(height: 6.0),
        MergeSemantics(
          child: Row(
            children: [
              Text('Merged: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)),
              Icon(Icons.star, color: Colors.amber, size: 20.0),
              SizedBox(width: 4.0),
              Text('4.5 stars'),
            ],
          ),
        ),
      ],
    ),
  );
  print('MergeSemantics combines child semantic annotations into one node');

  // ============================================================
  // SECTION 7: ExcludeSemantics — Hiding from Accessibility
  // ============================================================
  print('=== Section 7: ExcludeSemantics ===');

  Widget suExcludeExample = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ExcludeSemantics Example', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.orange.shade800)),
        SizedBox(height: 8.0),
        Text('Decorative elements should be excluded from the accessibility tree.', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SizedBox(height: 8.0),
        Row(
          children: [
            Text('Visible: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)),
            ExcludeSemantics(
              child: Container(
                width: 60.0,
                height: 30.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.orange.shade200, Colors.deepOrange.shade200]),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Center(child: Text('Decor', style: TextStyle(fontSize: 10.0, color: Colors.white))),
              ),
            ),
            SizedBox(width: 8.0),
            Text('(hidden from screen reader)', style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Colors.grey)),
          ],
        ),
        SizedBox(height: 10.0),
        Text('Use ExcludeSemantics for:', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.0)),
        Padding(
          padding: EdgeInsets.only(left: 12.0, top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('- Decorative icons and dividers', style: TextStyle(fontSize: 11.5)),
              Text('- Background images without meaning', style: TextStyle(fontSize: 11.5)),
              Text('- Redundant text already announced elsewhere', style: TextStyle(fontSize: 11.5)),
            ],
          ),
        ),
      ],
    ),
  );
  print('ExcludeSemantics removes subtree from accessibility');

  // ============================================================
  // SECTION 8: Semantics Properties Showcase
  // ============================================================
  print('=== Section 8: Semantics Properties ===');

  Widget suPropertyRow(String propName, String example, String effect, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6.0),
        border: Border(left: BorderSide(color: accent, width: 3.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.0,
            child: Text(propName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.5, fontFamily: 'monospace', color: accent)),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(example, style: TextStyle(fontSize: 11.0)),
                Text(effect, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600, fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final suProperties = <Widget>[
    suPropertyRow('label', '"Submit button"', 'Primary description read by screen reader', Colors.deepOrange),
    suPropertyRow('hint', '"Double tap to submit"', 'Additional action guidance', Colors.orange),
    suPropertyRow('value', '"50%"', 'Current value of a slider or progress', Colors.amber),
    suPropertyRow('increasedValue', '"60%"', 'Value after increase action', Colors.green),
    suPropertyRow('decreasedValue', '"40%"', 'Value after decrease action', Colors.red),
    suPropertyRow('tooltip', '"Saves the document"', 'Tooltip text associated with the element', Colors.blue),
    suPropertyRow('textDirection', 'TextDirection.ltr', 'Reading direction of the label', Colors.indigo),
    suPropertyRow('sortKey', 'OrdinalSortKey(1.0)', 'Controls traversal order', Colors.purple),
    suPropertyRow('tagForChildren', 'RenderViewport.excludeFromScrolling', 'Tag semantics children for framework use', Colors.teal),
  ];
  print('9 key semantics properties documented');

  // ============================================================
  // SECTION 9: Semantics in Interactive Widgets
  // ============================================================
  print('=== Section 9: Interactive Widget Semantics ===');

  Widget suInteractiveDemo(String widgetName, String announce, Widget child, Color accent) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(width: 80.0, child: child),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widgetName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: accent)),
                SizedBox(height: 2.0),
                Text('Announces: "$announce"', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final suInteractives = <Widget>[
    suInteractiveDemo(
      'Checkbox',
      'Checked / Unchecked',
      Checkbox(value: true, onChanged: (_) {}),
      Colors.green,
    ),
    suInteractiveDemo(
      'Switch',
      'On / Off',
      Switch(value: false, onChanged: (_) {}),
      Colors.blue,
    ),
    suInteractiveDemo(
      'Slider',
      'Value between min and max',
      SizedBox(width: 80.0, child: Slider(value: 0.7, onChanged: (_) {})),
      Colors.orange,
    ),
    suInteractiveDemo(
      'IconButton',
      'Button label + hint',
      IconButton(icon: Icon(Icons.favorite, color: Colors.red), onPressed: () {}),
      Colors.red,
    ),
  ];
  print('4 interactive widget semantics demonstrated');

  // ============================================================
  // SECTION 10: Semantic Sort Keys
  // ============================================================
  print('=== Section 10: Sort Keys ===');

  Widget suSortKeyDemo(int visualOrder, double sortOrder, String label) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.deepOrange.withValues(alpha: 0.2)),
      ),
      child: Semantics(
        sortKey: OrdinalSortKey(sortOrder),
        child: Row(
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('$visualOrder', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0))),
            ),
            SizedBox(width: 10.0),
            Text(label, style: TextStyle(fontSize: 12.0)),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text('sort: ${sortOrder.toStringAsFixed(1)}', style: TextStyle(fontSize: 10.0, fontFamily: 'monospace', color: Colors.deepOrange.shade700)),
            ),
          ],
        ),
      ),
    );
  }

  print('OrdinalSortKey controls screen reader traversal order');
  print('Elements are read in sortKey order, not visual order');

  // ============================================================
  // SECTION 11: Live Regions
  // ============================================================
  print('=== Section 11: Live Regions ===');

  Widget suLiveRegionDemo = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepOrange.shade50, Colors.orange.shade50],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.deepOrange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.campaign, color: Colors.deepOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text('Live Regions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0, color: Colors.deepOrange.shade800)),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A live region automatically announces content changes to the screen reader without requiring focus. Used for dynamic counters, status messages, and real-time updates.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 10.0),
        Semantics(
          liveRegion: true,
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(Icons.notifications_active, color: Colors.deepOrange.shade700, size: 18.0),
                SizedBox(width: 8.0),
                Text('3 new notifications', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.deepOrange.shade800)),
              ],
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text('liveRegion: true causes re-announcement on every label change.', style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );
  print('Live region widgets announce changes automatically');

  // ============================================================
  // SECTION 12: Image Semantics
  // ============================================================
  print('=== Section 12: Image Semantics ===');

  Widget suImageSemantics = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Image Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.amber.shade800)),
        SizedBox(height: 8.0),
        Row(
          children: [
            Semantics(
              label: 'Mountain landscape at sunset',
              image: true,
              child: Container(
                width: 80.0,
                height: 60.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange.shade300, Colors.deepOrange.shade400, Colors.brown.shade600],
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 10.0,
                      left: 10.0,
                      child: CustomPaint(size: Size(60.0, 30.0), painter: _MountainPainter()),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Semantics(image: true)', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0, color: Colors.amber.shade800)),
                  SizedBox(height: 4.0),
                  Text('Marks the node as an image. Screen reader announces label with "image" role.', style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text('Decorative images should use ExcludeSemantics instead.', style: TextStyle(fontSize: 11.0, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );
  print('Image semantics marks element as image role');

  // ============================================================
  // SECTION 13: TextField Semantics
  // ============================================================
  print('=== Section 13: TextField Semantics ===');

  Widget suTextFieldDemo = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TextField Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.teal.shade800)),
        SizedBox(height: 8.0),
        Text('TextField automatically provides:', style: TextStyle(fontSize: 12.0)),
        SizedBox(height: 6.0),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('- isTextField flag (announces "edit text")', style: TextStyle(fontSize: 11.5)),
              Text('- value (current text content)', style: TextStyle(fontSize: 11.5)),
              Text('- label from decoration.labelText', style: TextStyle(fontSize: 11.5)),
              Text('- hint from decoration.hintText', style: TextStyle(fontSize: 11.5)),
              Text('- isReadOnly when readOnly: true', style: TextStyle(fontSize: 11.5)),
              Text('- isObscured when obscureText: true', style: TextStyle(fontSize: 11.5)),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        SizedBox(
          height: 48.0,
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email address',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text('Screen reader: "Email, edit text, Enter your email address"', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
      ],
    ),
  );
  print('TextField provides rich semantics automatically');

  // ============================================================
  // SECTION 14: Tooltip Semantics
  // ============================================================
  print('=== Section 14: Tooltip Semantics ===');

  Widget suTooltipDemo = Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.purple.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.purple.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tooltip Semantics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.purple.shade800)),
        SizedBox(height: 8.0),
        Text('Tooltip text is announced by the screen reader as additional context. The tooltip property on Semantics sets the accessibility tooltip for the node.', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
        SizedBox(height: 10.0),
        Row(
          children: [
            Tooltip(
              message: 'Saves the current document',
              child: Semantics(
                button: true,
                label: 'Save',
                tooltip: 'Saves the current document',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save, color: Colors.purple.shade700, size: 18.0),
                      SizedBox(width: 6.0),
                      Text('Save', style: TextStyle(color: Colors.purple.shade700, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Text('Announced: "Save, button, Saves the current document"', style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Colors.grey.shade600)),
            ),
          ],
        ),
      ],
    ),
  );
  print('Tooltip semantics add extra context for assistive tech');

  // ============================================================
  // SECTION 15: Semantics Debugging
  // ============================================================
  print('=== Section 15: Semantics Debugging ===');

  Widget suDebugCard(String tool, String desc, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(8.0),
        border: Border(left: BorderSide(color: color, width: 3.0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.0),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tool, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0, color: color)),
                Text(desc, style: TextStyle(fontSize: 10.5, color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final suDebugTools = <Widget>[
    suDebugCard('showSemanticsDebugger', 'Enable visual overlay showing semantic nodes', Icons.bug_report, Colors.deepOrange),
    suDebugCard('debugDumpSemanticsTree()', 'Print semantics tree to console', Icons.terminal, Colors.green),
    suDebugCard('Accessibility Inspector (iOS)', 'Xcode tool for inspecting VoiceOver nodes', Icons.phone_iphone, Colors.blue),
    suDebugCard('TalkBack (Android)', 'Enable TalkBack in Settings > Accessibility', Icons.phone_android, Colors.teal),
    suDebugCard('SemanticsDebugger widget', 'Wrap MaterialApp to see all nodes overlaid', Icons.layers, Colors.purple),
  ];
  print('5 semantics debugging tools documented');

  // ============================================================
  // SECTION 16: Summary Dashboard
  // ============================================================
  print('=== Section 16: Summary Dashboard ===');

  Widget suSummaryTile(String label, String value, Color color) {
    return Container(
      width: 105.0,
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.05)],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: color)),
          SizedBox(height: 2.0),
          Text(label, style: TextStyle(fontSize: 10.0, color: Colors.grey.shade700), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  print('SemanticsUpdate deep demo completed');

  // ============================================================
  // ASSEMBLE FULL UI
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('SemanticsUpdate Deep Demo'),
        backgroundColor: Colors.deepOrange.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange.shade600, Colors.orange.shade400],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Icon(Icons.accessibility_new, color: Colors.white, size: 48.0),
                  SizedBox(height: 8.0),
                  Text('SemanticsUpdate', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4.0),
                  Text('The payload that carries accessibility tree changes to the platform engine', style: TextStyle(fontSize: 13.0, color: Colors.white70), textAlign: TextAlign.center),
                ],
              ),
            ),

            // Section 1: Pipeline
            SizedBox(height: 20.0),
            Text('1. Semantics Pipeline', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('The journey from widget annotations to platform accessibility:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...suPipelineStages,

            // Section 2: Builder
            SizedBox(height: 20.0),
            Text('2. SemanticsUpdateBuilder', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Low-level API for constructing semantics updates:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...suBuilderFacts,

            // Section 3: Labels
            SizedBox(height: 20.0),
            Text('3. Basic Semantic Labels', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Semantics widget annotates children with accessibility labels and hints:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            suLabelDemo('Play Music', 'Double tap to start playback', Colors.deepOrange),
            suLabelDemo('Volume: 75%', 'Swipe up to increase, down to decrease', Colors.orange),
            suLabelDemo('Shopping Cart, 3 items', 'Double tap to view cart contents', Colors.amber),

            // Section 4: Actions
            SizedBox(height: 20.0),
            Text('4. Semantics Actions', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Actions that assistive technology can trigger on a node:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            Wrap(children: suActionWidgets),

            // Section 5: Flags
            SizedBox(height: 20.0),
            Text('5. Semantics Flags', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Boolean flags that describe the nature and state of a node:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            Wrap(children: suFlagWidgets),

            // Section 6: Merge
            SizedBox(height: 20.0),
            Text('6. MergeSemantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            suMergeExample,

            // Section 7: Exclude
            SizedBox(height: 20.0),
            Text('7. ExcludeSemantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            suExcludeExample,

            // Section 8: Properties
            SizedBox(height: 20.0),
            Text('8. Semantics Properties', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Key properties on the Semantics widget that populate the SemanticsUpdate:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...suProperties,

            // Section 9: Interactive
            SizedBox(height: 20.0),
            Text('9. Interactive Widget Semantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Built-in widgets that provide rich semantics automatically:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...suInteractives,

            // Section 10: Sort Keys
            SizedBox(height: 20.0),
            Text('10. Semantic Sort Keys', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('OrdinalSortKey controls screen reader traversal order (lower = first):', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            suSortKeyDemo(1, 3.0, 'Visually first, read third'),
            suSortKeyDemo(2, 1.0, 'Visually second, read first'),
            suSortKeyDemo(3, 2.0, 'Visually third, read second'),

            // Section 11: Live regions
            SizedBox(height: 20.0),
            Text('11. Live Regions', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            suLiveRegionDemo,

            // Section 12: Image semantics
            SizedBox(height: 20.0),
            Text('12. Image Semantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            suImageSemantics,

            // Section 13: TextField
            SizedBox(height: 20.0),
            Text('13. TextField Semantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            suTextFieldDemo,

            // Section 14: Tooltip
            SizedBox(height: 20.0),
            Text('14. Tooltip Semantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            suTooltipDemo,

            // Section 15: Debugging
            SizedBox(height: 20.0),
            Text('15. Debugging Semantics', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 4.0),
            Text('Tools for inspecting and verifying the semantics tree:', style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
            SizedBox(height: 8.0),
            ...suDebugTools,

            // Section 16: Summary
            SizedBox(height: 20.0),
            Text('16. Summary', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.deepOrange.shade800)),
            SizedBox(height: 8.0),
            Wrap(
              children: [
                suSummaryTile('Actions', '12+', Colors.deepOrange),
                suSummaryTile('Flags', '15+', Colors.orange),
                suSummaryTile('Properties', '9', Colors.amber),
                suSummaryTile('Debug Tools', '5', Colors.green),
                suSummaryTile('Pipeline', '5 stages', Colors.blue),
                suSummaryTile('Sections', '16', Colors.purple),
              ],
            ),

            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

/// Simple mountain painter for the image semantics section
class _MountainPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withValues(alpha: 0.7);
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width * 0.3, size.height * 0.2);
    path.lineTo(size.width * 0.5, size.height * 0.5);
    path.lineTo(size.width * 0.7, size.height * 0.1);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
