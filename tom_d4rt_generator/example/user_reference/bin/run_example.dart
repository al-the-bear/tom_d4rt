// Run the User Reference example with D4rt.
//
// This script demonstrates a more complex example with
// data models and services.

import 'package:tom_d4rt/tom_d4rt.dart';

import '../lib/src/data_models.dart';
import '../lib/src/services.dart';
// Import generated bridge when available
// import 'user_reference_bridge.g.dart';

void main() async {
  print('=== User Reference Example ===\n');

  // Example 1: Using data models directly in Dart
  print('1. Using data models in Dart:');
  final user = User(id: 1, name: 'Alice', email: 'alice@example.com');
  print('   User: $user');

  final product = Product(
    sku: 'WIDGET-001',
    name: 'Super Widget',
    priceInCents: 1999,
    quantity: 50,
  );
  print('   Product: $product');

  final order = Order(orderId: 'ORD-001', customer: user);
  order.addItem(product);
  print('   Order: $order');

  // Example 2: Using services
  print('\n2. Using services in Dart:');
  final userService = UserService();
  userService.addUser(user);
  userService.addUser(User(id: 2, name: 'Bob'));
  print('   Users count: ${userService.users.length}');
  print('   Found user: ${userService.getUserById(1)}');

  final productService = ProductService();
  productService.setProduct(product);
  productService.setProduct(Product(
    sku: 'GADGET-002',
    name: 'Cool Gadget',
    priceInCents: 2499,
    quantity: 25,
  ));
  print('   In stock: ${productService.getInStockProducts().length} products');

  // Example 3: Async operations
  print('\n3. Async operations:');
  final fetchedUser = await userService.fetchUser(1);
  print('   Fetched: $fetchedUser');

  // Example 4: Event emitter
  print('\n4. Event emitter pattern:');
  final emitter = EventEmitter<String>();
  emitter.addListener((event) => print('   Event received: $event'));
  emitter.emit('Hello from EventEmitter!');

  // Example 5: Using with D4rt interpreter
  print('\n5. Running in D4rt (requires generated bridges):');
  print('   Note: Run the bridge generator first with:');
  print('   dart run tom_d4rt_generator --config d4rt_bridging.json');
  print('');

  // Once bridges are generated, you can run scripts like:
  //
  // final interpreter = D4rtInterpreter();
  // registerBridges(interpreter);
  //
  // final script = '''
  // import 'user_reference_example.dart';
  //
  // var user = User(id: 1, name: 'ScriptUser');
  // print(user.name);
  //
  // var service = UserService();
  // service.addUser(user);
  // ''';
  //
  // await interpreter.run(script);

  print('\n=== Example complete ===');
}
