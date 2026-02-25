import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Test enum used to construct [BridgedEnumDefinition] in tests.
enum TestColor { red, green, blue }

void main() {
  group('D4rt.bridgedLibraryUris', () {
    test('starts empty', () {
      final d4rt = D4rt();
      expect(d4rt.bridgedLibraryUris, isEmpty);
    });

    test('tracks URIs from registerBridgedEnum', () {
      final d4rt = D4rt();
      final enumDef = BridgedEnumDefinition<TestColor>(
        name: 'TestColor',
        values: TestColor.values,
      );
      d4rt.registerBridgedEnum(enumDef, 'package:test_lib/enums.dart');

      expect(d4rt.bridgedLibraryUris, contains('package:test_lib/enums.dart'));
    });

    test('tracks URIs from registerBridgedClass', () {
      final d4rt = D4rt();
      final classDef = BridgedClass(
        name: 'TestClass',
        nativeType: String,
      );
      d4rt.registerBridgedClass(classDef, 'package:test_lib/classes.dart');

      expect(
        d4rt.bridgedLibraryUris,
        contains('package:test_lib/classes.dart'),
      );
    });

    test('tracks URIs from registertopLevelFunction', () {
      final d4rt = D4rt();
      d4rt.registertopLevelFunction(
        'testFunc',
        (visitor, args, namedArgs, typeArgs) => null,
        'package:test_lib/funcs.dart',
      );

      expect(d4rt.bridgedLibraryUris, contains('package:test_lib/funcs.dart'));
    });

    test('tracks URIs from registerGlobalVariable', () {
      final d4rt = D4rt();
      d4rt.registerGlobalVariable('x', 42, 'package:test_lib/vars.dart');

      expect(d4rt.bridgedLibraryUris, contains('package:test_lib/vars.dart'));
    });

    test('tracks URIs from registerGlobalGetter', () {
      final d4rt = D4rt();
      d4rt.registerGlobalGetter('y', () => 99, 'package:test_lib/getters.dart');

      expect(
        d4rt.bridgedLibraryUris,
        contains('package:test_lib/getters.dart'),
      );
    });

    test('tracks URIs from registerGlobalSetter', () {
      final d4rt = D4rt();
      d4rt.registerGlobalSetter(
        'z',
        (v) {},
        'package:test_lib/setters.dart',
      );

      expect(
        d4rt.bridgedLibraryUris,
        contains('package:test_lib/setters.dart'),
      );
    });

    test('tracks URIs from registerBridgedExtension', () {
      final d4rt = D4rt();
      final extDef = BridgedExtensionDefinition(
        name: 'TestExt',
        onTypeName: 'int',
      );
      d4rt.registerBridgedExtension(
        extDef,
        'package:test_lib/extensions.dart',
      );

      expect(
        d4rt.bridgedLibraryUris,
        contains('package:test_lib/extensions.dart'),
      );
    });

    test('deduplicates URIs across multiple registrations', () {
      final d4rt = D4rt();
      d4rt.registerGlobalVariable('a', 1, 'package:test_lib/lib.dart');
      d4rt.registerGlobalVariable('b', 2, 'package:test_lib/lib.dart');

      expect(d4rt.bridgedLibraryUris, hasLength(1));
    });

    test('returns unmodifiable view', () {
      final d4rt = D4rt();
      d4rt.registerGlobalVariable('x', 1, 'package:test_lib/lib.dart');

      expect(
        () => d4rt.bridgedLibraryUris.add('hacked'),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });

  group('D4rt.createBundleFromSource', () {
    test('creates a single-module bundle from simple source', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        'void main() { print("hello"); }',
        sourcePath: 'test.dart',
      );

      expect(bundle, isA<AstBundle>());
      expect(bundle.entryPointUri, 'test.dart');
      expect(bundle.modules, hasLength(1));
    });

    test('skips dart: imports', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
import 'dart:core';
import 'dart:math';
void main() {}
''');

      expect(bundle.modules, hasLength(1));
    });

    test('skips bridged library imports', () async {
      final d4rt = D4rt();
      d4rt.registerGlobalVariable(
        'myVar',
        42,
        'package:my_lib/my_lib.dart',
      );

      final bundle = await d4rt.createBundleFromSource('''
import 'package:my_lib/my_lib.dart';
void main() {}
''');

      // Only the entry point — bridged lib is skipped
      expect(bundle.modules, hasLength(1));
    });

    test('includes explicit sources', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:helper/helper.dart';
void main() {}
''',
        explicitSources: {
          'package:helper/helper.dart': 'int add(int a, int b) => a + b;',
        },
      );

      expect(bundle.modules, hasLength(2));
      expect(
        bundle.modules.containsKey('package:helper/helper.dart'),
        isTrue,
      );
    });

    test('errors on unresolvable package import', () async {
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

  group('D4rt.createBundle', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('d4rt_bundle_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('creates bundle from file', () async {
      final mainFile = File(p.join(tempDir.path, 'main.dart'));
      mainFile.writeAsStringSync('void main() { print("hello"); }');

      final d4rt = D4rt();
      final bundle = await d4rt.createBundle(
        mainFile.path,
        projectRoot: tempDir.path,
      );

      expect(bundle.modules, hasLength(1));
    });

    test('resolves relative imports from disk', () async {
      File(p.join(tempDir.path, 'main.dart')).writeAsStringSync('''
import 'helper.dart';
void main() { greet(); }
''');
      File(p.join(tempDir.path, 'helper.dart')).writeAsStringSync('''
void greet() { print("hello"); }
''');

      final d4rt = D4rt();
      final bundle = await d4rt.createBundle(
        p.join(tempDir.path, 'main.dart'),
        projectRoot: tempDir.path,
      );

      expect(bundle.modules, hasLength(2));
    });

    test('throws on non-existent file', () async {
      final d4rt = D4rt();
      expect(
        () => d4rt.createBundle('/nonexistent/main.dart'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('D4rt.executeBundle', () {
    test('executes a simple bundle', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 42;
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, 42);
    });

    test('executes a bundle with multiple modules via explicitSources',
        () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:math_lib/add.dart';
int main() => add(3, 4);
''',
        explicitSources: {
          'package:math_lib/add.dart': 'int add(int a, int b) => a + b;',
        },
      );

      final result = d4rt.executeBundle(bundle);
      expect(result, 7);
    });

    test('executes bundle with custom entry function name', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int myFunc() => 99;
void main() {}
''');

      final result = d4rt.executeBundle(bundle, name: 'myFunc');
      expect(result, 99);
    });

    test('executes bundle with positional arguments', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
String greet(String name) => 'Hello, \$name!';
void main() {}
''');

      final result = d4rt.executeBundle(
        bundle,
        name: 'greet',
        positionalArgs: ['World'],
      );
      expect(result, 'Hello, World!');
    });

    test('executes bundle with bridged classes', () async {
      final d4rt = D4rt();

      // Register a bridged enum
      final enumDef = BridgedEnumDefinition<TestColor>(
        name: 'TestColor',
        values: TestColor.values,
      );
      d4rt.registerBridgedEnum(enumDef, 'package:colors/colors.dart');

      final bundle = await d4rt.createBundleFromSource('''
import 'package:colors/colors.dart';
String main() {
  final c = TestColor.red;
  return c.toString();
}
''');

      final result = d4rt.executeBundle(bundle);
      expect(result, isA<String>());
    });

    test('bundle is serializable and re-executable', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 42;
''');

      // Round-trip through JSON
      final json = bundle.toJson();
      final restored = AstBundle.fromJson(json);

      final result = d4rt.executeBundle(restored);
      expect(result, 42);
    });

    test('bundle is serializable to bytes and re-executable', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 42;
''');

      // Round-trip through bytes
      final bytes = bundle.toBytes();
      final restored = AstBundle.fromBytes(bytes);

      final result = d4rt.executeBundle(restored);
      expect(result, 42);
    });
  });

  group('D4rt backward compatibility', () {
    test('existing execute() still works', () {
      final d4rt = D4rt();
      final result = d4rt.execute(source: 'int main() => 42;');
      expect(result, 42);
    });

    test('execute with sources still works', () {
      final d4rt = D4rt();
      final result = d4rt.execute(
        library: 'package:test/main.dart',
        sources: {
          'package:test/main.dart': 'int main() => 100;',
        },
      );
      expect(result, 100);
    });

    test('continuedExecute still works', () {
      final d4rt = D4rt();
      d4rt.execute(source: 'void main() {}');
      d4rt.continuedExecute(source: '''
int square(int x) => x * x;
void main() {}
''');
      final result = d4rt.eval('square(5)');
      expect(result, 25);
    });

    test('eval still works', () {
      final d4rt = D4rt();
      d4rt.execute(source: '''
int counter = 0;
int getCounter() => counter;
void main() {}
''', name: 'getCounter');

      final result = d4rt.eval('getCounter()');
      expect(result, 0);
    });

    test('grant and revoke still work', () {
      final d4rt = D4rt();
      d4rt.grant(FilesystemPermission.read);
      expect(d4rt.hasPermission(FilesystemPermission.read), isTrue);
      d4rt.revoke(FilesystemPermission.read);
      expect(d4rt.hasPermission(FilesystemPermission.read), isFalse);
    });
  });

  group('D4rt end-to-end: create → serialize → execute', () {
    test('source → bundle → file → load → execute', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
int main() => 7 * 6;
''');

      // Save to temp file
      final tempDir = Directory.systemTemp.createTempSync('d4rt_e2e_');
      try {
        final bundlePath = p.join(tempDir.path, 'test.d4rtbundle');
        bundle.saveToFile(bundlePath);

        // Load and execute
        final loaded = AstBundle.fromFile(bundlePath);
        final result = d4rt.executeBundle(loaded);
        expect(result, 42);
      } finally {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('multi-module bundle → bytes → execute', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        '''
import 'package:utils/math.dart';
int main() => multiply(6, 7);
''',
        explicitSources: {
          'package:utils/math.dart':
              'int multiply(int a, int b) => a * b;',
        },
      );

      // Round-trip through bytes
      final bytes = bundle.toBytes();
      final restored = AstBundle.fromBytes(bytes);

      final result = d4rt.executeBundle(restored);
      expect(result, 42);
    });
  });
}
