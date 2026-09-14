// ignore_for_file: avoid_print
// D4rt deep demo: InspectorSerializationDelegate — controls how widgets and
// render objects are serialized into diagnostic maps for the Flutter widget
// inspector. The delegate determines which properties, children, and metadata
// are included when the inspector transmits widget tree data to DevTools.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Indigo / Plum palette ───
  const Color indigo = Color(0xFF4338CA);
  const Color plum = Color(0xFF7C3AED);
  const Color deepViolet = Color(0xFF312E81);
  const Color paleLavender = Color(0xFFEDE9FE);
  const Color amethyst = Color(0xFF8B5CF6);
  const Color lilac = Color(0xFFF5F3FF);
  const Color iris = Color(0xFF6366F1);
  const Color orchid = Color(0xFFA78BFA);
  const Color wisteria = Color(0xFFC4B5FD);
  const Color grape = Color(0xFF4C1D95);

  print('===== INSPECTOR SERIALIZATION DELEGATE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepViolet, grape],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepViolet.withValues(alpha: 0.35),
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
              color: indigo,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: iris, width: 1.5),
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
        color: lilac,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: wisteria),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepViolet.withValues(alpha: 0.9),
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
        border: Border.all(color: wisteria),
        boxShadow: [
          BoxShadow(
            color: indigo.withValues(alpha: 0.07),
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
              color: paleLavender,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepViolet)),
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
                    color: deepViolet)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: grape)),
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
                  color: deepViolet.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepViolet),
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
              Text(label, style: TextStyle(fontSize: 11, color: deepViolet)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: wisteria.withValues(alpha: 0.4),
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

  Widget delegateNode(String name, String detail, bool active, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: active ? color.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: active ? color : wisteria,
          width: active ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            active ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: active ? color : wisteria,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: active ? color : deepViolet)),
                Text(detail,
                    style: TextStyle(
                        fontSize: 10,
                        color: active
                            ? color.withValues(alpha: 0.7)
                            : grape.withValues(alpha: 0.5))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget jsonBlock(String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: deepViolet.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: wisteria),
      ),
      child: Text(content,
          style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: deepViolet,
              height: 1.4)),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'InspectorSerializationDelegate controls how the widget tree is '
          'converted into serializable diagnostic maps for transmission '
          'to DevTools. It determines which properties, children, and '
          'metadata appear in the serialized output.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Abstract delegate / configuration'),
              dataRow('Package', 'flutter/widgets (diagnostics)'),
              dataRow('Purpose', 'Control inspector serialization'),
              dataRow('Consumers', 'WidgetInspectorService, DevTools'),
              dataRow('Output', 'Map<String, Object?> per node'),
            ],
          )),
      infoCard(
          'Key Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Filter properties', 'Include/exclude by level'),
              dataRow('Control depth', 'How deep to serialize'),
              dataRow('Add summaries', 'Description vs full detail'),
              dataRow('Children policy', 'Which children to include'),
              dataRow('Custom data', 'Attach extra diagnostic info'),
            ],
          )),
    ],
  );

  // ─── Section 2: Serialization Architecture ───
  print('[Section 2] Serialization Architecture');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Serialization Architecture'),
      noteBox(
          'The delegate sits between DiagnosticsNode and the JSON output, '
          'intercepting each node to decide what gets included.'),
      infoCard(
          'Architecture Layers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              delegateNode('DiagnosticsNode', 'Source diagnostic data', false, indigo),
              delegateNode('Delegate', 'Filters and transforms', true, plum),
              delegateNode('toJsonMap()', 'Produces Map output', false, indigo),
              delegateNode('Service extension', 'Sends to DevTools', false, indigo),
            ],
          )),
      infoCard(
          'Data Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Tree walk', 'Visit each Element or RenderObject'),
              dataRow('2. Create diagnostics', 'toDiagnosticsNode()'),
              dataRow('3. Apply delegate', 'Filter properties/children'),
              dataRow('4. Serialize', 'toJsonMap(delegate)'),
              dataRow('5. Transmit', 'Send JSON to DevTools client'),
            ],
          )),
    ],
  );

  // ─── Section 3: Property Filtering ───
  print('[Section 3] Property Filtering');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Property Filtering'),
      noteBox(
          'The delegate can filter which DiagnosticsProperty entries are '
          'included based on their DiagnosticLevel — info, debug, fine, '
          'hidden, etc.'),
      infoCard(
          'Diagnostic Levels',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              delegateNode('hidden', 'Internal framework details', false, orchid),
              delegateNode('fine', 'Verbose debug information', false, orchid),
              delegateNode('debug', 'Standard debug properties', true, amethyst),
              delegateNode('info', 'Key user-facing properties', true, plum),
              delegateNode('summary', 'Most important properties', true, indigo),
            ],
          )),
      infoCard(
          'Filter Configuration',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('minLevel', 'Minimum DiagnosticLevel to include'),
              dataRow('summaryTree', 'Only summary-level in tree view'),
              dataRow('subtreeDepth', 'Depth limit for child tree'),
              dataRow('includeProperties', 'true/false for properties'),
            ],
          )),
    ],
  );

  // ─── Section 4: Children Policy ───
  print('[Section 4] Children Policy');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Children Policy'),
      noteBox(
          'The delegate controls which children of a node appear in the '
          'serialized tree — all children, only direct, or filtered by type.'),
      infoCard(
          'Child Inclusion Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('All children', 'Every child node included'),
              dataRow('Direct only', 'No deep recursion'),
              dataRow('Filtered', 'Only matching child types'),
              dataRow('Summary', 'Key children only for overview'),
              dataRow('None', 'Leaf node, no children'),
            ],
          )),
      infoCard(
          'Depth Control',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('subtreeDepth: 0', 'Current node only'),
              dataRow('subtreeDepth: 1', 'Direct children'),
              dataRow('subtreeDepth: 2', 'Two levels deep'),
              dataRow('subtreeDepth: -1', 'Unlimited (full tree)'),
            ],
          )),
    ],
  );

  // ─── Section 5: Summary vs Detail Tree ───
  print('[Section 5] Summary vs Detail Tree');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Summary vs Detail Tree'),
      noteBox(
          'The inspector supports two tree views — a summary tree that '
          'hides framework internals and a detail tree that shows everything.'),
      infoCard(
          'Summary Tree',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'User-focused widget overview'),
              dataRow('Filtering', 'Hides internal framework widgets'),
              dataRow('Depth', 'Collapses uninteresting subtrees'),
              dataRow('Labels', 'Friendly widget names'),
              dataRow('Use case', 'Default DevTools tree view'),
            ],
          )),
      infoCard(
          'Detail Tree',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Complete render tree'),
              dataRow('Filtering', 'Nothing hidden'),
              dataRow('Depth', 'Full tree depth'),
              dataRow('Labels', 'Technical type names'),
              dataRow('Use case', 'Deep debugging sessions'),
            ],
          )),
    ],
  );

  // ─── Section 6: JSON Map Format ───
  print('[Section 6] JSON Map Format');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'JSON Map Format'),
      noteBox(
          'The delegate produces a Map<String, Object?> for each node. '
          'Key fields include description, type, properties, and children.'),
      infoCard(
          'Output Fields',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('description', 'String — human-readable summary'),
              dataRow('type', 'String — runtime type name'),
              dataRow('hasChildren', 'bool — has child nodes'),
              dataRow('properties', 'List<Map> — property entries'),
              dataRow('children', 'List<Map> — child node maps'),
              dataRow('widgetRuntimeType', 'String — original widget type'),
            ],
          )),
      infoCard(
          'Example JSON Structure',
          jsonBlock(
              '{\n'
              '  "description": "Padding",\n'
              '  "type": "Padding",\n'
              '  "hasChildren": true,\n'
              '  "properties": [\n'
              '    {"name": "padding", "value": "EdgeInsets(8.0)"}\n'
              '  ],\n'
              '  "children": [ ... ]\n'
              '}')),
    ],
  );

  // ─── Section 7: Property Serialization ───
  print('[Section 7] Property Serialization');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Property Serialization'),
      noteBox(
          'Each DiagnosticsProperty is serialized into a map with name, '
          'value, level, and optional extra metadata.'),
      infoCard(
          'Property Map Fields',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('name', 'Property name (e.g. "padding")'),
              dataRow('value', 'String representation'),
              dataRow('level', 'DiagnosticLevel enum name'),
              dataRow('description', 'Optional longer description'),
              dataRow('ifNull', 'Text if value is null'),
              dataRow('defaultValue', 'Default for comparison'),
            ],
          )),
      infoCard(
          'Property Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              delegateNode('StringProperty', '"Hello" — plain text', true, indigo),
              delegateNode('DoubleProperty', '16.0 — numeric value', false, iris),
              delegateNode('FlagProperty', 'true/false — boolean', false, iris),
              delegateNode('EnumProperty', 'Axis.horizontal — enum', false, iris),
              delegateNode('ColorProperty', 'Color(0xFF...) — color', false, iris),
              delegateNode('DiagnosticsProperty', 'Generic typed property', false, iris),
            ],
          )),
    ],
  );

  // ─── Section 8: Truncation & Size Limits ───
  print('[Section 8] Truncation & Size Limits');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Truncation & Size Limits'),
      noteBox(
          'Large widget trees produce massive serialized output. The delegate '
          'helps truncate data to keep transmission sizes manageable.'),
      infoCard(
          'Size Management',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Max depth', 'Limit subtree recursion'),
              dataRow('Max properties', 'Cap property count per node'),
              dataRow('Truncate strings', 'Limit long descriptions'),
              dataRow('Skip hidden', 'Omit hidden-level data'),
              dataRow('Lazy expansion', 'Fetch children on demand'),
            ],
          )),
      infoCard(
          'Truncation Indicators',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('truncated: true', 'Node was truncated'),
              dataRow('childCount', 'Total children vs shown'),
              dataRow('...', 'Truncation marker in description'),
              dataRow('hasMore', 'More data available on request'),
            ],
          )),
    ],
  );

  // ─── Section 9: Custom Delegate Implementation ───
  print('[Section 9] Custom Delegate Implementation');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Custom Delegate Implementation'),
      noteBox(
          'A custom InspectorSerializationDelegate can override behavior '
          'to add project-specific diagnostic data or change filtering.'),
      infoCard(
          'Override Points',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('additionalNodeProperties', 'Add custom fields per node'),
              dataRow('filterProperties', 'Custom property inclusion'),
              dataRow('filterChildren', 'Custom child inclusion'),
              dataRow('truncateProperties', 'Custom truncation logic'),
              dataRow('groupName', 'Group nodes by category'),
            ],
          )),
      infoCard(
          'Implementation Pattern',
          jsonBlock(
              'class MyDelegate extends InspectorSerializationDelegate {\n'
              '  Map<String, Object?> additionalNodeProperties(\n'
              '    DiagnosticsNode node,\n'
              '  ) {\n'
              '    return {\n'
              '      "customData": node.runtimeType.toString(),\n'
              '      "timestamp": DateTime.now().toIso8601String(),\n'
              '    };\n'
              '  }\n'
              '}')),
    ],
  );

  // ─── Section 10: Service Extension Integration ───
  print('[Section 10] Service Extension Integration');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Service Extension Integration'),
      noteBox(
          'The delegate is used by WidgetInspectorService when responding '
          'to service extension calls from DevTools.'),
      infoCard(
          'Service Extensions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('getDetailsSubtree', 'Full detail tree request'),
              dataRow('getSummaryTree', 'Summary tree request'),
              dataRow('getProperties', 'Property list for node'),
              dataRow('getChildren', 'Children list for node'),
              dataRow('getRootWidget', 'Entry point for tree'),
            ],
          )),
      infoCard(
          'Request / Response Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. DevTools sends', 'Service extension call'),
              dataRow('2. Service creates', 'Delegate with parameters'),
              dataRow('3. Delegate serializes', 'Tree with configured depth'),
              dataRow('4. Service returns', 'JSON map to DevTools'),
            ],
          )),
    ],
  );

  // ─── Section 11: Grouping & Object References ───
  print('[Section 11] Grouping & Object References');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Grouping & Object References'),
      noteBox(
          'The inspector uses a group system to manage object references. '
          'The delegate interacts with this for object identity tracking.'),
      infoCard(
          'Object Groups',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Group name', 'String identifier for a set'),
              dataRow('Object refs', 'Track alive references'),
              dataRow('Dispose group', 'Release all refs in group'),
              dataRow('ID mapping', 'Object → unique ref ID'),
            ],
          )),
      infoCard(
          'Why Groups Matter',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Memory control', 'Prevent object leaks'),
              dataRow('Session scoping', 'Group per DevTools request'),
              dataRow('Identity', 'Same object → same ID'),
              dataRow('Cleanup', 'Dispose when DevTools disconnects'),
            ],
          )),
    ],
  );

  // ─── Section 12: Description Formatting ───
  print('[Section 12] Description Formatting');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Description Formatting'),
      noteBox(
          'The delegate controls how node descriptions are formatted — '
          'short summary vs verbose, single-line vs multi-line.'),
      infoCard(
          'Description Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('singleLine', '"Padding(padding: 8.0)"'),
              dataRow('shallow', '"Padding" — type only'),
              dataRow('deep', 'Full property list, multi-line'),
              dataRow('errorDescription', 'Red-highlighted for errors'),
            ],
          )),
      infoCard(
          'Format Examples',
          jsonBlock(
              'Single-line: Padding(padding: EdgeInsets(8.0))\n'
              'Shallow:     Padding\n'
              'Deep:        Padding\n'
              '               padding: EdgeInsets(8.0, 0.0, 8.0, 0.0)\n'
              '               child: Text\n'
              'Error:       ══╡ EXCEPTION CAUGHT ╞══')),
    ],
  );

  // ─── Section 13: Diagnostic Nodes ───
  print('[Section 13] Diagnostic Nodes');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'DiagnosticsNode Interaction'),
      noteBox(
          'The delegate works with DiagnosticsNode subclasses which wrap '
          'the actual widget/render object data for serialization.'),
      infoCard(
          'DiagnosticsNode Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              delegateNode('DiagnosticsNode', 'Base class', false, iris),
              delegateNode('DiagnosticsProperty<T>', 'Name-value property', true, plum),
              delegateNode('DiagnosticableTreeNode', 'Tree-structured node', false, iris),
              delegateNode('ErrorDescription', 'Error diagnostic', false, iris),
              delegateNode('ErrorSummary', 'Error summary line', false, iris),
            ],
          )),
      infoCard(
          'Node → Map Pipeline',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('node.toJsonMap()', 'Convert node to map'),
              dataRow('delegate.filter()', 'Apply delegate filters'),
              dataRow('node.getProperties()', 'List of property nodes'),
              dataRow('node.getChildren()', 'List of child nodes'),
              dataRow('Recursion', 'Apply delegate to each child'),
            ],
          )),
    ],
  );

  // ─── Section 14: Error Serialization ───
  print('[Section 14] Error Serialization');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Error Serialization'),
      noteBox(
          'When a widget has an error (e.g. overflow, build failure), the '
          'delegate ensures error diagnostics are prominently serialized.'),
      infoCard(
          'Error Diagnostic Fields',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('hasError', 'bool — node has error'),
              dataRow('errorDescription', 'Text of the error'),
              dataRow('level: error', 'DiagnosticLevel.error'),
              dataRow('errorSummary', 'Short summary line'),
              dataRow('errorDetails', 'Full stack trace / details'),
            ],
          )),
      infoCard(
          'Error JSON Example',
          jsonBlock(
              '{\n'
              '  "description": "ErrorWidget",\n'
              '  "hasError": true,\n'
              '  "level": "error",\n'
              '  "errorSummary": "A RenderFlex overflowed",\n'
              '  "properties": [\n'
              '    {"name": "message", "level": "error"}\n'
              '  ]\n'
              '}')),
    ],
  );

  // ─── Section 15: Performance Impact ───
  print('[Section 15] Performance Impact');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Performance Impact'),
      noteBox(
          'Serialization is debug-only but trades off completeness against '
          'performance — deeper trees take longer to serialize.'),
      infoCard(
          'Performance Trade-offs',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Shallow tree (depth 1)', 0.15, indigo),
              progressBar('Medium tree (depth 3)', 0.40, iris),
              progressBar('Deep tree (depth 10)', 0.75, plum),
              progressBar('Full tree (unlimited)', 0.95, grape),
            ],
          )),
      infoCard(
          'Optimization Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Lazy loading', 'Serialize children on demand'),
              dataRow('Level filtering', 'Skip hidden/fine levels'),
              dataRow('Depth limit', 'Bound recursion depth'),
              dataRow('Caching', 'Cache serialized map if unchanged'),
              dataRow('Delta updates', 'Only resend changed nodes'),
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
      noteBox('Complete overview of the InspectorSerializationDelegate deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Indigo', indigo),
              colorSwatch('Plum', plum),
              colorSwatch('Deep Violet', deepViolet),
              colorSwatch('Pale Lavender', paleLavender),
              colorSwatch('Amethyst', amethyst),
              colorSwatch('Lilac', lilac),
              colorSwatch('Iris', iris),
              colorSwatch('Orchid', orchid),
              colorSwatch('Wisteria', wisteria),
              colorSwatch('Grape', grape),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, indigo),
              progressBar('Architecture', 1.0, plum),
              progressBar('Property Filtering', 1.0, iris),
              progressBar('Children Policy', 1.0, grape),
              progressBar('Summary vs Detail', 1.0, indigo),
              progressBar('JSON Map Format', 1.0, plum),
              progressBar('Property Serialization', 1.0, iris),
              progressBar('Truncation', 1.0, grape),
              progressBar('Custom Delegate', 1.0, indigo),
              progressBar('Service Extensions', 1.0, plum),
              progressBar('Grouping', 1.0, iris),
              progressBar('Description Formatting', 1.0, grape),
              progressBar('DiagnosticsNode', 1.0, indigo),
              progressBar('Error Serialization', 1.0, plum),
              progressBar('Performance', 1.0, iris),
              progressBar('Dashboard', 1.0, grape),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Indigo / Plum'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('Serialization', indigo, Colors.white),
          tag('Delegate Pattern', plum, Colors.white),
          tag('Property Filtering', iris, Colors.white),
          tag('JSON Output', grape, Colors.white),
          tag('DiagnosticsNode', amethyst, Colors.white),
          tag('DevTools Protocol', orchid, deepViolet),
        ],
      ),
    ],
  );

  print('===== END INSPECTOR SERIALIZATION DELEGATE DEEP DEMO =====');

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
