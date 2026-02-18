/// Demonstrates Dart loop control statements
///
/// Features covered:
/// - break
/// - continue
/// - Labels
library;

void main() {
  print('=== Loop Control Statements ===');
  print('');

  // break - exit loop
  print('--- break ---');
  print('Breaking when finding 5:');
  for (int i = 1; i <= 10; i++) {
    if (i == 5) {
      print('  Found 5, breaking!');
      break;
    }
    print('  i = $i');
  }

  // break in while
  print('');
  print('break in while loop:');
  int count = 0;
  while (true) {
    count++;
    print('  count = $count');
    if (count >= 3) {
      print('  Breaking infinite loop');
      break;
    }
  }

  // continue - skip iteration
  print('');
  print('--- continue ---');
  print('Skipping even numbers:');
  for (int i = 1; i <= 10; i++) {
    if (i % 2 == 0) {
      continue; // Skip even numbers
    }
    print('  i = $i');
  }

  // continue in while
  print('');
  print('continue in while:');
  int n = 0;
  while (n < 10) {
    n++;
    if (n % 3 == 0) {
      continue; // Skip multiples of 3
    }
    print('  n = $n');
  }

  // Labeled break
  print('');
  print('--- Labeled break ---');
  print('Breaking outer loop:');
  outer:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      print('  i=$i, j=$j');
      if (i == 2 && j == 2) {
        print('  Breaking outer loop!');
        break outer;
      }
    }
  }

  // Labeled continue
  print('');
  print('--- Labeled continue ---');
  print('Continuing to outer loop:');
  outerLoop:
  for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
      if (j == 2) {
        print('  i=$i, j=$j - continuing outer');
        continue outerLoop;
      }
      print('  i=$i, j=$j');
    }
  }

  // Multiple nested loops with label
  print('');
  print('--- Complex Nested Example ---');
  print('Searching for target in matrix:');
  var matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];
  int target = 5;
  bool found = false;
  int? foundRow, foundCol;

  search:
  for (int row = 0; row < matrix.length; row++) {
    for (int col = 0; col < matrix[row].length; col++) {
      if (matrix[row][col] == target) {
        found = true;
        foundRow = row;
        foundCol = col;
        break search;
      }
    }
  }

  if (found) {
    print('  Found $target at row $foundRow, col $foundCol');
  }

  // Practical example: Input validation
  print('');
  print('--- Practical: Processing Valid Items ---');
  var items = ['apple', '', 'banana', '  ', 'cherry', null, 'date'];
  var validItems = <String>[];

  for (var item in items) {
    // Skip null or empty items
    if (item == null || item.trim().isEmpty) {
      continue;
    }
    validItems.add(item.trim());
  }
  print('Valid items: $validItems');

  // Practical example: Finding first match
  print('');
  print('--- Practical: Finding First Match ---');
  var users = [
    {'name': 'Alice', 'active': false},
    {'name': 'Bob', 'active': true},
    {'name': 'Charlie', 'active': true},
  ];

  String? firstActiveUser;
  for (var user in users) {
    if (user['active'] == true) {
      firstActiveUser = user['name'] as String;
      break;
    }
  }
  print('First active user: $firstActiveUser');

  // Practical example: Skip processing after error
  print('');
  print('--- Practical: Process Until Error ---');
  var operations = ['op1', 'op2', 'error', 'op3', 'op4'];
  var results = <String>[];

  for (var op in operations) {
    if (op == 'error') {
      print('  Error encountered, stopping');
      break;
    }
    results.add('Processed: $op');
    print('  $op completed');
  }
  print('Completed operations: ${results.length}');

  print('');
  print('=== End of Loop Control Statements Demo ===');
}
