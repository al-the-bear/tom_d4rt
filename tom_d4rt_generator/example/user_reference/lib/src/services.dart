/// Service classes for the user reference example.
///
/// These demonstrate async methods, callbacks, and more advanced patterns.
library;

import 'data_models.dart';

/// A service for managing users.
class UserService {
  final List<User> _users = [];

  /// Create a new user service.
  UserService();

  /// Get all users.
  List<User> get users => List.unmodifiable(_users);

  /// Get a user by ID.
  User? getUserById(int id) {
    try {
      return _users.firstWhere((u) => u.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Add a new user.
  void addUser(User user) => _users.add(user);

  /// Remove a user by ID.
  bool removeUser(int id) {
    final index = _users.indexWhere((u) => u.id == id);
    if (index >= 0) {
      _users.removeAt(index);
      return true;
    }
    return false;
  }

  /// Find users matching a predicate.
  List<User> findUsers(bool Function(User) predicate) {
    return _users.where(predicate).toList();
  }

  /// Async method to simulate fetching a user.
  Future<User?> fetchUser(int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return getUserById(id);
  }
}

/// A service for managing products.
class ProductService {
  final Map<String, Product> _products = {};

  /// Create a new product service.
  ProductService();

  /// Get all products.
  List<Product> get products => _products.values.toList();

  /// Add or update a product.
  void setProduct(Product product) {
    _products[product.sku] = product;
  }

  /// Get a product by SKU.
  Product? getProduct(String sku) => _products[sku];

  /// Remove a product by SKU.
  bool removeProduct(String sku) => _products.remove(sku) != null;

  /// Get products that are in stock.
  List<Product> getInStockProducts() {
    return _products.values.where((p) => p.isInStock).toList();
  }

  /// Calculate total inventory value.
  int calculateInventoryValue() {
    return _products.values.fold(
      0,
      (sum, p) => sum + (p.priceInCents * p.quantity),
    );
  }
}

/// A simple event emitter pattern.
class EventEmitter<T> {
  final List<void Function(T)> _listeners = [];

  /// Create a new event emitter.
  EventEmitter();

  /// Add a listener.
  void addListener(void Function(T) listener) {
    _listeners.add(listener);
  }

  /// Remove a listener.
  void removeListener(void Function(T) listener) {
    _listeners.remove(listener);
  }

  /// Emit an event to all listeners.
  void emit(T event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }

  /// Clear all listeners.
  void clearListeners() => _listeners.clear();
}
