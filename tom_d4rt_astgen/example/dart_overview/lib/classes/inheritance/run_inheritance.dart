/// Demonstrates Dart inheritance and interfaces
///
/// Features covered:
/// - extends (inheritance)
/// - implements (interfaces)
/// - super keyword
/// - Method overriding
/// - Abstract classes

void main() {
  print('=== Inheritance and Interfaces ===');
  print('');

  // Basic inheritance
  print('--- Basic Inheritance (extends) ---');
  var dog = Dog('Buddy');
  print('Dog name: ${dog.name}');
  dog.eat();
  dog.bark();

  var cat = Cat('Whiskers');
  print('');
  print('Cat name: ${cat.name}');
  cat.eat();
  cat.meow();

  // Method overriding
  print('');
  print('--- Method Overriding ---');
  Animal animal1 = Dog('Rex');
  Animal animal2 = Cat('Tom');

  print('animal1.speak(): ${animal1.speak()}');
  print('animal2.speak(): ${animal2.speak()}');

  // Polymorphism
  print('');
  print('--- Polymorphism ---');
  var animals = <Animal>[Dog('Spot'), Cat('Felix'), Dog('Max')];
  for (var animal in animals) {
    print('${animal.name} says: ${animal.speak()}');
  }

  // Super keyword
  print('');
  print('--- Super Keyword ---');
  var electricCar = ElectricCar('Tesla', 'Model 3', 75);
  electricCar.displayInfo();
  electricCar.charge();

  // Abstract class
  print('');
  print('--- Abstract Class ---');
  Shape circle = Circle(5);
  Shape rectangle = Rectangle(4, 6);

  print('Circle area: ${circle.area()}');
  print('Circle perimeter: ${circle.perimeter()}');
  print('Rectangle area: ${rectangle.area()}');
  print('Rectangle perimeter: ${rectangle.perimeter()}');

  // Interfaces (implements)
  print('');
  print('--- Interfaces (implements) ---');
  var emailService = EmailNotificationService();
  var smsService = SmsNotificationService();

  sendNotification(emailService, 'Hello via email!');
  sendNotification(smsService, 'Hello via SMS!');

  // Multiple interfaces
  print('');
  print('--- Multiple Interfaces ---');
  var smartDevice = SmartThermostat();
  smartDevice.turnOn();
  smartDevice.setTemperature(22);
  smartDevice.connect();
  smartDevice.turnOff();

  // Extending and implementing
  print('');
  print('--- Extending and Implementing ---');
  var advancedDevice = AdvancedRobot();
  advancedDevice.move();
  advancedDevice.speak();
  advancedDevice.connect();

  // Checking type with is
  print('');
  print('--- Type Checking ---');
  Machine machine = AdvancedRobot();

  print('machine is Connectable: ${machine is Connectable}');
  print('machine is Speakable: ${machine is Speakable}');

  if (machine case Speakable speakable) {
    speakable.speak();
  }

  print('');
  print('=== End of Inheritance and Interfaces Demo ===');
}

// Base class
class Animal {
  final String name;

  Animal(this.name);

  void eat() {
    print('$name is eating');
  }

  String speak() {
    return 'Some sound';
  }
}

// Derived classes
class Dog extends Animal {
  Dog(super.name);

  @override
  String speak() => 'Woof!';

  void bark() {
    print('$name barks loudly!');
  }
}

class Cat extends Animal {
  Cat(super.name);

  @override
  String speak() => 'Meow!';

  void meow() {
    print('$name meows softly');
  }
}

// Super keyword example
class Car {
  final String brand;
  final String model;

  Car(this.brand, this.model);

  void displayInfo() {
    print('$brand $model');
  }
}

class ElectricCar extends Car {
  final int batteryCapacity;

  ElectricCar(super.brand, super.model, this.batteryCapacity);

  @override
  void displayInfo() {
    super.displayInfo(); // Call parent method
    print('Battery: $batteryCapacity kWh');
  }

  void charge() {
    print('Charging...');
  }
}

// Abstract class
abstract class Shape {
  double area();
  double perimeter();
}

class Circle extends Shape {
  final double radius;

  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;

  @override
  double perimeter() => 2 * 3.14159 * radius;
}

class Rectangle extends Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double area() => width * height;

  @override
  double perimeter() => 2 * (width + height);
}

// Interface (any class can be used as interface)
abstract class NotificationService {
  void send(String message);
}

class EmailNotificationService implements NotificationService {
  @override
  void send(String message) {
    print('Sending email: $message');
  }
}

class SmsNotificationService implements NotificationService {
  @override
  void send(String message) {
    print('Sending SMS: $message');
  }
}

void sendNotification(NotificationService service, String message) {
  service.send(message);
}

// Multiple interfaces
abstract class Switchable {
  void turnOn();
  void turnOff();
}

abstract class TemperatureControl {
  void setTemperature(int temp);
}

abstract class Connectable {
  void connect();
}

class SmartThermostat implements Switchable, TemperatureControl, Connectable {
  bool _isOn = false;

  @override
  void turnOn() {
    _isOn = true;
    print('Thermostat is ON');
  }

  @override
  void turnOff() {
    _isOn = false;
    print('Thermostat is OFF');
  }

  @override
  void setTemperature(int temp) {
    if (_isOn) {
      print('Setting temperature to $temp degrees');
    }
  }

  @override
  void connect() {
    print('Thermostat connected to WiFi');
  }
}

// Extending class and implementing interfaces
abstract class Machine {
  void move();
}

abstract class Speakable {
  void speak();
}

class Robot extends Machine {
  @override
  void move() {
    print('Robot moving');
  }
}

class AdvancedRobot extends Robot implements Speakable, Connectable {
  @override
  void speak() {
    print('Robot speaking: Hello!');
  }

  @override
  void connect() {
    print('Robot connected to network');
  }
}
