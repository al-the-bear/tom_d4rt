/// Demonstrates Dart function parameters
///
/// Features covered:
/// - Positional parameters
/// - Named parameters
/// - Optional positional parameters
/// - Default values
/// - Required named parameters

void main() {
  print('=== Function Parameters ===');
  print('');

  // Required positional parameters
  print('--- Required Positional Parameters ---');
  print('greet("Alice"): ${greet('Alice')}');
  print('add(5, 3): ${add(5, 3)}');
  print('fullName("John", "Doe"): ${fullName('John', 'Doe')}');

  // Named parameters (optional by default)
  print('');
  print('--- Named Parameters ---');
  describe(name: 'Alice');
  describe(name: 'Bob', age: 30);
  describe(name: 'Charlie', age: 25, city: 'NYC');

  // Order does not matter for named parameters
  describe(city: 'LA', name: 'Diana', age: 28);

  // Required named parameters
  print('');
  print('--- Required Named Parameters ---');
  createUser(name: 'Eve', email: 'eve@example.com');
  createUser(name: 'Frank', email: 'frank@example.com', role: 'admin');

  // Optional positional parameters
  print('');
  print('--- Optional Positional Parameters ---');
  print('sayHello(): ${sayHello()}');
  print('sayHello("Bob"): ${sayHello('Bob')}');
  print('sayHello("Charlie", "Hi"): ${sayHello('Charlie', 'Hi')}');

  // Default values
  print('');
  print('--- Default Parameter Values ---');
  print('power(2): ${power(2)}');
  print('power(2, 3): ${power(2, 3)}');
  print('power(2, 10): ${power(2, 10)}');

  // Default values with named parameters
  print('');
  makeRequest('/api/users');
  makeRequest('/api/data', method: 'POST');
  makeRequest('/api/items', method: 'PUT', timeout: 10);

  // Mixed parameter types
  print('');
  print('--- Mixed Parameter Types ---');
  processOrder('ORD-001', 'laptop', quantity: 2);
  processOrder('ORD-002', 'mouse', quantity: 5, priority: 'high');

  // Function type parameters
  print('');
  print('--- Function as Parameter ---');
  var numbers = [1, 2, 3, 4, 5];
  var result = transform(numbers, (n) => n * 2);
  print('transform([1,2,3,4,5], n*2): $result');

  result = transform(numbers, (n) => n * n);
  print('transform([1,2,3,4,5], n*n): $result');

  // Callback with named parameter
  fetchData(
    url: 'https://api.example.com',
    onSuccess: (data) => print('  Success: $data'),
    onError: (error) => print('  Error: $error'),
  );

  print('');
  print('=== End of Function Parameters Demo ===');
}

// Required positional parameters
String greet(String name) => 'Hello, $name!';

int add(int a, int b) => a + b;

String fullName(String first, String last) => '$first $last';

// Named parameters (optional by default, with defaults)
void describe({required String name, int? age, String? city}) {
  var parts = ['Name: $name'];
  if (age != null) parts.add('Age: $age');
  if (city != null) parts.add('City: $city');
  print('  ${parts.join(', ')}');
}

// Required named parameters
void createUser({
  required String name,
  required String email,
  String role = 'user',
}) {
  print('  Created user: $name ($email) - Role: $role');
}

// Optional positional parameters (in square brackets)
String sayHello([String name = 'World', String greeting = 'Hello']) {
  return '$greeting, $name!';
}

// Default parameter values
int power(int base, [int exponent = 2]) {
  int result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

// Default values with named parameters
void makeRequest(
  String url, {
  String method = 'GET',
  int timeout = 30,
  Map<String, String>? headers,
}) {
  print('  $method $url (timeout: ${timeout}s)');
}

// Mixed: positional required, positional optional, named
void processOrder(
  String orderId,
  String product, {
  required int quantity,
  String priority = 'normal',
}) {
  print('  Order $orderId: $quantity x $product (priority: $priority)');
}

// Function type as parameter
List<int> transform(List<int> numbers, int Function(int) transformer) {
  return numbers.map(transformer).toList();
}

// Callback functions as named parameters
void fetchData({
  required String url,
  required void Function(String) onSuccess,
  required void Function(String) onError,
}) {
  print('  Fetching $url...');
  // Simulate success
  onSuccess('{"data": "sample"}');
}
