/// Demonstrates Dart class modifiers (Dart 3.0+)
///
/// Features covered:
/// - abstract (cannot be instantiated)
/// - base (force inheritance, prevent implementation)
/// - interface (force implementation, prevent inheritance)
/// - final (prevent both inheritance and implementation outside library)
/// - sealed (known set of subtypes, exhaustive switching)
/// - mixin class (can be used as both class and mixin)
library;

void main() {
  print('=== Class Modifiers (Dart 3.0+) ===');
  print('');

  // abstract - cannot instantiate
  print('--- abstract ---');
  // Cannot do: var vehicle = Vehicle(); // Error: abstract
  Vehicle car = Car();
  Vehicle motorcycle = Motorcycle();

  print('car.move(): ${car.move()}');
  print('motorcycle.move(): ${motorcycle.move()}');

  // base - must be inherited, cannot be implemented
  print('');
  print('--- base ---');
  // Base classes enforce that subclasses also use base, final, or sealed
  var animal = DogAnimal('Buddy');
  print('DogAnimal: ${animal.name}');
  animal.eat();

  // interface - must be implemented, not inherited (outside library)
  print('');
  print('--- interface (conceptual) ---');
  // In same library, can extend interface classes
  // Outside library, must use implements
  DataSource jsonSource = JsonDataSource();
  DataSource xmlSource = XmlDataSource();

  print('jsonSource.fetch(): ${jsonSource.fetch()}');
  print('xmlSource.fetch(): ${xmlSource.fetch()}');

  // final - cannot be extended or implemented outside library
  print('');
  print('--- final ---');
  // Final classes prevent all inheritance/implementation outside library
  var config = AppConfig('Production', true);
  print('Config: ${config.environment}, debug: ${config.debug}');
  print('config.getSetting(): ${config.getSetting()}');

  // sealed - known subtypes, exhaustive
  print('');
  print('--- sealed ---');
  printShape(SealedCircle(5));
  printShape(SealedSquare(4));
  printShape(SealedTriangle(3, 4));

  // mixin class - dual purpose
  print('');
  print('--- mixin class ---');
  // Can be used as a class
  var logger = LoggerMixin();
  logger.log('Direct instance');

  // Can be used as a mixin
  var service = LoggingService();
  service.performAction();

  print('');
  print('=== Modifier Combinations ===');
  print('');

  // abstract base
  print('--- abstract base ---');
  // Cannot instantiate, subclasses must use base/final/sealed
  AbstractBaseClass derived = DerivedFromAbstractBase();
  derived.doSomething();

  // abstract interface
  print('');
  print('--- abstract interface ---');
  // Cannot instantiate, implementers provide all behavior
  ApiClient restClient = RestApiClient();
  ApiClient graphqlClient = GraphqlApiClient();
  print('REST: ${restClient.request("/users")}');
  print('GraphQL: ${graphqlClient.request("{ users { id } }")}');

  // abstract final (unusual but valid)
  print('');
  print('--- abstract final (same library only) ---');
  // Only useful for defining types used within the same library
  var singleton = SingletonHolder.instance;
  print('Singleton value: ${singleton.value}');

  print('');
  print('=== End of Class Modifiers Demo ===');
}

// abstract - cannot be directly instantiated
abstract class Vehicle {
  String move();
}

class Car extends Vehicle {
  @override
  String move() => 'Car is driving';
}

class Motorcycle extends Vehicle {
  @override
  String move() => 'Motorcycle is riding';
}

// base - must be inherited, not implemented
base class BaseAnimal {
  final String name;
  BaseAnimal(this.name);

  void eat() {
    print('$name is eating');
  }
}

// Subclass of base must also be base, final, or sealed
base class DogAnimal extends BaseAnimal {
  DogAnimal(super.name);
}

// interface - designed to be implemented
interface class DataSource {
  String fetch() => 'Default data';
}

// In same library, can extend interface class
class JsonDataSource extends DataSource {
  @override
  String fetch() => 'JSON data from API';
}

class XmlDataSource implements DataSource {
  @override
  String fetch() => 'XML data from file';
}

// final - cannot be extended or implemented outside library
final class AppConfig {
  final String environment;
  final bool debug;

  AppConfig(this.environment, this.debug);

  String getSetting() => 'Environment: $environment';
}

// sealed - known set of subtypes, enables exhaustive switching
sealed class SealedShape {}

class SealedCircle extends SealedShape {
  final double radius;
  SealedCircle(this.radius);
}

class SealedSquare extends SealedShape {
  final double side;
  SealedSquare(this.side);
}

class SealedTriangle extends SealedShape {
  final double base;
  final double height;
  SealedTriangle(this.base, this.height);
}

void printShape(SealedShape shape) {
  // Exhaustive - compiler knows all subtypes
  final area = switch (shape) {
    SealedCircle(radius: var r) => 3.14159 * r * r,
    SealedSquare(side: var s) => s * s,
    SealedTriangle(base: var b, height: var h) => 0.5 * b * h,
  };
  print('${shape.runtimeType} area: $area');
}

// mixin class - can be used as class or mixin
mixin class LoggerMixin {
  void log(String message) {
    print('[LOG] $message');
  }
}

class LoggingService with LoggerMixin {
  void performAction() {
    log('Performing action...');
  }
}

// abstract base - abstract + base
abstract base class AbstractBaseClass {
  void doSomething();
}

base class DerivedFromAbstractBase extends AbstractBaseClass {
  @override
  void doSomething() {
    print('Derived implementation');
  }
}

// abstract interface - abstract + interface
abstract interface class ApiClient {
  String request(String endpoint);
}

class RestApiClient implements ApiClient {
  @override
  String request(String endpoint) => 'REST: GET $endpoint';
}

class GraphqlApiClient implements ApiClient {
  @override
  String request(String endpoint) => 'GraphQL: $endpoint';
}

// abstract final - only subclassable within library
abstract final class AbstractFinalClass {
  int get value;
}

final class SingletonHolder extends AbstractFinalClass {
  @override
  final int value = 42;

  SingletonHolder._();
  static final instance = SingletonHolder._();
}
