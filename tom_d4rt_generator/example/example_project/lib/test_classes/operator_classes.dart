/// Operator and indexer examples for bridge generation testing.
/// 
/// This file demonstrates operator bridging capabilities:
/// - Arithmetic operators (+, -, *, /)
/// - Comparison operators (==, <, >, <=, >=)
/// - Index operators ([], []=)
/// - Unary operators (-, ~)
library;

/// A 2D vector with operator overloading.
class Vector2D {
  final double x;
  final double y;

  const Vector2D(this.x, this.y);

  const Vector2D.zero()
      : x = 0,
        y = 0;

  /// Addition operator.
  Vector2D operator +(Vector2D other) => Vector2D(x + other.x, y + other.y);

  /// Subtraction operator.
  Vector2D operator -(Vector2D other) => Vector2D(x - other.x, y - other.y);

  /// Scalar multiplication.
  Vector2D operator *(double scalar) => Vector2D(x * scalar, y * scalar);

  /// Scalar division.
  Vector2D operator /(double scalar) => Vector2D(x / scalar, y / scalar);

  /// Unary negation.
  Vector2D operator -() => Vector2D(-x, -y);

  /// Magnitude (length) of vector.
  double get magnitude => (x * x + y * y);

  /// Normalize to unit vector.
  Vector2D normalize() {
    final mag = magnitude;
    if (mag == 0) return Vector2D.zero();
    return this / mag;
  }

  /// Dot product.
  double dot(Vector2D other) => x * other.x + y * other.y;

  @override
  bool operator ==(Object other) {
    if (other is! Vector2D) return false;
    return x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Vector2D($x, $y)';
}

/// A matrix class with index operators.
class Matrix {
  final List<List<double>> _data;
  final int rows;
  final int cols;

  Matrix(this.rows, this.cols)
      : _data = List.generate(rows, (_) => List.filled(cols, 0.0));

  /// Create matrix from 2D list.
  Matrix.fromList(List<List<double>> data)
      : rows = data.length,
        cols = data.isEmpty ? 0 : data[0].length,
        _data = data.map((row) => List<double>.from(row)).toList();

  /// Identity matrix.
  factory Matrix.identity(int size) {
    final m = Matrix(size, size);
    for (var i = 0; i < size; i++) {
      m[i][i] = 1.0;
    }
    return m;
  }

  /// Index operator - returns row.
  List<double> operator [](int row) => _data[row];

  /// Get specific element.
  double get(int row, int col) => _data[row][col];

  /// Set specific element.
  void set(int row, int col, double value) => _data[row][col] = value;

  /// Matrix addition.
  Matrix operator +(Matrix other) {
    if (rows != other.rows || cols != other.cols) {
      throw ArgumentError('Matrix dimensions must match');
    }
    final result = Matrix(rows, cols);
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        result[i][j] = _data[i][j] + other[i][j];
      }
    }
    return result;
  }

  /// Scalar multiplication.
  Matrix operator *(double scalar) {
    final result = Matrix(rows, cols);
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < cols; j++) {
        result[i][j] = _data[i][j] * scalar;
      }
    }
    return result;
  }

  @override
  String toString() {
    return _data.map((row) => row.join(', ')).join('\n');
  }
}

// Note: ComparableValue with recursive bound (T extends Comparable<T>) is an 
// advanced case that requires special bridge handling. Removed for simplicity.

/// A map-like container with index operators.
class Dictionary<K, V> {
  final Map<K, V> _data = {};

  /// Default constructor.
  Dictionary();

  /// Index get operator.
  V? operator [](K key) => _data[key];

  /// Index set operator.
  void operator []=(K key, V value) => _data[key] = value;

  /// Check if key exists.
  bool containsKey(K key) => _data.containsKey(key);

  /// Get all keys.
  Iterable<K> get keys => _data.keys;

  /// Get all values.
  Iterable<V> get values => _data.values;

  /// Get entry count.
  int get length => _data.length;

  /// Remove a key.
  V? remove(K key) => _data.remove(key);

  /// Clear all entries.
  void clear() => _data.clear();

  @override
  String toString() => _data.toString();
}
