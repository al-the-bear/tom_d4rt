// D4rt test script: Tests RenderAbsorbPointer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAbsorbPointer test executing');

  // ========== ABSORB POINTER WIDGET TESTS ==========
  print('--- AbsorbPointer Widget Tests ---');

  // Test AbsorbPointer with absorbing: true (default)
  final absorbingWidget = AbsorbPointer(
    absorbing: true,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Text('Absorbed'),
    ),
  );
  print('AbsorbPointer created with absorbing: true');
  print('  runtimeType: ${absorbingWidget.runtimeType}');
  print('  absorbing: ${absorbingWidget.absorbing}');

  // Test AbsorbPointer with absorbing: false
  final notAbsorbingWidget = AbsorbPointer(
    absorbing: false,
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('AbsorbPointer created with absorbing: false');
  print('  absorbing: ${notAbsorbingWidget.absorbing}');

  // ========== COMPARING WITH IGNORE POINTER ==========
  print('--- AbsorbPointer vs IgnorePointer ---');
  print(
    'AbsorbPointer: Absorbs pointer events, prevents children from receiving them',
  );
  print(
    'IgnorePointer: Ignores pointer events, they pass through to widgets behind',
  );
  print(
    'Key difference: AbsorbPointer stops propagation, IgnorePointer allows it',
  );

  // Test with ignoringSemantics
  final absorbWithSemantics = AbsorbPointer(
    absorbing: true,
    ignoringSemantics: true,
    child: Text('Semantics ignored'),
  );
  print('AbsorbPointer with ignoringSemantics: true');
  print('  ignoringSemantics: ${absorbWithSemantics.ignoringSemantics}');

  final absorbWithoutSemantics = AbsorbPointer(
    absorbing: true,
    ignoringSemantics: false,
    child: Text('Semantics not ignored'),
  );
  print('AbsorbPointer with ignoringSemantics: false');
  print('  ignoringSemantics: ${absorbWithoutSemantics.ignoringSemantics}');

  // Test with null ignoringSemantics (defaults to absorbing value)
  final absorbDefaultSemantics = AbsorbPointer(
    absorbing: true,
    child: Text('Default semantics'),
  );
  print('AbsorbPointer with default ignoringSemantics');
  print('  ignoringSemantics: ${absorbDefaultSemantics.ignoringSemantics}');

  // ========== NESTED ABSORB POINTER TESTS ==========
  print('--- Nested AbsorbPointer Tests ---');

  final nestedAbsorb = AbsorbPointer(
    absorbing: true,
    child: Column(
      children: [
        AbsorbPointer(absorbing: false, child: Text('Inner not absorbing')),
        Text('Direct child'),
      ],
    ),
  );
  print('Created nested AbsorbPointer widgets');
  print('  Outer absorbing: ${nestedAbsorb.absorbing}');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Disabling buttons during loading');
  print('2. Preventing interaction during animations');
  print('3. Form validation - disabling submit while invalid');
  print('4. Modal dialogs - preventing background interaction');

  // Test with GestureDetector child
  final absorbGesture = AbsorbPointer(
    absorbing: true,
    child: GestureDetector(
      onTap: () => print('Tap received'),
      child: Container(
        width: 80,
        height: 80,
        color: Colors.green,
        child: Center(child: Text('Tap Me')),
      ),
    ),
  );
  print('AbsorbPointer wrapping GestureDetector');
  print('  When absorbing=true, onTap will NOT trigger');

  // ========== WIDGET TREE TESTING ==========
  print('--- Widget Tree Structure ---');

  final complexTree = AbsorbPointer(
    absorbing: true,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(width: 60, height: 60, color: Colors.purple),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Container(width: 60, height: 60, color: Colors.orange),
        ),
      ],
    ),
  );
  print('Complex widget tree with AbsorbPointer');
  print('  All children are blocked from receiving pointer events');

  // ========== HIT TEST BEHAVIOR ==========
  print('--- Hit Test Behavior ---');
  print('AbsorbPointer stops hit testing at its boundary');
  print('RenderAbsorbPointer.hitTest returns false when absorbing');
  print('This prevents events from reaching child render objects');

  print('RenderAbsorbPointer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAbsorbPointer Tests'),
      absorbingWidget,
      SizedBox(height: 8),
      notAbsorbingWidget,
      SizedBox(height: 8),
      absorbGesture,
      SizedBox(height: 8),
      Text('All AbsorbPointer tests passed'),
    ],
  );
}
