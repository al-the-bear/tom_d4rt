/// Demonstrates Dart library system
///
/// Features covered:
/// - import statements
/// - Core libraries
/// - as (prefix)
/// - show/hide
/// - deferred loading
/// - part/part of (legacy)
/// - export
library;

// Standard library imports
import 'dart:math';
import 'dart:collection';
import 'dart:convert';

// Import with prefix
import 'dart:math' as mathematics;

// Note: 'show' and 'hide' are useful but avoid using them on dart:core
// as it can hide essential types like int, String, etc.
// Example: import 'dart:core' show print, Duration;

// Import with hide (commented - would hide print)
// import 'dart:core' hide print;

void main() {
  print('=== Libraries ===');
  print('');

  // Core libraries
  print('--- Core Libraries ---');
  print('dart:core - automatically imported');
  print('dart:math - math functions');
  print('dart:collection - collection utilities');
  print('dart:convert - encoding/decoding');
  print('dart:async - Future, Stream');
  print('dart:io - file/network I/O (non-web)');

  // Using dart:math
  print('');
  print('--- dart:math ---');
  print('pi: $pi');
  print('e: $e');
  print('sqrt(16): ${sqrt(16)}');
  print('pow(2, 10): ${pow(2, 10)}');
  print('sin(pi/2): ${sin(pi / 2)}');
  print('log(e): ${log(e)}');

  var random = Random();
  print('random.nextInt(100): ${random.nextInt(100)}');
  print('random.nextDouble(): ${random.nextDouble().toStringAsFixed(3)}');
  print('random.nextBool(): ${random.nextBool()}');

  // Using prefix
  print('');
  print('--- Using Prefix (as) ---');
  print('mathematics.pi: ${mathematics.pi}');
  print('mathematics.sqrt(25): ${mathematics.sqrt(25)}');

  // Using dart:collection
  print('');
  print('--- dart:collection ---');
  var queue = Queue<int>();
  queue.addAll([1, 2, 3]);
  print('Queue: $queue');
  print('removeFirst: ${queue.removeFirst()}');
  print('After: $queue');

  var linkedList = <String, int>{};
  linkedList['a'] = 1;
  linkedList['b'] = 2;
  linkedList['c'] = 3;
  print('LinkedHashMap: $linkedList');
  print('Keys in order: ${linkedList.keys.toList()}');

  var hashSet = HashSet<int>();
  hashSet.addAll([3, 1, 4, 1, 5, 9, 2, 6]);
  print('HashSet: $hashSet');

  // Using dart:convert
  print('');
  print('--- dart:convert ---');
  var data = {'name': 'Alice', 'age': 30, 'active': true};
  var jsonString = jsonEncode(data);
  print('jsonEncode: $jsonString');

  var decoded = jsonDecode(jsonString);
  print('jsonDecode: $decoded');
  print('Name: ${decoded['name']}');

  // Base64
  var text = 'Hello, Dart!';
  var encoded = base64Encode(utf8.encode(text));
  print('base64Encode("$text"): $encoded');
  var decodedBytes = base64Decode(encoded);
  print('base64Decode: ${utf8.decode(decodedBytes)}');

  // UTF-8
  var bytes = utf8.encode('Hello 🎯');
  print('utf8.encode: $bytes');
  print('utf8.decode: ${utf8.decode(bytes)}');

  // Point class from dart:math
  print('');
  print('--- Point class ---');
  var p1 = Point(3, 4);
  var p2 = Point(6, 8);
  print('p1: $p1');
  print('p2: $p2');
  print('p1.distanceTo(p2): ${p1.distanceTo(p2)}');
  print('p1.magnitude: ${p1.magnitude}');

  // Rectangle class
  print('');
  print('--- Rectangle class ---');
  var rect = Rectangle(0, 0, 100, 50);
  print('Rectangle: $rect');
  print('width: ${rect.width}, height: ${rect.height}');
  print('area: ${rect.width * rect.height}');
  print('containsPoint(50, 25): ${rect.containsPoint(Point(50, 25))}');

  // Show/Hide usage
  print('');
  print('--- show/hide ---');
  print('import "dart:core" show print, Duration;');
  print('  - Only imports print and Duration');
  print('');
  print('import "dart:core" hide print;');
  print('  - Imports everything except print');

  // Library visibility
  print('');
  print('--- Library Visibility ---');
  print('Private members (starting with _) are library-private');
  print('Public members are accessible from other libraries');

  var example = ExampleClass();
  print('Public: ${example.publicField}');
  // print('Private: ${example._privateField}'); // Error from other library

  // Deferred loading (conceptual)
  print('');
  print('--- Deferred Loading ---');
  print('import "package:heavy.dart" deferred as heavy;');
  print('');
  print('await heavy.loadLibrary();');
  print('heavy.doSomething();');
  print('');
  print('Benefits:');
  print('  - Reduces initial load time');
  print('  - Loads libraries on demand');
  print('  - Useful for web apps');

  // Export (conceptual)
  print('');
  print('--- Export ---');
  print('// In library.dart');
  print('export "src/public_api.dart";');
  print('export "src/utils.dart" show helper;');
  print('export "src/internal.dart" hide _private;');

  print('');
  print('=== End of Libraries Demo ===');
}

// Example class with visibility
class ExampleClass {
  String publicField = 'public';
  // ignore: unused_field
  final String _privateField = 'private';

  void publicMethod() {}
  void _privateMethod() {}
}

// ignore: unused_element
void _usePrivate(ExampleClass e) => e._privateMethod();
