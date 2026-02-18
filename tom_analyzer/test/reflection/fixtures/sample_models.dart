/// Sample classes for testing reflection code generation.
library;

/// A simple user model class.
class User {
  final String name;
  final int age;
  final String? email;

  User({required this.name, required this.age, this.email});

  factory User.guest() => User(name: 'Guest', age: 0);

  String get fullInfo => '$name ($age)';

  bool isAdult() => age >= 18;

  @override
  String toString() => 'User($name)';
}

/// An abstract base class.
abstract class Entity {
  String get id;
  DateTime get createdAt;
}

/// A mixin for trackable items.
mixin Trackable {
  DateTime? lastAccessed;

  void track() {
    lastAccessed = DateTime.now();
  }
}

/// A class using mixin.
class TrackedUser extends User with Trackable {
  final String trackingId;

  TrackedUser({
    required super.name,
    required super.age,
    super.email,
    required this.trackingId,
  });
}

/// An enum for user roles.
enum UserRole {
  admin,
  editor,
  viewer,
  guest;

  bool get canEdit => this == admin || this == editor;
}

/// A generic repository class.
class Repository<T extends Entity> {
  final List<T> _items = [];

  void add(T item) => _items.add(item);
  T? findById(String id) => _items.where((e) => e.id == id).firstOrNull;
  List<T> getAll() => List.unmodifiable(_items);
}

/// An extension on String.
extension StringUtils on String {
  String toTitleCase() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  bool get isBlank => trim().isEmpty;
}

/// A top-level function.
String greet(String name) => 'Hello, $name!';

/// A top-level constant.
const appVersion = '1.0.0';

/// A top-level variable.
int requestCounter = 0;
