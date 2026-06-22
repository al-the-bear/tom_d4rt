// Run All Examples
//
// This script runs all example files to verify they compile and execute correctly.
// Run with: dart run example/run_all_examples.dart

import 'dart:io';

// Import all user_guide examples
import 'user_guide/basic_execution_example.dart' as user_guide_basic;
import 'user_guide/arguments_example.dart' as user_guide_args;
import 'user_guide/eval_example.dart' as user_guide_eval;
import 'user_guide/multi_file_example.dart' as user_guide_multi;
import 'user_guide/permissions_example.dart' as user_guide_perms;
import 'user_guide/continued_execution_example.dart' as user_guide_continued;
import 'user_guide/async_example.dart' as user_guide_async;

// Import all bridging_guide examples
import 'bridging_guide/bridging_enums_example.dart' as bridge_enums;
import 'bridging_guide/bridging_classes_example.dart' as bridge_classes;
import 'bridging_guide/bridging_async_example.dart' as bridge_async;
import 'bridging_guide/globals_example.dart' as bridge_globals;

// Import all readme examples
import 'readme/quick_start_example.dart' as readme_quick;
import 'readme/basic_execution_example.dart' as readme_basic;
import 'readme/repl_example.dart' as readme_repl;
import 'readme/bridging_example.dart' as readme_bridge;
import 'readme/permissions_example.dart' as readme_perms;

// Import standalone examples
import 'd4rt_example.dart' as standalone_d4rt;

void main() async {
  final examples = <String, Future<void> Function()>{
    // User Guide examples
    'user_guide/basic_execution_example': () async => user_guide_basic.main(),
    'user_guide/arguments_example': () async => user_guide_args.main(),
    'user_guide/eval_example': () async => user_guide_eval.main(),
    'user_guide/multi_file_example': () async => user_guide_multi.main(),
    'user_guide/permissions_example': () async => user_guide_perms.main(),
    'user_guide/continued_execution_example': () async =>
        user_guide_continued.main(),
    'user_guide/async_example': () async {
      user_guide_async.main();
    },

    // Bridging Guide examples
    'bridging_guide/bridging_enums_example': () async => bridge_enums.main(),
    'bridging_guide/bridging_classes_example': () async =>
        bridge_classes.main(),
    'bridging_guide/bridging_async_example': () async {
      bridge_async.main();
    },
    'bridging_guide/globals_example': () async => bridge_globals.main(),

    // README examples
    'readme/quick_start_example': () async => readme_quick.main(),
    'readme/basic_execution_example': () async => readme_basic.main(),
    'readme/repl_example': () async => readme_repl.main(),
    'readme/bridging_example': () async => readme_bridge.main(),
    'readme/permissions_example': () async => readme_perms.main(),

    // Standalone examples
    'd4rt_example': () async {
      standalone_d4rt.main();
    },
  };

  print('=' * 60);
  print('Running all D4rt examples');
  print('=' * 60);

  var passed = 0;
  var failed = 0;
  final failures = <String, String>{};

  for (final entry in examples.entries) {
    final name = entry.key;
    final runExample = entry.value;

    stdout.write('\nRunning: $name... ');

    try {
      await runExample();
      print('✓ PASSED');
      passed++;
    } catch (e, stack) {
      print('✗ FAILED');
      print('  Error: $e');
      failures[name] = '$e\n$stack';
      failed++;
    }
  }

  print('\n${'=' * 60}');
  print('Results: $passed passed, $failed failed');
  print('=' * 60);

  if (failures.isNotEmpty) {
    print('\nFailures:');
    for (final entry in failures.entries) {
      print('\n--- ${entry.key} ---');
      print(entry.value);
    }
    exit(1);
  }

  print('\nAll examples passed!');
}
