/// Demonstrates Dart anonymous functions and closures
///
/// Features covered:
/// - Anonymous functions (lambdas)
/// - Closures
/// - Lexical scope

void main() {
  print('=== Anonymous Functions and Closures ===');
  print('');

  // Anonymous function (lambda)
  print('--- Anonymous Functions ---');

  // Full syntax
  var add = (int a, int b) {
    return a + b;
  };
  print('add(5, 3) = ${add(5, 3)}');

  // Arrow syntax
  var multiply = (int a, int b) => a * b;
  print('multiply(4, 7) = ${multiply(4, 7)}');

  // Without type annotations (inferred)
  var greet = (name) => 'Hello, $name!';
  print('greet("Alice") = ${greet('Alice')}');

  // Passing anonymous functions to methods
  print('');
  print('--- Passing to Methods ---');
  var numbers = [1, 2, 3, 4, 5];

  // Using anonymous function with map
  var doubled = numbers.map((n) => n * 2);
  print('numbers.map((n) => n * 2): ${doubled.toList()}');

  // Using anonymous function with where
  var evens = numbers.where((n) => n % 2 == 0);
  print('numbers.where((n) => n % 2 == 0): ${evens.toList()}');

  // Using anonymous function with reduce
  var sum = numbers.reduce((a, b) => a + b);
  print('numbers.reduce((a, b) => a + b): $sum');

  // Multi-line anonymous function
  print('');
  var processItem = (String item) {
    var trimmed = item.trim();
    var upper = trimmed.toUpperCase();
    return '[$upper]';
  };
  print('processItem("  hello  ") = ${processItem('  hello  ')}');

  // Closures
  print('');
  print('--- Closures ---');

  // Closure capturing outer variable
  int multiplier = 10;
  var multiplyBy = (int n) => n * multiplier;
  print('multiplyBy(5) with multiplier=10: ${multiplyBy(5)}');

  multiplier = 3;
  print('multiplyBy(5) with multiplier=3: ${multiplyBy(5)}');

  // Closure factory
  print('');
  print('--- Closure Factory ---');
  var addFive = makeAdder(5);
  var addTen = makeAdder(10);
  print('addFive(3) = ${addFive(3)}');
  print('addTen(3) = ${addTen(3)}');

  // Counter closure
  print('');
  print('--- Counter Closure ---');
  var counter = makeCounter();
  print('counter() = ${counter()}');
  print('counter() = ${counter()}');
  print('counter() = ${counter()}');

  // Each counter is independent
  var counter2 = makeCounter();
  print('counter2() = ${counter2()}');
  print('counter() = ${counter()}');

  // Lexical scope
  print('');
  print('--- Lexical Scope ---');
  String outerVar = 'outer';

  void innerFunction() {
    String innerVar = 'inner';
    print('  Inside inner: outerVar = $outerVar');
    print('  Inside inner: innerVar = $innerVar');
  }

  innerFunction();
  print('Outside inner: outerVar = $outerVar');
  // print(innerVar); // Error: innerVar not in scope

  // Nested closures
  print('');
  print('--- Nested Closures ---');
  String level1 = 'Level 1';

  var outer = () {
    String level2 = 'Level 2';

    return () {
      String level3 = 'Level 3';
      return '$level1 -> $level2 -> $level3';
    };
  };

  var inner = outer();
  print('Nested result: ${inner()}');

  // Practical example: Event handlers
  print('');
  print('--- Practical: Event Handlers ---');
  var button = Button('Submit');
  button.onClick = () {
    print('  Button "${button.label}" was clicked!');
  };
  button.click();

  // Practical example: Deferred execution
  print('');
  print('--- Practical: Deferred Execution ---');
  var actions = <void Function()>[];

  for (int i = 0; i < 3; i++) {
    actions.add(() => print('  Action $i'));
  }

  print('Executing actions:');
  for (var action in actions) {
    action();
  }

  // Closure in callbacks
  print('');
  print('--- Practical: Callbacks with Context ---');
  processItems(
    ['apple', 'banana', 'cherry'],
    onItem: (item, index) => print('  $index: ${item.toUpperCase()}'),
    onComplete: () => print('  Processing complete!'),
  );

  print('');
  print('=== End of Anonymous Functions and Closures Demo ===');
}

// Closure factory - returns function that captures addBy
int Function(int) makeAdder(int addBy) {
  return (int i) => i + addBy;
}

// Counter factory - each call creates independent counter
int Function() makeCounter() {
  int count = 0;
  return () => ++count;
}

// Button class for event handler example
class Button {
  String label;
  void Function()? onClick;

  Button(this.label);

  void click() {
    onClick?.call();
  }
}

// Callback-based processing
void processItems(
  List<String> items, {
  required void Function(String, int) onItem,
  required void Function() onComplete,
}) {
  for (int i = 0; i < items.length; i++) {
    onItem(items[i], i);
  }
  onComplete();
}
