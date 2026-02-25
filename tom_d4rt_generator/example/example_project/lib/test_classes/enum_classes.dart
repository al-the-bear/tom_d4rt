/// Enum examples for bridge generation testing.
/// 
/// This file demonstrates enum bridging capabilities:
/// - Simple enums
/// - Enhanced enums with values
/// - Enums with methods
/// - Enums implementing interfaces
library;

/// Simple status enum.
enum Status {
  pending,
  active,
  completed,
  cancelled,
}

/// Priority enum with comparable integer values.
enum Priority implements Comparable<Priority> {
  low(1),
  medium(2),
  high(3),
  critical(4);

  final int value;

  const Priority(this.value);

  @override
  int compareTo(Priority other) => value.compareTo(other.value);

  bool operator <(Priority other) => value < other.value;
  bool operator >(Priority other) => value > other.value;

  static Priority fromValue(int value) {
    return Priority.values.firstWhere(
      (p) => p.value == value,
      orElse: () => Priority.medium,
    );
  }
}

/// Color enum with RGB values.
enum Color {
  red(255, 0, 0),
  green(0, 255, 0),
  blue(0, 0, 255),
  white(255, 255, 255),
  black(0, 0, 0),
  yellow(255, 255, 0),
  cyan(0, 255, 255),
  magenta(255, 0, 255);

  final int r;
  final int g;
  final int b;

  const Color(this.r, this.g, this.b);

  /// Get hex representation.
  String get hex {
    final rHex = r.toRadixString(16).padLeft(2, '0');
    final gHex = g.toRadixString(16).padLeft(2, '0');
    final bHex = b.toRadixString(16).padLeft(2, '0');
    return '#$rHex$gHex$bHex'.toUpperCase();
  }

  /// Get brightness (0-255).
  int get brightness => ((r + g + b) / 3).round();

  /// Check if color is dark.
  bool get isDark => brightness < 128;

  /// Check if color is light.
  bool get isLight => brightness >= 128;

  /// Get inverted color values.
  (int, int, int) get inverted => (255 - r, 255 - g, 255 - b);

  /// Static factory to find by name.
  static Color? byName(String name) {
    for (final color in values) {
      if (color.name == name.toLowerCase()) return color;
    }
    return null;
  }
}

/// HTTP method enum.
enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE'),
  head('HEAD'),
  options('OPTIONS');

  final String value;

  const HttpMethod(this.value);

  bool get isIdempotent => this == get || this == put || this == delete || this == head;

  bool get hasBody => this == post || this == put || this == patch;

  static HttpMethod fromString(String method) {
    final upper = method.toUpperCase();
    return HttpMethod.values.firstWhere(
      (m) => m.value == upper,
      orElse: () => HttpMethod.get,
    );
  }
}

/// Day of week enum with utility methods.
enum DayOfWeek {
  monday(1, 'Mon'),
  tuesday(2, 'Tue'),
  wednesday(3, 'Wed'),
  thursday(4, 'Thu'),
  friday(5, 'Fri'),
  saturday(6, 'Sat'),
  sunday(7, 'Sun');

  final int number;
  final String shortName;

  const DayOfWeek(this.number, this.shortName);

  /// Check if weekend.
  bool get isWeekend => this == saturday || this == sunday;

  /// Check if weekday.
  bool get isWeekday => !isWeekend;

  /// Get next day.
  DayOfWeek get next {
    final nextIndex = (index + 1) % 7;
    return DayOfWeek.values[nextIndex];
  }

  /// Get previous day.
  DayOfWeek get previous {
    final prevIndex = (index - 1 + 7) % 7;
    return DayOfWeek.values[prevIndex];
  }

  /// Get day from number (1-7).
  static DayOfWeek fromNumber(int number) {
    return DayOfWeek.values.firstWhere(
      (d) => d.number == number,
      orElse: () => DayOfWeek.monday,
    );
  }

  /// Get today's day (for demo, returns monday).
  static DayOfWeek today() => DayOfWeek.monday;
}
