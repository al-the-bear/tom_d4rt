/// A 2x2 matrix class that needs index operator overrides via UserBridge.
///
/// The `operator[]` takes a `List<int>` for multi-dimensional indexing,
/// which the generator cannot handle automatically.
library;

/// A 2x2 matrix with index operators.
class Matrix2x2 {
  final List<List<double>> _data;

  /// Create a matrix from four values: [[a, b], [c, d]].
  Matrix2x2(double a, double b, double c, double d)
      : _data = [
          [a, b],
          [c, d],
        ];

  /// Create an identity matrix.
  Matrix2x2.identity()
      : _data = [
          [1, 0],
          [0, 1],
        ];

  /// Get element at [row, col].
  double operator [](List<int> indices) {
    return _data[indices[0]][indices[1]];
  }

  /// Set element at [row, col].
  void operator []=(List<int> indices, double value) {
    _data[indices[0]][indices[1]] = value;
  }

  /// Get a row of the matrix.
  List<double> row(int index) => List.from(_data[index]);

  /// Get the determinant.
  double get determinant =>
      _data[0][0] * _data[1][1] - _data[0][1] * _data[1][0];

  /// Get the trace (sum of diagonal elements).
  double get trace => _data[0][0] + _data[1][1];

  @override
  String toString() => 'Matrix2x2([${_data[0]}, ${_data[1]}])';
}
