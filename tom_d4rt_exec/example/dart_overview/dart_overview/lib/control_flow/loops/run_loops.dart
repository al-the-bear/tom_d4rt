/// Demonstrates Dart loop constructs
///
/// Features covered:
/// - for loop
/// - for-in loop
/// - while loop
/// - do-while loop
/// - forEach method

void main() {
  print('=== Loops ===');
  print('');

  // Basic for loop
  print('--- Basic for Loop ---');
  print('Counting 1 to 5:');
  for (int i = 1; i <= 5; i++) {
    print('  i = $i');
  }

  // Counting down
  print('');
  print('Counting down from 5:');
  for (int i = 5; i >= 1; i--) {
    print('  i = $i');
  }

  // Step by 2
  print('');
  print('Even numbers 2 to 10:');
  for (int i = 2; i <= 10; i += 2) {
    print('  i = $i');
  }

  // Multiple variables
  print('');
  print('Two variables:');
  for (int i = 0, j = 10; i < j; i++, j--) {
    print('  i = $i, j = $j');
  }

  // for-in loop
  print('');
  print('--- for-in Loop ---');
  var fruits = ['apple', 'banana', 'cherry'];
  print('Fruits:');
  for (var fruit in fruits) {
    print('  $fruit');
  }

  // for-in with index (using indexed extension would be better)
  print('');
  print('With index:');
  var colors = ['red', 'green', 'blue'];
  for (var i = 0; i < colors.length; i++) {
    print('  $i: ${colors[i]}');
  }

  // for-in with Map
  print('');
  print('Iterating Map:');
  var scores = {'Alice': 95, 'Bob': 87, 'Charlie': 92};
  for (var entry in scores.entries) {
    print('  ${entry.key}: ${entry.value}');
  }

  // while loop
  print('');
  print('--- while Loop ---');
  int count = 1;
  print('Counting with while:');
  while (count <= 5) {
    print('  count = $count');
    count++;
  }

  // while with condition
  print('');
  print('Finding first power of 2 >= 100:');
  int power = 1;
  while (power < 100) {
    power *= 2;
  }
  print('  Result: $power');

  // do-while loop
  print('');
  print('--- do-while Loop ---');
  int num = 1;
  print('do-while (always runs at least once):');
  do {
    print('  num = $num');
    num++;
  } while (num <= 5);

  // do-while vs while (with false condition)
  print('');
  print('Comparison with false condition:');
  int x = 10;
  print('while (x < 5) - does not execute:');
  while (x < 5) {
    print('  x = $x');
    x++;
  }
  print('  (no output)');

  print('');
  print('do-while (x < 5) - executes once:');
  x = 10;
  do {
    print('  x = $x');
    x++;
  } while (x < 5);

  // forEach
  print('');
  print('--- forEach Method ---');
  var numbers = [1, 2, 3, 4, 5];
  print('Using forEach:');
  numbers.forEach((n) {
    print('  $n');
  });

  // forEach with arrow function
  print('');
  print('forEach with arrow function:');
  numbers.forEach((n) => print('  Number: $n'));

  // Nested loops
  print('');
  print('--- Nested Loops ---');
  print('Multiplication table (1-3):');
  for (int i = 1; i <= 3; i++) {
    var row = StringBuffer('  ');
    for (int j = 1; j <= 3; j++) {
      row.write('${i * j}\t');
    }
    print(row);
  }

  // Loop with collection transformation
  print('');
  print('--- Loop with Collection Building ---');
  var squares = <int>[];
  for (int i = 1; i <= 5; i++) {
    squares.add(i * i);
  }
  print('Squares 1-5: $squares');

  // Using for in collection literal
  print('');
  print('Collection for (comprehension-like):');
  var cubes = [for (int i = 1; i <= 5; i++) i * i * i];
  print('Cubes 1-5: $cubes');

  // Conditional in collection for
  var evenSquares = [for (int i = 1; i <= 10; i++) if (i % 2 == 0) i * i];
  print('Even squares 1-10: $evenSquares');

  print('');
  print('=== End of Loops Demo ===');
}
