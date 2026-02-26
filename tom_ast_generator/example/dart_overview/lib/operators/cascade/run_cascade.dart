/// Demonstrates Dart cascade operators
///
/// Features covered:
/// - Standard cascade (..)
/// - Null-aware cascade (?..)

void main() {
  print('=== Cascade Operators ===');
  print('');

  // Standard cascade
  print('--- Standard Cascade (..) ---');

  // Without cascade
  var list1 = <int>[];
  list1.add(1);
  list1.add(2);
  list1.add(3);
  print('Without cascade: $list1');

  // With cascade
  var list2 = <int>[]
    ..add(4)
    ..add(5)
    ..add(6);
  print('With cascade: $list2');

  // Cascade on object
  var buffer = StringBuffer()
    ..write('Hello')
    ..write(' ')
    ..write('World')
    ..write('!');
  print('StringBuffer cascade: $buffer');

  // Method chaining vs cascade
  print('');
  print('--- Method Chaining vs Cascade ---');

  // Method chaining (methods return this)
  var builder1 = StringBuilder()
      .append('Hello')
      .append(' ')
      .append('World');
  print('Method chaining: ${builder1.build()}');

  // Cascade (works even if methods return void)
  var person = Person()
    ..name = 'Alice'
    ..age = 30
    ..greet();

  print('Cascade on Person: ${person.name}, ${person.age}');

  // Cascade with return value
  print('');
  print('--- Cascade with Final Value ---');

  // Get the object after cascading
  var configured = (Config()
        ..host = 'localhost'
        ..port = 8080
        ..debug = true)
      .toString(); // Gets the result after cascade
  print('Configured: $configured');

  // Nested cascade (rare but possible)
  print('');
  print('--- Nested Operations ---');
  var team = Team()
    ..name = 'Engineering'
    ..members.add('Alice')
    ..members.add('Bob')
    ..members.add('Charlie');
  print('Team: ${team.name}, Members: ${team.members}');

  // Null-aware cascade
  print('');
  print('--- Null-Aware Cascade (?..) ---');

  Person? maybePerson = getPerson(Person());
  maybePerson
    ?..name = 'Bob'
    ..age = 25
    ..greet();
  print('maybePerson: ${maybePerson?.name}, ${maybePerson?.age}');

  maybePerson = getPerson(null);
  maybePerson
    ?..name = 'Charlie' // None of these execute
    ..age = 35
    ..greet();
  print('null person (no cascade executed): $maybePerson');

  // Practical examples
  print('');
  print('--- Practical Examples ---');

  // Building UI widget tree (pseudo-code style)
  var widget = Container()
    ..width = 100
    ..height = 50
    ..color = 'blue'
    ..children.add(Text()..content = 'Hello')
    ..children.add(Text()..content = 'World');
  print('Widget: $widget');

  // Configuring HTTP request
  var request = HttpRequest()
    ..url = 'https://api.example.com/data'
    ..method = 'POST'
    ..headers['Content-Type'] = 'application/json'
    ..headers['Authorization'] = 'Bearer token123'
    ..body = '{"key": "value"}';
  print('Request: ${request.method} ${request.url}');
  print('Headers: ${request.headers}');

  // Building complex objects
  var query = QueryBuilder()
    ..select(['name', 'email'])
    ..from('users')
    ..where('active', true)
    ..orderBy('name')
    ..limit(10);
  print('Query: ${query.build()}');

  print('');
  print('=== End of Cascade Operators Demo ===');
}

// Helper classes

class StringBuilder {
  final _buffer = StringBuffer();

  StringBuilder append(String s) {
    _buffer.write(s);
    return this;
  }

  String build() => _buffer.toString();
}

class Person {
  String name = '';
  int age = 0;

  void greet() {
    print('Hello, I am $name!');
  }
}

class Config {
  String host = '';
  int port = 0;
  bool debug = false;

  @override
  String toString() => 'Config(host: $host, port: $port, debug: $debug)';
}

class Team {
  String name = '';
  List<String> members = [];
}

class Container {
  int width = 0;
  int height = 0;
  String color = '';
  List<Text> children = [];

  @override
  String toString() =>
      'Container($width x $height, $color, ${children.length} children)';
}

class Text {
  String content = '';

  @override
  String toString() => 'Text($content)';
}

class HttpRequest {
  String url = '';
  String method = '';
  Map<String, String> headers = {};
  String body = '';
}

class QueryBuilder {
  final List<String> _select = [];
  String _from = '';
  final Map<String, dynamic> _where = {};
  String _orderBy = '';
  int _limit = 0;

  void select(List<String> columns) => _select.addAll(columns);
  void from(String table) => _from = table;
  void where(String column, dynamic value) => _where[column] = value;
  void orderBy(String column) => _orderBy = column;
  void limit(int n) => _limit = n;

  String build() {
    return 'SELECT ${_select.join(', ')} FROM $_from '
        'WHERE $_where ORDER BY $_orderBy LIMIT $_limit';
  }
}

// Helper function to prevent compile-time optimization
Person? getPerson(Person? p) => p;
