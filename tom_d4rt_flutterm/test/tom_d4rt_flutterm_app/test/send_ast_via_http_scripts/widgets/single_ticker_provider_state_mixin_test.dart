// ignore_for_file: avoid_print
// D4rt test script: Tests SingleTickerProviderStateMixin from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SingleTickerProviderStateMixin test executing');

  // SingleTickerProviderStateMixin - Provides a single Ticker for animation
  // Use when State needs exactly one AnimationController
  
  print('SingleTickerProviderStateMixin purpose:');
  print('- Provides vsync for AnimationController');
  print('- Manages single ticker lifecycle');
  print('- Automatically disposes ticker');
  print('- Optimized for single animation case');
  
  // Usage pattern
  print('\nUsage pattern:');
  print('class _MyState extends State<MyWidget>');
  print('    with SingleTickerProviderStateMixin {');
  print('  late AnimationController _controller;');
  print('  @override initState() {');
  print('    _controller = AnimationController(vsync: this);');
  print('  }');
  print('}');
  
  // Comparison with TickerProviderStateMixin
  print('\nSingle vs Multiple tickers:');
  print('- SingleTickerProviderStateMixin: One animation');
  print('- TickerProviderStateMixin: Multiple animations');
  print('- Single is more efficient for single animation');
  print('- Use Multiple when having 2+ controllers');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('SingleTickerProviderStateMixin is mixin on State');
  print('Implements TickerProvider interface');
  print('createTicker() returns single Ticker');
  
  // Use cases
  print('\nUse cases:');
  print('- Simple fade animations');
  print('- Single rotation animation');
  print('- Loading spinners');
  print('- Pulse effects');

  print('\nSingleTickerProviderStateMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SingleTickerProviderStateMixin Tests'),
      Text('Single ticker for animations'),
      Text('Provides vsync to AnimationController'),
      Text('Use for single animation scenarios'),
    ],
  );
}
