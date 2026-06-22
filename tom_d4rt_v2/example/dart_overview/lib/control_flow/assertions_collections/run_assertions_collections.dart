/// Demonstrates Dart assertions and collection control flow
///
/// Features covered:
/// - assert statements
/// - Collection if
/// - Collection for

// Helper functions to prevent compile-time optimization
bool getBool(bool b) => b;
String? getString(String? s) => s;
int? getInt(int? i) => i;

void main() {
  print('=== Assertions and Collection Control Flow ===');
  print('');

  // Assertions (only run in debug mode)
  print('--- Assertions ---');
  print('Note: Assertions only run in debug mode (dart run --enable-asserts)');
  print('');

  int age = 25;
  assert(age >= 0, 'Age cannot be negative');
  print('Age $age passed assertion (age >= 0)');

  String name = 'Alice';
  assert(name.isNotEmpty, 'Name cannot be empty');
  print('Name "$name" passed assertion (not empty)');

  // Multiple assertions for validation
  void validateUser(String username, int age, String email) {
    assert(username.isNotEmpty, 'Username required');
    assert(age >= 0 && age <= 150, 'Age must be 0-150');
    assert(email.contains('@'), 'Invalid email format');
    print('User validated: $username, $age, $email');
  }

  validateUser('bob', 30, 'bob@example.com');

  // Assert with expression message
  int value = 42;
  assert(value > 0, 'Value must be positive, got: $value');
  print('Value $value passed assertion');

  // Collection if
  print('');
  print('--- Collection if ---');

  bool includeAdmin = getBool(true);
  var users = [
    'user1',
    'user2',
    if (includeAdmin) 'admin',
  ];
  print('Users (with admin): $users');

  includeAdmin = getBool(false);
  users = [
    'user1',
    'user2',
    if (includeAdmin) 'admin',
  ];
  print('Users (without admin): $users');

  // Collection if-else
  print('');
  bool isProduction = getBool(false);
  var config = {
    'name': 'MyApp',
    if (isProduction) 'apiUrl': 'https://api.example.com' else 'apiUrl': 'http://localhost:3000',
    if (isProduction) 'debug': false else 'debug': true,
  };
  print('Config (dev): $config');

  isProduction = getBool(true);
  config = {
    'name': 'MyApp',
    if (isProduction) 'apiUrl': 'https://api.example.com' else 'apiUrl': 'http://localhost:3000',
    if (isProduction) 'debug': false else 'debug': true,
  };
  print('Config (prod): $config');

  // Nested collection if
  print('');
  bool hasPermission = getBool(true);
  bool isOwner = getBool(false);
  var menuItems = [
    'View',
    if (hasPermission) ...[
      'Edit',
      if (isOwner) 'Delete',
    ],
    'Help',
  ];
  print('Menu (permission, not owner): $menuItems');

  isOwner = getBool(true);
  menuItems = [
    'View',
    if (hasPermission) ...[
      'Edit',
      if (isOwner) 'Delete',
    ],
    'Help',
  ];
  print('Menu (permission, owner): $menuItems');

  // Collection for
  print('');
  print('--- Collection for ---');

  var squares = [for (int i = 1; i <= 5; i++) i * i];
  print('Squares: $squares');

  var doubled = [for (var n in [1, 2, 3, 4, 5]) n * 2];
  print('Doubled: $doubled');

  // Collection for with if
  var evenNumbers = [for (int i = 1; i <= 10; i++) if (i % 2 == 0) i];
  print('Even numbers 1-10: $evenNumbers');

  // Nested collection for
  var pairs = [
    for (int i = 1; i <= 3; i++)
      for (int j = i + 1; j <= 3; j++) '($i, $j)',
  ];
  print('Pairs: $pairs');

  // Collection for with transformation
  var names = ['alice', 'bob', 'charlie'];
  var capitalized = [for (var name in names) name[0].toUpperCase() + name.substring(1)];
  print('Capitalized: $capitalized');

  // Building a Map with collection for
  print('');
  print('--- Building Maps ---');
  var indices = {for (var i = 0; i < names.length; i++) names[i]: i};
  print('Name indices: $indices');

  // Building a Set
  var uniqueChars = {for (var name in names) ...name.split('')};
  print('Unique characters: $uniqueChars');

  // Practical examples
  print('');
  print('--- Practical Examples ---');

  // Building widget children
  var items = ['Item 1', 'Item 2', 'Item 3'];
  bool showHeader = getBool(true);
  bool showFooter = getBool(false);

  var widgets = [
    if (showHeader) 'Header',
    for (var item in items) 'Content: $item',
    if (showFooter) 'Footer',
  ];
  print('Widgets: $widgets');

  // Flattening nested structure
  var nested = [
    [1, 2],
    [3, 4],
    [5, 6]
  ];
  var flat = [for (var list in nested) for (var item in list) item];
  print('Flattened: $flat');

  // Building query parameters
  String? searchTerm = getString(null);
  int? page = getInt(2);
  var queryParams = {
    if (searchTerm != null) 'q': searchTerm,
    if (page != null) 'page': page.toString(),
    'limit': '10',
  };
  print('Query params: $queryParams');

  print('');
  print('=== End of Assertions and Collection Control Flow Demo ===');
}
