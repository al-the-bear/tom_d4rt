/// A sample class demonstrating AST structure.
class Person {
  /// The person's name.
  final String name;
  
  /// The person's age.
  int age;
  
  /// Creates a new person.
  Person(this.name, {this.age = 0});
  
  /// Greets someone.
  String greet(String other) {
    return 'Hello, $other! I am $name.';
  }
}
