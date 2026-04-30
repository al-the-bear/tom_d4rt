// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AnimationEagerListenerMixin from animation
// Deep Demo: Visual demonstration of eager listener mixin behavior
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimationEagerListenerMixin Deep Demo executing');

  // ============================================================
  // SECTION 1: Understanding Eager Listener Mixin
  // ============================================================
  print('=== Section 1: Eager Listener Mixin Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is AnimationEagerListenerMixin
  conceptCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blue.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.notifications_active, size: 48.0, color: Colors.blue),
          SizedBox(height: 12.0),
          Text(
            'AnimationEagerListenerMixin',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Immediately adds listeners when\nthe first listener is registered',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.blue.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Eager vs Lazy comparison
  conceptCards.add(
    Container(
      margin: EdgeInsets.all(12.0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.bolt, size: 32.0, color: Colors.orange),
                  Text(
                    'EAGER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              Text('vs', style: TextStyle(color: Colors.grey)),
              Column(
                children: [
                  Icon(Icons.hourglass_empty, size: 32.0, color: Colors.grey),
                  Text(
                    'LAZY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Eager: Connect immediately\nLazy: Connect when needed',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: AlwaysStoppedAnimation Demo
  // ============================================================
  print('=== Section 2: AlwaysStoppedAnimation (uses EagerListenerMixin) ===');

  // Create various AlwaysStoppedAnimation instances
  final animations = <Map<String, dynamic>>[];

  final anim0 = AlwaysStoppedAnimation<double>(0.0);
  animations.add({'value': 0.0, 'anim': anim0, 'label': 'Start'});

  final anim25 = AlwaysStoppedAnimation<double>(0.25);
  animations.add({'value': 0.25, 'anim': anim25, 'label': 'Quarter'});

  final anim50 = AlwaysStoppedAnimation<double>(0.5);
  animations.add({'value': 0.5, 'anim': anim50, 'label': 'Half'});

  final anim75 = AlwaysStoppedAnimation<double>(0.75);
  animations.add({'value': 0.75, 'anim': anim75, 'label': 'Three-Quarter'});

  final anim100 = AlwaysStoppedAnimation<double>(1.0);
  animations.add({'value': 1.0, 'anim': anim100, 'label': 'Complete'});

  final animationWidgets = <Widget>[];
  for (final entry in animations) {
    final value = entry['value'] as double;
    final label = entry['label'] as String;
    final anim = entry['anim'] as AlwaysStoppedAnimation<double>;

    print('AlwaysStoppedAnimation($value) - status: ${anim.status}');

    animationWidgets.add(
      Container(
        width: 100.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: value * 0.3 + 0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.green.withValues(alpha: value * 0.5 + 0.3),
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
            SizedBox(height: 8.0),
            // Progress indicator
            Container(
              height: 80.0,
              width: 12.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80.0 * value,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.green.shade700],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${animationWidgets.length} animation widgets');

  // ============================================================
  // SECTION 3: Listener Management Demonstration
  // ============================================================
  print('=== Section 3: Listener Management ===');

  // Track listener operations
  final listenerOps = <Map<String, dynamic>>[];

  final testAnim = AlwaysStoppedAnimation<double>(0.5);
  var listenerCallCount = 0;
  var statusListenerCallCount = 0;

  void listener() {
    listenerCallCount++;
  }

  void statusListener(AnimationStatus status) {
    statusListenerCallCount++;
  }

  // Operation 1: Initial state
  listenerOps.add({
    'op': 'Initial State',
    'listenerCount': listenerCallCount,
    'statusCount': statusListenerCallCount,
    'icon': Icons.play_circle_outline,
    'color': Colors.grey,
  });

  // Operation 2: Add listener
  testAnim.addListener(listener);
  listenerOps.add({
    'op': 'Add Listener',
    'listenerCount': listenerCallCount,
    'statusCount': statusListenerCallCount,
    'icon': Icons.add_circle,
    'color': Colors.green,
  });
  print('Added listener');

  // Operation 3: Add status listener
  testAnim.addStatusListener(statusListener);
  listenerOps.add({
    'op': 'Add Status Listener',
    'listenerCount': listenerCallCount,
    'statusCount': statusListenerCallCount,
    'icon': Icons.add_circle_outline,
    'color': Colors.blue,
  });
  print('Added status listener');

  // Operation 4: Remove listener
  testAnim.removeListener(listener);
  listenerOps.add({
    'op': 'Remove Listener',
    'listenerCount': listenerCallCount,
    'statusCount': statusListenerCallCount,
    'icon': Icons.remove_circle,
    'color': Colors.orange,
  });
  print('Removed listener');

  // Operation 5: Remove status listener
  testAnim.removeStatusListener(statusListener);
  listenerOps.add({
    'op': 'Remove Status Listener',
    'listenerCount': listenerCallCount,
    'statusCount': statusListenerCallCount,
    'icon': Icons.remove_circle_outline,
    'color': Colors.red,
  });
  print('Removed status listener');

  final listenerWidgets = <Widget>[];
  for (int i = 0; i < listenerOps.length; i++) {
    final op = listenerOps[i];
    listenerWidgets.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: (op['color'] as Color).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: (op['color'] as Color).withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: (op['color'] as Color).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: op['color'] as Color,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Icon(
              op['icon'] as IconData,
              color: op['color'] as Color,
              size: 24.0,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    op['op'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: op['color'] as Color,
                    ),
                  ),
                  Text(
                    'Listeners: ${op['listenerCount']} | Status: ${op['statusCount']}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey.shade600,
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
  print('Created ${listenerWidgets.length} listener operation widgets');

  // ============================================================
  // SECTION 4: Generic Type Support
  // ============================================================
  print('=== Section 4: Generic Type Support ===');

  // Demonstrate various types with AlwaysStoppedAnimation
  final typeExamples = <Map<String, dynamic>>[
    {
      'type': 'double',
      'anim': AlwaysStoppedAnimation<double>(0.75),
      'display': '0.75',
      'color': Colors.blue,
      'icon': Icons.functions,
    },
    {
      'type': 'int',
      'anim': AlwaysStoppedAnimation<int>(42),
      'display': '42',
      'color': Colors.green,
      'icon': Icons.tag,
    },
    {
      'type': 'String',
      'anim': AlwaysStoppedAnimation<String>('Hello'),
      'display': 'Hello',
      'color': Colors.purple,
      'icon': Icons.text_fields,
    },
    {
      'type': 'Color',
      'anim': AlwaysStoppedAnimation<Color>(Colors.red),
      'display': 'Red',
      'color': Colors.red,
      'icon': Icons.palette,
    },
    {
      'type': 'Offset',
      'anim': AlwaysStoppedAnimation<Offset>(Offset(10.0, 20.0)),
      'display': '(10, 20)',
      'color': Colors.orange,
      'icon': Icons.control_point,
    },
    {
      'type': 'Size',
      'anim': AlwaysStoppedAnimation<Size>(Size(100.0, 200.0)),
      'display': '100×200',
      'color': Colors.teal,
      'icon': Icons.aspect_ratio,
    },
  ];

  for (final ex in typeExamples) {
    print('AlwaysStoppedAnimation<${ex['type']}> value: ${ex['display']}');
  }

  final typeWidgets = <Widget>[];
  for (final ex in typeExamples) {
    final color = ex['color'] as Color;
    typeWidgets.add(
      Container(
        width: 110.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
        ),
        child: Column(
          children: [
            Icon(ex['icon'] as IconData, color: color, size: 28.0),
            SizedBox(height: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '<${ex['type']}>',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              ex['display'] as String,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${typeWidgets.length} type example widgets');

  // ============================================================
  // SECTION 5: Mixin Behavior Timeline
  // ============================================================
  print('=== Section 5: Mixin Behavior Timeline ===');

  final timelineSteps = [
    {
      'step': 'Create Animation',
      'desc': 'AlwaysStoppedAnimation created with value',
      'icon': Icons.create,
      'color': Colors.blue,
    },
    {
      'step': 'Eager Connection',
      'desc': 'Mixin immediately connects to value source',
      'icon': Icons.link,
      'color': Colors.green,
    },
    {
      'step': 'Add Listener',
      'desc': 'Listener registered without additional setup',
      'icon': Icons.add_alert,
      'color': Colors.orange,
    },
    {
      'step': 'Value Access',
      'desc': 'Value always available, status always dismissed',
      'icon': Icons.check_circle,
      'color': Colors.purple,
    },
  ];

  final timelineWidgets = <Widget>[];
  for (int i = 0; i < timelineSteps.length; i++) {
    final step = timelineSteps[i];
    final color = step['color'] as Color;
    final isLast = i == timelineSteps.length - 1;

    timelineWidgets.add(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              if (!isLast)
                Container(
                  width: 3.0,
                  height: 40.0,
                  color: color.withValues(alpha: 0.5),
                ),
            ],
          ),
          SizedBox(width: 16.0),
          // Content
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 16.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step['step'] as String,
                    style: TextStyle(fontWeight: FontWeight.bold, color: color),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    step['desc'] as String,
                    style: TextStyle(
                      fontSize: 12.0,
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
  // SECTION 6: Code Examples
  // ============================================================
  print('=== Section 6: Code Examples ===');

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
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
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
            '// Create with eager listener mixin\n'
            'final animation = AlwaysStoppedAnimation<double>(0.5);\n'
            '\n'
            '// Add listeners - immediately active\n'
            'animation.addListener(() {\n'
            '  print("Value: \${animation.value}");\n'
            '});\n'
            '\n'
            '// Access value directly\n'
            'print(animation.value);  // 0.5\n'
            'print(animation.status); // dismissed',
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
            '// Generic type support\n'
            'AlwaysStoppedAnimation<Color>(Colors.blue);\n'
            'AlwaysStoppedAnimation<Offset>(Offset(10, 20));\n'
            'AlwaysStoppedAnimation<String>("Hello");',
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
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.bolt,
          'Immediate Connection',
          'Listeners active as soon as registered',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.extension,
          'Generic Support',
          'Works with any type: double, Color, Offset, etc.',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.lock,
          'Constant Value',
          'AlwaysStoppedAnimation never changes',
          Colors.orange,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.memory,
          'Efficient',
          'No disposal needed for stopped animations',
          Colors.purple,
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('AnimationEagerListenerMixin Deep Demo completed successfully');

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
              colors: [Colors.teal, Colors.cyan],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(Icons.notifications_active, size: 56.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'AnimationEagerListenerMixin',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Immediate Listener Registration',
                style: TextStyle(fontSize: 14.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1: Concepts
        Text(
          '1. Understanding Eager Listeners',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: conceptCards,
        ),
        SizedBox(height: 32.0),

        // Section 2: Animation Values
        Text(
          '2. AlwaysStoppedAnimation Values',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: animationWidgets),
        SizedBox(height: 32.0),

        // Section 3: Listener Operations
        Text(
          '3. Listener Operations',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        ...listenerWidgets,
        SizedBox(height: 32.0),

        // Section 4: Generic Types
        Text(
          '4. Generic Type Support',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(alignment: WrapAlignment.center, children: typeWidgets),
        SizedBox(height: 32.0),

        // Section 5: Timeline
        Text(
          '5. Mixin Behavior Timeline',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: timelineWidgets),
        ),
        SizedBox(height: 32.0),

        // Section 6: Code Examples
        Text(
          '6. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamples,
        SizedBox(height: 32.0),

        // Section 7: Summary
        Text(
          '7. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
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
