/// Demonstrates Dart switch statement
///
/// Features covered:
/// - Basic switch statement
/// - Multiple case labels
/// - Default case
/// - break and fall-through prevention
/// - Switch on various types
library;

void main() {
  print('=== Switch Statement ===');
  print('');

  // Basic switch
  print('--- Basic Switch ---');
  String grade = 'B';

  switch (grade) {
    case 'A':
      print('Excellent!');
      break;
    case 'B':
      print('Good job!');
      break;
    case 'C':
      print('Satisfactory');
      break;
    case 'D':
      print('Needs improvement');
      break;
    case 'F':
      print('Failed');
      break;
    default:
      print('Invalid grade');
  }

  // Multiple case labels
  print('');
  print('--- Multiple Case Labels ---');
  int dayNumber = 6;

  switch (dayNumber) {
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
      print('Day $dayNumber: Weekday');
      break;
    case 6:
    case 7:
      print('Day $dayNumber: Weekend');
      break;
    default:
      print('Invalid day number');
  }

  // Switch with different types
  print('');
  print('--- Switch on Different Types ---');

  // String
  String command = 'start';
  switch (command) {
    case 'start':
      print('Starting...');
      break;
    case 'stop':
      print('Stopping...');
      break;
    case 'pause':
      print('Pausing...');
      break;
  }

  // int with ranges (using when in Dart 3)
  print('');
  print('--- Switch with when Clause ---');
  int score = 85;

  switch (score) {
    case int s when s >= 90:
      print('Score $score: Grade A');
      break;
    case int s when s >= 80:
      print('Score $score: Grade B');
      break;
    case int s when s >= 70:
      print('Score $score: Grade C');
      break;
    case int s when s >= 60:
      print('Score $score: Grade D');
      break;
    default:
      print('Score $score: Grade F');
  }

  // Switch with enum
  print('');
  print('--- Switch on Enum ---');
  Color color = Color.green;

  switch (color) {
    case Color.red:
      print('Stop!');
      break;
    case Color.yellow:
      print('Caution!');
      break;
    case Color.green:
      print('Go!');
      break;
  }

  // Switch with pattern matching (Dart 3)
  print('');
  print('--- Switch with Pattern Matching ---');
  Object value = [1, 2, 3];

  switch (value) {
    case int i:
      print('Integer: $i');
      break;
    case String s:
      print('String: $s');
      break;
    case List<int> list when list.isNotEmpty:
      print('Non-empty int list: $list');
      break;
    case List list:
      print('Some list: $list');
      break;
    default:
      print('Unknown type');
  }

  // Switch with records
  print('');
  print('--- Switch on Records ---');
  var point = (2, 0);

  switch (point) {
    case (0, 0):
      print('Origin');
      break;
    case (var x, 0):
      print('On x-axis at x=$x');
      break;
    case (0, var y):
      print('On y-axis at y=$y');
      break;
    case (var x, var y):
      print('Point at ($x, $y)');
      break;
  }

  // Switch with continue (labeled cases)
  print('');
  print('--- Switch with continue ---');
  String input = 'YES';

  switch (input.toLowerCase()) {
    case 'yes':
    case 'y':
      print('Confirmed');
      continue shared;
    case 'no':
    case 'n':
      print('Declined');
      continue shared;
    shared:
    case 'shared':
      print('Processing complete');
      break;
    default:
      print('Unknown response');
  }

  // Empty switch body handling
  print('');
  print('--- Exhaustive Switch ---');
  Status status = Status.active;

  // When all enum values are handled, no default needed
  switch (status) {
    case Status.pending:
      print('Waiting...');
      break;
    case Status.active:
      print('Running');
      break;
    case Status.completed:
      print('Done!');
      break;
    case Status.failed:
      print('Error occurred');
      break;
  }

  print('');
  print('=== End of Switch Statement Demo ===');
}

enum Color { red, yellow, green }

enum Status { pending, active, completed, failed }
