// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SelectableRegionSelectionStatusScope – the
// InheritedWidget that exposes the current selection status to descendant
// widgets so they can react visually when selection begins, changes, or ends.
// Deep Demo: Visualises scope lookup, status propagation, and reactive UIs
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableRegionSelectionStatusScope Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept – What is SelectableRegionSelectionStatusScope?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.account_tree_outlined,
      'title': 'InheritedWidget Pattern',
      'body': 'SelectableRegionSelectionStatusScope is an InheritedWidget '
          'placed in the tree by SelectableRegion. It exposes the current '
          'SelectableRegionSelectionStatus to all descendants.',
    },
    {
      'icon': Icons.search,
      'title': 'Lookup via maybeOf / of',
      'body': 'Widgets call SelectableRegionSelectionStatusScope.maybeOf(context) '
          'to read the current status, or .of(context) which asserts the scope '
          'exists. Returns null when outside a SelectableRegion.',
    },
    {
      'icon': Icons.sync_alt,
      'title': 'Reactive Rebuilds',
      'body': 'Because it is an InheritedWidget, any dependant widget rebuilds '
          'automatically whenever the selection status changes – no manual '
          'subscription needed.',
    },
    {
      'icon': Icons.layers_outlined,
      'title': 'Scoped per Region',
      'body': 'Each SelectableRegion creates its own scope. Nested or sibling '
          'regions have independent statuses – one region selecting does not '
          'affect another.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.indigo.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.indigo.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.indigo, size: 28.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey.shade800,
                      height: 1.4,
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
  // SECTION 2: Widget Tree Diagram
  // ============================================================
  print('=== Section 2: Widget Tree Diagram ===');

  Widget buildTreeNode(String label, Color color, {List<Widget>? children}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (children != null) ...[
          Container(width: 2.0, height: 14.0, color: color.withValues(alpha: 0.4)),
          ...children,
        ],
      ],
    );
  }

  final treeDiagram = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        const Text(
          'Widget Tree with Scope',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12.0),
        buildTreeNode('SelectableRegion', Colors.deepPurple, children: [
          buildTreeNode(
            'SelectableRegionSelectionStatusScope',
            Colors.indigo,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTreeNode('Text("Hello")', Colors.teal),
                  const SizedBox(width: 16.0),
                  buildTreeNode('Text("World")', Colors.teal),
                ],
              ),
            ],
          ),
        ]),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade700),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info_outline, size: 16.0, color: Colors.amber.shade800),
              const SizedBox(width: 8.0),
              Text(
                'Scope is injected automatically by SelectableRegion',
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.amber.shade900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Selection Status Values
  // ============================================================
  print('=== Section 3: Selection Status Values ===');

  final statusEntries = <Map<String, dynamic>>[
    {
      'name': 'none',
      'description': 'No active selection in the region',
      'color': Colors.grey,
      'icon': Icons.deselect,
      'visualFill': 0.0,
    },
    {
      'name': 'selecting',
      'description': 'User is actively dragging to select content',
      'color': Colors.orange,
      'icon': Icons.touch_app,
      'visualFill': 0.5,
    },
    {
      'name': 'selected',
      'description': 'A selection exists and the user released the pointer',
      'color': Colors.green,
      'icon': Icons.check_box_outlined,
      'visualFill': 1.0,
    },
  ];

  final statusCards = <Widget>[];
  for (final entry in statusEntries) {
    final color = entry['color'] as Color;
    final fill = entry['visualFill'] as double;
    print('Status: ${entry['name']} – ${entry['description']}');

    statusCards.add(
      Container(
        width: 185.0,
        margin: const EdgeInsets.symmetric(horizontal: 6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            Icon(entry['icon'] as IconData, color: color, size: 32.0),
            const SizedBox(height: 8.0),
            Text(
              entry['name'] as String,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              entry['description'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.3),
            ),
            const SizedBox(height: 10.0),
            // Visual bar showing "fill level"
            Container(
              height: 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: fill == 0.0 ? 0.05 : fill,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${(fill * 100).toInt()}% progression',
              style: TextStyle(fontSize: 10.0, color: color),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: API Surface Reference
  // ============================================================
  print('=== Section 4: API Surface ===');

  final apiMethods = <Map<String, String>>[
    {
      'signature': 'static SelectableRegionSelectionStatus? maybeOf(BuildContext context)',
      'returns': 'SelectableRegionSelectionStatus?',
      'note': 'Returns null if no scope exists above the context. '
          'Safe to call anywhere – will not throw.',
    },
    {
      'signature': 'static SelectableRegionSelectionStatus of(BuildContext context)',
      'returns': 'SelectableRegionSelectionStatus',
      'note': 'Asserts the scope exists. Throws if called outside a '
          'SelectableRegion. Use only when you are certain the scope is present.',
    },
    {
      'signature': 'bool updateShouldNotify(covariant SelectableRegionSelectionStatusScope old)',
      'returns': 'bool',
      'note': 'Returns true when the status value has changed, '
          'causing dependants to rebuild.',
    },
  ];

  final apiCards = <Widget>[];
  for (var i = 0; i < apiMethods.length; i++) {
    final m = apiMethods[i];
    print('API: ${m['signature']}');
    apiCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8.0),
          border: Border(
            left: BorderSide(color: Colors.blueGrey.shade400, width: 3.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                m['signature']!,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 6.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '→ ${m['returns']}',
                    style: const TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              m['note']!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live SelectableRegion with Status Indicator
  // ============================================================
  print('=== Section 5: Live SelectableRegion with Status ===');

  // Build a live selectable area where the user can see status changes.
  // We wrap SelectableText in a SelectionArea (which uses SelectableRegion
  // internally) and show status-aware visual decoration around it.

  final liveRegionDemo = _LiveStatusRegionDemo();

  // ============================================================
  // SECTION 6: Multiple Scopes – Independent Regions
  // ============================================================
  print('=== Section 6: Multiple Independent Scopes ===');

  final multiScopeDemo = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Two Independent Scopes',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Each SelectionArea creates its own scope. Selecting text in '
          'Region A does not affect Region B – their status values are '
          'completely independent.',
          style: TextStyle(fontSize: 12.5, color: Colors.grey.shade700, height: 1.35),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: _ScopedRegionCard(
                label: 'Region A',
                color: Colors.deepPurple,
                sampleText: 'Flutter makes it easy and fast to build '
                    'beautiful apps for mobile and beyond. Select '
                    'this text to see the status scope in action.',
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: _ScopedRegionCard(
                label: 'Region B',
                color: Colors.teal,
                sampleText: 'Dart is a client-optimised language for fast '
                    'apps on any platform. It powers Flutter and can '
                    'be compiled ahead-of-time or JIT.',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: maybeOf vs of – Safety Comparison
  // ============================================================
  print('=== Section 7: maybeOf vs of comparison ===');

  final safetyRows = <Map<String, dynamic>>[
    {
      'method': 'maybeOf(ctx)',
      'outsideRegion': 'Returns null',
      'insideRegion': 'Returns status',
      'throws': false,
      'recommended': true,
    },
    {
      'method': 'of(ctx)',
      'outsideRegion': 'Throws AssertionError',
      'insideRegion': 'Returns status',
      'throws': true,
      'recommended': false,
    },
  ];

  final safetyTable = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lookup Safety Comparison',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10.0),
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: const Row(
            children: [
              Expanded(flex: 2, child: Text('Method', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 3, child: Text('Outside Region', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 3, child: Text('Inside Region', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 2, child: Text('Safe?', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        ...safetyRows.map((row) {
          final throws = row['throws'] as bool;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    row['method'] as String,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    row['outsideRegion'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: throws ? Colors.red.shade700 : Colors.green.shade700,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    row['insideRegion'] as String,
                    style: TextStyle(fontSize: 12.0, color: Colors.green.shade700),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Icon(
                    throws ? Icons.warning_amber : Icons.check_circle,
                    color: throws ? Colors.amber.shade700 : Colors.green,
                    size: 18.0,
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.green, size: 18.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Prefer maybeOf() in reusable widgets that might be placed '
                  'outside a SelectableRegion. Use of() only in widgets that '
                  'are guaranteed to live inside one.',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.green.shade800,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Reactive Widget Pattern
  // ============================================================
  print('=== Section 8: Reactive Widget Pattern ===');

  // Show a code-style visual of how a widget would use the scope
  final reactivePatternCode = [
    'class SelectionAwareHighlight extends StatelessWidget {',
    '  @override',
    '  Widget build(BuildContext context) {',
    '    final status = SelectableRegionSelectionStatusScope',
    '        .maybeOf(context);',
    '',
    '    final isSelecting =',
    '        status == SelectableRegionSelectionStatus.selecting;',
    '',
    '    return AnimatedContainer(',
    '      duration: Duration(milliseconds: 200),',
    '      decoration: BoxDecoration(',
    '        color: isSelecting',
    '            ? Colors.yellow.withOpacity(0.3)',
    '            : Colors.transparent,',
    '      ),',
    '      child: Text("Select me!"),',
    '    );',
    '  }',
    '}',
  ];

  final codeDisplayLines = <Widget>[];
  for (var i = 0; i < reactivePatternCode.length; i++) {
    final line = reactivePatternCode[i];
    final isHighlight = line.contains('maybeOf') || line.contains('SelectableRegionSelectionStatus');
    codeDisplayLines.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28.0,
            child: Text(
              '${i + 1}',
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Container(
              color: isHighlight ? Colors.yellow.withValues(alpha: 0.2) : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 1.0),
              child: Text(
                line,
                style: TextStyle(
                  fontSize: 11.5,
                  fontFamily: 'monospace',
                  color: isHighlight ? Colors.deepPurple.shade800 : Colors.grey.shade800,
                  fontWeight: isHighlight ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final codeBlock = Container(
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
              'Reactive Pattern – Selection-Aware Widget',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Colors.deepPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        ...codeDisplayLines,
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Highlighted lines show the key interaction: reading the scope '
            'via maybeOf and comparing against status values. The enclosing '
            'AnimatedContainer automatically rebuilds when status changes.',
            style: TextStyle(fontSize: 11.5, color: Colors.deepPurple.shade700, height: 1.35),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: updateShouldNotify Behaviour
  // ============================================================
  print('=== Section 9: updateShouldNotify ===');

  final notifyScenarios = <Map<String, dynamic>>[
    {'from': 'none', 'to': 'selecting', 'notifies': true, 'color': Colors.orange},
    {'from': 'selecting', 'to': 'selected', 'notifies': true, 'color': Colors.green},
    {'from': 'selected', 'to': 'none', 'notifies': true, 'color': Colors.grey},
    {'from': 'none', 'to': 'none', 'notifies': false, 'color': Colors.grey},
    {'from': 'selecting', 'to': 'selecting', 'notifies': false, 'color': Colors.orange},
    {'from': 'selected', 'to': 'selected', 'notifies': false, 'color': Colors.green},
  ];

  final notifyRows = <Widget>[];
  for (final s in notifyScenarios) {
    final notifies = s['notifies'] as bool;
    notifyRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          color: notifies ? Colors.green.withValues(alpha: 0.03) : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: (s['color'] as Color).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      s['from'] as String,
                      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: s['color'] as Color),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    child: Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: (s['color'] as Color).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      s['to'] as String,
                      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace', color: s['color'] as Color),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Icon(
                    notifies ? Icons.notifications_active : Icons.notifications_off,
                    size: 16.0,
                    color: notifies ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    notifies ? 'Notifies' : 'No change',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: notifies ? Colors.green.shade700 : Colors.grey.shade600,
                      fontWeight: notifies ? FontWeight.w600 : FontWeight.normal,
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

  final updateShouldNotifyBlock = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'updateShouldNotify Transitions',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Only transitions between different status values trigger rebuild. '
          'Same-to-same transitions are skipped to avoid unnecessary work.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade600, height: 1.3),
        ),
        const SizedBox(height: 10.0),
        // Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6.0)),
          ),
          child: const Row(
            children: [
              Expanded(flex: 3, child: Text('Transition', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700))),
              Expanded(flex: 2, child: Text('Result', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700))),
            ],
          ),
        ),
        ...notifyRows,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {'icon': Icons.account_tree, 'text': 'InheritedWidget exposing SelectableRegionSelectionStatus'},
    {'icon': Icons.construction, 'text': 'Automatically injected by SelectableRegion / SelectionArea'},
    {'icon': Icons.search, 'text': 'Read via maybeOf(context) (safe) or of(context) (asserting)'},
    {'icon': Icons.sync, 'text': 'Dependant widgets rebuild only on actual status changes'},
    {'icon': Icons.layers, 'text': 'Each region maintains an independent scope instance'},
    {'icon': Icons.palette, 'text': 'Enables reactive UIs that respond to selection lifecycle'},
  ];

  final summaryItems = <Widget>[];
  for (final sp in summaryPoints) {
    summaryItems.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(sp['icon'] as IconData, size: 16.0, color: Colors.indigo),
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
  print('Building final tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SelectableRegionSelectionStatusScope'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Tree'),
            Tab(text: 'Status Values'),
            Tab(text: 'API'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Multi-Scope'),
            Tab(text: 'Patterns'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('What is it?',
                    'An InheritedWidget that carries the current selection status '
                    'for a SelectableRegion. Descendant widgets depend on it to '
                    'adapt their appearance during text selection.'),
                const SizedBox(height: 14.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Tree
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('Widget Tree',
                    'SelectableRegion inserts the scope into the tree so that all '
                    'descendant widgets can read the current selection status. The '
                    'diagram below shows how the scope sits between SelectableRegion '
                    'and its child content.'),
                const SizedBox(height: 14.0),
                treeDiagram,
              ],
            ),
          ),
          // Tab 3: Status Values
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('Three Status Values',
                    'The scope carries one of three status values that represent '
                    'the lifecycle of a selection gesture.'),
                const SizedBox(height: 14.0),
                Wrap(
                  runSpacing: 10.0,
                  children: statusCards,
                ),
                const SizedBox(height: 16.0),
                updateShouldNotifyBlock,
              ],
            ),
          ),
          // Tab 4: API
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('API Reference',
                    'Three key methods form the complete public API of '
                    'SelectableRegionSelectionStatusScope.'),
                const SizedBox(height: 14.0),
                ...apiCards,
                const SizedBox(height: 14.0),
                safetyTable,
              ],
            ),
          ),
          // Tab 5: Live Demo
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('Live Selection Demo',
                    'Select the text below. The surrounding decoration reacts '
                    'to the current selection status through the scope.'),
                const SizedBox(height: 14.0),
                liveRegionDemo,
              ],
            ),
          ),
          // Tab 6: Multi-Scope
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('Independent Scopes',
                    'Sibling SelectionAreas each have their own scope. Selecting '
                    'text in one does not affect the other.'),
                const SizedBox(height: 14.0),
                multiScopeDemo,
              ],
            ),
          ),
          // Tab 7: Patterns
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('Reactive Pattern',
                    'A complete example of a widget that adapts its appearance '
                    'based on the selection status scope.'),
                const SizedBox(height: 14.0),
                codeBlock,
              ],
            ),
          ),
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSRSSBullet('Key Takeaways', ''),
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.indigo.withValues(alpha: 0.05),
                        Colors.deepPurple.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.indigo.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: summaryItems,
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
Widget _buildSRSSBullet(String title, String body) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.indigo.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: Colors.indigo, width: 3.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Colors.indigo,
          ),
        ),
        if (body.isNotEmpty) ...[
          const SizedBox(height: 4.0),
          Text(
            body,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Live Status Region Demo – interactive selectable text with status indicator
// ---------------------------------------------------------------------------
class _LiveStatusRegionDemo extends StatefulWidget {
  @override
  State<_LiveStatusRegionDemo> createState() => _LiveStatusRegionDemoState();
}

class _LiveStatusRegionDemoState extends State<_LiveStatusRegionDemo> {
  String _lastAction = 'No selection started yet';
  int _selectionCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.08),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.touch_app, color: Colors.indigo, size: 22.0),
              const SizedBox(width: 8.0),
              const Text(
                'Interactive Selection Area',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // The actual selectable region
          SelectionArea(
            onSelectionChanged: (value) {
              setState(() {
                if (value != null && value.plainText.isNotEmpty) {
                  _selectionCount++;
                  _lastAction = 'Selected: "${value.plainText.length > 40 ? '${value.plainText.substring(0, 40)}...' : value.plainText}"';
                } else {
                  _lastAction = 'Selection cleared';
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'The Flutter framework provides a powerful selection system that '
                    'allows users to select text across multiple widgets. The '
                    'SelectableRegionSelectionStatusScope is the InheritedWidget '
                    'that makes this work by propagating status changes down the '
                    'widget tree.',
                    style: TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Try selecting any part of this text. The selection status '
                    'will update below, showing how the scope communicates '
                    'the current state to dependent widgets.',
                    style: TextStyle(fontSize: 13.5, height: 1.6, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          // Status readout
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, size: 16.0, color: Colors.grey.shade600),
                    const SizedBox(width: 6.0),
                    Text(
                      'Last action: $_lastAction',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.repeat, size: 16.0, color: Colors.grey.shade600),
                    const SizedBox(width: 6.0),
                    Text(
                      'Selection events: $_selectionCount',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey.shade700,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Scoped Region Card – used in multi-scope demo
// ---------------------------------------------------------------------------
class _ScopedRegionCard extends StatefulWidget {
  final String label;
  final Color color;
  final String sampleText;

  const _ScopedRegionCard({
    required this.label,
    required this.color,
    required this.sampleText,
  });

  @override
  State<_ScopedRegionCard> createState() => _ScopedRegionCardState();
}

class _ScopedRegionCardState extends State<_ScopedRegionCard> {
  bool _hasSelection = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _hasSelection
            ? widget.color.withValues(alpha: 0.08)
            : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: _hasSelection
              ? widget.color
              : widget.color.withValues(alpha: 0.3),
          width: _hasSelection ? 2.0 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10.0,
                height: 10.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _hasSelection ? widget.color : Colors.grey.shade400,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: widget.color,
                ),
              ),
              const Spacer(),
              Text(
                _hasSelection ? 'ACTIVE' : 'idle',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: _hasSelection ? widget.color : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SelectionArea(
            onSelectionChanged: (value) {
              final sel = value != null && value.plainText.isNotEmpty;
              if (sel != _hasSelection) {
                setState(() => _hasSelection = sel);
              }
            },
            child: Text(
              widget.sampleText,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey.shade800,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
