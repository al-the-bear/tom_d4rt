/// Test fixtures for bridge generator enum tests.
///
/// This file contains various enum definitions to test:
/// - Simple enums
/// - Enums with members (methods, getters)
/// - Enums with complex features
library;

// =============================================================================
// Simple Enums (no members)
// =============================================================================

/// A simple status enum with no members.
enum SimpleStatus {
  pending,
  active,
  completed,
  cancelled,
}

/// A simple color enum.
enum Color {
  red,
  green,
  blue,
}

/// A single-value enum (edge case).
enum Singleton {
  instance,
}

// =============================================================================
// Enums with Members
// =============================================================================

/// An enum with custom getters.
enum Priority {
  low,
  medium,
  high,
  critical;

  /// Returns a numeric priority level.
  int get level {
    switch (this) {
      case Priority.low:
        return 1;
      case Priority.medium:
        return 2;
      case Priority.high:
        return 3;
      case Priority.critical:
        return 4;
    }
  }

  /// Returns true if this is a high priority.
  bool get isHighPriority => this == high || this == critical;
}

/// An enum with methods.
enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete;

  /// Returns true if this method can have a body.
  bool canHaveBody() {
    return this == post || this == put || this == patch;
  }

  /// Returns the uppercase method name.
  String toUpperCase() => name.toUpperCase();
}

/// An enum with final fields (Dart 2.17+ enhanced enums).
enum Planet {
  mercury(3.303e+23, 2.4397e6),
  venus(4.869e+24, 6.0518e6),
  earth(5.976e+24, 6.37814e6),
  mars(6.421e+23, 3.3972e6);

  /// The mass of the planet in kilograms.
  final double mass;

  /// The radius of the planet in meters.
  final double radius;

  const Planet(this.mass, this.radius);

  /// Returns the surface gravity in m/s².
  double get surfaceGravity {
    const G = 6.67300E-11;
    return G * mass / (radius * radius);
  }
}

// =============================================================================
// Private Enums (should be skipped)
// =============================================================================

/// A private enum that should not be bridged.
// ignore: unused_element
enum _InternalState {
  // ignore: unused_field
  initializing,
  // ignore: unused_field
  ready,
  // ignore: unused_field
  disposed,
}

// =============================================================================
// Classes that use enums
// =============================================================================

/// A class that references enums in its fields.
class Task {
  final String id;
  final String title;
  final SimpleStatus status;
  final Priority priority;

  Task({
    required this.id,
    required this.title,
    this.status = SimpleStatus.pending,
    this.priority = Priority.medium,
  });
}

/// A class with enum parameters in methods.
class TaskManager {
  final List<Task> _tasks = [];

  /// Adds a task with the given priority.
  void addTask(String id, String title, {Priority priority = Priority.medium}) {
    _tasks.add(Task(id: id, title: title, priority: priority));
  }

  /// Filters tasks by status.
  List<Task> filterByStatus(SimpleStatus status) {
    return _tasks.where((t) => t.status == status).toList();
  }

  /// Returns all tasks with high priority or above.
  List<Task> getHighPriorityTasks() {
    return _tasks.where((t) => t.priority.isHighPriority).toList();
  }
}
