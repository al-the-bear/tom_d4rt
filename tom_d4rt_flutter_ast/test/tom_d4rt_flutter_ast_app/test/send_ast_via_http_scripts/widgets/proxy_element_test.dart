// ignore_for_file: avoid_print
// D4rt test script: Tests ProxyElement from widgets
// Deep Demo: Visual demonstration of the proxy element pass-through pattern
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ProxyElement Deep Demo executing');

  // ============================================================
  // SECTION 1: What is ProxyElement?
  // ============================================================
  print('=== Section 1: ProxyElement Overview ===');

  // Color palette: Jade / Mint
  final jade900 = Color(0xFF0B3D2E);
  final jade800 = Color(0xFF115740);
  final jade700 = Color(0xFF1A7358);
  final jade600 = Color(0xFF248F6E);
  final jade500 = Color(0xFF30AB85);
  final mint400 = Color(0xFF52C49E);
  final mint300 = Color(0xFF7DD8B6);
  final mint200 = Color(0xFFA8E8CF);
  final mint100 = Color(0xFFD3F4E7);
  final mint50 = Color(0xFFEDFAF4);

  final overviewCards = <Widget>[];

  // Hero card
  overviewCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [jade900, jade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: jade900.withValues(alpha: 0.45),
            blurRadius: 14.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.layers, size: 38.0, color: mint200),
              SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'ProxyElement',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: mint400.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'abstract class ProxyElement extends ComponentElement',
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                color: mint200,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'The invisible pass-through element. ProxyElement does not '
            'create its own widget tree — its build() method simply '
            'returns the child widget. It exists to intercept updates '
            'and notify dependents when the proxy widget changes, '
            'powering InheritedWidget and ParentDataWidget.',
            style: TextStyle(
              fontSize: 14.0,
              color: mint100,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Key insight card
  overviewCards.add(
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: mint50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: jade600.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, size: 20.0, color: Colors.amber.shade700),
              SizedBox(width: 8.0),
              Text(
                'Key Insight',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: jade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'ProxyElement is the bridge between the widget tree and the '
            'dependency notification system. While StatelessElement and '
            'StatefulElement BUILD subtrees, ProxyElement PASSES THROUGH '
            'a single child while adding metadata or inherited data.',
            style: TextStyle(fontSize: 13.0, color: jade800, height: 1.5),
          ),
        ],
      ),
    ),
  );

  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: build() — The Pass-Through
  // ============================================================
  print('=== Section 2: build() Method ===');

  final buildCards = <Widget>[];

  buildCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, size: 18.0, color: mint400),
              SizedBox(width: 8.0),
              Text(
                'ProxyElement.build()',
                style: TextStyle(fontSize: 14.0, color: mint300, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            '@override\n'
            'Widget build() => (widget as ProxyWidget).child;',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'monospace',
              color: mint200,
              height: 1.6,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'One line. It doesn\'t create anything — it just returns '
            'the child from its ProxyWidget. This is so fundamentally '
            'different from StatelessElement (which calls widget.build()) '
            'or StatefulElement (which calls state.build()).',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade400,
              height: 1.5,
            ),
          ),
        ],
      ),
    ),
  );

  // Visual comparison: what different elements do in build()
  final buildComparison = <Map<String, String>>[
    {
      'element': 'StatelessElement',
      'buildDoes': 'Calls widget.build(context)',
      'creates': 'New widget subtree',
    },
    {
      'element': 'StatefulElement',
      'buildDoes': 'Calls state.build(context)',
      'creates': 'New widget subtree from state',
    },
    {
      'element': 'ProxyElement',
      'buildDoes': 'Returns widget.child directly',
      'creates': 'Nothing — passes child through',
    },
  ];

  for (var i = 0; i < buildComparison.length; i++) {
    final comp = buildComparison[i];
    final isProxy = comp['element'] == 'ProxyElement';
    final lineColor = isProxy ? jade600 : Colors.grey.shade500;

    buildCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isProxy ? jade600.withValues(alpha: 0.1) : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: lineColor,
            width: isProxy ? 2.5 : 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 100.0,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: lineColor,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                comp['element']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comp['buildDoes']!,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: isProxy ? jade900 : Colors.grey.shade800,
                      fontWeight: isProxy ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Text(
                    comp['creates']!,
                    style: TextStyle(
                      fontSize: 10.5,
                      color: isProxy ? jade700 : Colors.grey.shade600,
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

  print('Created build() comparison with ${buildComparison.length} elements');

  // ============================================================
  // SECTION 3: update() — The Notification Chain
  // ============================================================
  print('=== Section 3: update() Method ===');

  final updateCards = <Widget>[];

  updateCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ProxyElement.update()',
            style: TextStyle(fontSize: 14.0, color: mint300, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          Text(
            '@override\n'
            'void update(ProxyWidget newWidget) {\n'
            '  final oldWidget = widget as ProxyWidget;\n'
            '  super.update(newWidget);\n'
            '  updated(oldWidget);\n'
            '  rebuild(force: true);\n'
            '}',
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: mint200,
              height: 1.6,
            ),
          ),
        ],
      ),
    ),
  );

  // Update flow visualization
  final updateSteps = <Map<String, String>>[
    {
      'step': 'Store old widget',
      'detail': 'Captures current widget before swap',
    },
    {
      'step': 'super.update(newWidget)',
      'detail': 'Swaps widget reference in Element base class',
    },
    {
      'step': 'updated(oldWidget)',
      'detail': 'Notifies clients of the change (subclass implements)',
    },
    {
      'step': 'rebuild(force: true)',
      'detail': 'Forces rebuild to pick up new child widget',
    },
  ];

  for (var i = 0; i < updateSteps.length; i++) {
    final step = updateSteps[i];
    final stepColor = Color.lerp(jade800, mint400, i / (updateSteps.length - 1))!;

    updateCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
        child: Column(
          children: [
            if (i > 0)
              Container(
                height: 14.0,
                width: 2.0,
                color: stepColor.withValues(alpha: 0.4),
              ),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: stepColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: stepColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: stepColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['step']!,
                          style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            color: jade900,
                          ),
                        ),
                        Text(
                          step['detail']!,
                          style: TextStyle(fontSize: 11.0, color: jade700),
                        ),
                      ],
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

  print('Created update() flow with ${updateSteps.length} steps');

  // ============================================================
  // SECTION 4: notifyClients — Abstract Contract
  // ============================================================
  print('=== Section 4: notifyClients() ===');

  final notifyCards = <Widget>[];

  notifyCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: jade800,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Abstract Contract',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.0),
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '@protected\n'
              'void notifyClients(covariant ProxyWidget oldWidget);',
              style: TextStyle(
                fontSize: 13.0,
                fontFamily: 'monospace',
                color: mint200,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'ProxyElement declares notifyClients as abstract. Each subclass '
            'decides HOW to notify. InheritedElement marks dependent elements '
            'dirty. ParentDataElement applies new parent data to the render object.',
            style: TextStyle(fontSize: 12.5, color: mint100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Subclass implementations
  final implementations = <Map<String, String>>[
    {
      'subclass': 'InheritedElement',
      'notification': 'Walks dependent elements and marks them as needing rebuild',
      'trigger': 'updateShouldNotify(oldWidget) returns true',
      'effect': 'Descendants that called dependOnInheritedWidgetOfExactType rebuild',
    },
    {
      'subclass': 'ParentDataElement',
      'notification': 'Applies new parent data to child render object',
      'trigger': 'Always (every update)',
      'effect': 'RenderObject.parentData is modified directly',
    },
  ];

  for (final impl in implementations) {
    notifyCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: mint50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: jade600.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: jade700,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                impl['subclass']!,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.notifications_active, size: 16.0, color: jade600),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    impl['notification']!,
                    style: TextStyle(fontSize: 11.5, color: jade800),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.bolt, size: 16.0, color: Colors.amber.shade700),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Trigger: ${impl['trigger']!}',
                    style: TextStyle(fontSize: 11.0, color: jade700),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.arrow_right_alt, size: 16.0, color: jade500),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Effect: ${impl['effect']!}',
                    style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  print('Created notifyClients() with ${implementations.length} implementations');

  // ============================================================
  // SECTION 5: Element Class Hierarchy
  // ============================================================
  print('=== Section 5: Element Hierarchy ===');

  final hierarchyNodes = <Map<String, dynamic>>[
    {'name': 'Element', 'depth': 0, 'color': Colors.grey.shade700, 'abstract': true},
    {'name': 'ComponentElement', 'depth': 1, 'color': Colors.blueGrey, 'abstract': true},
    {'name': 'StatelessElement', 'depth': 2, 'color': Colors.blue.shade600, 'abstract': false},
    {'name': 'StatefulElement', 'depth': 2, 'color': Colors.purple.shade600, 'abstract': false},
    {'name': 'ProxyElement', 'depth': 2, 'color': jade600, 'abstract': true},
    {'name': 'InheritedElement', 'depth': 3, 'color': jade500, 'abstract': false},
    {'name': 'ParentDataElement', 'depth': 3, 'color': mint400, 'abstract': false},
    {'name': 'RenderObjectElement', 'depth': 1, 'color': Colors.orange.shade700, 'abstract': true},
  ];

  final hierarchyWidgets = <Widget>[];

  for (var i = 0; i < hierarchyNodes.length; i++) {
    final node = hierarchyNodes[i];
    final depth = node['depth'] as int;
    final isProxy = node['name'] == 'ProxyElement';
    final nodeColor = node['color'] as Color;

    hierarchyWidgets.add(
      Container(
        margin: EdgeInsets.only(left: 12.0 + depth * 28.0, right: 12.0, top: 3.0, bottom: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isProxy ? nodeColor.withValues(alpha: 0.15) : nodeColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: nodeColor,
            width: isProxy ? 3.0 : 1.5,
          ),
          boxShadow: isProxy
              ? [BoxShadow(color: nodeColor.withValues(alpha: 0.25), blurRadius: 6.0, offset: Offset(0, 3))]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              node['name'] as String,
              style: TextStyle(
                fontSize: 12.0,
                fontFamily: 'monospace',
                fontWeight: isProxy ? FontWeight.bold : FontWeight.w500,
                color: nodeColor,
              ),
            ),
            if (node['abstract'] as bool) ...[
              SizedBox(width: 6.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                decoration: BoxDecoration(
                  color: nodeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'abstract',
                  style: TextStyle(
                    fontSize: 9.0,
                    fontStyle: FontStyle.italic,
                    color: nodeColor,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  print('Created element hierarchy with ${hierarchyNodes.length} nodes');

  // ============================================================
  // SECTION 6: InheritedElement — Prime Subclass
  // ============================================================
  print('=== Section 6: InheritedElement ===');

  final inheritedCards = <Widget>[];

  inheritedCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [jade700, mint400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.share, size: 28.0, color: Colors.white),
              SizedBox(width: 10.0),
              Text(
                'InheritedElement',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Text(
            'The most important ProxyElement subclass. InheritedElement '
            'powers InheritedWidget — the foundation of Theme.of(), '
            'MediaQuery.of(), and every other .of(context) in Flutter. '
            'It maintains a set of dependent elements and notifies them '
            'when its inherited data changes.',
            style: TextStyle(fontSize: 12.5, color: mint100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Visual: dependency flow
  final depFlow = <String>[
    'Theme (InheritedWidget)',
    'ProxyElement / InheritedElement holds theme data',
    'Dependents: Text, Icon, Button elements',
    'Theme changes → notifyClients → dependents rebuild',
  ];

  for (var i = 0; i < depFlow.length; i++) {
    inheritedCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
        child: Column(
          children: [
            if (i > 0)
              Container(height: 12.0, width: 2.0, color: jade500.withValues(alpha: 0.4)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Color.lerp(jade700, mint300, i / (depFlow.length - 1))!.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Color.lerp(jade700, mint400, i / (depFlow.length - 1))!,
                  width: 1.5,
                ),
              ),
              child: Text(
                depFlow[i],
                style: TextStyle(
                  fontSize: 11.5,
                  color: jade900,
                  fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created InheritedElement section');

  // ============================================================
  // SECTION 7: ParentDataElement — The Other Subclass
  // ============================================================
  print('=== Section 7: ParentDataElement ===');

  final parentDataCards = <Widget>[];

  parentDataCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: mint50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: jade500, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.dataset, size: 24.0, color: jade600),
              SizedBox(width: 10.0),
              Text(
                'ParentDataElement<T>',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  color: jade900,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            'Extends ProxyElement to configure per-child layout data. '
            'Used by Positioned inside Stack, Flexible inside Flex, '
            'and similar parent-child configuration patterns. Its '
            'notifyClients applies new parent data to the child\'s '
            'RenderObject directly.',
            style: TextStyle(fontSize: 12.5, color: jade800, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Examples: ParentDataWidget usage
  final parentDataExamples = <Map<String, String>>[
    {
      'widget': 'Positioned',
      'parent': 'Stack',
      'data': 'StackParentData (left, top, right, bottom, width, height)',
    },
    {
      'widget': 'Flexible / Expanded',
      'parent': 'Row / Column / Flex',
      'data': 'FlexParentData (flex, fit)',
    },
    {
      'widget': 'TableCell',
      'parent': 'Table',
      'data': 'TableCellParentData (verticalAlignment)',
    },
  ];

  for (final example in parentDataExamples) {
    parentDataCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: jade500.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: jade600,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                example['widget']!,
                style: TextStyle(fontSize: 10.5, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 8.0),
            Icon(Icons.arrow_right_alt, size: 16.0, color: jade500),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inside: ${example['parent']!}',
                    style: TextStyle(fontSize: 10.5, color: jade800),
                  ),
                  Text(
                    example['data']!,
                    style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ParentDataElement with ${parentDataExamples.length} examples');

  // ============================================================
  // SECTION 8: Element Lifecycle
  // ============================================================
  print('=== Section 8: Element Lifecycle ===');

  final lifecycleStages = <Map<String, String>>[
    {
      'stage': 'mount()',
      'detail': 'Element is inserted into the tree. ProxyElement is inflated from ProxyWidget.',
    },
    {
      'stage': 'build()',
      'detail': 'Returns widget.child — the pass-through. No new widgets created.',
    },
    {
      'stage': 'update(newWidget)',
      'detail': 'Parent rebuilds with new ProxyWidget. Triggers updated() then rebuild.',
    },
    {
      'stage': 'updated(oldWidget)',
      'detail': 'Calls notifyClients(oldWidget). Subclass handles notification.',
    },
    {
      'stage': 'deactivate()',
      'detail': 'Element removed from tree temporarily. Dependencies cleaned up.',
    },
    {
      'stage': 'unmount()',
      'detail': 'Element permanently removed. All references released.',
    },
  ];

  final lifecycleWidgets = <Widget>[];

  for (var i = 0; i < lifecycleStages.length; i++) {
    final stage = lifecycleStages[i];
    final stageColor = Color.lerp(jade900, mint300, i / (lifecycleStages.length - 1))!;

    lifecycleWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        child: Column(
          children: [
            if (i > 0)
              Icon(Icons.arrow_downward, size: 16.0, color: stageColor.withValues(alpha: 0.5)),
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: stageColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: stageColor, width: 1.5),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: stageColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      stage['stage']!,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontFamily: 'monospace',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      stage['detail']!,
                      style: TextStyle(fontSize: 11.0, color: jade800),
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

  print('Created lifecycle with ${lifecycleStages.length} stages');

  // ============================================================
  // SECTION 9: Three Trees Visualization
  // ============================================================
  print('=== Section 9: Three Trees ===');

  Widget buildTreeColumn({
    required String treeName,
    required List<Map<String, dynamic>> nodes,
    required Color headerColor,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              treeName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          ...nodes.map((node) {
            final isProxy = node['isProxy'] == true;
            return Container(
              margin: EdgeInsets.only(left: (node['depth'] as int) * 8.0, top: 2.0, bottom: 2.0, right: 2.0),
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: isProxy
                    ? jade500.withValues(alpha: 0.15)
                    : headerColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
                border: isProxy
                    ? Border.all(color: jade500, width: 1.5)
                    : Border.all(color: headerColor.withValues(alpha: 0.2)),
              ),
              child: Text(
                node['label'] as String,
                style: TextStyle(
                  fontSize: 8.5,
                  fontFamily: 'monospace',
                  color: isProxy ? jade900 : Colors.grey.shade800,
                  fontWeight: isProxy ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  final threeTreesRow = Container(
    margin: EdgeInsets.all(12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTreeColumn(
          treeName: 'Widget Tree',
          headerColor: Colors.blue.shade700,
          nodes: [
            {'label': 'MaterialApp', 'depth': 0, 'isProxy': false},
            {'label': 'Theme (Proxy)', 'depth': 1, 'isProxy': true},
            {'label': 'Scaffold', 'depth': 2, 'isProxy': false},
            {'label': 'Positioned (Proxy)', 'depth': 3, 'isProxy': true},
            {'label': 'Text', 'depth': 4, 'isProxy': false},
          ],
        ),
        SizedBox(width: 6.0),
        buildTreeColumn(
          treeName: 'Element Tree',
          headerColor: jade700,
          nodes: [
            {'label': 'StatefulElement', 'depth': 0, 'isProxy': false},
            {'label': 'InheritedElement', 'depth': 1, 'isProxy': true},
            {'label': 'StatefulElement', 'depth': 2, 'isProxy': false},
            {'label': 'ParentDataElem', 'depth': 3, 'isProxy': true},
            {'label': 'StatelessElement', 'depth': 4, 'isProxy': false},
          ],
        ),
        SizedBox(width: 6.0),
        buildTreeColumn(
          treeName: 'Render Tree',
          headerColor: Colors.orange.shade700,
          nodes: [
            {'label': 'RenderView', 'depth': 0, 'isProxy': false},
            {'label': '(no render obj)', 'depth': 1, 'isProxy': true},
            {'label': 'RenderFlex', 'depth': 1, 'isProxy': false},
            {'label': '(no render obj)', 'depth': 2, 'isProxy': true},
            {'label': 'RenderParagraph', 'depth': 2, 'isProxy': false},
          ],
        ),
      ],
    ),
  );

  print('Created three trees visualization');

  // ============================================================
  // SECTION 10: The Proxy Pattern
  // ============================================================
  print('=== Section 10: Proxy Pattern ===');

  final proxyPatternCards = <Widget>[];

  proxyPatternCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: jade900,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.architecture, size: 28.0, color: mint200),
              SizedBox(width: 10.0),
              Text(
                'The Proxy Design Pattern',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Text(
            'In software design, a Proxy acts as an intermediary that '
            'controls access to another object. Flutter\'s ProxyElement '
            'applies this pattern to the element tree: it intercepts '
            'widget updates without changing the child subtree, adding '
            'metadata (InheritedWidget) or configuration (ParentDataWidget) '
            'as a transparent layer.',
            style: TextStyle(fontSize: 12.5, color: mint100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final proxyVsReal = <Map<String, String>>[
    {
      'aspect': 'Build responsibility',
      'proxy': 'Returns child unchanged',
      'real': 'Creates new widget tree',
    },
    {
      'aspect': 'State management',
      'proxy': 'No state — purely pass-through',
      'real': 'Manages State object lifecycle',
    },
    {
      'aspect': 'Update behavior',
      'proxy': 'Notifies dependents, rebuilds child',
      'real': 'Calls setState, rebuilds own tree',
    },
    {
      'aspect': 'RenderObject',
      'proxy': 'Never creates one',
      'real': 'May create via RenderObjectWidget',
    },
  ];

  for (var i = 0; i < proxyVsReal.length; i++) {
    final row = proxyVsReal[i];
    proxyPatternCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: i.isEven ? mint50 : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 90.0,
              child: Text(
                row['aspect']!,
                style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: jade900),
              ),
            ),
            Expanded(
              child: Text(
                row['proxy']!,
                style: TextStyle(fontSize: 10.0, color: jade700),
              ),
            ),
            Expanded(
              child: Text(
                row['real']!,
                style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created proxy pattern section');

  // ============================================================
  // SECTION 11: Dependency Tracking
  // ============================================================
  print('=== Section 11: Dependency Tracking ===');

  final depCards = <Widget>[];

  depCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [jade600, mint400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How Dependency Tracking Works',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            'When a widget calls Theme.of(context), the framework registers '
            'that element as a dependent of the InheritedElement (a ProxyElement). '
            'When the InheritedWidget changes, ProxyElement.update() calls '
            'updated() → notifyClients(), which marks all dependents dirty '
            'for rebuild.',
            style: TextStyle(fontSize: 12.0, color: mint100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  // Dependency registration flow
  final depSteps = <Map<String, String>>[
    {'label': 'Widget calls Theme.of(context)', 'note': 'context.dependOnInheritedWidgetOfExactType<Theme>()'},
    {'label': 'Framework registers dependency', 'note': 'InheritedElement._dependents.add(element)'},
    {'label': 'Theme widget rebuilt with new data', 'note': 'Parent triggers update with new ThemeData'},
    {'label': 'ProxyElement.update() called', 'note': 'updated(oldWidget) → notifyClients()'},
    {'label': 'All dependents marked dirty', 'note': 'Each dependent element.markNeedsBuild()'},
    {'label': 'Dependents rebuild next frame', 'note': 'Widgets read new theme data via Theme.of()'},
  ];

  for (var i = 0; i < depSteps.length; i++) {
    final step = depSteps[i];
    final stepColor = Color.lerp(jade800, mint300, i / (depSteps.length - 1))!;

    depCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: stepColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(6.0),
          border: Border(left: BorderSide(color: stepColor, width: 3.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${i + 1}. ${step['label']!}',
              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w600, color: jade900),
            ),
            Text(
              step['note']!,
              style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: jade700),
            ),
          ],
        ),
      ),
    );
  }

  print('Created dependency tracking with ${depSteps.length} steps');

  // ============================================================
  // SECTION 12: When ProxyElement Rebuilds
  // ============================================================
  print('=== Section 12: When ProxyElement Rebuilds ===');

  final rebuildScenarios = <Map<String, dynamic>>[
    {
      'trigger': 'Parent widget rebuilds',
      'detail': 'Parent provides new ProxyWidget with different child or data',
      'calls': 'update() → updated() → rebuild(force: true)',
      'icon': Icons.refresh,
      'color': jade700,
    },
    {
      'trigger': 'GlobalKey reattachment',
      'detail': 'Element moves in the tree via GlobalKey',
      'calls': 'Element lifecycle (deactivate → activate)',
      'icon': Icons.swap_horiz,
      'color': jade500,
    },
    {
      'trigger': 'Framework marks dirty',
      'detail': 'Rare — external framework operation forces rebuild',
      'calls': 'markNeedsBuild() → build()',
      'icon': Icons.warning_amber_rounded,
      'color': Colors.amber.shade800,
    },
  ];

  final rebuildCards = <Widget>[];

  for (final scenario in rebuildScenarios) {
    rebuildCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (scenario['color'] as Color).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (scenario['color'] as Color).withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              scenario['icon'] as IconData,
              size: 24.0,
              color: scenario['color'] as Color,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    scenario['trigger'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: jade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    scenario['detail'] as String,
                    style: TextStyle(fontSize: 11.0, color: jade700),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      scenario['calls'] as String,
                      style: TextStyle(fontSize: 9.5, fontFamily: 'monospace', color: jade800),
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

  print('Created ${rebuildScenarios.length} rebuild scenarios');

  // ============================================================
  // SECTION 13: Performance Characteristics
  // ============================================================
  print('=== Section 13: Performance ===');

  final perfCards = <Widget>[];

  perfCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: jade800,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed, size: 28.0, color: mint200),
              SizedBox(width: 10.0),
              Text(
                'Performance Advantages',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.0),
          Text(
            'ProxyElement is designed for minimal overhead. Since build() '
            'is a single field access (returning widget.child), there is '
            'no tree creation cost. The element acts as a zero-cost '
            'metadata layer in the element tree.',
            style: TextStyle(fontSize: 12.5, color: mint100, height: 1.5),
          ),
        ],
      ),
    ),
  );

  final perfPoints = <Map<String, String>>[
    {
      'point': 'Zero build cost',
      'detail': 'build() returns widget.child — one field access, no allocation',
    },
    {
      'point': 'Targeted notifications',
      'detail': 'Only registered dependents rebuild, not the entire subtree',
    },
    {
      'point': 'No render object',
      'detail': 'ProxyElements do not participate in the render tree — zero layout cost',
    },
    {
      'point': 'updateShouldNotify gate',
      'detail': 'InheritedElement skips notification when data has not actually changed',
    },
  ];

  for (final point in perfPoints) {
    perfCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: mint100,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.bolt, size: 18.0, color: jade600),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    point['point']!,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: jade900,
                    ),
                  ),
                  Text(
                    point['detail']!,
                    style: TextStyle(fontSize: 11.0, color: jade700, height: 1.3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${perfPoints.length} performance points');

  // ============================================================
  // SECTION 14: Real-World Usage Examples
  // ============================================================
  print('=== Section 14: Real-World Examples ===');

  final examples = <Map<String, dynamic>>[
    {
      'name': 'Theme.of(context)',
      'proxyWidget': 'InheritedTheme',
      'element': 'InheritedElement',
      'data': 'ThemeData (colors, fonts, shapes)',
      'icon': Icons.palette,
      'color': Colors.purple,
    },
    {
      'name': 'MediaQuery.of(context)',
      'proxyWidget': 'MediaQuery (InheritedWidget)',
      'element': 'InheritedElement',
      'data': 'MediaQueryData (size, padding, textScale)',
      'icon': Icons.phone_android,
      'color': Colors.blue,
    },
    {
      'name': 'Positioned inside Stack',
      'proxyWidget': 'Positioned (ParentDataWidget)',
      'element': 'ParentDataElement',
      'data': 'StackParentData (offsets)',
      'icon': Icons.layers,
      'color': Colors.orange,
    },
    {
      'name': 'Expanded inside Column',
      'proxyWidget': 'Expanded (ParentDataWidget)',
      'element': 'ParentDataElement',
      'data': 'FlexParentData (flex factor)',
      'icon': Icons.view_column,
      'color': Colors.teal,
    },
  ];

  final exampleCards = <Widget>[];

  for (final example in examples) {
    exampleCards.add(
      Container(
        width: 165.0,
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (example['color'] as Color).withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: (example['color'] as Color).withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Icon(example['icon'] as IconData, size: 28.0, color: example['color'] as Color),
            SizedBox(height: 8.0),
            Text(
              example['name'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: example['color'] as Color,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              example['proxyWidget'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              example['data'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9.0, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${examples.length} real-world examples');

  // ============================================================
  // SECTION 15: Integration Summary
  // ============================================================
  print('=== Section 15: Integration Summary ===');

  final summaryEntries = <Map<String, String>>[
    {'key': 'Class', 'value': 'abstract class ProxyElement extends ComponentElement'},
    {'key': 'Constructor', 'value': 'ProxyElement(ProxyWidget widget)'},
    {'key': 'build()', 'value': 'Returns (widget as ProxyWidget).child directly'},
    {'key': 'update()', 'value': 'Swaps widget, calls updated(), forces rebuild'},
    {'key': 'notifyClients()', 'value': 'Abstract — subclasses decide notification strategy'},
    {'key': 'Subclasses', 'value': 'InheritedElement (data sharing) and ParentDataElement (layout config)'},
    {'key': 'Render tree', 'value': 'No RenderObject — zero layout overhead'},
    {'key': 'Pattern', 'value': 'Proxy pattern: transparent layer adding metadata without modifying child'},
  ];

  final summaryRows = <Widget>[];

  for (var i = 0; i < summaryEntries.length; i++) {
    final entry = summaryEntries[i];
    summaryRows.add(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: i.isEven ? jade900.withValues(alpha: 0.04) : Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100.0,
              child: Text(
                entry['key']!,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: jade900,
                ),
              ),
            ),
            Expanded(
              child: Text(
                entry['value']!,
                style: TextStyle(fontSize: 11.5, color: jade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  print('Created ${summaryEntries.length} summary entries');
  print('ProxyElement Deep Demo complete');

  // ============================================================
  // BUILD FINAL LAYOUT
  // ============================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('ProxyElement Deep Demo'),
        backgroundColor: jade800,
        foregroundColor: Colors.white,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section 1: Overview
            ...overviewCards,

            // Section 2: build()
            ...buildCards,

            // Section 3: update()
            Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: mint50,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('update() — Notification Chain', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: jade900)),
                  SizedBox(height: 8.0),
                  ...updateCards,
                ],
              ),
            ),

            // Section 4: notifyClients
            ...notifyCards,

            // Section 5: Hierarchy
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('Element Class Hierarchy', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: jade900)),
                  ),
                  SizedBox(height: 8.0),
                  ...hierarchyWidgets,
                ],
              ),
            ),

            // Section 6: InheritedElement
            ...inheritedCards,

            // Section 7: ParentDataElement
            ...parentDataCards,

            // Section 8: Lifecycle
            Container(
              margin: EdgeInsets.all(12.0),
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: jade900.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: jade600.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Element Lifecycle', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: jade900)),
                  SizedBox(height: 8.0),
                  ...lifecycleWidgets,
                ],
              ),
            ),

            // Section 9: Three Trees
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('Widget → Element → Render Trees', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: jade900)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text('ProxyElement exists in element tree but NOT in render tree', style: TextStyle(fontSize: 11.0, color: jade600)),
                ),
                threeTreesRow,
              ],
            ),

            // Section 10: Proxy Pattern
            ...proxyPatternCards,

            // Section 11: Dependency Tracking
            ...depCards,

            // Section 12: Rebuild Scenarios
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text('When ProxyElement Rebuilds', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: jade900)),
                  ),
                  SizedBox(height: 8.0),
                  ...rebuildCards,
                ],
              ),
            ),

            // Section 13: Performance
            ...perfCards,

            // Section 14: Real-World
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text('Real-World Usage', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: jade900)),
                  SizedBox(height: 12.0),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    alignment: WrapAlignment.center,
                    children: exampleCards,
                  ),
                ],
              ),
            ),

            // Section 15: Summary
            Container(
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: jade600.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: jade800,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11.0),
                        topRight: Radius.circular(11.0),
                      ),
                    ),
                    child: Text('Quick Reference Summary', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  ...summaryRows,
                ],
              ),
            ),

            SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}
