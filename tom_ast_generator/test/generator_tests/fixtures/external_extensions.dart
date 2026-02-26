/// Test fixture: Extensions defined in a separate file that will be imported.
/// Used to test GEN-049: Extension methods on bridged classes from imports.

/// Extension on int for testing import discovery
extension ImportedIntHelpers on int {
  /// Double the value
  int get doubled => this * 2;
  
  /// Check if even
  bool get isEvenNumber => this % 2 == 0;
  
  /// Add a value
  int plus(int other) => this + other;
}

/// Extension on List for testing generic type matching
extension ImportedListHelpers<T> on List<T> {
  /// Get first or null
  T? get firstOrNull => isEmpty ? null : first;
  
  /// Append and return the list
  List<T> appended(T item) => [...this, item];
}
