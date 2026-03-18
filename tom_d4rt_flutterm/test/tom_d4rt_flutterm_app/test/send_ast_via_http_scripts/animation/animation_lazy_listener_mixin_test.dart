// D4rt test script: Tests AnimationLazyListenerMixin from animation
// Deep Demo: Visual demonstration of lazy listener mixin deferred registration
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationLazyListenerMixin Deep Demo executing');

  // ============================================================
  // SECTION 1: Understanding Lazy Listener Mixin
  // ============================================================
  print('=== Section 1: Lazy Listener Mixin Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is Lazy Listener
  conceptCards.add(
    Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.hourglass_empty, size: 48.0, color: Colors.orange),
          SizedBox(height: 12.0),
          Text(
            'Lazy Listener',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Defers connection until\na listener is actually added',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Benefits
  conceptCards.add(
    Container(
      width: 160.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade50, Colors.teal.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.green.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.battery_saver, size: 48.0, color: Colors.green),
          SizedBox(height: 12.0),
          Text(
            'Memory Efficient',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'No resources used until\nactually needed',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.green.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Eager vs Lazy Comparison
  // ============================================================
  print('=== Section 2: Eager vs Lazy Comparison ===');

  final comparisonWidget = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade200],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade400, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Mixin Comparison',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Eager column
            Container(
              width: 140.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.blue.shade300, width: 1.5),
              ),
              child: Column(
                children: [
                  Icon(Icons.bolt, size: 32.0, color: Colors.blue),
                  SizedBox(height: 8.0),
                  Text(
                    'EAGER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildCompareRow(
                    'Created',
                    Icons.play_circle_filled,
                    Colors.green,
                  ),
                  SizedBox(height: 4.0),
                  _buildCompareRow(
                    'Connected',
                    Icons.check_circle,
                    Colors.green,
                  ),
                  SizedBox(height: 4.0),
                  _buildCompareRow(
                    'Listening',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ],
              ),
            ),
            // Arrow
            Column(
              children: [
                Icon(Icons.compare_arrows, size: 32.0, color: Colors.grey),
                Text('vs', style: TextStyle(color: Colors.grey)),
              ],
            ),
            // Lazy column
            Container(
              width: 140.0,
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.orange.shade300, width: 1.5),
              ),
              child: Column(
                children: [
                  Icon(Icons.hourglass_empty, size: 32.0, color: Colors.orange),
                  SizedBox(height: 8.0),
                  Text(
                    'LAZY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade900,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildCompareRow(
                    'Created',
                    Icons.play_circle_filled,
                    Colors.green,
                  ),
                  SizedBox(height: 4.0),
                  _buildCompareRow(
                    'Connected',
                    Icons.pause_circle_outline,
                    Colors.grey,
                  ),
                  SizedBox(height: 4.0),
                  _buildCompareRow(
                    'Listening',
                    Icons.pause_circle_outline,
                    Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.amber.shade800,
                size: 20.0,
              ),
              SizedBox(width: 8.0),
              Text(
                'Lazy connects only when first listener is added',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created comparison widget');

  // ============================================================
  // SECTION 3: ProxyAnimation Demo
  // ============================================================
  print('=== Section 3: ProxyAnimation (uses LazyListenerMixin) ===');

  // Create source animations
  final source1 = AlwaysStoppedAnimation<double>(0.0);
  final source2 = AlwaysStoppedAnimation<double>(0.25);
  final source3 = AlwaysStoppedAnimation<double>(0.5);
  final source4 = AlwaysStoppedAnimation<double>(0.75);
  final source5 = AlwaysStoppedAnimation<double>(1.0);

  final proxyAnimations = <Map<String, dynamic>>[
    {'source': source1, 'label': '0%', 'value': 0.0},
    {'source': source2, 'label': '25%', 'value': 0.25},
    {'source': source3, 'label': '50%', 'value': 0.5},
    {'source': source4, 'label': '75%', 'value': 0.75},
    {'source': source5, 'label': '100%', 'value': 1.0},
  ];

  final proxyWidgets = <Widget>[];
  for (final entry in proxyAnimations) {
    final proxy = ProxyAnimation(entry['source'] as Animation<double>);
    final value = entry['value'] as double;
    final label = entry['label'] as String;

    print('ProxyAnimation wrapping $label: value=${proxy.value}');

    proxyWidgets.add(
      Container(
        width: 70.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withValues(alpha: 0.1 + value * 0.3),
              Colors.indigo.withValues(alpha: 0.1 + value * 0.3),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.purple.withValues(alpha: 0.3 + value * 0.4),
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            // Progress ring
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    Colors.purple,
                    Colors.purple.withValues(alpha: value),
                    Colors.grey.shade300,
                  ],
                  stops: [0.0, value, value + 0.01],
                ),
              ),
              child: Center(
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      '${(value * 100).toInt()}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${proxyWidgets.length} proxy animation widgets');

  // ============================================================
  // SECTION 4: Parent Switching Demo
  // ============================================================
  print('=== Section 4: Parent Switching ===');

  final proxy = ProxyAnimation(source1);
  final parentSwitchSteps = <Map<String, dynamic>>[];

  parentSwitchSteps.add({
    'step': 'Initial',
    'parent': 'source1 (0.0)',
    'value': proxy.value,
    'color': Colors.blue,
  });

  proxy.parent = source3;
  parentSwitchSteps.add({
    'step': 'Switch to 50%',
    'parent': 'source3 (0.5)',
    'value': proxy.value,
    'color': Colors.green,
  });

  proxy.parent = source5;
  parentSwitchSteps.add({
    'step': 'Switch to 100%',
    'parent': 'source5 (1.0)',
    'value': proxy.value,
    'color': Colors.purple,
  });

  proxy.parent = source2;
  parentSwitchSteps.add({
    'step': 'Switch to 25%',
    'parent': 'source2 (0.25)',
    'value': proxy.value,
    'color': Colors.orange,
  });

  final parentSwitchWidgets = <Widget>[];
  for (int i = 0; i < parentSwitchSteps.length; i++) {
    final step = parentSwitchSteps[i];
    final color = step['color'] as Color;
    final isLast = i == parentSwitchSteps.length - 1;

    print('Parent switch: ${step['step']} -> value: ${step['value']}');

    parentSwitchWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
        child: Row(
          children: [
            // Step indicator
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            // Content
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: color.withValues(alpha: 0.3),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['step'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        Text(
                          'Parent: ${step['parent']}',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Text(
                        'Value: ${step['value']}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!isLast) {
      parentSwitchWidgets.add(
        Container(
          margin: EdgeInsets.only(left: 31.0),
          height: 20.0,
          width: 2.0,
          color: color.withValues(alpha: 0.3),
        ),
      );
    }
  }
  print('Created ${parentSwitchWidgets.length} parent switch widgets');

  // ============================================================
  // SECTION 5: Null Parent Behavior
  // ============================================================
  print('=== Section 5: Null Parent Behavior ===');

  final emptyProxy = ProxyAnimation();
  print(
    'Empty ProxyAnimation: value=${emptyProxy.value}, status=${emptyProxy.status}',
  );

  final nullBehaviorWidget = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade200, width: 2.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.block, size: 32.0, color: Colors.red.shade400),
            SizedBox(width: 12.0),
            Text(
              'Null Parent Behavior',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPropertyCard('value', '${emptyProxy.value}', Colors.blue),
            _buildPropertyCard('status', emptyProxy.status.name, Colors.orange),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ProxyAnimation with null parent defaults to 0.0 and dismissed status',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.red.shade900),
          ),
        ),
      ],
    ),
  );
  print('Created null behavior widget');

  // ============================================================
  // SECTION 6: Listener Registration Timeline
  // ============================================================
  print('=== Section 6: Listener Registration Timeline ===');

  final timelineSteps = [
    {
      'title': 'ProxyAnimation Created',
      'desc': 'Animation exists but NOT connected to parent',
      'icon': Icons.add_box,
      'color': Colors.blue,
      'connected': false,
    },
    {
      'title': 'addListener() Called',
      'desc': 'Lazy mixin triggers didRegisterListener()',
      'icon': Icons.notifications_active,
      'color': Colors.green,
      'connected': true,
    },
    {
      'title': 'Connection Established',
      'desc': 'Now listening to parent animation',
      'icon': Icons.link,
      'color': Colors.purple,
      'connected': true,
    },
    {
      'title': 'removeListener() Called',
      'desc': 'Last listener removed, triggers didUnregisterListener()',
      'icon': Icons.notifications_off,
      'color': Colors.orange,
      'connected': false,
    },
    {
      'title': 'Connection Closed',
      'desc': 'Resources released, no longer listening',
      'icon': Icons.link_off,
      'color': Colors.red,
      'connected': false,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < timelineSteps.length; i++) {
    final step = timelineSteps[i];
    final color = step['color'] as Color;
    final connected = step['connected'] as bool;
    final isLast = i == timelineSteps.length - 1;

    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 22.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, (timelineSteps[i + 1]['color'] as Color)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          // Content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 12.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        step['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: connected ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              connected ? Icons.wifi : Icons.wifi_off,
                              color: Colors.white,
                              size: 12.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              connected ? 'ON' : 'OFF',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  print('Created ${timelineWidgets.length} timeline widgets');

  // ============================================================
  // SECTION 7: Code Examples
  // ============================================================
  print('=== Section 7: Code Examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.orange.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'ProxyAnimation Patterns',
              style: TextStyle(
                color: Colors.orange.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Create proxy with lazy connection\n'
            'final source = controller.view;\n'
            'final proxy = ProxyAnimation(source);\n'
            '\n'
            '// Lazy: Not connected yet!\n'
            'print(proxy.value); // Still works\n'
            '\n'
            '// Adding listener triggers connection\n'
            'proxy.addListener(() {\n'
            '  // Now connected to parent\n'
            '});',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Switch parent dynamically\n'
            'proxy.parent = newAnimation;\n'
            '\n'
            '// Or set to null\n'
            'proxy.parent = null;\n'
            'print(proxy.value); // 0.0',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples widget');

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryWidget = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade100, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryRow(
          Icons.hourglass_empty,
          'Deferred Connection',
          'Resources allocated only when needed',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryRow(
          Icons.swap_horiz,
          'Dynamic Parents',
          'Can switch parent animation at runtime',
          Colors.purple,
        ),
        SizedBox(height: 8.0),
        _buildSummaryRow(
          Icons.battery_saver,
          'Memory Efficient',
          'No overhead until listeners are added',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryRow(
          Icons.block,
          'Null Safe',
          'Handles null parent gracefully (value=0)',
          Colors.red,
        ),
      ],
    ),
  );
  print('Created summary widget');

  print('AnimationLazyListenerMixin Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.hourglass_empty, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'AnimationLazyListenerMixin',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Deferred Connection Pattern',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concepts
        Text(
          '1. Understanding Lazy Listeners',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: conceptCards,
        ),
        SizedBox(height: 32.0),

        // Section 2: Comparison
        Text(
          '2. Eager vs Lazy Comparison',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        comparisonWidget,
        SizedBox(height: 32.0),

        // Section 3: ProxyAnimation
        Text(
          '3. ProxyAnimation Values',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: proxyWidgets),
        SizedBox(height: 32.0),

        // Section 4: Parent Switching
        Text(
          '4. Dynamic Parent Switching',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...parentSwitchWidgets,
        SizedBox(height: 32.0),

        // Section 5: Null Parent
        Text(
          '5. Null Parent Behavior',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        nullBehaviorWidget,
        SizedBox(height: 32.0),

        // Section 6: Timeline
        Text(
          '6. Registration Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: timelineWidgets),
        ),
        SizedBox(height: 32.0),

        // Section 7: Code
        Text(
          '7. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 8: Summary
        Text(
          '8. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryWidget,
      ],
    ),
  );
}

// Helper: Build compare row
Widget _buildCompareRow(String label, IconData icon, Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(icon, color: color, size: 16.0),
      SizedBox(width: 4.0),
      Text(label, style: TextStyle(fontSize: 10.0)),
    ],
  );
}

// Helper: Build property card
Widget _buildPropertyCard(String label, String value, Color color) {
  return Container(
    width: 100.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 4.0),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: color,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build summary row
Widget _buildSummaryRow(IconData icon, String title, String desc, Color color) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
