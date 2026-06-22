/// Demonstrates Dart class declarations
///
/// Features covered:
/// - Basic class declaration
/// - Instance variables (fields)
/// - Constructors
/// - Methods
/// - Getters and setters

void main() {
  print('=== Class Declarations ===');
  print('');

  // Basic class instantiation
  print('--- Basic Class ---');
  var person = Person();
  person.name = 'Alice';
  person.age = 30;
  print('Person: ${person.name}, ${person.age}');
  person.greet();

  // Class with constructor
  print('');
  print('--- Constructor ---');
  var dog = Dog('Buddy', 3);
  print('Dog: ${dog.name}, ${dog.age} years old');
  dog.bark();

  // Multiple constructors
  print('');
  print('--- Multiple Constructors ---');
  var user1 = User('Alice', 'alice@example.com');
  var user2 = User.guest();
  var user3 = User.fromMap({'name': 'Bob', 'email': 'bob@example.com'});

  print('user1: $user1');
  print('user2 (guest): $user2');
  print('user3 (from map): $user3');

  // Instance methods
  print('');
  print('--- Instance Methods ---');
  var calc = Calculator();
  print('5 + 3 = ${calc.add(5, 3)}');
  print('10 - 4 = ${calc.subtract(10, 4)}');
  print('6 * 7 = ${calc.multiply(6, 7)}');

  // Getters and setters
  print('');
  print('--- Getters and Setters ---');
  var rect = Rectangle(5, 3);
  print('Rectangle: ${rect.width} x ${rect.height}');
  print('Area (getter): ${rect.area}');
  print('Perimeter (getter): ${rect.perimeter}');

  rect.scale = 2;
  print('After scale = 2: ${rect.width} x ${rect.height}');

  // Private fields
  print('');
  print('--- Private Fields ---');
  var account = BankAccount('12345', 1000);
  print('Account: ${account.accountNumber}');
  print('Balance: ${account.balance}');
  account.deposit(500);
  print('After deposit 500: ${account.balance}');
  account.withdraw(200);
  print('After withdraw 200: ${account.balance}');

  // Computed properties
  print('');
  print('--- Computed Properties ---');
  var circle = Circle(5);
  print('Circle radius: ${circle.radius}');
  print('Diameter: ${circle.diameter}');
  print('Circumference: ${circle.circumference.toStringAsFixed(2)}');
  print('Area: ${circle.circleArea.toStringAsFixed(2)}');

  print('');
  print('=== End of Class Declarations Demo ===');
}

// Basic class
class Person {
  String name = '';
  int age = 0;

  void greet() {
    print('Hello, I am $name!');
  }
}

// Class with constructor
class Dog {
  String name;
  int age;

  Dog(this.name, this.age);

  void bark() {
    print('$name says: Woof!');
  }
}

// Class with multiple constructors
class User {
  String name;
  String email;

  // Primary constructor
  User(this.name, this.email);

  // Named constructor - guest user
  User.guest()
      : name = 'Guest',
        email = 'guest@example.com';

  // Named constructor - from map
  User.fromMap(Map<String, dynamic> map)
      : name = map['name'] as String,
        email = map['email'] as String;

  @override
  String toString() => 'User($name, $email)';
}

// Class with methods
class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  int multiply(int a, int b) => a * b;
  double divide(int a, int b) => a / b;
}

// Class with getters and setters
class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  // Getter
  double get area => width * height;
  double get perimeter => 2 * (width + height);

  // Setter
  set scale(double factor) {
    width *= factor;
    height *= factor;
  }
}

// Class with private field
class BankAccount {
  final String accountNumber;
  double _balance; // Private (starts with _)

  BankAccount(this.accountNumber, this._balance);

  // Public getter for private field
  double get balance => _balance;

  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }

  bool withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      return true;
    }
    return false;
  }
}

// Class with computed properties
class Circle {
  final double radius;

  Circle(this.radius);

  double get diameter => radius * 2;
  double get circumference => 2 * 3.14159 * radius;
  double get circleArea => 3.14159 * radius * radius;
}
