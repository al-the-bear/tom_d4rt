/// Demonstrates Dart annotations (metadata)
///
/// Features covered:
/// - Built-in annotations (@override, @deprecated, @pragma)
/// - Custom annotation classes
/// - Annotations with arguments
/// - Annotation targets (class, method, field, parameter)
/// - Const values in annotations
/// - Common annotation patterns
library;

void main() {
  print('=== Annotations ===');
  print('');

  // Built-in annotations
  print('--- Built-in Annotations ---');
  print('');
  print('@override - indicates intentional override');
  print('@deprecated - marks code as deprecated');
  print('@Deprecated("msg") - deprecation with message');
  print('@pragma("vm:prefer-inline") - compiler hints');

  // Demonstrate @override
  print('');
  print('--- @override Example ---');
  var dog = Dog();
  dog.speak();

  // Demonstrate @deprecated
  print('');
  print('--- @deprecated Example ---');
  var legacy = LegacyClass();
  // ignore: deprecated_member_use_from_same_package
  legacy.oldMethod();
  legacy.newMethod();

  // Custom annotations
  print('');
  print('--- Custom Annotations ---');
  print('');
  print('Creating annotation class:');
  print('  class Todo {');
  print('    final String description;');
  print('    const Todo(this.description);');
  print('  }');
  print('');
  print('Using annotation:');
  print('  @Todo("Implement caching")');
  print('  void fetchData() {}');

  // Annotation with multiple arguments
  print('');
  print('--- Annotations with Arguments ---');
  print('');
  print('@Route("/users", method: "GET")');
  print('@JsonKey(name: "user_name", ignore: false)');
  print('@Range(min: 0, max: 100)');

  // Demonstrate annotation targets
  print('');
  print('--- Annotation Targets ---');
  print('');
  print('Class:      @Immutable() class User {}');
  print('Field:      @JsonKey(name: "x") final int x;');
  print('Method:     @Get("/path") void fetch() {}');
  print('Parameter:  void fn(@Body() User u) {}');
  print('Constructor: @Inject() Service(this.dep);');
  print('Getter:     @Cached() int get value => ...;');

  // Using annotated class
  print('');
  print('--- Annotated Class Example ---');
  var user = User('Alice', 30, email: 'alice@example.com');
  print('User: ${user.name}, age: ${user.age}');
  print('Encoded: ${user.toSimpleString()}');

  // Route controller example
  print('');
  print('--- Route Annotations Example ---');
  var controller = UserController();
  print('UserController routes:');
  print('  @Route("/users") - class');
  print('  @Get("/list") - getUsers()');
  print('  @Post("/create") - createUser()');
  controller.logRoutes();

  // Const values in annotations
  print('');
  print('--- Const Values in Annotations ---');
  print('');
  print('Valid (compile-time constants):');
  print('  @Route("/users")           // literal');
  print('  @Retry(maxRetries)         // const variable');
  print('  @Timeout(Duration(s: 30))  // const constructor');
  print('  @Tags(["api", "public"])   // const collection');
  print('');
  print('Invalid (runtime values):');
  print('  var timeout = 30;');
  print('  @Timeout(Duration(s: timeout))  // Error!');

  // Common patterns
  print('');
  print('--- Common Annotation Patterns ---');
  print('');
  print('Serialization: @JsonSerializable(), @JsonKey()');
  print('Validation:    @Required(), @MinLength(3)');
  print('DI:            @Injectable(), @Inject()');
  print('Testing:       @Skip(), @Tags([])');
  print('API:           @Route(), @Get(), @Post()');

  // Validation example
  print('');
  print('--- Validation Pattern ---');
  var form = SignupForm();
  form.username = 'alice';
  form.email = 'alice@example.com';
  form.password = 'secret123';
  print('SignupForm fields with annotations:');
  print('  @Required() @MinLength(3) username');
  print('  @Required() @Email() email');
  print('  @Required() @MinLength(8) password');

  // Marker annotations
  print('');
  print('--- Marker Annotations ---');
  print('');
  print('// No-argument annotation');
  print('class Immutable { const Immutable(); }');
  print('const immutable = Immutable();  // convenience');
  print('');
  print('@Immutable() class A {}  // constructor call');
  print('@immutable class B {}    // using constant');

  // Reading annotations (conceptual)
  print('');
  print('--- Reading Annotations ---');
  print('');
  print('dart:mirrors (VM only, not Flutter):');
  print('  var mirror = reflectClass(MyClass);');
  print('  for (var m in mirror.metadata) { ... }');
  print('');
  print('Code generation (recommended):');
  print('  Use build_runner + source_gen');
  print('  Generates code at compile time');

  print('');
  print('=== End of Annotations Demo ===');
}

// @override example
class Animal {
  void speak() => print('Animal makes a sound');
}

class Dog extends Animal {
  @override
  void speak() => print('Dog says: Woof!');
}

// @deprecated example
class LegacyClass {
  @Deprecated('Use newMethod() instead. Removal in v2.0')
  void oldMethod() {
    print('Old method (deprecated)');
  }

  @Deprecated('Use newMethod() instead. Removal in v2.0')
  void anotherOldMethod() {}

  void newMethod() {
    print('New method (recommended)');
  }
}

// Custom annotation classes
class Todo {
  final String description;
  final String? assignee;
  final DateTime? dueDate;

  const Todo(this.description, {this.assignee, this.dueDate});
}

class Route {
  final String path;
  final String method;

  const Route(this.path, {this.method = 'GET'});
}

class Get extends Route {
  const Get(super.path) : super(method: 'GET');
}

class Post extends Route {
  const Post(super.path) : super(method: 'POST');
}

class JsonKey {
  final String? name;
  final bool ignore;
  final Object? defaultValue;

  const JsonKey({this.name, this.ignore = false, this.defaultValue});
}

class Required {
  const Required();
}

class MinLength {
  final int value;
  const MinLength(this.value);
}

class MaxLength {
  final int value;
  const MaxLength(this.value);
}

class Email {
  const Email();
}

class Range {
  final num min;
  final num max;
  const Range({required this.min, required this.max});
}

// Annotated user class
@Todo('Add validation', assignee: 'Alice')
class User {
  @JsonKey(name: 'user_name')
  final String name;

  @JsonKey(ignore: true)
  final int age;

  @JsonKey(name: 'email_address')
  final String? email;

  const User(this.name, this.age, {this.email});

  String toSimpleString() => 'User(name: $name, age: $age, email: $email)';
}

// Annotated controller
@Route('/users')
class UserController {
  @Get('/list')
  List<String> getUsers() => ['Alice', 'Bob'];

  @Post('/create')
  String createUser(String name) => 'Created: $name';

  void logRoutes() {
    print('  GET  /users/list   -> getUsers()');
    print('  POST /users/create -> createUser()');
  }
}

// Validation pattern
class SignupForm {
  @Required()
  @MinLength(3)
  @MaxLength(50)
  String username = '';

  @Required()
  @Email()
  String email = '';

  @Required()
  @MinLength(8)
  String password = '';

  @Range(min: 18, max: 120)
  int? age;
}
