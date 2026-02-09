/// Test fixture: Pure mixin declarations for GEN-048 testing.
///
/// This file contains pure `mixin` declarations (not `mixin class`)
/// to verify the generator correctly bridges them.

/// A simple mixin without type constraint
mixin Printable {
  /// Print self in a custom format
  void printFormatted() {
    print('Printable: $this');
  }
  
  /// Get a string representation
  String get displayString => toString();
}

/// A mixin with an `on` clause constraint
mixin JsonSerializable on Object {
  /// Convert to JSON map
  Map<String, dynamic> toMap() => {};
  
  /// Convert to JSON string
  String toJsonString() => '{}';
}

/// A generic mixin
mixin Comparable<T> {
  /// Compare with another value
  int compareTo(T other);
  
  /// Check if greater than
  bool isGreaterThan(T other) => compareTo(other) > 0;
}

/// A mixin with getters and setters
mixin Nameable {
  String _name = '';
  
  /// Get the name
  String get name => _name;
  
  /// Set the name
  set name(String value) => _name = value;
}

/// A private mixin (should be skipped)
mixin _PrivateMixin {
  void secretMethod() {}
}

/// A class that uses multiple mixins
class TestEntity with Printable, Nameable {
  final int id;
  
  TestEntity(this.id);
  
  @override
  String toString() => 'TestEntity($id)';
}
