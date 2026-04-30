// ignore_for_file: avoid_print
// D4rt deep demo: InspectorReferenceData — a container object that holds
// reference information about widgets and render objects for the Flutter
// DevTools inspector. It carries the data needed to display widget details,
// properties, and tree relationships in the inspector panel.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Crimson / Garnet palette ───
  const Color crimson = Color(0xFFDC2626);
  const Color garnet = Color(0xFFB91C1C);
  const Color deepCrimson = Color(0xFF7F1D1D);
  const Color paleRose = Color(0xFFFEE2E2);
  const Color ruby = Color(0xFFEF4444);
  const Color blush = Color(0xFFFEF2F2);
  const Color maroon = Color(0xFF991B1B);
  const Color coral = Color(0xFFF87171);
  const Color petal = Color(0xFFFECACA);
  const Color scarlet = Color(0xFFE11D48);

  print('===== INSPECTOR REFERENCE DATA DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepCrimson, maroon],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepCrimson.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: garnet,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: coral, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: blush,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: petal),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepCrimson.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: petal),
        boxShadow: [
          BoxShadow(
            color: crimson.withValues(alpha: 0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleRose,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepCrimson)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepCrimson)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: maroon)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepCrimson.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepCrimson),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 11, color: deepCrimson)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: petal.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget propertyRow(String name, String type, String example, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(name,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: accent)),
          ),
          SizedBox(
            width: 70,
            child: Text(type,
                style: TextStyle(fontSize: 10, color: maroon)),
          ),
          Expanded(
            child: Text(example,
                style: TextStyle(fontSize: 10, color: deepCrimson)),
          ),
        ],
      ),
    );
  }

  Widget treeNode(String label, int depth, bool selected, Color nodeColor) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: depth * 20.0, bottom: 3),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: BoxDecoration(
        color: selected ? nodeColor.withValues(alpha: 0.12) : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
            color: selected ? nodeColor : petal,
            width: selected ? 2 : 1),
      ),
      child: Row(
        children: [
          Icon(
            selected ? Icons.arrow_right : Icons.subdirectory_arrow_right,
            size: 14,
            color: selected ? nodeColor : coral.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
                  color: selected ? nodeColor : deepCrimson)),
        ],
      ),
    );
  }

  Widget fieldBlock(String fieldName, String fieldValue, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: accent.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$fieldName: ',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: accent)),
          Expanded(
            child: Text(fieldValue,
                style: TextStyle(fontSize: 11, color: deepCrimson)),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'InspectorReferenceData is a data container used by the Flutter '
          'widget inspector to hold references to widgets, render objects, '
          'and their associated diagnostic information. It bridges the '
          'running widget tree with the inspector\'s display.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Data class / container'),
              dataRow('Package', 'flutter/widgets (widgetInspector)'),
              dataRow('Purpose', 'Hold inspector reference info'),
              dataRow('Consumers', 'Inspector panel, DevTools'),
              dataRow('Lifecycle', 'Created per selection, discarded'),
            ],
          )),
      infoCard(
          'What It Holds',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Widget reference', 'The selected widget instance'),
              dataRow('Element reference', 'The widget\'s element'),
              dataRow('RenderObject', 'The render object if available'),
              dataRow('Properties', 'DiagnosticsNode tree'),
              dataRow('Location', 'Source file and line number'),
            ],
          )),
    ],
  );

  // ─── Section 2: Data Fields ───
  print('[Section 2] Data Fields');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Data Fields'),
      noteBox(
          'InspectorReferenceData contains multiple fields that together '
          'describe everything the inspector needs to display about a '
          'selected widget.'),
      infoCard(
          'Field Inventory',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              propertyRow('widget', 'Widget', 'Text("Hello")', crimson),
              propertyRow('element', 'Element', 'StatelessElement', garnet),
              propertyRow('renderObject', 'RenderObject?', 'RenderParagraph', maroon),
              propertyRow('depth', 'int', '12', scarlet),
              propertyRow('description', 'String', 'Text', crimson),
              propertyRow('properties', 'List<DiagNode>', '[...props]', garnet),
              propertyRow('children', 'List<RefData>', '[...kids]', maroon),
            ],
          )),
    ],
  );

  // ─── Section 3: Widget Tree References ───
  print('[Section 3] Widget Tree References');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Widget Tree References'),
      noteBox(
          'The reference data captures a snapshot of the widget tree '
          'around the selected widget, including parent and children.'),
      infoCard(
          'Tree Reference Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              treeNode('MaterialApp', 0, false, crimson),
              treeNode('Scaffold', 1, false, crimson),
              treeNode('Column', 2, false, crimson),
              treeNode('Padding', 3, true, crimson),
              treeNode('Text("Hello")', 4, false, crimson),
              treeNode('Icon(star)', 4, false, crimson),
              const SizedBox(height: 8),
              dataRow('Selected', 'Padding (depth 3)'),
              dataRow('Parent chain', 'Column → Scaffold → MaterialApp'),
              dataRow('Children', 'Text, Icon'),
            ],
          )),
    ],
  );

  // ─── Section 4: Properties Display ───
  print('[Section 4] Properties Display');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Properties Display'),
      noteBox(
          'The reference data provides a list of diagnostic properties '
          'that the inspector displays as key-value pairs.'),
      infoCard(
          'Property Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('StringProperty', 'Text values like "Hello"'),
              dataRow('DoubleProperty', 'Numeric values like 16.0'),
              dataRow('ColorProperty', 'Color values with swatch'),
              dataRow('EnumProperty', 'Enum values like Axis.vertical'),
              dataRow('FlagProperty', 'Boolean flags like hasSize'),
              dataRow('DiagnosticsProperty', 'Complex nested objects'),
            ],
          )),
      infoCard(
          'Example Properties for Padding',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldBlock('padding', 'EdgeInsets.all(16.0)', crimson),
              fieldBlock('child', 'Text', garnet),
              fieldBlock('renderObject', 'RenderPadding', maroon),
              fieldBlock('size', 'Size(375.0, 52.0)', scarlet),
              fieldBlock('parentData', 'FlexParentData', crimson),
            ],
          )),
    ],
  );

  // ─── Section 5: Render Object Info ───
  print('[Section 5] Render Object Info');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Render Object Information'),
      noteBox(
          'When available, the reference data includes render object '
          'details — size, constraints, paint bounds, and more.'),
      infoCard(
          'Render Data Fields',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('type', 'RenderPadding, RenderFlex, etc.'),
              dataRow('size', 'Width x Height in logical pixels'),
              dataRow('constraints', 'BoxConstraints min/max'),
              dataRow('parentData', 'Layout data from parent'),
              dataRow('needsPaint', 'Whether repaint is scheduled'),
              dataRow('needsLayout', 'Whether relayout is scheduled'),
            ],
          )),
      infoCard(
          'Constraints Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldBlock('minWidth', '0.0', crimson),
              fieldBlock('maxWidth', '375.0', garnet),
              fieldBlock('minHeight', '0.0', maroon),
              fieldBlock('maxHeight', 'Infinity', scarlet),
              const SizedBox(height: 6),
              dataRow('Interpretation', 'Width bounded, height unbounded'),
              dataRow('Typical of', 'Scrollable child'),
            ],
          )),
    ],
  );

  // ─── Section 6: Source Location ───
  print('[Section 6] Source Location');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Source Location'),
      noteBox(
          'Reference data can include source file and line number, letting '
          'DevTools jump to the definition in the IDE.'),
      infoCard(
          'Location Data',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('file', 'lib/screens/home.dart'),
              dataRow('line', '42'),
              dataRow('column', '12'),
              dataRow('package', 'package:myapp/screens/home.dart'),
            ],
          )),
      infoCard(
          'IDE Integration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Click to source', 'Opens file at line in IDE'),
              dataRow('VS Code', 'dart.openFile command'),
              dataRow('IntelliJ', 'Navigate to file action'),
              dataRow('Availability', 'Debug builds only'),
            ],
          )),
    ],
  );

  // ─── Section 7: Selection Flow ───
  print('[Section 7] Selection Flow');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Selection Flow'),
      noteBox(
          'When a developer taps a widget in the inspector overlay, '
          'InspectorReferenceData is created to capture that selection.'),
      infoCard(
          'Selection Steps',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Tap overlay', 'User taps on widget'),
              dataRow('2. Hit test', 'Find deepest RenderObject'),
              dataRow('3. Walk up', 'Find corresponding Element'),
              dataRow('4. Collect refs', 'Build InspectorReferenceData'),
              dataRow('5. Send', 'Transmit to inspector panel'),
              dataRow('6. Display', 'Show properties and tree'),
            ],
          )),
    ],
  );

  // ─── Section 8: Serialization ───
  print('[Section 8] Serialization');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Serialization'),
      noteBox(
          'Reference data must be serialized when sending from the '
          'running app to DevTools via the service extension protocol.'),
      infoCard(
          'Serialization Format',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Wire format', 'JSON map'),
              dataRow('Widget ref', 'ID string (not full object)'),
              dataRow('Properties', 'Serialized DiagnosticsNode list'),
              dataRow('Children', 'Recursive ID references'),
              dataRow('Render data', 'Flattened numeric values'),
            ],
          )),
      infoCard(
          'JSON Structure',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fieldBlock('widgetId', '"inspector-42"', crimson),
              fieldBlock('description', '"Padding"', garnet),
              fieldBlock('depth', '3', maroon),
              fieldBlock('hasChildren', 'true', scarlet),
              fieldBlock('creationLocation', '{"file": "...", "line": 42}', crimson),
            ],
          )),
    ],
  );

  // ─── Section 9: DiagnosticsNode Connection ───
  print('[Section 9] DiagnosticsNode');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'DiagnosticsNode Connection'),
      noteBox(
          'Properties in the reference data come from the widget\'s '
          'debugDescribeChildren() and other diagnostics methods.'),
      infoCard(
          'Diagnostics API',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('debugDescribeChildren', 'List child diagnostics'),
              dataRow('debugFillProperties', 'Add property descriptions'),
              dataRow('toStringDeep', 'Full recursive text dump'),
              dataRow('toDiagnosticsNode', 'Tree node representation'),
            ],
          )),
      infoCard(
          'Node Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('DiagnosticsNode', 'Base property/tree node'),
              dataRow('DiagnosticableTree', 'Widget/RenderObject mixin'),
              dataRow('DiagnosticsProperty', 'Typed property holder'),
              dataRow('DiagnosticsBlock', 'Group of related properties'),
            ],
          )),
    ],
  );

  // ─── Section 10: DevTools Protocol ───
  print('[Section 10] DevTools Protocol');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'DevTools Protocol'),
      noteBox(
          'Reference data is transmitted to DevTools using the VM service '
          'extension protocol, enabling remote debugging over websockets.'),
      infoCard(
          'Protocol Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. App registers', 'Service extensions on startup'),
              dataRow('2. DevTools connects', 'WebSocket to VM service'),
              dataRow('3. Query sent', 'getSelectedWidget request'),
              dataRow('4. App responds', 'Serialized reference data'),
              dataRow('5. DevTools renders', 'Properties panel updated'),
            ],
          )),
      infoCard(
          'Service Extensions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('ext.flutter.inspector', 'Main inspector extension'),
              dataRow('getSelectedRenderObject', 'Render object details'),
              dataRow('getSelectedWidget', 'Widget diagnostics'),
              dataRow('getSelectedSummaryWidget', 'Summary tree node'),
            ],
          )),
    ],
  );

  // ─── Section 11: Memory Management ───
  print('[Section 11] Memory Management');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Memory Management'),
      noteBox(
          'Reference data holds strong references to live objects in the '
          'widget tree, which must be managed carefully to avoid leaks.'),
      infoCard(
          'Reference Lifecycle',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Created', 'On widget selection'),
              dataRow('Held', 'While selection is active'),
              dataRow('Released', 'When new selection replaces'),
              dataRow('GC eligible', 'After release and deselect'),
            ],
          )),
      infoCard(
          'Leak Prevention',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Weak refs', 'Optional use for widget refs'),
              dataRow('ID mapping', 'Map IDs instead of live objects'),
              dataRow('Selection limit', 'Only one active at a time'),
              dataRow('Overlay close', 'Clears all references'),
            ],
          )),
    ],
  );

  // ─── Section 12: Comparison with DiagnosticsNode ───
  print('[Section 12] Comparison');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Comparison with DiagnosticsNode'),
      noteBox(
          'While related, InspectorReferenceData and DiagnosticsNode '
          'serve different roles in the inspector system.'),
      infoCard(
          'Key Differences',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('DiagnosticsNode', 'Property description for display'),
              dataRow('ReferenceData', 'Live references + context'),
              dataRow('DiagnosticsNode', 'Framework-level, any widget'),
              dataRow('ReferenceData', 'Inspector-level, selected only'),
              dataRow('DiagnosticsNode', 'Serializable text'),
              dataRow('ReferenceData', 'Contains object references'),
            ],
          )),
    ],
  );

  // ─── Section 13: Tree Traversal ───
  print('[Section 13] Tree Traversal');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Tree Traversal'),
      noteBox(
          'The reference data supports navigating up and down the widget '
          'tree from the selected node.'),
      infoCard(
          'Navigation Operations',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Parent', 'Navigate to parent widget'),
              dataRow('Children', 'List direct children'),
              dataRow('Siblings', 'Other children of same parent'),
              dataRow('Ancestors', 'Full chain to root'),
              dataRow('Subtree', 'All descendants recursively'),
            ],
          )),
      infoCard(
          'Tree Snapshot',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              treeNode('Scaffold', 0, false, garnet),
              treeNode('AppBar', 1, false, garnet),
              treeNode('Body: Column', 1, false, garnet),
              treeNode('Card', 2, true, garnet),
              treeNode('ListTile', 3, false, garnet),
              treeNode('Trailing: Icon', 3, false, garnet),
              treeNode('BottomNavBar', 1, false, garnet),
            ],
          )),
    ],
  );

  // ─── Section 14: Filtering ───
  print('[Section 14] Filtering');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Filtering Reference Data'),
      noteBox(
          'The inspector can filter reference data to show or hide '
          'framework widgets, focusing on user-created widgets.'),
      infoCard(
          'Filter Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Summary tree', 'Only user widgets (default)'),
              dataRow('Full tree', 'All widgets including framework'),
              dataRow('Render tree', 'RenderObject hierarchy'),
              dataRow('Custom filter', 'By package or library'),
            ],
          )),
      infoCard(
          'Summary vs Full',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Summary: visible', 'Scaffold, Column, Text, etc.'),
              dataRow('Summary: hidden', 'RawGestureDetector, Overlay, etc.'),
              dataRow('Full: visible', 'Every single widget node'),
              dataRow('Full: count', 'Often 10-50x more nodes'),
            ],
          )),
    ],
  );

  // ─── Section 15: Debugging Reference Data ───
  print('[Section 15] Debugging');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Debugging Reference Data'),
      noteBox(
          'When the inspector shows wrong or missing data, debugging '
          'the reference data pipeline helps find the problem.'),
      infoCard(
          'Common Issues',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Empty properties', 'debugFillProperties not overridden'),
              dataRow('Missing children', 'debugDescribeChildren incomplete'),
              dataRow('Wrong selection', 'Hit test returning wrong render'),
              dataRow('Stale data', 'Reference not updated after rebuild'),
            ],
          )),
      infoCard(
          'Debug Commands',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('debugDumpApp()', 'Print full widget tree'),
              dataRow('debugDumpRenderTree()', 'Print render tree'),
              dataRow('debugPrintMarkNeedsLayoutStacks', 'Layout trace'),
              dataRow('debugPrintMarkNeedsPaintStacks', 'Paint trace'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the InspectorReferenceData deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Crimson', crimson),
              colorSwatch('Garnet', garnet),
              colorSwatch('Deep Crimson', deepCrimson),
              colorSwatch('Pale Rose', paleRose),
              colorSwatch('Ruby', ruby),
              colorSwatch('Blush', blush),
              colorSwatch('Maroon', maroon),
              colorSwatch('Coral', coral),
              colorSwatch('Petal', petal),
              colorSwatch('Scarlet', scarlet),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, crimson),
              progressBar('Data Fields', 1.0, garnet),
              progressBar('Widget Tree References', 1.0, maroon),
              progressBar('Properties Display', 1.0, scarlet),
              progressBar('Render Object Info', 1.0, crimson),
              progressBar('Source Location', 1.0, garnet),
              progressBar('Selection Flow', 1.0, maroon),
              progressBar('Serialization', 1.0, scarlet),
              progressBar('DiagnosticsNode', 1.0, crimson),
              progressBar('DevTools Protocol', 1.0, garnet),
              progressBar('Memory Management', 1.0, maroon),
              progressBar('Comparison', 1.0, scarlet),
              progressBar('Tree Traversal', 1.0, crimson),
              progressBar('Filtering', 1.0, garnet),
              progressBar('Debugging', 1.0, maroon),
              progressBar('Dashboard', 1.0, scarlet),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Crimson / Garnet'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('InspectorReferenceData', crimson, Colors.white),
          tag('Widget Inspector', garnet, Colors.white),
          tag('Diagnostics', maroon, Colors.white),
          tag('DevTools Protocol', deepCrimson, Colors.white),
          tag('Reference Container', scarlet, Colors.white),
          tag('Tree Traversal', coral, deepCrimson),
        ],
      ),
    ],
  );

  print('===== END INSPECTOR REFERENCE DATA DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
