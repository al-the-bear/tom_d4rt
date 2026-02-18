/// Demonstrates Dart enums
///
/// Features covered:
/// - Simple enums
/// - Enhanced enums (with fields, constructors, methods)
/// - Enum properties (name, index, values)
/// - Implementing interfaces
/// - Using mixins
/// - Pattern matching with enums
library;

void main() {
  print('=== Enums ===');
  print('');

  // Simple enum
  print('--- Simple Enum ---');
  var today = Day.wednesday;
  print('Today is: $today');
  print('Name: ${today.name}');
  print('Index: ${today.index}');
  print('All days: ${Day.values}');

  // Switch with enum
  print('');
  print('--- Switch with Enum ---');
  var activity = switch (today) {
    Day.monday => 'Start of work week',
    Day.friday => 'Almost weekend!',
    Day.saturday || Day.sunday => 'Weekend!',
    _ => 'Regular work day'
  };
  print('Activity: $activity');

  // Iterating enum values
  print('');
  print('--- Iterating Enum Values ---');
  for (var day in Day.values) {
    print('  ${day.index}: ${day.name}');
  }

  // Enhanced enum with fields
  print('');
  print('--- Enhanced Enum with Fields ---');
  var spring = Season.spring;
  print('Season: ${spring.name}');
  print('Months: ${spring.months}');
  print('Average temp: ${spring.avgTemperature}°C');

  // All seasons
  print('');
  print('All seasons:');
  for (var season in Season.values) {
    print('  ${season.name}: ${season.months.join(", ")} (${season.avgTemperature}°C)');
  }

  // Enum with methods
  print('');
  print('--- Enum with Methods ---');
  var status = HttpStatus.ok;
  print('Status: ${status.code} ${status.name}');
  print('Is success: ${status.isSuccess}');
  print('Is error: ${status.isError}');
  print('Message: ${status.message}');

  print('');
  print('All HTTP statuses:');
  for (var s in HttpStatus.values) {
    print('  ${s.code}: ${s.message} (${s.isSuccess ? "success" : "error"})');
  }

  // Looking up by value
  print('');
  print('--- Lookup by Value ---');
  var found = HttpStatus.values.firstWhere(
    (s) => s.code == 404,
    orElse: () => HttpStatus.internalServerError,
  );
  print('Found status for 404: ${found.message}');

  // Implementing interfaces
  print('');
  print('--- Enum Implementing Interface ---');
  var ops = [Operation.add, Operation.subtract, Operation.multiply, Operation.divide];

  for (var op in ops) {
    var result = op.execute(10, 3);
    print('10 ${op.symbol} 3 = $result');
  }

  // Enum with mixins
  print('');
  print('--- Enum with Mixin ---');
  var debug = LogLevel.debug;
  print('Log level: ${debug.name}');
  print('Severity: ${debug.severity}');
  print('Should log warning for debug level: ${LogLevel.warning.shouldLog(debug)}');
  print('Should log info for debug level: ${LogLevel.info.shouldLog(debug)}');

  // Parsing enum
  print('');
  print('--- Parsing Enum ---');
  var dayName = 'friday';
  var parsedDay = Day.values.byName(dayName);
  print('Parsed "$dayName": $parsedDay');

  // Pattern matching
  print('');
  print('--- Pattern Matching ---');
  var priority = Priority.high;
  var (icon, color) = switch (priority) {
    Priority.low => ('⬇️', 'green'),
    Priority.medium => ('➡️', 'yellow'),
    Priority.high => ('⬆️', 'orange'),
    Priority.critical => ('🔥', 'red'),
  };
  print('Priority: $priority - Icon: $icon, Color: $color');

  // Enum as map key
  print('');
  print('--- Enum as Map Key ---');
  var permissions = {
    Role.admin: ['read', 'write', 'delete', 'admin'],
    Role.editor: ['read', 'write'],
    Role.viewer: ['read'],
  };

  var userRole = Role.editor;
  print('$userRole permissions: ${permissions[userRole]}');

  // Comparable enum
  print('');
  print('--- Comparable Enum ---');
  var levels = [LogLevel.warning, LogLevel.debug, LogLevel.error, LogLevel.info];
  levels.sort((a, b) => a.severity.compareTo(b.severity));
  print('Sorted by severity: ${levels.map((l) => l.name).join(", ")}');

  print('');
  print('=== End of Enums Demo ===');
}

// Simple enum
enum Day {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

// Enhanced enum with fields
enum Season {
  spring(['March', 'April', 'May'], 15),
  summer(['June', 'July', 'August'], 25),
  autumn(['September', 'October', 'November'], 12),
  winter(['December', 'January', 'February'], 2);

  final List<String> months;
  final int avgTemperature;

  const Season(this.months, this.avgTemperature);
}

// Enum with computed properties and methods
enum HttpStatus {
  ok(200, 'OK'),
  created(201, 'Created'),
  badRequest(400, 'Bad Request'),
  unauthorized(401, 'Unauthorized'),
  notFound(404, 'Not Found'),
  internalServerError(500, 'Internal Server Error');

  final int code;
  final String message;

  const HttpStatus(this.code, this.message);

  bool get isSuccess => code >= 200 && code < 300;
  bool get isError => code >= 400;
}

// Enum implementing interface
abstract class MathOperation {
  double execute(double a, double b);
}

enum Operation implements MathOperation {
  add('+'),
  subtract('-'),
  multiply('*'),
  divide('/');

  final String symbol;

  const Operation(this.symbol);

  @override
  double execute(double a, double b) {
    return switch (this) {
      Operation.add => a + b,
      Operation.subtract => a - b,
      Operation.multiply => a * b,
      Operation.divide => a / b,
    };
  }
}

// Enum with mixin
mixin LoggableMixin {
  int get severity;

  bool shouldLog(LogLevel minLevel) {
    return severity >= minLevel.severity;
  }
}

enum LogLevel with LoggableMixin {
  debug(0),
  info(1),
  warning(2),
  error(3);

  @override
  final int severity;

  const LogLevel(this.severity);
}

// Priority enum
enum Priority { low, medium, high, critical }

// Role enum
enum Role { viewer, editor, admin }
