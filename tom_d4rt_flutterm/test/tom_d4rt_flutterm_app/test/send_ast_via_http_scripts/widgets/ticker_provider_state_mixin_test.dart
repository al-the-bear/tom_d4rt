// D4rt test script: Tests TickerProviderStateMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TickerProviderStateMixin test executing');

  // TickerProviderStateMixin - Provides multiple Tickers for animations
  // Use when State needs multiple AnimationControllers
  
  print('TickerProviderStateMixin purpose:');
  print('- Provides multiple tickers for animations');
  print('- Manages ticker lifecycle automatically');
  print('- Tracks all created tickers');
  print('- Disposes tickers when state disposed');
  
  // Usage pattern
  print('\nUsage pattern:');
  print('class _MyState extends State<MyWidget>');
  print('    with TickerProviderStateMixin {');
  print('  late AnimationController _controller1;');
  print('  late AnimationController _controller2;');
  print('  @override initState() {');
  print('    _controller1 = AnimationController(vsync: this);');
  print('    _controller2 = AnimationController(vsync: this);');
  print('  }');
  print('}');
  
  // Comparison with Single variant
  print('\nSingle vs Multiple tickers:');
  print('- SingleTickerProviderStateMixin: One ticker only');
  print('- TickerProviderStateMixin: Multiple tickers');
  print('- Use Single when only one AnimationController');
  print('- Use Multiple when 2+ AnimationControllers');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('TickerProviderStateMixin is mixin on State');
  print('Implements TickerProvider interface');
  print('createTicker() returns new Ticker each call');
  
  // Use cases
  print('\nUse cases:');
  print('- Multiple concurrent animations');
  print('- Tab controller animations');
  print('- Complex animated widgets');
  print('- Staggered animations');

  print('\nTickerProviderStateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TickerProviderStateMixin Tests'),
      Text('Multiple tickers for animations'),
      Text('Auto-dispose on state dispose'),
      Text('For multiple AnimationControllers'),
    ],
  );
}
