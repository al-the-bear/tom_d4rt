part of 'model.dart';

/// Thrown when a requested element cannot be found.
class ElementNotFoundException implements Exception {
  final String message;

  ElementNotFoundException(this.message);

  @override
  String toString() => 'ElementNotFoundException: $message';
}

/// Thrown when a query returns multiple matching elements.
class AmbiguousElementException implements Exception {
  final String message;
  final List<String> candidates;

  AmbiguousElementException(this.message, {this.candidates = const []});

  @override
  String toString() {
    final buffer = StringBuffer('AmbiguousElementException: $message');
    if (candidates.isNotEmpty) {
      buffer.write('\nCandidates:\n');
      for (final candidate in candidates) {
        buffer.write('  - $candidate\n');
      }
    }
    return buffer.toString();
  }
}
