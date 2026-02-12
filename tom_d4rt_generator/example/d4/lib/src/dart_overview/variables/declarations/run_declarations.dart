/// Demonstrates Dart variable declarations
///
/// Features covered:
/// - Type inference with var
/// - Explicit type annotations
/// - final - single assignment
/// - const - compile-time constants
/// - late - late initialization

void main() {
  print('=== Variable Declarations ===\n');

  // Type inference with var
  print('--- Type Inference with var ---');
  var name = 'Alice'; // String inferred
  var age = 30; // int inferred
  var height = 5.9; // double inferred
  var isStudent = false; // bool inferred
  print('name: $name (${name.runtimeType})');
  print('age: $age (${age.runtimeType})');
  print('height: $height (${height.runtimeType})');
  print('isStudent: $isStudent (${isStudent.runtimeType})');

  // Explicit type annotations
  print('\n--- Explicit Type Annotations ---');
  String city = 'New York';
  int population = 8_336_817; // Underscores for readability
  double area = 302.6;
  bool isCapital = false;
  print('city: $city');
  print('population: $population');
  print('area: $area sq mi');
  print('isCapital: $isCapital');

  // final - single assignment (runtime)
  print('\n--- final - Single Assignment ---');
  final currentTime = DateTime.now(); // Computed at runtime
  final String greeting = 'Hello';
  // final variables can only be set once
  // greeting = 'Hi'; // Error: Can't assign to a final variable
  print('currentTime: $currentTime');
  print('greeting: $greeting');

  // const - compile-time constants
  print('\n--- const - Compile-Time Constants ---');
  const pi = 3.14159;
  const double e = 2.71828;
  const String appName = 'MyApp';
  // const values must be known at compile time
  // const now = DateTime.now(); // Error: Not a constant expression
  print('pi: $pi');
  print('e: $e');
  print('appName: $appName');

  // Const collections are deeply immutable
  const numbers = [1, 2, 3];
  const config = {'debug': true, 'version': '1.0'};
  print('const numbers: $numbers');
  print('const config: $config');

  // late - lazy initialization
  print('\n--- late - Late Initialization ---');
  late String description;
  // Can be assigned later, but must be assigned before use
  description = 'This is a late-initialized variable';
  print('description: $description');

  // late with initializer - computed lazily
  late String expensiveValue = computeExpensiveValue();
  print('About to access expensiveValue...');
  print('expensiveValue: $expensiveValue');

  print('\n=== End of Variable Declarations Demo ===');
}

String computeExpensiveValue() {
  print('Computing expensive value...');
  return 'Computed at ${DateTime.now()}';
}
