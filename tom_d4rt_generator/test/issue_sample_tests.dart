/// Sample issue reproduction tests for the D4rt Bridge Generator.
///
/// This file demonstrates the test infrastructure for reproducing and verifying
/// known generator issues documented in doc/issues.md.
///
/// ## Test Categories
///
/// - **Fixed issues** (GEN-028, GEN-029, GEN-030): These tests verify the fix
///   works correctly. They should PASS.
/// - **Won't Fix issues** (GEN-001, GEN-003, GEN-004, GEN-006, GEN-014): These
///   tests demonstrate known limitations. They document the expected behavior
///   and should PASS (by asserting the known-limited behavior).
/// - **TODO issues** (GEN-002, GEN-005, GEN-011, GEN-017): Templates for
///   future test development. These document current (potentially buggy) behavior.
///
/// ## How to add a new issue test
///
/// 1. Create source Dart files that trigger the issue
/// 2. Create a barrel file that exports the source
/// 3. Use [runGenerationTest] to generate bridges and inspect the code
/// 4. Assert on [IssueTestResult.generatedCode] to verify the issue manifests
/// 5. Optionally use [runIssueTest] with a D4rt script for runtime verification
///
/// See [IssueTestHelper] for the full API.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';

void main() {
  // =========================================================================
  // FIXED ISSUES — These tests verify the fixes work correctly
  // =========================================================================

  group('Fixed Issues', () {
    // -----------------------------------------------------------------------
    // GEN-028: CLI didn't pass export filtering params to generator
    // -----------------------------------------------------------------------
    group('GEN-028: export filtering params passed to generator', () {
      test('excludeSourcePatterns filters source files correctly', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-028',
          sourceFiles: {
            'lib/src/public_api.dart': '''
class PublicClass {
  String get name => 'public';
}
''',
            'lib/src/internal_helper.dart': '''
class InternalHelper {
  String get name => 'internal';
}
''',
          },
          barrelContent: '''
export 'src/public_api.dart';
export 'src/internal_helper.dart';
''',
          moduleConfig: const TestModuleConfig(
            // Full package URI glob pattern (see _matchesSourceExclusion docs)
            excludeSourcePatterns: ['package:test_pkg/src/internal_helper.dart'],
          ),
        );

        expect(result.generationSucceeded, isTrue,
            reason: 'Generation should succeed');
        expect(result.generatedCode, isNotNull);
        expect(result.generatedCode!, contains('PublicClass'),
            reason: 'PublicClass should be in the generated bridge');
        expect(result.generatedCode!, isNot(contains('InternalHelper')),
            reason:
                'InternalHelper should be excluded by excludeSourcePatterns');
      });

      test('excludeClasses filters classes correctly', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-028',
          sourceFiles: {
            'lib/src/classes.dart': '''
class IncludedClass {
  String get value => 'included';
}

class ExcludedClass {
  String get value => 'excluded';
}

class AnotherIncluded {
  int get count => 42;
}
''',
          },
          barrelContent: "export 'src/classes.dart';",
          moduleConfig: const TestModuleConfig(
            excludeClasses: ['ExcludedClass'],
          ),
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);
        expect(result.generatedCode!, contains('IncludedClass'));
        expect(result.generatedCode!, contains('AnotherIncluded'));
        expect(result.generatedCode!, isNot(contains("name: 'ExcludedClass'")),
            reason: 'ExcludedClass should be filtered by excludeClasses');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-029: CLI path missing export info filtering for globals
    // -----------------------------------------------------------------------
    group('GEN-029: global export filtering', () {
      test('global functions are generated when exported', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-029',
          sourceFiles: {
            'lib/src/globals.dart': '''
/// A public helper function.
String formatMessage(String msg) => 'Formatted: \$msg';

/// Another public function.
int addNumbers(int a, int b) => a + b;
''',
          },
          barrelContent: "export 'src/globals.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);
        // The bridge should contain the global functions
        expect(result.generatedCode!, contains('formatMessage'));
        expect(result.generatedCode!, contains('addNumbers'));
      });
    });

    // -----------------------------------------------------------------------
    // GEN-030: Multi-barrel modules only registered under primary barrel
    // -----------------------------------------------------------------------
    group('GEN-030: multi-barrel registration', () {
      test('generated bridge contains sourceUri for deduplication', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-030',
          sourceFiles: {
            'lib/src/shared_class.dart': '''
/// A class that might be exported from multiple barrels.
class SharedClass {
  final String label;
  SharedClass(this.label);
  String describe() => 'SharedClass: \$label';
}
''',
          },
          barrelContent: "export 'src/shared_class.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);
        // The bridge should contain SharedClass
        expect(result.generatedCode!, contains("name: 'SharedClass'"));
        // The bridge should have sourceUri support for deduplication
        expect(result.generatedCode!, contains('sourceUri'),
            reason: 'Bridge should include sourceUri for multi-barrel dedup');
      });
    });
  });

  // =========================================================================
  // WON'T FIX ISSUES — These tests document known limitations
  // =========================================================================

  group("Won't Fix Issues", () {
    // -----------------------------------------------------------------------
    // GEN-001: Generic methods lose type parameters (type erasure)
    // -----------------------------------------------------------------------
    group('GEN-001: generic type erasure', () {
      test('generic method type parameter is erased to dynamic', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-001',
          sourceFiles: {
            'lib/src/generic_methods.dart': '''
class TypedProcessor {
  /// Generic method — T should be forwarded but gets erased.
  T process<T>(T input) => input;

  /// Generic method with bound.
  T transform<T extends num>(T value, T multiplier) =>
      (value * multiplier) as T;
}
''',
          },
          barrelContent: "export 'src/generic_methods.dart';",
        );

        expect(result.generationSucceeded, isTrue,
            reason: 'Generation should succeed despite type erasure');
        expect(result.generatedCode, isNotNull);

        // KNOWN LIMITATION: Type parameter T is erased to dynamic
        // The generated code calls the method with <dynamic> instead of <T>
        expect(result.generatedCode!, contains('<dynamic>'),
            reason: 'GEN-001: Type parameter should be erased to <dynamic>');

        // The typeArgs parameter is received but unused
        expect(result.generatedCode!, contains('typeArgs'),
            reason: 'typeArgs parameter should be present in callback');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-003: Complex default values cannot be represented
    // -----------------------------------------------------------------------
    group('GEN-003: complex default values', () {
      test('non-wrappable defaults use combinatorial dispatch', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-003',
          sourceFiles: {
            'lib/src/complex_defaults.dart': '''
/// Private constant — cannot be reproduced in generated code.
const _defaultTimeout = Duration(seconds: 30);

class ConfigManager {
  /// Simple wrappable defaults work fine.
  void setName({String name = 'default'}) {}

  /// Complex default: private constant reference.
  void configure({Duration timeout = _defaultTimeout}) {}
}
''',
          },
          barrelContent: "export 'src/complex_defaults.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);

        // KNOWN LIMITATION: Private defaults cannot be reproduced
        // The generator uses if/else branches to handle presence/absence
        // of the parameter
        expect(result.generatedCode!, contains("name: 'ConfigManager'"),
            reason: 'ConfigManager should be generated');

        // Simple default ('default') should be directly in the generated code
        expect(result.generatedCode!, contains("'default'"),
            reason: 'Simple string default should be wrappable');

        // Complex default (_defaultTimeout) triggers combinatorial dispatch:
        // The generator checks if named.containsKey('timeout')
        expect(result.generatedCode!, contains("containsKey('timeout')"),
            reason: 'GEN-003: Complex default should use containsKey dispatch');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-004: Combinatorial dispatch capped at 4 non-wrappable params
    // -----------------------------------------------------------------------
    group('GEN-004: combinatorial dispatch cap', () {
      test('3 non-wrappable defaults generate combinatorial dispatch',
          () async {
        final result = await runGenerationTest(
          issueId: 'GEN-004',
          sourceFiles: {
            'lib/src/many_defaults.dart': '''
const _d1 = Duration(seconds: 1);
const _d2 = Duration(seconds: 2);
const _d3 = Duration(seconds: 3);

class MultiDefault {
  /// 3 non-wrappable defaults — within the 4-param cap.
  void withinCap({
    Duration a = _d1,
    Duration b = _d2,
    Duration c = _d3,
  }) {}
}
''',
          },
          barrelContent: "export 'src/many_defaults.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);

        // With 3 non-wrappable defaults, should have 2^3 = 8 combinations
        // Each combination is an if-block checking containsKey
        expect(result.generatedCode!, contains("name: 'MultiDefault'"));
        expect(result.generatedCode!, contains("containsKey('a')"),
            reason: 'GEN-004: Should generate containsKey checks for '
                'combinatorial dispatch');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-006: Syntactic fallback loses all resolved type information
    // -----------------------------------------------------------------------
    // Note: This issue only triggers when the analyzer cannot resolve a file.
    // In a well-configured test environment, the resolved path is always used.
    // We verify the resolved path works correctly as the baseline.
    group('GEN-006: syntactic fallback', () {
      test('resolved path produces typed parameters (not dynamic)', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-006',
          sourceFiles: {
            'lib/src/typed_class.dart': '''
class Server {
  final int port;
  final String host;

  Server(this.port, this.host);

  String describe() => '\$host:\$port';
}
''',
          },
          barrelContent: "export 'src/typed_class.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);

        // The resolved path should produce properly typed parameters
        expect(result.generatedCode!, contains("name: 'Server'"));
        // In the resolved path, this.port and this.host should resolve
        // to int and String respectively
        expect(result.generatedCode!, contains('<int>'),
            reason:
                'Resolved path should produce int type for port parameter');
        expect(result.generatedCode!, contains('<String>'),
            reason:
                'Resolved path should produce String type for host parameter');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-014: Syntactic fallback: this.x params always typed as dynamic
    // -----------------------------------------------------------------------
    // Same caveat as GEN-006 — this only affects the syntactic fallback path.
    // The resolved path handles this.x correctly.
    group('GEN-014: this.x parameter types', () {
      test('resolved path correctly types this.x parameters', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-014',
          sourceFiles: {
            'lib/src/field_params.dart': '''
class UserProfile {
  final String name;
  final int age;
  final bool active;

  UserProfile(this.name, this.age, {this.active = true});

  String describe() => '\$name (age: \$age, active: \$active)';
}
''',
          },
          barrelContent: "export 'src/field_params.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);
        expect(result.generatedCode!, contains("name: 'UserProfile'"));

        // The resolved path should correctly type this.x parameters
        // (the syntactic fallback would produce dynamic for all of these)
        expect(result.generatedCode!, contains('<String>'),
            reason: 'this.name should resolve to String');
        expect(result.generatedCode!, contains('<int>'),
            reason: 'this.age should resolve to int');
        expect(result.generatedCode!, contains('<bool>'),
            reason: 'this.active should resolve to bool');
      });
    });
  });

  // =========================================================================
  // TODO ISSUES — Templates for future test development
  // =========================================================================

  group('TODO Issues', () {
    // -----------------------------------------------------------------------
    // GEN-002: Recursive type bounds dispatched to only 3 hardcoded types
    // Fixed: Added Duration and BigInt to default dispatch list, plus made
    //        configurable via `recursiveBoundTypes` in buildkit.yaml
    // -----------------------------------------------------------------------
    group('GEN-002: recursive type bound dispatch', () {
      test('dispatches to num, String, DateTime, Duration, BigInt for Comparable<T>', () async {
        // NOTE: Recursive bound dispatch only works for GLOBAL functions,
        // not class methods. Class methods get type erasure (GEN-001).
        final result = await runGenerationTest(
          issueId: 'GEN-002',
          sourceFiles: {
            'lib/src/comparable_funcs.dart': '''
/// Top-level function with recursive type bound.
T findMax<T extends Comparable<T>>(List<T> items) {
  return items.reduce((a, b) => a.compareTo(b) >= 0 ? a : b);
}
''',
          },
          barrelContent: "export 'src/comparable_funcs.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);

        // GEN-002 FIX: Now dispatches to 5 types by default
        expect(result.generatedCode!, contains('is num'),
            reason: 'Should have num dispatch for Comparable<T>');
        expect(result.generatedCode!, contains('is String'),
            reason: 'Should have String dispatch for Comparable<T>');
        expect(result.generatedCode!, contains('is DateTime'),
            reason: 'Should have DateTime dispatch for Comparable<T>');
        expect(result.generatedCode!, contains('is Duration'),
            reason: 'GEN-002 FIX: Duration now in default dispatch list');
        expect(result.generatedCode!, contains('is BigInt'),
            reason: 'GEN-002 FIX: BigInt now in default dispatch list');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-005: Function types inside collections are unbridgeable
    // -----------------------------------------------------------------------
    group('GEN-005: function types in collections', () {
      test('List<Function> parameter triggers UnimplementedError', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-005',
          sourceFiles: {
            'lib/src/function_collections.dart': '''
class EventBus {
  /// A parameter with function type inside a List.
  void addListeners(List<void Function(String)> listeners) {
    for (final l in listeners) {
      l('event');
    }
  }

  /// Simple function parameter works fine (for comparison).
  void addListener(void Function(String) listener) {
    listener('event');
  }
}
''',
          },
          barrelContent: "export 'src/function_collections.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);
        expect(result.generatedCode!, contains("name: 'EventBus'"));

        // Simple function parameter should work
        expect(result.generatedCode!, contains("'addListener'"));

        // GEN-005: List<Function> should produce an UnimplementedError throw
        expect(result.generatedCode!, contains('UnimplementedError'),
            reason: 'GEN-005: List<void Function(String)> should throw '
                'UnimplementedError');
      });
    });

    // -----------------------------------------------------------------------
    // GEN-011: Global function/variable generation counts always report 0
    // -----------------------------------------------------------------------
    group('GEN-011: global counts always 0', () {
      test('global functions are generated despite count being 0', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-011',
          sourceFiles: {
            'lib/src/top_level.dart': '''
/// A top-level function.
String greet(String name) => 'Hello, \$name!';

/// Another top-level function.
int multiply(int a, int b) => a * b;

/// A top-level variable.
const String appVersion = '1.0.0';
''',
          },
          barrelContent: "export 'src/top_level.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);

        // Functions should be in the generated code even though counts are 0
        expect(result.generatedCode!, contains('greet'));
        expect(result.generatedCode!, contains('multiply'));
      });
    });

    // -----------------------------------------------------------------------
    // GEN-017: Missing barrel export silently downgrades to dynamic
    // -----------------------------------------------------------------------
    group('GEN-017: missing barrel export downgrade', () {
      test('type not in barrel may fall back to dynamic', () async {
        final result = await runGenerationTest(
          issueId: 'GEN-017',
          sourceFiles: {
            'lib/src/exported.dart': '''
import 'not_exported.dart';

class MyService {
  /// Uses a type NOT exported from the barrel.
  InternalConfig getConfig() => InternalConfig('default');
}
''',
            'lib/src/not_exported.dart': '''
class InternalConfig {
  final String value;
  InternalConfig(this.value);
}
''',
          },
          // Only export MyService, not InternalConfig
          barrelContent: "export 'src/exported.dart';",
        );

        expect(result.generationSucceeded, isTrue);
        expect(result.generatedCode, isNotNull);
        expect(result.generatedCode!, contains("name: 'MyService'"));
        // GEN-017: InternalConfig is not exported from barrel.
        // The resolved path may still find it via source imports,
        // but in strict mode it would degrade to dynamic.
      });
    });
  });
}
