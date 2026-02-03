/// Data models for the user reference example.
///
/// These classes demonstrate various patterns that the bridge generator
/// handles: constructors, getters/setters, methods, static members.
library;

/// A simple user model with various field types.
class User {
  /// The user's unique identifier.
  final int id;

  /// The user's name.
  String name;

  /// The user's email.
  String? email;

  /// Creates a new user.
  User({
    required this.id,
    required this.name,
    this.email,
  });

  /// Creates a user from a map.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String?,
    );
  }

  /// Converts to a map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

/// A product model with pricing.
class Product {
  /// The product ID.
  final String sku;

  /// The product name.
  final String name;

  /// The price in cents.
  int priceInCents;

  /// The quantity in stock.
  int quantity;

  /// Creates a new product.
  Product({
    required this.sku,
    required this.name,
    this.priceInCents = 0,
    this.quantity = 0,
  });

  /// Get the price formatted as dollars.
  String get formattedPrice {
    final dollars = priceInCents ~/ 100;
    final cents = priceInCents % 100;
    return '\$$dollars.${cents.toString().padLeft(2, '0')}';
  }

  /// Check if in stock.
  bool get isInStock => quantity > 0;

  /// Static method to create a placeholder.
  static Product placeholder() => Product(sku: 'PLACEHOLDER', name: 'TBD');

  @override
  String toString() =>
      'Product(sku: $sku, name: $name, price: $formattedPrice, qty: $quantity)';
}

/// An order containing multiple products.
class Order {
  /// The order ID.
  final String orderId;

  /// The customer who placed the order.
  final User customer;

  /// The products in the order.
  final List<Product> items;

  /// When the order was created.
  final DateTime createdAt;

  /// Creates a new order.
  Order({
    required this.orderId,
    required this.customer,
    List<Product>? items,
    DateTime? createdAt,
  })  : items = items ?? [],
        createdAt = createdAt ?? DateTime.now();

  /// Add an item to the order.
  void addItem(Product product) => items.add(product);

  /// Get the total price in cents.
  int get totalPriceInCents =>
      items.fold(0, (sum, p) => sum + p.priceInCents);

  /// Get the total price formatted.
  String get formattedTotal {
    final cents = totalPriceInCents;
    final dollars = cents ~/ 100;
    final remainder = cents % 100;
    return '\$$dollars.${remainder.toString().padLeft(2, '0')}';
  }

  @override
  String toString() =>
      'Order($orderId: ${items.length} items, total: $formattedTotal)';
}
