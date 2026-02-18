/// Demonstrates Dart extensions
///
/// Features covered:
/// - Extension methods
/// - Extension getters/setters
/// - Extension operators
/// - Generic extensions
/// - Static extensions
/// - Extension types (Dart 3.3+)
/// - Named vs anonymous extensions
library;

void main() {
  print('=== Extensions ===');
  print('');

  // Basic extension method
  print('--- Basic Extension Method ---');
  var name = 'hello world';
  print('Original: $name');
  print('capitalize(): ${name.capitalize()}');
  print('reverse(): ${name.reverse()}');
  print('words: ${name.words}');

  // Extension on int
  print('');
  print('--- Extension on int ---');
  var n = 5;
  print('$n.isEven: ${n.isEven}');
  print('$n.squared: ${n.squared}');
  print('$n.cubed: ${n.cubed}');
  print('$n.times: ${n.times((i) => i * 2)}');

  // Duration extensions
  print('');
  print('--- Duration Extension ---');
  var duration = 5.seconds;
  print('5.seconds: $duration');
  print('3.minutes: ${3.minutes}');
  print('2.hours: ${2.hours}');
  print('1.days: ${1.days}');

  // Extension on List
  print('');
  print('--- Extension on List ---');
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('numbers: $numbers');
  print('sum: ${numbers.sum}');
  print('average: ${numbers.average}');
  print('secondOrNull: ${numbers.secondOrNull}');
  print('shuffled: ${numbers.shuffled()}');

  var empty = <int>[];
  print('empty.secondOrNull: ${empty.secondOrNull}');

  // Extension on Map
  print('');
  print('--- Extension on Map ---');
  var map = {'a': 1, 'b': 2, 'c': 3};
  print('map: $map');
  print('getOrDefault(a, 0): ${map.getOrDefault('a', 0)}');
  print('getOrDefault(z, 0): ${map.getOrDefault('z', 0)}');

  // Generic extension
  print('');
  print('--- Generic Extension ---');
  var items = ['apple', 'banana', 'cherry'];
  print('items: $items');
  print('firstOrNull: ${items.firstOrNull}');
  print('lastOrNull: ${items.lastOrNull}');

  List<String>? nullableList;
  print('nullableList.orEmpty: ${nullableList.orEmpty}');

  // Extension on DateTime
  print('');
  print('--- DateTime Extension ---');
  var now = DateTime.now();
  print('now: $now');
  print('formatted: ${now.formatted}');
  print('isWeekend: ${now.isWeekend}');
  print('tomorrow: ${now.tomorrow}');
  print('yesterday: ${now.yesterday}');

  // Extension with operators
  print('');
  print('--- Extension with Operators ---');
  var point1 = Point(1, 2);
  var point2 = Point(3, 4);
  print('$point1 + $point2 = ${point1 + point2}');
  print('$point1 * 2 = ${point1 * 2}');

  // Named vs anonymous extensions
  print('');
  print('--- Named Extension ---');
  var text = '  hello  ';
  print('trimmed and capitalized: ${text.trimAndCapitalize()}');

  // Extension on nullable types
  print('');
  print('--- Extension on Nullable Types ---');
  String? nullable;
  print('nullable.orEmpty: "${nullable.orEmpty}"');
  print('nullable.isNullOrEmpty: ${nullable.isNullOrEmpty}');

  nullable = 'hello';
  print('nullable (with value).isNullOrEmpty: ${nullable.isNullOrEmpty}');

  // Extension on enums
  print('');
  print('--- Extension on Enum ---');
  var status = Status.active;
  print('status: $status');
  print('displayName: ${status.displayName}');
  print('isActive: ${status.isActive}');

  // Extension types (Dart 3.3+)
  print('');
  print('--- Extension Types (Dart 3.3+) ---');
  var userId = UserId(123);
  print('UserId: ${userId.value}');
  print('UserId.isValid: ${userId.isValid}');

  var email = EmailAddress('user@example.com');
  print('Email: ${email.value}');
  print('Email domain: ${email.domain}');

  print('');
  print('=== End of Extensions Demo ===');
}

// Extension on String
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String reverse() {
    return split('').reversed.join();
  }

  List<String> get words => split(RegExp(r'\s+'));

  String trimAndCapitalize() => trim().capitalize();
}

// Extension on int
extension IntExtension on int {
  int get squared => this * this;
  int get cubed => this * this * this;

  List<T> times<T>(T Function(int) f) {
    return [for (var i = 0; i < this; i++) f(i)];
  }

  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
}

// Extension on List<int>
extension IntListExtension on List<int> {
  int get sum => fold(0, (a, b) => a + b);
  double get average => isEmpty ? 0 : sum / length;
}

// Generic extension on List
extension ListExtension<T> on List<T> {
  T? get secondOrNull => length >= 2 ? this[1] : null;

  List<T> shuffled() {
    var copy = List<T>.from(this);
    copy.shuffle();
    return copy;
  }
}

// Extension on Iterable
extension IterableExtension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
  T? get lastOrNull => isEmpty ? null : last;
}

// Extension on nullable List
extension NullableListExtension<T> on List<T>? {
  List<T> get orEmpty => this ?? [];
}

// Extension on Map
extension MapExtension<K, V> on Map<K, V> {
  V getOrDefault(K key, V defaultValue) {
    return containsKey(key) ? this[key] as V : defaultValue;
  }
}

// Extension on DateTime
extension DateTimeExtension on DateTime {
  String get formatted => '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;

  DateTime get tomorrow => add(const Duration(days: 1));
  DateTime get yesterday => subtract(const Duration(days: 1));
}

// Class for operator extension
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  String toString() => 'Point($x, $y)';
}

// Extension with operators
extension PointExtension on Point {
  Point operator +(Point other) => Point(x + other.x, y + other.y);
  Point operator *(int scalar) => Point(x * scalar, y * scalar);
}

// Extension on nullable String
extension NullableStringExtension on String? {
  String get orEmpty => this ?? '';
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

// Extension on enum
enum Status { active, inactive, pending }

extension StatusExtension on Status {
  String get displayName {
    return switch (this) {
      Status.active => 'Active',
      Status.inactive => 'Inactive',
      Status.pending => 'Pending',
    };
  }

  bool get isActive => this == Status.active;
}

// Extension type (Dart 3.3+)
extension type UserId(int value) {
  bool get isValid => value > 0;
}

extension type EmailAddress(String value) {
  String get domain => value.split('@').last;
  String get localPart => value.split('@').first;
}
