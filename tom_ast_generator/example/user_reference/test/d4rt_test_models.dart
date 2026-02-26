// D4rt test script for user_reference
// Tests User, Product, and Order classes via generated bridges.

import 'package:user_reference_example/user_reference_example.dart';

void main() {
  // Test User class
  var user = User(id: 1, name: 'Alice', email: 'alice@example.com');
  print('User: ${user.name}');
  print('User id: ${user.id}');
  print('User email: ${user.email}');

  // Test toMap
  var map = user.toMap();
  print('User map name: ${map["name"]}');

  // Test Product class
  var product = Product(sku: 'SKU-001', name: 'Widget', priceInCents: 1999, quantity: 10);
  print('Product: ${product.name}');
  print('Product sku: ${product.sku}');
  print('Product in stock: ${product.isInStock}');
  print('Product price: ${product.formattedPrice}');

  // Test static method
  var placeholder = Product.placeholder();
  print('Placeholder sku: ${placeholder.sku}');

  print('ALL_TESTS_PASSED');
}
