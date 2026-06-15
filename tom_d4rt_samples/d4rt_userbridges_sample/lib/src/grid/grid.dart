/// A 2D grid whose index operators take a `List<int>` coordinate.
///
/// `operator[]` with a composite (`List<int>`) key is exactly the shape the
/// generator cannot bridge automatically — it expects a single scalar index.
/// [GridUserBridge] supplies the index operators by hand while the generator
/// still bridges the ordinary members ([rows], [cols], [sum], [fill]).
library;

/// A dense row-major grid of numbers addressed by `grid[[row, col]]`.
class Grid {
  /// Number of rows.
  final int rows;

  /// Number of columns.
  final int cols;

  final List<num> _data;

  /// Create a [rows] x [cols] grid initialised to zero.
  Grid(this.rows, this.cols) : _data = List<num>.filled(rows * cols, 0);

  /// Read the cell at `[row, col]`.
  num operator [](List<int> rc) => _data[_offset(rc)];

  /// Write [value] into the cell at `[row, col]`.
  void operator []=(List<int> rc, num value) => _data[_offset(rc)] = value;

  /// The sum of every cell.
  num get sum => _data.fold<num>(0, (acc, v) => acc + v);

  /// Set every cell to [value].
  void fill(num value) {
    for (var i = 0; i < _data.length; i++) {
      _data[i] = value;
    }
  }

  int _offset(List<int> rc) {
    if (rc.length != 2) {
      throw ArgumentError('Expected [row, col], got $rc');
    }
    final row = rc[0];
    final col = rc[1];
    if (row < 0 || row >= rows || col < 0 || col >= cols) {
      throw RangeError('Index $rc out of bounds for ${rows}x$cols grid');
    }
    return row * cols + col;
  }

  @override
  String toString() => 'Grid(${rows}x$cols, sum: $sum)';
}
