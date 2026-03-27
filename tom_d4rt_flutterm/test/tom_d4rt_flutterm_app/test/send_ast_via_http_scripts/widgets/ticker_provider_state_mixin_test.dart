// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TickerProviderStateMixin from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Example widget using TickerProviderStateMixin
class TickerTestWidget extends StatefulWidget {
  const TickerTestWidget({super.key});
  
  @override
  State<TickerTestWidget> createState() => _TickerTestWidgetState();
}

class _TickerTestWidgetState extends State<TickerTestWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  
  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _controller2 = AnimationController(vsync: this, duration: Duration(seconds: 2));
  }
  
  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) => SizedBox();
}

dynamic build(BuildContext context) {
  print('TickerProviderStateMixin test executing');
  print('=' * 50);

  // Overview
  print('TickerProviderStateMixin overview:');
  print('  - Mixin for State classes');
  print('  - Implements TickerProvider');
  print('  - Supports MULTIPLE AnimationControllers');
  print('  - Auto-mutes tickers based on TickerMode');

  // Mixin declaration
  print('\nMixin declaration:');
  print('  mixin TickerProviderStateMixin<T extends StatefulWidget>');
  print('      on State<T> implements TickerProvider');

  // Compare with SingleTickerProviderStateMixin
  print('\nComparison with SingleTickerProviderStateMixin:');
  print('  TickerProviderStateMixin:');
  print('    - Multiple tickers');
  print('    - Uses Set<Ticker> internally');
  print('    - Slightly more overhead');
  print('  SingleTickerProviderStateMixin:');
  print('    - Single ticker only');
  print('    - Assert on second createTicker');
  print('    - More efficient');

  // createTicker method
  print('\ncreateTicker method:');
  print('  Ticker createTicker(TickerCallback onTick)');
  print('  - Creates and tracks new ticker');
  print('  - Sets muted based on TickerMode');
  print('  - Adds debug label in debug mode');

  // TickerMode integration
  print('\nTickerMode integration:');
  print('  - Listens to TickerMode.getValuesNotifier');
  print('  - Auto-mutes all tickers when disabled');
  print('  - Supports forceFrames property');
  print('  - Updates on activate()');

  // Lifecycle
  print('\nLifecycle methods:');
  print('  - activate(): Updates TickerMode notifier');
  print('  - dispose(): Validates no active tickers');

  // Error checking
  print('\nError checking in dispose:');
  print('  - Throws if any ticker still active');
  print('  - Must dispose AnimationControllers first');
  print('  - Clear error message in debug mode');

  // Usage
  print('\nUsage example:');
  print('  class _MyState extends State<MyWidget>');
  print('      with TickerProviderStateMixin {');
  print('    late AnimationController _c1, _c2;');
  print('    void initState() {');
  print('      _c1 = AnimationController(vsync: this, ...);');
  print('      _c2 = AnimationController(vsync: this, ...);');
  print('    }');
  print('  }');

  print('\n' + '=' * 50);
  print('TickerProviderStateMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TickerProviderStateMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin on State<T>'),
      Text('Implements: TickerProvider'),
      Text('Supports: Multiple tickers'),
    ],
  );
}
