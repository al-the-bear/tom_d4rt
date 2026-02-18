/// Dart Language Overview - Master Runner
///
/// This script runs all area demonstrations in the dart_overview folder.
///
/// Areas covered (20 total):
/// 1.  Variables - declarations, types, null safety, constants
/// 2.  Operators - arithmetic, comparison, logical, bitwise, etc.
/// 3.  Control Flow - conditionals, switch, loops
/// 4.  Functions - declarations, parameters, closures, generators
/// 5.  Classes - declarations, constructors, inheritance
/// 6.  Class Modifiers - abstract, sealed, interface, mixin
/// 7.  Generics - generic classes, functions, bounds, variance
/// 8.  Collections - lists, sets, maps, iterables
/// 9.  Records - anonymous aggregate data structures
/// 10. Patterns - destructuring, matching, switch patterns
/// 11. Enums - simple and enhanced enumerations
/// 12. Mixins - code reuse through mixins
/// 13. Extensions - adding functionality to existing types
/// 14. Async - futures, streams, isolates
/// 15. Error Handling - try/catch, exceptions, stack traces
/// 16. Libraries - imports, exports, visibility
/// 17. Comments - documentation and code comments
/// 18. Typedefs - type aliases for functions and types
/// 19. Annotations - metadata annotations, built-in and custom
/// 20. Globals - top-level variables, functions, getters/setters
///
/// Run with: dart run_dart_overview.dart
library;

import 'variables/run_variables.dart' as variables;
import 'operators/run_operators.dart' as operators;
import '../control_flow/run_control_flow.dart' as control_flow;
import '../functions/run_functions.dart' as functions;
import '../classes/run_classes.dart' as classes;
import '../class_modifiers/run_class_modifiers.dart' as class_modifiers;
import '../generics/run_generics.dart' as generics;
import '../collections/run_collections.dart' as collections;
import 'records/run_records.dart' as records;
import 'patterns/run_patterns.dart' as patterns;
import '../enums/run_enums.dart' as enums;
import 'mixins/run_mixins.dart' as mixins;
import '../extensions/run_extensions.dart' as extensions;
import '../async/run_async.dart' as async_area;
import '../error_handling/run_error_handling.dart' as error_handling;
import 'libraries/run_libraries.dart' as libraries;
import '../comments/run_comments.dart' as comments;
import 'typedefs/run_typedefs.dart' as typedefs;
import '../annotations/run_annotations.dart' as annotations;
import '../globals/run_globals.dart' as globals;

Future<void> main() async {
  final bigSeparator = '=' * 80;
  final sectionSeparator = '*' * 80;

  print('');
  print(bigSeparator);
  print('');
  print('     ██████╗  █████╗ ██████╗ ████████╗');
  print('     ██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝');
  print('     ██║  ██║███████║██████╔╝   ██║   ');
  print('     ██║  ██║██╔══██║██╔══██╗   ██║   ');
  print('     ██████╔╝██║  ██║██║  ██║   ██║   ');
  print('     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ');
  print('');
  print('                LANGUAGE OVERVIEW');
  print('           Comprehensive Examples Suite');
  print('');
  print(bigSeparator);
  print('');

  // Track timing
  var stopwatch = Stopwatch()..start();

  // 1. Variables
  print('');
  print(sectionSeparator);
  print('  AREA 1/20: VARIABLES');
  print(sectionSeparator);
  print('');
  variables.main();

  // 2. Operators
  print('');
  print(sectionSeparator);
  print('  AREA 2/20: OPERATORS');
  print(sectionSeparator);
  print('');
  operators.main();

  // 3. Control Flow
  print('');
  print(sectionSeparator);
  print('  AREA 3/20: CONTROL FLOW');
  print(sectionSeparator);
  print('');
  control_flow.main();

  // 4. Functions
  print('');
  print(sectionSeparator);
  print('  AREA 4/20: FUNCTIONS');
  print(sectionSeparator);
  print('');
  functions.main();

  // 5. Classes
  print('');
  print(sectionSeparator);
  print('  AREA 5/20: CLASSES');
  print(sectionSeparator);
  print('');
  classes.main();

  // 6. Class Modifiers
  print('');
  print(sectionSeparator);
  print('  AREA 6/20: CLASS MODIFIERS');
  print(sectionSeparator);
  print('');
  class_modifiers.main();

  // 7. Generics
  print('');
  print(sectionSeparator);
  print('  AREA 7/20: GENERICS');
  print(sectionSeparator);
  print('');
  generics.main();

  // 8. Collections
  print('');
  print(sectionSeparator);
  print('  AREA 8/20: COLLECTIONS');
  print(sectionSeparator);
  print('');
  collections.main();

  // 9. Records
  print('');
  print(sectionSeparator);
  print('  AREA 9/20: RECORDS');
  print(sectionSeparator);
  print('');
  records.main();

  // 10. Patterns
  print('');
  print(sectionSeparator);
  print('  AREA 10/20: PATTERNS');
  print(sectionSeparator);
  print('');
  patterns.main();

  // 11. Enums
  print('');
  print(sectionSeparator);
  print('  AREA 11/20: ENUMS');
  print(sectionSeparator);
  print('');
  enums.main();

  // 12. Mixins
  print('');
  print(sectionSeparator);
  print('  AREA 12/20: MIXINS');
  print(sectionSeparator);
  print('');
  mixins.main();

  // 13. Extensions
  print('');
  print(sectionSeparator);
  print('  AREA 13/20: EXTENSIONS');
  print(sectionSeparator);
  print('');
  extensions.main();

  // 14. Async (await required)
  print('');
  print(sectionSeparator);
  print('  AREA 14/20: ASYNC PROGRAMMING');
  print(sectionSeparator);
  print('');
  await async_area.main();

  // 15. Error Handling
  print('');
  print(sectionSeparator);
  print('  AREA 15/20: ERROR HANDLING');
  print(sectionSeparator);
  print('');
  error_handling.main();

  // 16. Libraries
  print('');
  print(sectionSeparator);
  print('  AREA 16/20: LIBRARIES');
  print(sectionSeparator);
  print('');
  libraries.main();

  // 17. Comments
  print('');
  print(sectionSeparator);
  print('  AREA 17/20: COMMENTS');
  print(sectionSeparator);
  print('');
  comments.main();

  // 18. Typedefs
  print('');
  print(sectionSeparator);
  print('  AREA 18/20: TYPEDEFS');
  print(sectionSeparator);
  print('');
  typedefs.main();

  // 19. Annotations
  print('');
  print(sectionSeparator);
  print('  AREA 19/20: ANNOTATIONS');
  print(sectionSeparator);
  print('');
  annotations.main();

  // 20. Globals (Top-Level Declarations)
  print('');
  print(sectionSeparator);
  print('  AREA 20/20: TOP-LEVEL DECLARATIONS');
  print(sectionSeparator);
  print('');
  globals.main();

  // Summary
  stopwatch.stop();
  print('');
  print(bigSeparator);
  print('');
  print('                    OVERVIEW COMPLETE');
  print('');
  print('  All 20 areas demonstrated successfully!');
  print('');
  print('  Areas covered:');
  print('    1.  Variables          11. Enums');
  print('    2.  Operators          12. Mixins');
  print('    3.  Control Flow       13. Extensions');
  print('    4.  Functions          14. Async');
  print('    5.  Classes            15. Error Handling');
  print('    6.  Class Modifiers    16. Libraries');
  print('    7.  Generics           17. Comments');
  print('    8.  Collections        18. Typedefs');
  print('    9.  Records            19. Annotations');
  print('    10. Patterns           20. Globals');
  print('');
  print('  Total execution time: ${stopwatch.elapsedMilliseconds}ms');
  print('');
  print(bigSeparator);
}
