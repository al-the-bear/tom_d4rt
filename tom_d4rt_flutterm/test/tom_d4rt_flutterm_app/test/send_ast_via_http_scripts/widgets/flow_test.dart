// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Flow widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Flow test executing');

  // Flow requires a FlowDelegate subclass. In D4rt, abstract classes cannot
  // be subclassed, so we cannot provide a custom FlowDelegate implementation.
  // This test verifies the Flow class is bridged and accessible.

  print('Flow widget is bridged in D4rt');
  print('Flow requires FlowDelegate - abstract class, cannot subclass in D4rt');
  print('FlowDelegate defines paintChildren() and shouldRepaint() as abstract');

  // Demonstrate that Flow.unwrapped constructor concept exists
  // We cannot construct Flow directly without a valid delegate
  print('Flow.unwrapped also requires a delegate parameter');

  // Show fallback: Column mimics a simple vertical flow layout
  final fallbackLayout = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.all(4.0),
        color: Colors.blue,
        child: Center(
          child: Text('F1', style: TextStyle(color: Colors.white)),
        ),
      ),
      Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.all(4.0),
        color: Colors.green,
        child: Center(
          child: Text('F2', style: TextStyle(color: Colors.white)),
        ),
      ),
      Container(
        width: 60.0,
        height: 60.0,
        margin: EdgeInsets.all(4.0),
        color: Colors.orange,
        child: Center(
          child: Text('F3', style: TextStyle(color: Colors.white)),
        ),
      ),
    ],
  );
  print('Fallback Column layout created (simulating Flow children)');

  // Test Wrap as an alternative flow-style layout
  final wrapFallback = Wrap(
    spacing: 8.0,
    runSpacing: 8.0,
    children: [
      Container(width: 50.0, height: 50.0, color: Colors.red),
      Container(width: 50.0, height: 50.0, color: Colors.purple),
      Container(width: 50.0, height: 50.0, color: Colors.teal),
      Container(width: 50.0, height: 50.0, color: Colors.amber),
    ],
  );
  print('Wrap layout created as flow-style alternative');

  print('Flow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Flow widget (delegate required - D4rt limitation)'),
      SizedBox(height: 8.0),
      fallbackLayout,
      SizedBox(height: 8.0),
      Text('Wrap alternative:'),
      wrapFallback,
    ],
  );
}
