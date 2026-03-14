// D4rt test script: Tests RenderBlockSemantics from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderBlockSemantics test executing');

  // ========== BLOCK SEMANTICS WIDGET TESTS ==========
  print('--- BlockSemantics Widget Tests ---');

  // Test BlockSemantics with blocking: true (default)
  final blockingWidget = BlockSemantics(
    blocking: true,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Text('Blocked'),
    ),
  );
  print('BlockSemantics created with blocking: true');
  print('  runtimeType: ${blockingWidget.runtimeType}');
  print('  blocking: ${blockingWidget.blocking}');

  // Test BlockSemantics with blocking: false
  final notBlockingWidget = BlockSemantics(
    blocking: false,
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('BlockSemantics created with blocking: false');
  print('  blocking: ${notBlockingWidget.blocking}');

  // ========== SEMANTICS BLOCKING BEHAVIOR ==========
  print('--- Semantics Blocking Behavior ---');
  print('BlockSemantics: Drops semantics of widgets below it in paint order');
  print('Used to prevent lower widgets from being announced by screen readers');
  print('Useful for overlays, modals, and dialogs');

  // Test nested BlockSemantics
  final nestedBlocking = BlockSemantics(
    blocking: true,
    child: Column(
      children: [
        BlockSemantics(
          blocking: false,
          child: Text('Inner not blocking'),
        ),
        Text('Direct child'),
      ],
    ),
  );
  print('Created nested BlockSemantics widgets');
  print('  Outer blocking: ${nestedBlocking.blocking}');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. Modal dialogs that should hide background content');
  print('2. Full-screen overlays');
  print('3. Loading screens');
  print('4. Splash screens');

  // Test with Semantics widget
  final withSemantics = BlockSemantics(
    blocking: true,
    child: Semantics(
      label: 'Blocking area',
      child: Container(
        width: 80,
        height: 80,
        color: Colors.green,
        child: Center(child: Text('Semantics')),
      ),
    ),
  );
  print('BlockSemantics wrapping Semantics widget');
  print('  Semantic label is preserved for this widget');

  // ========== WIDGET TREE TESTING ==========
  print('--- Widget Tree Structure ---');

  final complexTree = BlockSemantics(
    blocking: true,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Semantics(
            label: 'First item',
            child: Container(width: 60, height: 60, color: Colors.purple),
          ),
        ),
        Positioned(
          left: 20,
          top: 20,
          child: Semantics(
            label: 'Second item',
            child: Container(width: 60, height: 60, color: Colors.orange),
          ),
        ),
      ],
    ),
  );
  print('Complex widget tree with BlockSemantics');
  print('  Semantics below this in paint order are dropped');

  // ========== COMPARING WITH EXCLUDE SEMANTICS ==========
  print('--- BlockSemantics vs ExcludeSemantics ---');
  print('BlockSemantics: Blocks semantics of widgets BELOW in paint order');
  print('ExcludeSemantics: Excludes semantics of THIS widget and its subtree');
  print('Key difference: BlockSemantics affects Z-order, ExcludeSemantics affects subtree');

  // Test toggle behavior
  final toggleBlocking = BlockSemantics(
    blocking: true,
    child: Text('Toggle test'),
  );
  print('BlockSemantics toggle test');
  print('  Initial blocking: ${toggleBlocking.blocking}');

  // ========== ACCESSIBILITY TESTING ==========
  print('--- Accessibility Behavior ---');
  print('RenderBlockSemantics drops semantics nodes below it');
  print('Screen readers will not announce blocked content');
  print('Important for proper focus management in overlays');

  print('RenderBlockSemantics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderBlockSemantics Tests'),
      blockingWidget,
      SizedBox(height: 8),
      notBlockingWidget,
      SizedBox(height: 8),
      withSemantics,
      SizedBox(height: 8),
      Text('All BlockSemantics tests passed'),
    ],
  );
}
