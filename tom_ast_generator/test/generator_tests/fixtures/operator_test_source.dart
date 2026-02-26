/// Test source for operator bridge generation.
library test_package.operator_test;

/// Class with arithmetic operators.
class Vector2 {
  final double x;
  final double y;

  Vector2(this.x, this.y);

  Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);
  Vector2 operator -(Vector2 other) => Vector2(x - other.x, y - other.y);
  Vector2 operator *(double scalar) => Vector2(x * scalar, y * scalar);
  Vector2 operator /(double scalar) => Vector2(x / scalar, y / scalar);
  Vector2 operator -() => Vector2(-x, -y);
}

/// Class with index operators.
class Container {
  final List<int> _items = [];

  void add(int item) => _items.add(item);

  int operator [](int index) => _items[index];
  void operator []=(int index, int value) => _items[index] = value;
}

/// Class with bitwise operators.
class BitMask {
  final int value;

  BitMask(this.value);

  BitMask operator &(BitMask other) => BitMask(value & other.value);
  BitMask operator |(BitMask other) => BitMask(value | other.value);
  BitMask operator ^(BitMask other) => BitMask(value ^ other.value);
  BitMask operator ~() => BitMask(~value);
  BitMask operator <<(int shift) => BitMask(value << shift);
  BitMask operator >>(int shift) => BitMask(value >> shift);
}

/// Class with comparison operators.
class ComparableValue {
  final int value;

  ComparableValue(this.value);

  bool operator <(ComparableValue other) => value < other.value;
  bool operator >(ComparableValue other) => value > other.value;
  bool operator <=(ComparableValue other) => value <= other.value;
  bool operator >=(ComparableValue other) => value >= other.value;

  @override
  bool operator ==(Object other) =>
      other is ComparableValue && value == other.value;

  @override
  int get hashCode => value.hashCode;
}

/// Class with mixed methods and operators.
class MixedClass {
  final int value;

  MixedClass(this.value);

  MixedClass operator +(MixedClass other) => MixedClass(value + other.value);

  int add(int x, int y) => x + y;
}
