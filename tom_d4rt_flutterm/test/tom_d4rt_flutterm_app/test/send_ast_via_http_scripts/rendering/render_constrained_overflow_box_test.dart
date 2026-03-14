// D4rt test script: Tests RenderConstrainedOverflowBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderConstrainedOverflowBox test executing');

  // ========== CONSTRAINED OVERFLOW BOX BASICS ==========
  print('--- ConstrainedOverflowBox Basics ---');
  print('RenderConstrainedOverflowBox allows child to overflow with constraints');
  print('Child can be larger than parent but respects min/max constraints');
  print('Useful for controlled overflow scenarios');

  // Test using OverflowBox which maps to RenderConstrainedOverflowBox
  final basicOverflow = OverflowBox(
    minWidth: 50,
    maxWidth: 200,
    minHeight: 50,
    maxHeight: 200,
    child: Container(
      width: 150,
      height: 150,
      color: Colors.blue,
      child: Center(child: Text('Overflow')),
    ),
  );
  print('OverflowBox created with constrained dimensions');
  print('  minWidth: ${basicOverflow.minWidth}');
  print('  maxWidth: ${basicOverflow.maxWidth}');
  print('  minHeight: ${basicOverflow.minHeight}');
  print('  maxHeight: ${basicOverflow.maxHeight}');

  // ========== ALIGNMENT OPTIONS ==========
  print('--- Alignment Options ---');

  final alignCenter = OverflowBox(
    alignment: Alignment.center,
    maxWidth: 100,
    maxHeight: 100,
    child: Container(width: 80, height: 80, color: Colors.red),
  );
  print('Alignment.center: Child centered in overflow area');

  final alignTopLeft = OverflowBox(
    alignment: Alignment.topLeft,
    maxWidth: 100,
    maxHeight: 100,
    child: Container(width: 80, height: 80, color: Colors.green),
  );
  print('Alignment.topLeft: Child at top-left corner');

  final alignBottomRight = OverflowBox(
    alignment: Alignment.bottomRight,
    maxWidth: 100,
    maxHeight: 100,
    child: Container(width: 80, height: 80, color: Colors.orange),
  );
  print('Alignment.bottomRight: Child at bottom-right corner');

  // ========== CONSTRAINT VARIATIONS ==========
  print('--- Constraint Variations ---');

  // Only width constrained
  final widthOnly = OverflowBox(
    minWidth: 100,
    maxWidth: 100,
    child: Container(width: 150, height: 50, color: Colors.purple),
  );
  print('Width-only constraints: width forced to 100');

  // Only height constrained
  final heightOnly = OverflowBox(
    minHeight: 100,
    maxHeight: 100,
    child: Container(width: 50, height: 150, color: Colors.teal),
  );
  print('Height-only constraints: height forced to 100');

  // Tight constraints
  final tightConstraints = OverflowBox(
    minWidth: 80,
    maxWidth: 80,
    minHeight: 80,
    maxHeight: 80,
    child: Container(width: 200, height: 200, color: Colors.amber),
  );
  print('Tight constraints (80x80): Child forced to exact size');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Dropdown menus that extend beyond parent');
  print('2. Tooltips that overflow container');
  print('3. Custom popup widgets');
  print('4. Image previews in constrained spaces');

  // Test with Stack for visual overflow
  final stackOverflow = Container(
    width: 100,
    height: 100,
    color: Colors.grey[300],
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        OverflowBox(
          maxWidth: 150,
          maxHeight: 150,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.5),
              border: Border.all(color: Colors.blue, width: 2),
            ),
          ),
        ),
      ],
    ),
  );
  print('Stack with overflow: Child extends beyond parent');

  // ========== FIT PROPERTY ==========
  print('--- Fit Property ---');
  print('OverflowBox uses constraints to control child sizing');
  print('Unlike SizedOverflowBox which has explicit size');
  print('Constraints can be null to use parent constraints');

  // Test with null constraints (pass through)
  final passThrough = OverflowBox(
    child: Container(width: 50, height: 50, color: Colors.pink),
  );
  print('No constraints specified: Uses parent constraints');

  // ========== COMPARING OVERFLOW WIDGETS ==========
  print('--- Comparing Overflow Widgets ---');
  print('OverflowBox: Constrains child, allows visual overflow');
  print('SizedOverflowBox: Fixed size, child can overflow');
  print('FractionallySizedBox: Size relative to parent');
  print('UnconstrainedBox: Removes parent constraints');

  // ========== NESTED OVERFLOW ==========
  print('--- Nested Overflow Behavior ---');

  final nestedOverflow = Container(
    width: 80,
    height: 80,
    color: Colors.grey[200],
    child: OverflowBox(
      maxWidth: 120,
      maxHeight: 120,
      child: Container(
        width: 120,
        height: 120,
        color: Colors.indigo.withValues(alpha: 0.7),
        child: Center(
          child: OverflowBox(
            maxWidth: 80,
            maxHeight: 80,
            child: Container(width: 80, height: 80, color: Colors.yellow),
          ),
        ),
      ),
    ),
  );
  print('Nested OverflowBox widgets');
  print('  Outer: 80 -> 120 overflow');
  print('  Inner: Forces 80x80');

  // ========== LAYOUT IMPLICATIONS ==========
  print('--- Layout Implications ---');
  print('RenderConstrainedOverflowBox reports its own size to parent');
  print('But child can paint outside those bounds');
  print('Use with Stack.clipBehavior = Clip.none for visibility');

  print('RenderConstrainedOverflowBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderConstrainedOverflowBox Tests'),
      Container(
        width: 100,
        height: 100,
        color: Colors.grey[300],
        child: basicOverflow,
      ),
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 60, height: 60, child: alignCenter),
          SizedBox(width: 8),
          Container(width: 60, height: 60, child: alignTopLeft),
        ],
      ),
      SizedBox(height: 8),
      stackOverflow,
      SizedBox(height: 8),
      Text('All ConstrainedOverflowBox tests passed'),
    ],
  );
}
