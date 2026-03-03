// D4rt test script: Tests D4rtSingleChildLayoutDelegate proxy with CustomSingleChildLayout widget
// Phase 4: Proxy class generation for abstract delegates (GEN-083)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('D4rtSingleChildLayoutDelegate proxy test executing');

  // ========== BASIC SINGLE-CHILD LAYOUT ==========
  print('--- D4rtSingleChildLayoutDelegate Basic ---');

  // Create a delegate that positions a single child
  final basicDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => false,
  );
  print('D4rtSingleChildLayoutDelegate created: ${basicDelegate.runtimeType}');
  print(
    '  is SingleChildLayoutDelegate: ${basicDelegate is SingleChildLayoutDelegate}',
  );

  // Use in CustomSingleChildLayout widget
  final widget1 = CustomSingleChildLayout(
    delegate: basicDelegate,
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.blue,
      child: Center(child: Text('Centered')),
    ),
  );
  print('CustomSingleChildLayout with basic delegate created');

  // ========== OFFSET LAYOUT ==========
  print('--- Offset Layout ---');

  final offsetDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => false,
  );
  print('Offset delegate created');

  final widget2 = CustomSingleChildLayout(
    delegate: offsetDelegate,
    child: Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Center(child: Text('Offset')),
    ),
  );
  print('CustomSingleChildLayout with offset delegate created');

  // ========== CONSTRAINED LAYOUT ==========
  print('--- Constrained Layout ---');

  final constrainedDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => false,
  );
  print('Constrained delegate created');

  final widget3 = CustomSingleChildLayout(
    delegate: constrainedDelegate,
    child: Container(
      color: Colors.green,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Constrained child with padding'),
      ),
    ),
  );
  print('CustomSingleChildLayout with constrained delegate created');

  // ========== DYNAMIC RELAYOUT ==========
  print('--- shouldRelayout Logic ---');

  final dynamicDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => true,
  );
  print('Dynamic delegate (always relayouts) created');

  final widget4 = CustomSingleChildLayout(
    delegate: dynamicDelegate,
    child: Container(
      width: 120.0,
      height: 60.0,
      color: Colors.purple,
      child: Center(
        child: Text('Dynamic', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('CustomSingleChildLayout with dynamic delegate created');

  // ========== WITH KEY ==========
  print('--- CustomSingleChildLayout with Key ---');

  final widget5 = CustomSingleChildLayout(
    key: ValueKey('proxy-single-layout-1'),
    delegate: basicDelegate,
    child: Container(
      width: 90.0,
      height: 90.0,
      color: Colors.teal,
      child: Center(child: Text('Keyed')),
    ),
  );
  print('CustomSingleChildLayout with ValueKey created');

  // ========== NESTED SINGLE-CHILD LAYOUTS ==========
  print('--- Nested Layouts ---');

  final outerDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => false,
  );
  final innerDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => false,
  );

  final widget6 = CustomSingleChildLayout(
    delegate: outerDelegate,
    child: CustomSingleChildLayout(
      delegate: innerDelegate,
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          shape: BoxShape.circle,
        ),
        child: Center(child: Text('Inner')),
      ),
    ),
  );
  print('Nested CustomSingleChildLayout created (outer + inner)');

  // ========== WITH DECORATION ==========
  print('--- Decorated Child ---');

  final decoratedDelegate = D4rtSingleChildLayoutDelegate(
    onShouldRelayout: (SingleChildLayoutDelegate oldDelegate) => false,
  );

  final widget7 = CustomSingleChildLayout(
    delegate: decoratedDelegate,
    child: Container(
      width: 150.0,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Decorated',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
  print('CustomSingleChildLayout with decorated child created');

  print('D4rtSingleChildLayoutDelegate proxy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('D4rtSingleChildLayoutDelegate Proxy Tests'),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, height: 120.0, child: widget1),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, height: 100.0, child: widget2),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, height: 80.0, child: widget3),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, height: 70.0, child: widget4),
      SizedBox(height: 8.0),
      SizedBox(width: 180.0, height: 100.0, child: widget6),
      SizedBox(height: 8.0),
      SizedBox(width: 200.0, height: 100.0, child: widget7),
    ],
  );
}
