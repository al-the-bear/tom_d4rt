/// D4 Global Functions and Variables Example
///
/// Demonstrates bridging top-level functions and global variables using
/// D4 helper methods. These are registered directly with the interpreter
/// rather than through BridgedClass.
///
/// Run with: dart run example/advanced_bridging/d4_globals_example.dart
library;

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

// =============================================================================
// Global Variables and Functions to Bridge
// =============================================================================

/// Application version.
const String appVersion = '2.0.0';

/// Maximum connection count.
int maxConnections = 100;

/// Whether debug mode is enabled.
bool debugMode = false;

/// Get the current timestamp.
DateTime get currentTimestamp => DateTime.now();

/// A simple greeting function.
String greet(String name) => 'Hello, $name!';

/// Format a number with a suffix.
String formatNumber(int value, {String suffix = '', int padding = 0}) {
  final padded = value.toString().padLeft(padding, '0');
  return suffix.isEmpty ? padded : '$padded $suffix';
}

/// Calculate a factorial.
int factorial(int n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}

/// Join strings with a separator.
String joinStrings(List<String> strings, {String separator = ', '}) {
  return strings.join(separator);
}

/// Create a range of integers.
List<int> range(int start, int end, {int step = 1}) {
  final result = <int>[];
  for (int i = start; i < end; i += step) {
    result.add(i);
  }
  return result;
}

// =============================================================================
// Bridge Registration Using D4 Helpers
// =============================================================================

/// Registers all global members with the interpreter.
void registerGlobals(D4rt d4rt, String importPath) {
  // Register global constants/variables
  d4rt.registerGlobalVariable('appVersion', appVersion, importPath);
  d4rt.registerGlobalVariable('maxConnections', maxConnections, importPath);
  d4rt.registerGlobalVariable('debugMode', debugMode, importPath);

  // Register global getters (computed values)
  d4rt.registerGlobalGetter('currentTimestamp', () => currentTimestamp, importPath);

  // Register global functions
  registerGlobalFunctions(d4rt, importPath);
}

/// Registers global functions with proper argument handling.
void registerGlobalFunctions(D4rt d4rt, String importPath) {
  // Simple function with one required argument
  d4rt.registertopLevelFunction(
    'greet',
    (visitor, positional, named, typeArgs) {
      final name = D4.getRequiredArg<String>(positional, 0, 'name', 'greet');
      return greet(name);
    },
    importPath,
  );

  // Function with named arguments and defaults
  d4rt.registertopLevelFunction(
    'formatNumber',
    (visitor, positional, named, typeArgs) {
      final value =
          D4.getRequiredArg<int>(positional, 0, 'value', 'formatNumber');
      final suffix = D4.getNamedArgWithDefault<String>(named, 'suffix', '');
      final padding = D4.getNamedArgWithDefault<int>(named, 'padding', 0);
      return formatNumber(value, suffix: suffix, padding: padding);
    },
    importPath,
  );

  // Recursive function
  d4rt.registertopLevelFunction(
    'factorial',
    (visitor, positional, named, typeArgs) {
      final n = D4.getRequiredArg<int>(positional, 0, 'n', 'factorial');
      return factorial(n);
    },
    importPath,
  );

  // Function with list parameter
  d4rt.registertopLevelFunction(
    'joinStrings',
    (visitor, positional, named, typeArgs) {
      // D4rt creates List<Object?>, use D4.coerceList to convert
      final strings =
          D4.coerceList<String>(positional[0], 'strings');
      final separator =
          D4.getNamedArgWithDefault<String>(named, 'separator', ', ');
      return joinStrings(strings, separator: separator);
    },
    importPath,
  );

  // Function that returns a list
  d4rt.registertopLevelFunction(
    'range',
    (visitor, positional, named, typeArgs) {
      final start = D4.getRequiredArg<int>(positional, 0, 'start', 'range');
      final end = D4.getRequiredArg<int>(positional, 1, 'end', 'range');
      final step = D4.getNamedArgWithDefault<int>(named, 'step', 1);
      return range(start, end, step: step);
    },
    importPath,
  );
}

// =============================================================================
// Demonstration
// =============================================================================

void main() async {
  print('D4 Global Functions and Variables Example');
  print('=' * 60);

  final d4rt = D4rt();
  registerGlobals(d4rt, 'package:example/example.dart');

  final script = '''
import 'package:example/example.dart';

void main() {
  // Access global variables
  print('Global Variables:');
  print('  appVersion = \$appVersion');
  print('  maxConnections = \$maxConnections');
  print('  debugMode = \$debugMode');
  
  // Access global getter
  print('\\nGlobal Getter:');
  print('  currentTimestamp = \$currentTimestamp');
  
  // Call global functions
  print('\\nGlobal Functions:');
  
  // Simple function
  print('  greet("World") = \${greet("World")}');
  
  // Function with named arguments
  print('  formatNumber(42) = \${formatNumber(42)}');
  print('  formatNumber(42, suffix: "items") = \${formatNumber(42, suffix: "items")}');
  print('  formatNumber(7, padding: 3) = \${formatNumber(7, padding: 3)}');
  print('  formatNumber(7, padding: 3, suffix: "days") = \${formatNumber(7, padding: 3, suffix: "days")}');
  
  // Recursive function
  print('\\nFactorials:');
  for (int i = 0; i <= 10; i++) {
    print('  factorial(\$i) = \${factorial(i)}');
  }
  
  // Function with list parameter
  print('\\nList Functions:');
  final words = ['apple', 'banana', 'cherry'];
  print('  joinStrings(\$words) = \${joinStrings(words)}');
  print('  joinStrings(\$words, separator: " | ") = \${joinStrings(words, separator: " | ")}');
  
  // Function returning list
  print('\\nRange Functions:');
  print('  range(0, 5) = \${range(0, 5)}');
  print('  range(0, 10, step: 2) = \${range(0, 10, step: 2)}');
  print('  range(5, 15, step: 3) = \${range(5, 15, step: 3)}');
}
''';

  print('\nExecuting script...\n');
  await d4rt.execute(source: script);

  print('\n' + '=' * 60);
  print('Example completed!');
}
