/// Demonstrates Dart function declarations
///
/// Features covered:
/// - Basic function declaration
/// - Return types
/// - Arrow functions
/// - main() function
library;

void main() {
  print('=== Function Declarations ===');
  print('');

  // Basic function with return type
  print('--- Basic Function ---');
  int result = add(5, 3);
  print('add(5, 3) = $result');

  result = multiply(4, 7);
  print('multiply(4, 7) = $result');

  // Function with no return value (void)
  print('');
  print('--- void Function ---');
  greet('Alice');
  printSeparator();

  // Arrow functions (expression body)
  print('');
  print('--- Arrow Functions ---');
  print('square(5) = ${square(5)}');
  print('cube(3) = ${cube(3)}');
  print('isEven(4) = ${isEven(4)}');
  print('isEven(7) = ${isEven(7)}');

  // Function returning complex types
  print('');
  print('--- Returning Complex Types ---');
  var numbers = getNumbers();
  print('getNumbers() = $numbers');

  var user = createUser('Bob', 25);
  print('createUser() = $user');

  // Calling functions with expressions
  print('');
  print('--- Functions in Expressions ---');
  var total = add(multiply(2, 3), multiply(4, 5));
  print('add(multiply(2,3), multiply(4,5)) = $total');

  var isLarge = square(10) > 50;
  print('square(10) > 50: $isLarge');

  // Type inference on return
  print('');
  print('--- Return Type Inference ---');
  print('inferredReturn() = ${inferredReturn()}');
  print('Type: ${inferredReturn().runtimeType}');

  // Dynamic return
  print('');
  print('--- Dynamic Return ---');
  print('dynamicReturn(1) = ${dynamicReturn(1)}');
  print('dynamicReturn(2) = ${dynamicReturn(2)}');
  print('dynamicReturn(3) = ${dynamicReturn(3)}');

  // Never-returning function
  print('');
  print('--- Never Return Type ---');
  try {
    alwaysThrows();
  } catch (e) {
    print('Caught: $e');
  }

  print('');
  print('=== End of Function Declarations Demo ===');
}

// Basic functions with explicit return types
int add(int a, int b) {
  return a + b;
}

int multiply(int a, int b) {
  return a * b;
}

// void function - no return value
void greet(String name) {
  print('Hello, $name!');
}

void printSeparator() {
  print('-' * 20);
}

// Arrow functions (single expression)
int square(int n) => n * n;
int cube(int n) => n * n * n;
bool isEven(int n) => n % 2 == 0;

// Returning complex types
List<int> getNumbers() => [1, 2, 3, 4, 5];

Map<String, dynamic> createUser(String name, int age) => {
      'name': name,
      'age': age,
      'createdAt': DateTime.now().toString(),
    };

// Type inference on return
inferredReturn() {
  return 42; // Return type inferred as int
}

// Dynamic return type
dynamic dynamicReturn(int choice) {
  switch (choice) {
    case 1:
      return 'String value';
    case 2:
      return 42;
    default:
      return [1, 2, 3];
  }
}

// Never-returning function
Never alwaysThrows() {
  throw Exception('This function never returns normally');
}
