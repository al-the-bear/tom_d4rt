/// Demonstrates Dart top-level (global) declarations
///
/// Features covered:
/// - Top-level variables (var, final, const, late)
/// - Top-level functions
/// - Top-level getters and setters
/// - Private declarations
/// - External declarations (conceptual)
/// - Type aliases at top level
library;

// ============================================
// TOP-LEVEL VARIABLES
// ============================================

// Basic mutable variables
var globalCounter = 0;
String appName = 'Dart Globals Demo';
int maxRetries = 3;

// Nullable variables
String? currentUser;
int? lastProcessedId;

// Final (runtime constants)
final DateTime appStartTime = DateTime.now();
final String sessionId = _generateSessionId();

// Const (compile-time constants)
const double pi = 3.14159265359;
const String apiUrl = 'https://api.example.com';
const int maxConnections = 10;
const Duration defaultTimeout = Duration(seconds: 30);

// Const collections
const List<String> validStatuses = ['active', 'pending', 'closed'];
const Map<String, int> priorities = {'low': 1, 'medium': 2, 'high': 3};
const Set<int> reservedIds = {0, 1, 100};

// Late initialization
String lazyConfig = _loadConfig();

// Private variables
String _internalState = 'ready';
int _connectionCount = 0;

// ============================================
// TOP-LEVEL FUNCTIONS
// ============================================

// Basic function
int add(int a, int b) => a + b;

// Arrow syntax
String greet(String name) => 'Hello, $name!';

// Block body
void log(String message) {
  print('[${DateTime.now().toIso8601String()}] $message');
}

// Generic function
T? firstOrNull<T>(List<T> items) => items.isEmpty ? null : items.first;

// Private function
String _generateSessionId() {
  return 'session_${DateTime.now().millisecondsSinceEpoch}';
}

String _loadConfig() {
  print('  (Lazily loading config...)');
  return 'config_data';
}

void _updateInternalState(String state) {
  _internalState = state;
}

// ============================================
// TOP-LEVEL GETTERS AND SETTERS
// ============================================

// Read-only getter
DateTime get now => DateTime.now();

// Computed getter
int get connectionCount => _connectionCount;

// Getter with caching
String? _cachedValue;
String get cachedValue {
  return _cachedValue ??= _computeExpensiveValue();
}

String _computeExpensiveValue() {
  print('  (Computing expensive value...)');
  return 'computed_result';
}

// Getter and setter pair
LogLevel _logLevel = LogLevel.info;

LogLevel get logLevel => _logLevel;

set logLevel(LogLevel level) {
  print('  Log level changed: $_logLevel -> $level');
  _logLevel = level;
}

// ============================================
// TYPE ALIASES (TOP-LEVEL)
// ============================================

typedef IntOperation = int Function(int a, int b);
typedef Predicate<T> = bool Function(T value);
typedef VoidCallback = void Function();
typedef JsonMap = Map<String, dynamic>;

// ============================================
// ENUM (TOP-LEVEL)
// ============================================

enum LogLevel { debug, info, warning, error }

// ============================================
// MAIN FUNCTION
// ============================================

void main() {
  print('=== Top-Level Declarations (Globals) ===');
  print('');

  // Top-level variables
  print('--- Top-Level Variables ---');
  print('appName: $appName');
  print('globalCounter: $globalCounter');
  globalCounter++;
  print('globalCounter (after ++): $globalCounter');
  print('');

  print('maxRetries: $maxRetries');
  print('currentUser: $currentUser');
  currentUser = 'Alice';
  print('currentUser (after set): $currentUser');
  print('');

  // Final variables
  print('--- Final Variables ---');
  print('appStartTime: $appStartTime');
  print('sessionId: $sessionId');
  // appStartTime = DateTime.now();  // Error - can't reassign
  print('');

  // Const variables
  print('--- Const Variables ---');
  print('pi: $pi');
  print('apiUrl: $apiUrl');
  print('maxConnections: $maxConnections');
  print('defaultTimeout: $defaultTimeout');
  print('');

  // Const collections
  print('--- Const Collections ---');
  print('validStatuses: $validStatuses');
  print('priorities: $priorities');
  print('reservedIds: $reservedIds');
  // validStatuses.add('invalid');  // Error - const list
  print('');

  // Late variable
  print('--- Late Variables ---');
  print('Accessing lazyConfig for first time:');
  print('lazyConfig: $lazyConfig');
  print('Accessing again (no recompute):');
  print('lazyConfig: $lazyConfig');
  print('');

  // Private variables
  print('--- Private Variables ---');
  print('_internalState: $_internalState');
  _updateInternalState('running');
  print('_internalState (after update): $_internalState');
  print('_connectionCount: $_connectionCount');
  _connectionCount++;
  print('_connectionCount (after ++): $_connectionCount');
  print('');

  // Top-level functions
  print('--- Top-Level Functions ---');
  print('add(5, 3): ${add(5, 3)}');
  print('greet("World"): ${greet("World")}');
  log('This is a log message');
  print('');

  // Generic function
  print('--- Generic Functions ---');
  var numbers = [1, 2, 3];
  var empty = <int>[];
  print('firstOrNull([1,2,3]): ${firstOrNull(numbers)}');
  print('firstOrNull([]): ${firstOrNull(empty)}');
  print('');

  // Getters
  print('--- Top-Level Getters ---');
  print('now: $now');
  print('connectionCount: $connectionCount');
  print('');

  // Cached getter
  print('--- Cached Getter ---');
  print('First access to cachedValue:');
  print('cachedValue: $cachedValue');
  print('Second access (no recompute):');
  print('cachedValue: $cachedValue');
  print('');

  // Getter/setter pair
  print('--- Getter/Setter Pair ---');
  print('logLevel: $logLevel');
  logLevel = LogLevel.debug;
  print('logLevel: $logLevel');
  logLevel = LogLevel.error;
  print('logLevel: $logLevel');
  print('');

  // Type aliases
  print('--- Type Aliases ---');
  int multiply(int a, int b) => a * b;
  print('multiply(4, 5): ${multiply(4, 5)}');

  bool isEven(int n) => n % 2 == 0;
  print('isEven(4): ${isEven(4)}');
  print('isEven(5): ${isEven(5)}');

  void callback() => print('  Callback executed!');
  callback();

  JsonMap data = {'name': 'Alice', 'age': 30};
  print('JsonMap: $data');
  print('');

  // External declarations (conceptual)
  print('--- External Declarations (Conceptual) ---');
  print('external int nativeAdd(int a, int b);');
  print('  - Implemented in native code (FFI)');
  print('');
  print('@JS("console.log")');
  print('external void consoleLog(String msg);');
  print('  - Implemented in JavaScript (dart:js_interop)');
  print('');

  // Visibility summary
  print('--- Visibility Summary ---');
  print('');
  print('| Declaration | Visibility |');
  print('|-------------|------------|');
  print('| var x = 1   | Public     |');
  print('| var _x = 1  | Private    |');
  print('| final x     | Public     |');
  print('| const x     | Public     |');
  print('| void fn()   | Public     |');
  print('| void _fn()  | Private    |');
  print('| get x       | Public     |');
  print('| set x       | Public     |');

  print('');
  print('=== End of Top-Level Declarations Demo ===');
}
