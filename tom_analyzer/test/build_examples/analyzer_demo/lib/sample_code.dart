/// Sample code library for demonstrating tom_analyzer.
///
/// Contains various Dart constructs for analysis:
/// - Classes (abstract, concrete, with generics)
/// - Enums (simple and enhanced)
/// - Mixins
/// - Extensions
/// - Functions and methods

library;

// ============================================================================
// ENUMS
// ============================================================================

/// Simple enum for days of the week.
enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  /// Check if this is a weekend day.
  bool get isWeekend => this == saturday || this == sunday;
}

/// Enhanced enum with values.
enum Priority {
  low(1, 'Low Priority'),
  medium(2, 'Medium Priority'),
  high(3, 'High Priority'),
  critical(4, 'Critical Priority');

  const Priority(this.level, this.description);

  final int level;
  final String description;

  /// Check if this priority is urgent.
  bool get isUrgent => level >= 3;
}

// ============================================================================
// MIXINS
// ============================================================================

/// Mixin for objects that can be validated.
mixin Validatable {
  /// Validate this object.
  bool validate();

  /// Get validation errors.
  List<String> get validationErrors;
}

/// Mixin for objects that can be serialized.
mixin Serializable {
  /// Convert to JSON map.
  Map<String, dynamic> toJson();

  /// Create from JSON map.
  static T fromJson<T>(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

// ============================================================================
// ABSTRACT CLASSES
// ============================================================================

/// Base class for all entities with an ID.
abstract class Entity<T> {
  /// The unique identifier.
  T get id;

  /// When the entity was created.
  DateTime get createdAt;

  /// When the entity was last updated.
  DateTime? get updatedAt;
}

/// Interface for repositories.
abstract class Repository<T extends Entity<dynamic>> {
  /// Find an entity by ID.
  Future<T?> findById(dynamic id);

  /// Find all entities.
  Future<List<T>> findAll();

  /// Save an entity.
  Future<T> save(T entity);

  /// Delete an entity.
  Future<void> delete(T entity);
}

// ============================================================================
// CONCRETE CLASSES
// ============================================================================

/// A user in the system.
class User with Validatable, Serializable implements Entity<String> {
  User({
    required this.id,
    required this.email,
    required this.name,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  final String id;

  @override
  final DateTime createdAt;

  @override
  DateTime? updatedAt;

  /// The user's email address.
  final String email;

  /// The user's display name.
  String name;

  /// User's roles.
  final List<String> roles = [];

  /// Check if user has a specific role.
  bool hasRole(String role) => roles.contains(role);

  /// Add a role to the user.
  void addRole(String role) {
    if (!roles.contains(role)) {
      roles.add(role);
      updatedAt = DateTime.now();
    }
  }

  @override
  bool validate() => validationErrors.isEmpty;

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (email.isEmpty || !email.contains('@')) {
      errors.add('Invalid email address');
    }
    if (name.isEmpty) {
      errors.add('Name is required');
    }
    return errors;
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'roles': roles,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

/// A task with priority.
class Task with Validatable implements Entity<int> {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.priority = Priority.medium,
    DateTime? createdAt,
    this.updatedAt,
    this.dueDate,
  }) : createdAt = createdAt ?? DateTime.now();

  @override
  final int id;

  @override
  final DateTime createdAt;

  @override
  DateTime? updatedAt;

  /// Task title.
  String title;

  /// Optional description.
  String? description;

  /// Task priority.
  Priority priority;

  /// Optional due date.
  DateTime? dueDate;

  /// Whether the task is completed.
  bool isCompleted = false;

  /// Mark the task as complete.
  void complete() {
    isCompleted = true;
    updatedAt = DateTime.now();
  }

  /// Check if the task is overdue.
  bool get isOverdue =>
      dueDate != null && !isCompleted && DateTime.now().isAfter(dueDate!);

  @override
  bool validate() => validationErrors.isEmpty;

  @override
  List<String> get validationErrors {
    final errors = <String>[];
    if (title.isEmpty) {
      errors.add('Title is required');
    }
    return errors;
  }
}

/// Generic result wrapper.
class Result<T, E> {
  Result.success(this._value) : _error = null;
  Result.failure(this._error) : _value = null;

  final T? _value;
  final E? _error;

  /// Whether this is a success.
  bool get isSuccess => _error == null;

  /// Whether this is a failure.
  bool get isFailure => _error != null;

  /// Get the value (throws if failure).
  T get value {
    if (isFailure) throw StateError('Cannot get value from failure');
    return _value as T;
  }

  /// Get the error (throws if success).
  E get error {
    if (isSuccess) throw StateError('Cannot get error from success');
    return _error as E;
  }

  /// Map the success value.
  Result<U, E> map<U>(U Function(T) transform) {
    if (isSuccess) {
      return Result.success(transform(value));
    }
    return Result.failure(error);
  }
}

// ============================================================================
// EXTENSIONS
// ============================================================================

/// Extensions on String.
extension StringExtensions on String {
  /// Capitalize the first letter.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Convert to title case.
  String toTitleCase() {
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Check if string is a valid email.
  bool get isValidEmail => contains('@') && contains('.');
}

/// Extensions on List.
extension ListExtensions<T> on List<T> {
  /// Get first element or null.
  T? get firstOrNull => isEmpty ? null : first;

  /// Get last element or null.
  T? get lastOrNull => isEmpty ? null : last;

  /// Chunk the list into smaller lists.
  List<List<T>> chunked(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

// ============================================================================
// TOP-LEVEL FUNCTIONS
// ============================================================================

/// Create a unique ID.
String generateId() => DateTime.now().millisecondsSinceEpoch.toRadixString(36);

/// Calculate the sum of a list of numbers.
num sum(List<num> numbers) => numbers.fold(0, (a, b) => a + b);

/// Calculate the average of a list of numbers.
double average(List<num> numbers) {
  if (numbers.isEmpty) return 0;
  return sum(numbers) / numbers.length;
}

/// Debounce a function call.
Future<T> debounce<T>(
  Duration delay,
  Future<T> Function() action,
) async {
  await Future.delayed(delay);
  return action();
}

// ============================================================================
// TYPE ALIASES
// ============================================================================

/// Type alias for JSON objects.
typedef JsonObject = Map<String, dynamic>;

/// Type alias for async result.
typedef AsyncResult<T> = Future<Result<T, Exception>>;

/// Type alias for entity factory.
typedef EntityFactory<T extends Entity<dynamic>> = T Function(JsonObject json);
