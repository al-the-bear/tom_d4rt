// D4rt test script: Tests Accumulator from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Accumulator test executing');
  final results = <String>[];

  // Test 1: Default constructor
  final acc1 = Accumulator();
  results.add('Default value: ${acc1.value}');
  assert(acc1.value == 0, 'Default constructor should initialize value to 0');

  // Test 2: Constructor with initial value
  final acc2 = Accumulator(10);
  results.add('Initial value 10: ${acc2.value}');
  assert(acc2.value == 10, 'Constructor should accept initial value');

  // Test 3: Constructor with negative value
  final acc3 = Accumulator(-5);
  results.add('Negative value -5: ${acc3.value}');
  assert(acc3.value == -5, 'Constructor should accept negative values');

  // Test 4: Constructor with large value
  final acc4 = Accumulator(1000000);
  results.add('Large value 1000000: ${acc4.value}');
  assert(acc4.value == 1000000, 'Constructor should accept large values');

  // Test 5: Increment from zero
  final acc5 = Accumulator();
  acc5.increment(5);
  results.add('Increment 0 + 5: ${acc5.value}');
  assert(acc5.value == 5, 'Increment should add to value');

  // Test 6: Multiple increments
  final acc6 = Accumulator(10);
  acc6.increment(3);
  acc6.increment(7);
  acc6.increment(10);
  results.add('Multiple increments 10 + 3 + 7 + 10: ${acc6.value}');
  assert(acc6.value == 30, 'Multiple increments should accumulate');

  // Test 7: Increment with negative amount
  final acc7 = Accumulator(20);
  acc7.increment(-5);
  results.add('Negative increment 20 + (-5): ${acc7.value}');
  assert(acc7.value == 15, 'Negative increment should subtract');

  // Test 8: Increment zero (no change)
  final acc8 = Accumulator(42);
  acc8.increment(0);
  results.add('Zero increment 42 + 0: ${acc8.value}');
  assert(acc8.value == 42, 'Zero increment should not change value');

  // Test 9: Chained increments building up
  final acc9 = Accumulator();
  for (var i = 1; i <= 10; i++) {
    acc9.increment(i);
  }
  results.add('Sum 1..10: ${acc9.value}');
  assert(acc9.value == 55, 'Sum of 1..10 should be 55');

  // Test 10: Value getter returns current state
  final acc10 = Accumulator(100);
  final initialValue = acc10.value;
  acc10.increment(25);
  final afterIncrement = acc10.value;
  results.add('Before: $initialValue, After: $afterIncrement');
  assert(
    initialValue == 100 && afterIncrement == 125,
    'Value getter should reflect state',
  );

  // Test 11: Large increments
  final acc11 = Accumulator(0);
  acc11.increment(1000000);
  results.add('Large increment: ${acc11.value}');
  assert(acc11.value == 1000000, 'Should handle large increments');

  // Test 12: Multiple accumulators independent
  final accA = Accumulator(5);
  final accB = Accumulator(10);
  accA.increment(3);
  results.add('AccA: ${accA.value}, AccB: ${accB.value}');
  assert(
    accA.value == 8 && accB.value == 10,
    'Accumulators should be independent',
  );

  print('Accumulator test completed');
  print('All tests passed: ${results.length} assertions');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Accumulator Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8.0),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Text(r, style: TextStyle(fontSize: 12.0)),
        ),
      ),
    ],
  );
}
