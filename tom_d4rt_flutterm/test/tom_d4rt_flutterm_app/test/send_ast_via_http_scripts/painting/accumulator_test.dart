// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Accumulator from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Accumulator test executing');

  // Create Accumulator
  final accumulator = Accumulator();

  print('Created: ${accumulator.runtimeType}');

  // Test initial value
  print('\nInitial value:');
  print('value: ${accumulator.value}');

  // Increment
  print('\nIncrement operations:');
  accumulator.increment(10);
  print('After increment(10): ${accumulator.value}');

  accumulator.increment(5);
  print('After increment(5): ${accumulator.value}');

  accumulator.increment(3);
  print('After increment(3): ${accumulator.value}');

  // Explain purpose
  print('\nAccumulator purpose:');
  print('- Simple value accumulator');
  print('- Tracks running total');
  print('- Used internally in text layout');
  print('- Part of InlineSpan painting');

  // Properties
  print('\nProperties:');
  print('- value: current accumulated value');

  // Methods
  print('\nMethods:');
  print('- increment(double): add to value');

  // Create another
  print('\nNew Accumulator:');
  final acc2 = Accumulator();
  print('Initial: ${acc2.value}');
  acc2.increment(100);
  print('After 100: ${acc2.value}');

  // Use case
  print('\nUse case:');
  print('- Calculating text layout offsets');
  print('- Tracking cumulative widths');
  print('- Internal framework use');

  print('\nAccumulator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Accumulator Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Running total accumulator'),
      Text('value: ${accumulator.value}'),
      Text('Method: increment(double)'),
      Text('Used in: text layout'),
    ],
  );
}
