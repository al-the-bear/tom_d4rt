/// Phase 5: End-to-end tests for the AST bundle architecture.
///
/// These tests exercise the full pipeline across all three packages:
///   tom_d4rt_exec (D4rt) → tom_d4rt_astgen (AstBundler) →
///   tom_d4rt_ast (AstBundle, D4rtRunner)
///
/// Focus areas:
/// - Bundle distribution: D4rt creates bundles, D4rtRunner executes them
/// - Complex language features through the bundle path
/// - Multi-module import chains
/// - Permission forwarding through bundle execution
/// - AstBundlerConfig customization via D4rt
/// - Serialization round-trips with verified execution
/// - Error scenarios in the full pipeline
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Test enum for bridged enum e2e tests.
enum Planet { mercury, venus, earth, mars, jupiter }

void main() {
  // =========================================================================
  // Bundle Distribution: D4rt → D4rtRunner
  // =========================================================================
  // This is THE key architectural flow: bundles created with the full
  // analyzer (D4rt/AstBundler) can be shipped and executed on a lightweight
  // runtime (D4rtRunner) that carries zero analyzer dependency.
  group('Bundle distribution: D4rt → D4rtRunner', () {
    test('single-module bundle executes on fresh D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 21 * 2;
''');

      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, 42);
    });

    test('multi-module bundle executes on fresh D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:utils/math.dart';
int main() => add(20, 22);
''',
        explicitSources: {
          'package:utils/math.dart': 'int add(int a, int b) => a + b;',
        },
      );

      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, 42);
    });

    test('serialized bundle via JSON executes on D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
String main() => 'Hello from bundle';
''');

      final json = bundle.toJson();
      final restored = AstBundle.fromJson(json);

      final runner = D4rtRunner();
      final result = runner.executeBundle(restored);
      expect(result, 'Hello from bundle');
    });

    test('serialized bundle via bytes executes on D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 100;
''');

      final bytes = bundle.toBytes();
      final restored = AstBundle.fromBytes(bytes);

      final runner = D4rtRunner();
      final result = runner.executeBundle(restored);
      expect(result, 100);
    });

    test('serialized bundle via ZIP executes on D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 256;
''');

      final zip = bundle.toZip();
      final restored = AstBundle.fromZip(zip);

      final runner = D4rtRunner();
      final result = runner.executeBundle(restored);
      expect(result, 256);
    });

    test('serialized bundle via file executes on D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 999;
''');

      final tempDir = Directory.systemTemp.createTempSync('d4rt_dist_');
      try {
        final bundlePath = p.join(tempDir.path, 'dist.d4rtbundle');
        bundle.saveToFile(bundlePath);

        final restored = AstBundle.fromFile(bundlePath);

        final runner = D4rtRunner();
        final result = runner.executeBundle(restored);
        expect(result, 999);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('bundle with bridged enum — serialize + execute on D4rtRunner',
        () async {
      final enumDef = BridgedEnumDefinition<Planet>(
        name: 'Planet',
        values: Planet.values,
      );

      // Create bundle on D4rt (with analyzer)
      final d4rt = D4rt();
      d4rt.registerBridgedEnum(enumDef, 'package:astro/planets.dart');
      final bundle = await d4rt.createBundleFromSource('''
import 'package:astro/planets.dart';
String main() {
  final p = Planet.earth;
  return p.name;
}
''');

      // Serialize → deserialize → execute on separate D4rtRunner
      final bytes = bundle.toBytes();
      final restored = AstBundle.fromBytes(bytes);

      final runner = D4rtRunner();
      runner.registerBridgedEnum(enumDef, 'package:astro/planets.dart');
      final result = runner.executeBundle(restored);
      expect(result, 'earth');
    });

    test('bundle with bridged function — serialize + execute on D4rtRunner',
        () async {
      dynamic nativeAdd(visitor, args, namedArgs, typeArgs) {
        return (args[0] as int) + (args[1] as int);
      }

      // Create on D4rt
      final d4rt = D4rt();
      d4rt.registertopLevelFunction(
        'nativeAdd',
        nativeAdd,
        'package:native/math.dart',
      );
      final bundle = await d4rt.createBundleFromSource('''
import 'package:native/math.dart';
int main() => nativeAdd(30, 12);
''');

      // Serialize → D4rtRunner
      final zip = bundle.toZip();
      final restored = AstBundle.fromZip(zip);

      final runner = D4rtRunner();
      runner.registerTopLevelFunction(
        'nativeAdd',
        nativeAdd,
        'package:native/math.dart',
      );
      final result = runner.executeBundle(restored);
      expect(result, 42);
    });

    test('bundle with bridged global variable — execute on D4rtRunner',
        () async {
      final d4rt = D4rt();
      d4rt.registerGlobalVariable(
        'magicNumber',
        42,
        'package:config/constants.dart',
      );
      final bundle = await d4rt.createBundleFromSource('''
import 'package:config/constants.dart';
int main() => magicNumber;
''');

      final json = bundle.toJson();
      final restored = AstBundle.fromJson(json);

      final runner = D4rtRunner();
      runner.registerGlobalVariable(
        'magicNumber',
        42,
        'package:config/constants.dart',
      );
      final result = runner.executeBundle(restored);
      expect(result, 42);
    });

    test('mirrors architecture doc usage example', () async {
      // This test mirrors the "Create and Distribute Bundle" example
      // from d4rt_ast_architecture_design.md

      dynamic greetImpl(visitor, args, namedArgs, typeArgs) {
        return 'Hello, ${args[0]}!';
      }

      // Development time: create bundle
      final d4rt = D4rt();
      d4rt.registertopLevelFunction(
        'greet',
        greetImpl,
        'package:my_lib/my_lib.dart',
      );

      final bundle = await d4rt.createBundleFromSource('''
import 'package:my_lib/my_lib.dart';
String main() => greet('World');
''');

      // Distribution: serialize to file
      final tempDir = Directory.systemTemp.createTempSync('d4rt_archex_');
      try {
        final bundlePath = p.join(tempDir.path, 'my_app.ast');
        bundle.saveToFile(bundlePath);

        // Runtime: load and execute (no analyzer needed)
        final runner = D4rtRunner();
        runner.registerTopLevelFunction(
          'greet',
          greetImpl,
          'package:my_lib/my_lib.dart',
        );

        final loaded = AstBundle.fromFile(bundlePath);
        final result = runner.executeBundle(loaded);
        expect(result, 'Hello, World!');
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });
  });

  // =========================================================================
  // Complex Language Features Through Bundles
  // =========================================================================
  group('Complex language features through bundles', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    test('classes with methods and properties', () async {
      final bundle = await d4rt.createBundleFromSource('''
class Point {
  final int x;
  final int y;
  Point(this.x, this.y);
  int distanceSquared() => x * x + y * y;
}
int main() {
  final p = Point(3, 4);
  return p.distanceSquared();
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 25);
    });

    test('inheritance and method override', () async {
      final bundle = await d4rt.createBundleFromSource('''
class Animal {
  String speak() => 'silence';
}
class Dog extends Animal {
  @override
  String speak() => 'woof';
}
String main() {
  Animal a = Dog();
  return a.speak();
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'woof');
    });

    test('list iteration and accumulation', () async {
      final bundle = await d4rt.createBundleFromSource('''
int main() {
  final numbers = [1, 2, 3, 4, 5];
  int sum = 0;
  for (final n in numbers) {
    sum += n;
  }
  return sum;
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 15);
    });

    test('map operations', () async {
      final bundle = await d4rt.createBundleFromSource('''
int main() {
  final ages = <String, int>{'alice': 30, 'bob': 25, 'charlie': 35};
  int total = 0;
  for (final entry in ages.entries) {
    total += entry.value;
  }
  return total;
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 90);
    });

    test('string interpolation', () async {
      final bundle = await d4rt.createBundleFromSource(r'''
String main() {
  final name = 'World';
  final count = 42;
  return 'Hello, $name! The answer is $count.';
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'Hello, World! The answer is 42.');
    });

    test('conditional expressions and control flow', () async {
      final bundle = await d4rt.createBundleFromSource('''
String classify(int n) {
  if (n < 0) return 'negative';
  if (n == 0) return 'zero';
  return n.isEven ? 'even' : 'odd';
}
String main() {
  final results = <String>[];
  results.add(classify(-5));
  results.add(classify(0));
  results.add(classify(3));
  results.add(classify(4));
  return results.join(', ');
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'negative, zero, odd, even');
    });

    test('recursive function (fibonacci)', () async {
      final bundle = await d4rt.createBundleFromSource('''
int fibonacci(int n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
int main() => fibonacci(10);
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 55);
    });

    test('closures and higher-order functions', () async {
      final bundle = await d4rt.createBundleFromSource('''
int Function(int) makeMultiplier(int factor) {
  return (int x) => x * factor;
}
int main() {
  final triple = makeMultiplier(3);
  return triple(14);
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 42);
    });

    test('interpreted enum definition and usage', () async {
      final bundle = await d4rt.createBundleFromSource('''
enum Suit { hearts, diamonds, clubs, spades }
String main() {
  final s = Suit.diamonds;
  return s.name;
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'diamonds');
    });

    test('try-catch error handling', () async {
      final bundle = await d4rt.createBundleFromSource(r'''
String main() {
  try {
    throw 'bad input';
  } catch (e) {
    return 'caught: $e';
  }
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'caught: bad input');
    });

    test('switch statement', () async {
      final bundle = await d4rt.createBundleFromSource('''
String describe(int n) {
  switch (n) {
    case 0:
      return 'zero';
    case 1:
      return 'one';
    default:
      return 'many';
  }
}
String main() => describe(1);
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'one');
    });

    test('while loop and mutation', () async {
      final bundle = await d4rt.createBundleFromSource('''
int main() {
  int n = 1;
  int count = 0;
  while (n < 1000) {
    n *= 2;
    count++;
  }
  return count;
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 10); // 2^10 = 1024 >= 1000
    });

    test('named and optional parameters', () async {
      final bundle = await d4rt.createBundleFromSource('''
String greet({required String name, String greeting = 'Hello'}) {
  return '\$greeting, \$name!';
}
String main() => greet(name: 'Alice');
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'Hello, Alice!');
    });

    test('cascade notation', () async {
      final bundle = await d4rt.createBundleFromSource('''
class Builder {
  final List<String> parts = [];
  void addPart(String part) { parts.add(part); }
  String build() => parts.join('-');
}
String main() {
  final b = Builder()
    ..addPart('alpha')
    ..addPart('beta')
    ..addPart('gamma');
  return b.build();
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 'alpha-beta-gamma');
    });
  });

  // =========================================================================
  // Multi-Module Import Chains
  // =========================================================================
  group('Multi-module import chains', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    test('three-level chain: main → middleware → core', () async {
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:app/middleware.dart';
int main() => processValue(10);
''',
        explicitSources: {
          'package:app/middleware.dart': '''
import 'package:app/core.dart';
int processValue(int n) => doubleIt(n) + 1;
''',
          'package:app/core.dart': '''
int doubleIt(int n) => n * 2;
''',
        },
      );

      expect(bundle.modules, hasLength(3));
      final result = d4rt.executeBundle(bundle);
      expect(result, 21);
    });

    test('diamond: main → A + B, both → shared', () async {
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:app/format.dart';
import 'package:app/validate.dart';
String main() {
  final raw = '42';
  if (isValid(raw)) return formatResult(raw);
  return 'invalid';
}
''',
        explicitSources: {
          'package:app/format.dart': '''
import 'package:app/utils.dart';
String formatResult(String s) => 'Result: \${toInt(s)}';
''',
          'package:app/validate.dart': '''
import 'package:app/utils.dart';
bool isValid(String s) => toInt(s) > 0;
''',
          'package:app/utils.dart': '''
int toInt(String s) => int.parse(s);
''',
        },
      );

      // 4 modules: main + format + validate + utils (deduplicated)
      expect(bundle.modules, hasLength(4));
      final result = d4rt.executeBundle(bundle);
      expect(result, 'Result: 42');
    });

    test('module with re-exports', () async {
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:app/facade.dart';
int main() => compute(5);
''',
        explicitSources: {
          'package:app/facade.dart': '''
export 'package:app/impl.dart';
''',
          'package:app/impl.dart': '''
int compute(int n) => n * n;
''',
        },
      );

      expect(bundle.modules, hasLength(3));
      final result = d4rt.executeBundle(bundle);
      expect(result, 25);
    });

    test('file-based project with relative imports', () async {
      final tempDir = Directory.systemTemp.createTempSync('d4rt_multimod_');
      try {
        File(p.join(tempDir.path, 'main.dart')).writeAsStringSync('''
import 'models/user.dart';
import 'utils/formatter.dart';
String main() {
  final u = User('Alice', 30);
  return formatUser(u);
}
''');

        Directory(p.join(tempDir.path, 'models')).createSync();
        File(p.join(tempDir.path, 'models', 'user.dart')).writeAsStringSync('''
class User {
  final String name;
  final int age;
  User(this.name, this.age);
}
''');

        Directory(p.join(tempDir.path, 'utils')).createSync();
        File(p.join(tempDir.path, 'utils', 'formatter.dart'))
            .writeAsStringSync('''
import '../models/user.dart';
String formatUser(User u) => '\${u.name} (age \${u.age})';
''');

        final bundle = await d4rt.createBundle(
          p.join(tempDir.path, 'main.dart'),
          projectRoot: tempDir.path,
        );

        expect(bundle.modules.length, greaterThanOrEqualTo(3));
        final result = d4rt.executeBundle(bundle);
        expect(result, 'Alice (age 30)');
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('file-based bundle → serialize → D4rtRunner', () async {
      final tempDir = Directory.systemTemp.createTempSync('d4rt_filebundle_');
      try {
        File(p.join(tempDir.path, 'main.dart')).writeAsStringSync('''
import 'lib.dart';
int main() => square(7);
''');
        File(p.join(tempDir.path, 'lib.dart')).writeAsStringSync('''
int square(int n) => n * n;
''');

        final d4rt = D4rt();
        final bundle = await d4rt.createBundle(
          p.join(tempDir.path, 'main.dart'),
          projectRoot: tempDir.path,
        );

        // Serialize and execute on D4rtRunner
        final bytes = bundle.toBytes();
        final restored = AstBundle.fromBytes(bytes);

        final runner = D4rtRunner();
        final result = runner.executeBundle(restored);
        expect(result, 49);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });
  });

  // =========================================================================
  // Permission Forwarding
  // =========================================================================
  group('Permission forwarding', () {
    test('D4rt permission grants are visible', () {
      final d4rt = D4rt();
      d4rt.grant(FilesystemPermission.read);

      expect(d4rt.hasPermission(FilesystemPermission.read), isTrue);
      expect(d4rt.hasPermission(FilesystemPermission.write), isFalse);
    });

    test('revoked permissions are reflected', () {
      final d4rt = D4rt();
      d4rt.grant(NetworkPermission.connect);
      expect(d4rt.hasPermission(NetworkPermission.connect), isTrue);

      d4rt.revoke(NetworkPermission.connect);
      expect(d4rt.hasPermission(NetworkPermission.connect), isFalse);
    });

    test('D4rtRunner directly respects permission grants', () {
      final runner = D4rtRunner();
      runner.grant(FilesystemPermission.read);

      expect(runner.hasPermission(FilesystemPermission.read), isTrue);
      expect(runner.hasPermission(FilesystemPermission.write), isFalse);
    });

    test('multiple permission types can coexist', () {
      final d4rt = D4rt();
      d4rt.grant(FilesystemPermission.read);
      d4rt.grant(NetworkPermission.connect);
      d4rt.grant(ProcessRunPermission.any);

      expect(d4rt.hasPermission(FilesystemPermission.read), isTrue);
      expect(d4rt.hasPermission(NetworkPermission.connect), isTrue);
      expect(d4rt.hasPermission(ProcessRunPermission.any), isTrue);
      expect(d4rt.hasPermission(DangerousPermission.codeEvaluation), isFalse);
    });

    test('bundle executes under granted permissions', () async {
      final d4rt = D4rt();
      d4rt.grant(FilesystemPermission.read);

      final bundle = await d4rt.createBundleFromSource('''
bool main() => true;
''');

      // Should execute without error under granted permissions
      final result = d4rt.executeBundle(bundle);
      expect(result, true);
    });
  });

  // =========================================================================
  // AstBundlerConfig Through D4rt
  // =========================================================================
  group('AstBundlerConfig through D4rt', () {
    test('createBundleFromSource accepts custom config', () async {
      final d4rt = D4rt();
      final config = AstBundlerConfig(maxImportDepth: 10);

      final bundle = await d4rt.createBundleFromSource(
        'int main() => 1;',
        bundlerConfig: config,
      );
      expect(bundle.modules, hasLength(1));
    });

    test('createBundle accepts custom config', () async {
      final tempDir = Directory.systemTemp.createTempSync('d4rt_config_');
      try {
        File(p.join(tempDir.path, 'main.dart'))
            .writeAsStringSync('int main() => 1;');

        final d4rt = D4rt();
        final config = AstBundlerConfig(maxImportDepth: 10);

        final bundle = await d4rt.createBundle(
          p.join(tempDir.path, 'main.dart'),
          projectRoot: tempDir.path,
          bundlerConfig: config,
        );
        expect(bundle.modules, hasLength(1));
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('maxImportDepth limits deep import chains', () async {
      final d4rt = D4rt();
      final config = AstBundlerConfig(maxImportDepth: 1);

      // Chain: main → a → b. Depth of 'a' imports = 1 >= limit → throws.
      expect(
        () => d4rt.createBundleFromSource(
          '''
import 'package:app/a.dart';
void main() {}
''',
          explicitSources: {
            'package:app/a.dart': '''
import 'package:app/b.dart';
void a() {}
''',
            'package:app/b.dart': 'void b() {}',
          },
          bundlerConfig: config,
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('adequate depth allows deep chains', () async {
      final d4rt = D4rt();
      final config = AstBundlerConfig(maxImportDepth: 5);

      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:app/a.dart';
int main() => getValue();
''',
        explicitSources: {
          'package:app/a.dart': '''
import 'package:app/b.dart';
int getValue() => getBase() + 1;
''',
          'package:app/b.dart': '''
int getBase() => 41;
''',
        },
        bundlerConfig: config,
      );

      final result = d4rt.executeBundle(bundle);
      expect(result, 42);
    });
  });

  // =========================================================================
  // Error Scenarios
  // =========================================================================
  group('Error scenarios', () {
    test('executeBundle with non-existent function name throws', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 42;
''');

      expect(
        () => d4rt.executeBundle(bundle, name: 'doesNotExist'),
        throwsA(anything),
      );
    });

    test('createBundle from non-existent file throws ArgumentError', () async {
      final d4rt = D4rt();
      expect(
        () => d4rt.createBundle('/nonexistent/phantom.dart'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('AstBundle constructor rejects missing entry point', () {
      expect(
        () => AstBundle(
          entryPointUri: 'missing.dart',
          modules: {},
        ),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('unresolvable import in createBundleFromSource throws', () async {
      final d4rt = D4rt();
      expect(
        () => d4rt.createBundleFromSource('''
import 'package:unknown/unknown.dart';
void main() {}
'''),
        throwsA(isA<StateError>()),
      );
    });
  });

  // =========================================================================
  // Full Round-Trip: Create → Serialize → Deserialize → Execute
  // =========================================================================
  group('Full round-trip: serialize → D4rtRunner', () {
    /// A non-trivial source used across all serialization format tests.
    const sourceWithClass = '''
class Calculator {
  int add(int a, int b) => a + b;
  int multiply(int a, int b) => a * b;
}
int main() {
  final calc = Calculator();
  return calc.add(calc.multiply(6, 7), 0);
}
''';

    late AstBundle originalBundle;

    setUp(() async {
      final d4rt = D4rt();
      originalBundle = await d4rt.createBundleFromSource(sourceWithClass);
    });

    test('JSON round-trip preserves execution on D4rtRunner', () {
      final json = originalBundle.toJson();
      final restored = AstBundle.fromJson(json);
      final result = D4rtRunner().executeBundle(restored);
      expect(result, 42);
    });

    test('bytes round-trip preserves execution on D4rtRunner', () {
      final bytes = originalBundle.toBytes();
      final restored = AstBundle.fromBytes(bytes);
      final result = D4rtRunner().executeBundle(restored);
      expect(result, 42);
    });

    test('ZIP round-trip preserves execution on D4rtRunner', () {
      final zip = originalBundle.toZip();
      final restored = AstBundle.fromZip(zip);
      final result = D4rtRunner().executeBundle(restored);
      expect(result, 42);
    });

    test('file round-trip preserves execution on D4rtRunner', () {
      final tempDir = Directory.systemTemp.createTempSync('d4rt_roundtrip_');
      try {
        final path = p.join(tempDir.path, 'calc.d4rtbundle');
        originalBundle.saveToFile(path);

        final restored = AstBundle.fromFile(path);
        final result = D4rtRunner().executeBundle(restored);
        expect(result, 42);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('multi-module JSON round-trip on D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:tools/strings.dart';
String main() => shout('hello');
''',
        explicitSources: {
          'package:tools/strings.dart':
              "String shout(String s) => s.toUpperCase() + '!';",
        },
      );

      final json = bundle.toJson();
      final restored = AstBundle.fromJson(json);

      final result = D4rtRunner().executeBundle(restored);
      expect(result, 'HELLO!');
    });

    test('multi-module file round-trip on D4rtRunner', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:tools/strings.dart';
String main() => shout('world');
''',
        explicitSources: {
          'package:tools/strings.dart':
              "String shout(String s) => s.toUpperCase() + '!';",
        },
      );

      final tempDir = Directory.systemTemp.createTempSync('d4rt_mmrt_');
      try {
        final path = p.join(tempDir.path, 'multimod.d4rtbundle');
        bundle.saveToFile(path);

        final restored = AstBundle.fromFile(path);
        final result = D4rtRunner().executeBundle(restored);
        expect(result, 'WORLD!');
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });
  });

  // =========================================================================
  // Execute with Custom Entry Point and Arguments
  // =========================================================================
  group('executeBundle with custom entry and arguments', () {
    test('custom function name via name parameter', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int compute() => 99;
void main() {}
''');

      final result = d4rt.executeBundle(bundle, name: 'compute');
      expect(result, 99);
    });

    test('positional args passed to bundle entry function', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int add(int a, int b) => a + b;
void main() {}
''');

      final result = d4rt.executeBundle(
        bundle,
        name: 'add',
        positionalArgs: [17, 25],
      );
      expect(result, 42);
    });

    test('named args passed to bundle entry function', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
String greet({required String who, String prefix = 'Hi'}) {
  return '\$prefix, \$who!';
}
void main() {}
''');

      final result = d4rt.executeBundle(
        bundle,
        name: 'greet',
        namedArgs: {'who': 'Alice'},
      );
      expect(result, 'Hi, Alice!');
    });

    test('entryPoint override selects different module', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:alt/entry.dart';
void main() {}
''',
        explicitSources: {
          'package:alt/entry.dart': '''
int altMain() => 77;
void main() {}
''',
        },
      );

      final result = d4rt.executeBundle(
        bundle,
        entryPoint: 'package:alt/entry.dart',
        name: 'altMain',
      );
      expect(result, 77);
    });
  });
}
