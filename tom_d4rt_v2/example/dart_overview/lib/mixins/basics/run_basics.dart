/// Demonstrates Dart mixins
///
/// Features covered:
/// - Basic mixin declaration
/// - Using mixins with 'with' keyword
/// - Multiple mixins
/// - Mixin constraints (on clause)
/// - Mixin class
/// - Method resolution order
/// - Abstract methods in mixins

void main() {
  print('=== Mixins ===');
  print('');

  // Basic mixin
  print('--- Basic Mixin ---');
  var musician = Musician('Alice');
  musician.playInstrument();

  var dancer = ProfessionalDancer('Bob');
  dancer.dance();

  // Multiple mixins
  print('');
  print('--- Multiple Mixins ---');
  var entertainer = Entertainer('Charlie');
  entertainer.playInstrument();
  entertainer.dance();
  entertainer.perform();

  // Mixin with state
  print('');
  print('--- Mixin with State ---');
  var counter = CountableItem();
  counter.increment();
  counter.increment();
  counter.increment();
  print('Count: ${counter.count}');
  counter.reset();
  print('After reset: ${counter.count}');

  // Mixin constraints (on clause)
  print('');
  print('--- Mixin Constraints ---');
  var flyingBird = Eagle('Eddie');
  print('${flyingBird.name} can fly:');
  flyingBird.fly();
  flyingBird.move();

  // Bird that uses walking mixin
  var walkingBird = Penguin('Pete');
  print('${walkingBird.name} walks:');
  walkingBird.walk();
  walkingBird.move();

  // Mixin with abstract methods
  print('');
  print('--- Mixin with Abstract Methods ---');
  var logger = ConsoleLogger();
  logger.info('This is info');
  logger.warning('This is warning');
  logger.error('This is error');

  // Multiple mixins - method resolution
  print('');
  print('--- Method Resolution Order ---');
  var multi = MultiMixed();
  multi.greet(); // Last mixin wins

  // Mixin class (Dart 3.0+)
  print('');
  print('--- Mixin Class ---');
  // Can be used as a class
  var helper = Helper();
  helper.help();

  // Can be used as a mixin
  var service = HelpfulService();
  service.help();
  service.serve();

  // Real-world example: Event handling
  print('');
  print('--- Real-World Example: Event Handling ---');
  var button = Button('Submit');
  button.addListener((event) => print('  Listener 1: $event'));
  button.addListener((event) => print('  Listener 2: $event'));
  button.click();

  // Comparable mixin
  print('');
  print('--- Mixin with Operators ---');
  var p1 = SortableItem(5);
  var p2 = SortableItem(3);
  var p3 = SortableItem(8);

  var items = [p1, p2, p3];
  items.sort();
  print('Sorted: ${items.map((i) => i.value).toList()}');

  // JSON serialization mixin
  print('');
  print('--- Serialization Mixin ---');
  var user = User('Alice', 'alice@example.com');
  print('User JSON: ${user.toJson()}');

  print('');
  print('=== End of Mixins Demo ===');
}

// Basic mixins
mixin Musical {
  void playInstrument() {
    print('Playing an instrument');
  }
}

mixin Dancing {
  void dance() {
    print('Dancing gracefully');
  }
}

// Using single mixin
class Musician with Musical {
  final String name;
  Musician(this.name);
}

class ProfessionalDancer with Dancing {
  final String name;
  ProfessionalDancer(this.name);
}

// Using multiple mixins
class Entertainer with Musical, Dancing {
  final String name;
  Entertainer(this.name);

  void perform() {
    print('$name is performing!');
    playInstrument();
    dance();
  }
}

// Mixin with state
mixin Counter {
  int _count = 0;

  int get count => _count;

  void increment() => _count++;
  void decrement() => _count--;
  void reset() => _count = 0;
}

class CountableItem with Counter {}

// Mixin constraints with 'on' clause
abstract class Animal {
  String get name;
  void move();
}

mixin Flying on Animal {
  void fly() {
    print('$name is flying through the air');
  }
}

mixin Walking on Animal {
  void walk() {
    print('$name is walking on the ground');
  }
}

class Bird extends Animal {
  @override
  final String name;

  Bird(this.name);

  @override
  void move() {
    print('$name is moving');
  }
}

class Eagle extends Bird with Flying {
  Eagle(super.name);
}

class Penguin extends Bird with Walking {
  Penguin(super.name);
}

// Mixin with abstract methods
mixin Logging {
  void log(String level, String message);

  void info(String message) => log('INFO', message);
  void warning(String message) => log('WARNING', message);
  void error(String message) => log('ERROR', message);
}

class ConsoleLogger with Logging {
  @override
  void log(String level, String message) {
    print('[$level] $message');
  }
}

// Method resolution order
mixin Greeter1 {
  void greet() => print('Hello from Greeter1');
}

mixin Greeter2 {
  void greet() => print('Hello from Greeter2');
}

class MultiMixed with Greeter1, Greeter2 {}

// Mixin class (Dart 3.0+)
mixin class Helper {
  void help() {
    print('Helping...');
  }
}

class HelpfulService with Helper {
  void serve() {
    print('Serving...');
  }
}

// Event handling example
typedef EventListener = void Function(String event);

mixin EventEmitter {
  final List<EventListener> _listeners = [];

  void addListener(EventListener listener) {
    _listeners.add(listener);
  }

  void removeListener(EventListener listener) {
    _listeners.remove(listener);
  }

  void emit(String event) {
    for (var listener in _listeners) {
      listener(event);
    }
  }
}

class Button with EventEmitter {
  final String label;

  Button(this.label);

  void click() {
    print('Button "$label" clicked');
    emit('click:$label');
  }
}

// Comparable mixin using comparison
mixin ComparableMixin implements Comparable<SortableItem> {
  int get value;

  @override
  int compareTo(SortableItem other) => value.compareTo(other.value);
}

class SortableItem with ComparableMixin {
  @override
  final int value;

  SortableItem(this.value);
}

// JSON serialization mixin
mixin JsonSerializable {
  Map<String, dynamic> toJsonMap();

  String toJson() {
    return toJsonMap().toString();
  }
}

class User with JsonSerializable {
  final String name;
  final String email;

  User(this.name, this.email);

  @override
  Map<String, dynamic> toJsonMap() {
    return {'name': name, 'email': email};
  }
}
