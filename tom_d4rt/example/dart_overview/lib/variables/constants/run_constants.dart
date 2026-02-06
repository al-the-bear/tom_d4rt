/// Demonstrates Dart constants
///
/// Features covered:
/// - static const (class-level)
/// - const constructors
/// - Top-level constants

void main() {
  print('=== Constants ===\n');

  // Top-level constants
  print('--- Top-Level Constants ---');
  print('pi: $pi');
  print('e: $e');
  print('appName: $appName');
  print('maxRetries: $maxRetries');

  // Class with static constants
  print('\n--- Static Constants (Class-Level) ---');
  print('Colors.red: ${Colors.red}');
  print('Colors.green: ${Colors.green}');
  print('Colors.blue: ${Colors.blue}');
  print('Colors.defaultColor: ${Colors.defaultColor}');

  print('\nHttpStatus codes:');
  print('OK: ${HttpStatus.ok}');
  print('NOT_FOUND: ${HttpStatus.notFound}');
  print('SERVER_ERROR: ${HttpStatus.serverError}');

  // Const constructors
  print('\n--- Const Constructors ---');
  const point1 = Point(0, 0);
  const point2 = Point(0, 0);
  const point3 = Point(1, 1);

  print('point1: $point1');
  print('point2: $point2');
  print('point3: $point3');
  print('point1 == point2: ${point1 == point2}');
  print('identical(point1, point2): ${identical(point1, point2)}'); // true!

  // Non-const instances of const-capable class
  var point4 = Point(0, 0); // Not const
  print('point4: $point4');
  print('identical(point1, point4): ${identical(point1, point4)}'); // false

  // Const collections
  print('\n--- Const Collections ---');
  const numbers = [1, 2, 3, 4, 5];
  const config = {
    'debug': false,
    'version': '1.0.0',
    'maxConnections': 100,
  };
  const coordinates = {Point(0, 0), Point(1, 1), Point(2, 2)};

  print('const list: $numbers');
  print('const map: $config');
  print('const set of Points: $coordinates');

  // Const collections are deeply immutable
  // numbers.add(6); // Error: Cannot modify unmodifiable list
  // config['debug'] = true; // Error: Cannot modify unmodifiable map

  // Compile-time constant expressions
  print('\n--- Compile-Time Constant Expressions ---');
  const doubled = maxRetries * 2;
  const message = 'App: $appName';
  const combined = '$appName v${doubled}';
  print('doubled: $doubled');
  print('message: $message');
  print('combined: $combined');

  // Const expressions must be evaluable at compile-time
  const platform = 'web';
  const apiEndpoint = 'https://api.example.com/$platform';
  print('apiEndpoint: $apiEndpoint');

  // Complex const objects
  print('\n--- Complex Const Objects ---');
  const user = User(
    name: 'Alice',
    email: 'alice@example.com',
    settings: UserSettings(darkMode: true, fontSize: 14),
  );
  print('const user: $user');
  print('user.settings: ${user.settings}');

  // Configuration pattern with const
  print('\n--- Configuration Pattern ---');
  const devConfig = AppConfig(
    apiUrl: 'http://localhost:3000',
    debug: true,
    maxRetries: 5,
  );
  const prodConfig = AppConfig(
    apiUrl: 'https://api.example.com',
    debug: false,
    maxRetries: 3,
  );

  print('Dev config: $devConfig');
  print('Prod config: $prodConfig');

  print('\n=== End of Constants Demo ===');
}

// Top-level constants
const double pi = 3.14159265359;
const double e = 2.71828182846;
const String appName = 'DartDemo';
const int maxRetries = 3;

// Class with static constants
class Colors {
  static const String red = '#FF0000';
  static const String green = '#00FF00';
  static const String blue = '#0000FF';
  static const String defaultColor = blue;

  // Private constructor prevents instantiation
  Colors._();
}

class HttpStatus {
  static const int ok = 200;
  static const int created = 201;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int serverError = 500;

  HttpStatus._();
}

// Class with const constructor
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  @override
  String toString() => 'Point($x, $y)';
  // Note: For const sets/maps, elements must use default == and hashCode
  // Custom equality operators would prevent compile-time canonicalization
}

// Nested const objects
class UserSettings {
  final bool darkMode;
  final int fontSize;

  const UserSettings({required this.darkMode, required this.fontSize});

  @override
  String toString() => 'UserSettings(darkMode: $darkMode, fontSize: $fontSize)';
}

class User {
  final String name;
  final String email;
  final UserSettings settings;

  const User({required this.name, required this.email, required this.settings});

  @override
  String toString() => 'User(name: $name, email: $email)';
}

// Configuration class
class AppConfig {
  final String apiUrl;
  final bool debug;
  final int maxRetries;

  const AppConfig({
    required this.apiUrl,
    required this.debug,
    required this.maxRetries,
  });

  @override
  String toString() =>
      'AppConfig(apiUrl: $apiUrl, debug: $debug, maxRetries: $maxRetries)';
}
