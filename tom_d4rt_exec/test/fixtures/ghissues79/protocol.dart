// GitHub #23's `protocol.dart` (ghissues79), plus the constructor shapes
// ghissues79 adds: a generative and an implicit constructor, a named one and
// a generic class. Imported with a prefix by `main.dart`; valid Dart, so the
// tests run it natively too.

/// Mirrors the generated Serverpod Protocol imported with a prefix.
class Protocol {
  /// Creates the stable singleton used by the factory.
  Protocol._(this.value);

  final int value;

  static final Protocol _instance = Protocol._(11);

  /// Matches the unnamed factory form emitted by Serverpod's generated Protocol.
  factory Protocol() => _instance;
}

/// An ordinary generative constructor.
class Plain {
  Plain(this.value);

  final int value;
}

/// No constructor written: the implicit default one.
class Implicit {
  final int value = 5;
}

/// A generic class with an unnamed and a named constructor.
class Box<T> {
  Box(this.value);

  Box.named(this.value, String label) : tag = label;

  final T value;
  String tag = 'unnamed';

  String describe() => '$T:$value:$tag';
}
