/// Test support types for D4rt bridge coverage testing
///
/// Contains types needed for specific test coverage scenarios:
/// - NumberWrapper: Custom arithmetic operators (OP05, OP06, OP07)
/// - BitFlags: Custom bitwise operators (OP12)
/// - NullableFields: Class with nullable instance fields (CLS05)
/// - LateFieldDemo: Class with late instance field (CLS06)
/// - MixinAppDemo: Mixin application class = with (TOP29)

// ============================================
// ARITHMETIC OPERATOR CLASS (OP05, OP06, OP07)
// ============================================

/// A number wrapper that provides custom arithmetic operators.
class NumberWrapper {
  final double value;

  const NumberWrapper(this.value);

  NumberWrapper operator +(NumberWrapper other) =>
      NumberWrapper(value + other.value);

  NumberWrapper operator -(NumberWrapper other) =>
      NumberWrapper(value - other.value);

  NumberWrapper operator *(NumberWrapper other) =>
      NumberWrapper(value * other.value);

  NumberWrapper operator /(NumberWrapper other) =>
      NumberWrapper(value / other.value);

  NumberWrapper operator ~/(NumberWrapper other) =>
      NumberWrapper((value ~/ other.value).toDouble());

  NumberWrapper operator %(NumberWrapper other) =>
      NumberWrapper(value % other.value);

  NumberWrapper operator -() => NumberWrapper(-value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberWrapper && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'NumberWrapper($value)';
}

// ============================================
// BITWISE OPERATOR CLASS (OP12)
// ============================================

/// A bit flags wrapper that provides custom bitwise operators.
class BitFlags {
  final int bits;

  const BitFlags(this.bits);

  BitFlags operator &(BitFlags other) => BitFlags(bits & other.bits);
  BitFlags operator |(BitFlags other) => BitFlags(bits | other.bits);
  BitFlags operator ^(BitFlags other) => BitFlags(bits ^ other.bits);
  BitFlags operator ~() => BitFlags(~bits);
  BitFlags operator <<(int shift) => BitFlags(bits << shift);
  BitFlags operator >>(int shift) => BitFlags(bits >> shift);

  bool hasFlag(int flag) => (bits & flag) != 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is BitFlags && bits == other.bits;

  @override
  int get hashCode => bits.hashCode;

  @override
  String toString() => 'BitFlags(0x${bits.toRadixString(16)})';
}

// ============================================
// NULLABLE FIELDS CLASS (CLS05)
// ============================================

/// A class with nullable instance fields for testing bridge null handling.
class NullableFields {
  String? name;
  int? age;
  List<String>? tags;

  NullableFields({this.name, this.age, this.tags});

  @override
  String toString() => 'NullableFields(name: $name, age: $age, tags: $tags)';
}

// ============================================
// LATE FIELD CLASS (CLS06)
// ============================================

/// A class with a late-initialized field.
class LateFieldDemo {
  late String config;
  late final int id;

  LateFieldDemo();

  LateFieldDemo.withValues(this.config, this.id);
}

// ============================================
// CALLABLE CLASS (CLS17)
// ============================================

/// A class with a call() method — makes instances callable.
class Multiplier {
  final int factor;
  const Multiplier(this.factor);

  int call(int value) => value * factor;

  @override
  String toString() => 'Multiplier($factor)';
}

// ============================================
// MIXIN APPLICATION (TOP29)
// ============================================

/// Base class for mixin application demo.
class Printable {
  void printInfo() {
    print('Printable: ${toString()}');
  }
}

/// A simple mixin for serialization.
mixin Serializable {
  String serialize() => toString();
}

/// Mixin application: `class = with` syntax (TOP29).
class SerializablePrintable = Printable with Serializable;

// ============================================
// BASE MIXIN (TOP15)
// ============================================

/// A base mixin — can only be used within the same library.
base mixin Trackable {
  int _trackCount = 0;

  int get trackCount => _trackCount;

  void track() {
    _trackCount++;
  }
}

/// Class using the base mixin.
base class TrackedItem with Trackable {
  final String name;
  TrackedItem(this.name);

  @override
  String toString() => 'TrackedItem($name, tracked: $trackCount)';
}

// ============================================
// ASYNC FUNCTIONS (TOP24, ASYNC01)
// ============================================

/// Simple async function returning `Future<String>`.
Future<String> fetchGreeting(String name) async {
  await Future.delayed(Duration(milliseconds: 10));
  return 'Hello, $name!';
}

/// Async function returning `Future<int>`.
Future<int> computeSum(List<int> numbers) async {
  await Future.delayed(Duration(milliseconds: 10));
  var sum = 0;
  for (var n in numbers) {
    sum += n;
  }
  return sum;
}

// ============================================
// MAIN (for standalone testing)
// ============================================

void main() {
  print('=== Test Support Types ===');

  // NumberWrapper
  var a = NumberWrapper(10);
  var b = NumberWrapper(3);
  print('$a / $b = ${a / b}');
  print('$a ~/ $b = ${a ~/ b}');
  print('$a % $b = ${a % b}');

  // BitFlags
  var f1 = BitFlags(0x0F);
  var f2 = BitFlags(0xF0);
  print('$f1 & $f2 = ${f1 & f2}');
  print('$f1 | $f2 = ${f1 | f2}');

  // NullableFields
  var nf = NullableFields(name: 'Test');
  print('NullableFields: $nf');
  print('age is null: ${nf.age == null}');

  // LateFieldDemo
  var lf = LateFieldDemo.withValues('cfg', 42);
  print('LateFieldDemo: config=${lf.config}, id=${lf.id}');

  print('=== End ===');
}
