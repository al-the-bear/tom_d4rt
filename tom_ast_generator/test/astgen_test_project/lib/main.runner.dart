/// Main application runner
/// 
/// This is a sample runner file for testing astgen conversion.
library;

void main() {
  print('Hello from main runner!');
  
  final calculator = Calculator();
  final result = calculator.add(5, 3);
  print('5 + 3 = $result');
}

class Calculator {
  int add(int a, int b) => a + b;
  
  int subtract(int a, int b) => a - b;
  
  double multiply(double a, double b) {
    return a * b;
  }
  
  double divide(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Cannot divide by zero');
    }
    return a / b;
  }
}

enum Operation {
  add,
  subtract,
  multiply,
  divide;
  
  String get symbol {
    switch (this) {
      case Operation.add:
        return '+';
      case Operation.subtract:
        return '-';
      case Operation.multiply:
        return '*';
      case Operation.divide:
        return '/';
    }
  }
}
