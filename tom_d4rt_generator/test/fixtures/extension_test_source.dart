// ignore_for_file: unused_element

/// Test fixtures for extension bridge generation (GEN-047)

/// A simple extension on String with a getter
extension StringHelpers on String {
  bool get isPalindrome => this == split('').reversed.join();
  
  String get reversed => split('').reversed.join();
  
  String repeat(int times) {
    final sb = StringBuffer();
    for (var i = 0; i < times; i++) {
      sb.write(this);
    }
    return sb.toString();
  }
  
  String surround(String prefix, String suffix) => '$prefix$this$suffix';
}

/// An unnamed extension on int
extension on int {
  int get doubled => this * 2;
  
  int add(int other) => this + other;
}

/// Extension with setter
extension DateTimeHelpers on DateTime {
  String get isoDate => toIso8601String().split('T').first;
}

/// Private extension (should be skipped)
extension _PrivateExtension on String {
  String get secret => 'secret $this';
}

/// A class for testing extension resolution
class Point {
  final int x;
  final int y;
  Point(this.x, this.y);
}

/// Extension on a custom class
extension PointExtensions on Point {
  double get magnitude => (x * x + y * y).toDouble();
  
  Point add(Point other) => Point(x + other.x, y + other.y);
}
