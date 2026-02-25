/// Demonstrates Dart generic covariance and contravariance
///
/// Features covered:
/// - Covariant type parameters (out)
/// - Invariance with generics
/// - Generic type relationships
/// - Type safety with generics

void main() {
  print('=== Variance ===');
  print('');

  // Covariance with read-only
  print('--- Covariance (Read-Only) ---');
  // List<Dog> is subtype of List<Animal> for read operations
  List<Animal> animals = <Dog>[Dog('Buddy'), Dog('Max')];
  printAnimals(animals);

  // Using Iterable (covariant)
  print('');
  Iterable<Animal> animalIterable = <Cat>[Cat('Whiskers'), Cat('Felix')];
  for (var animal in animalIterable) {
    print('Animal: ${animal.name}');
  }

  // Producer (covariant - out)
  print('');
  print('--- Producer (Covariant) ---');
  Producer<Dog> dogProducer = DogFactory();
  Producer<Animal> animalProducer = dogProducer; // OK: Dog is Animal

  var animal = animalProducer.produce();
  print('Produced: ${animal.name} (${animal.runtimeType})');

  // Consumer would need contravariance
  print('');
  print('--- Consumer Pattern ---');
  var dogConsumer = DogConsumer();
  dogConsumer.consume(Dog('Rex'));

  // AnimalConsumer can consume any animal
  var animalConsumer = AnimalConsumer();
  animalConsumer.consume(Dog('Fido'));
  animalConsumer.consume(Cat('Tom'));

  // Invariance in practice
  print('');
  print('--- Invariance ---');
  // Box<Dog> is NOT a subtype of Box<Animal>
  // Because Box allows both read AND write
  var dogBox = Box<Dog>(Dog('Spot'));
  print('dogBox.value: ${dogBox.value.name}');

  // This would be unsafe:
  // Box<Animal> animalBox = dogBox; // Error!
  // animalBox.value = Cat('Felix'); // Would put Cat in Dog box!

  // Safe alternative: use bounds
  void printBoxContent<T extends Animal>(Box<T> box) {
    print('Box contains: ${box.value.name}');
  }
  printBoxContent(dogBox);

  // Covariant keyword
  print('');
  print('--- covariant Keyword ---');
  AnimalHandler animalHandler = DogHandler();
  animalHandler.handle(Dog('Lucky'));  // Works at runtime

  // Read-only interfaces
  print('');
  print('--- Read-Only Interface ---');
  ReadOnlyList<Dog> dogs = ImmutableList([Dog('A'), Dog('B'), Dog('C')]);
  ReadOnlyList<Animal> readAnimals = dogs; // OK: read-only is covariant

  print('First: ${readAnimals.first.name}');
  print('Length: ${readAnimals.length}');
  print('At index 1: ${readAnimals[1].name}');

  // Type relationships
  print('');
  print('--- Type Relationships ---');
  demonstrateTypeRelationships();

  print('');
  print('=== End of Variance Demo ===');
}

// Base animal hierarchy
class Animal {
  final String name;
  Animal(this.name);
}

class Dog extends Animal {
  Dog(super.name);
  void bark() => print('$name barks!');
}

class Cat extends Animal {
  Cat(super.name);
  void meow() => print('$name meows!');
}

void printAnimals(List<Animal> animals) {
  for (var animal in animals) {
    print('Animal: ${animal.name}');
  }
}

// Producer interface (covariant - produces T)
abstract class Producer<T> {
  T produce();
}

class DogFactory implements Producer<Dog> {
  int _counter = 0;

  @override
  Dog produce() => Dog('Dog${++_counter}');
}

class CatFactory implements Producer<Cat> {
  int _counter = 0;

  @override
  Cat produce() => Cat('Cat${++_counter}');
}

// Consumer pattern
class DogConsumer {
  void consume(Dog dog) {
    print('Consuming dog: ${dog.name}');
  }
}

class AnimalConsumer {
  void consume(Animal animal) {
    print('Consuming animal: ${animal.name}');
  }
}

// Invariant box (read and write)
class Box<T> {
  T value;
  Box(this.value);
}

// Using covariant keyword
abstract class AnimalHandler {
  void handle(covariant Animal animal);
}

class DogHandler implements AnimalHandler {
  @override
  void handle(Dog dog) {
    print('Handling dog: ${dog.name}');
    dog.bark();
  }
}

// Read-only interface (covariant)
abstract class ReadOnlyList<T> {
  T get first;
  int get length;
  T operator [](int index);
}

class ImmutableList<T> implements ReadOnlyList<T> {
  final List<T> _items;

  ImmutableList(List<T> items) : _items = List.unmodifiable(items);

  @override
  T get first => _items.first;

  @override
  int get length => _items.length;

  @override
  T operator [](int index) => _items[index];
}

// Demonstrate type relationships
void demonstrateTypeRelationships() {
  // List variance
  List<int> ints = [1, 2, 3];
  List<num> nums = ints; // OK for read
  print('ints as nums: $nums');

  // Type checking with Object
  Object obj = [1, 2, 3];
  print('obj is List: ${obj is List}');
  print('obj is List<int>: ${obj is List<int>}');
  // Note: ints is List<int>/List<num>/List<Object> are always true
  // because static type is known at compile time

  // Dynamic difference
  List<dynamic> dynamicList = [1, 'two', 3.0];
  print('dynamicList: $dynamicList');
  print('dynamicList is List<Object>: ${dynamicList is List<Object>}');
}
