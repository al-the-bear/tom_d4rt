import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle;
import 'package:tom_d4rt_astgen/src/bundler/ast_bundler.dart';

void main() {
  group('AstBundlerConfig', () {
    test('has sensible defaults', () {
      const config = AstBundlerConfig();
      expect(config.stdlibSchemes, {'dart'});
      expect(config.maxImportDepth, 64);
      expect(config.followPartDirectives, true);
    });

    test('can be customized', () {
      const config = AstBundlerConfig(
        stdlibSchemes: {'dart', 'ffi'},
        maxImportDepth: 10,
        followPartDirectives: false,
      );
      expect(config.stdlibSchemes, {'dart', 'ffi'});
      expect(config.maxImportDepth, 10);
      expect(config.followPartDirectives, false);
    });
  });

  group('ImportResolution', () {
    test('include carries source and canonicalUri', () {
      const res = ImportResolution.include(
        'void main() {}',
        canonicalUri: 'lib/main.dart',
      );
      expect(res.action, ImportAction.include);
      expect(res.value, 'void main() {}');
      expect(res.canonicalUri, 'lib/main.dart');
    });

    test('skip carries canonicalUri', () {
      const res = ImportResolution.skip(canonicalUri: 'dart:core');
      expect(res.action, ImportAction.skip);
      expect(res.value, isNull);
      expect(res.canonicalUri, 'dart:core');
    });

    test('error carries message and canonicalUri', () {
      const res = ImportResolution.error(
        'not found',
        canonicalUri: 'package:foo/foo.dart',
      );
      expect(res.action, ImportAction.error);
      expect(res.value, 'not found');
      expect(res.canonicalUri, 'package:foo/foo.dart');
    });
  });

  group('AstBundler.createFromSource', () {
    test('bundles simple source with no imports', () async {
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource(
        'void main() { print("hello"); }',
      );

      expect(bundle.entryPointUri, 'main.dart');
      expect(bundle.modules, hasLength(1));
      expect(bundle.modules.containsKey('main.dart'), isTrue);
      expect(bundle.modules['main.dart'], isA<SCompilationUnit>());
    });

    test('uses custom sourcePath as entry point URI', () async {
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource(
        'void main() {}',
        sourcePath: 'bin/app.dart',
      );

      expect(bundle.entryPointUri, 'bin/app.dart');
      expect(bundle.modules.containsKey('bin/app.dart'), isTrue);
    });

    test('skips dart: stdlib imports', () async {
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource('''
import 'dart:core';
import 'dart:math';
import 'dart:convert';

void main() {}
''');

      expect(bundle.modules, hasLength(1));
      expect(bundle.modules.containsKey('main.dart'), isTrue);
    });

    test('skips bridged library imports', () async {
      final bundler = AstBundler(
        bridgedLibraries: {
          'package:flutter/material.dart',
          'package:my_lib/my_lib.dart',
        },
      );
      final bundle = await bundler.createFromSource('''
import 'package:flutter/material.dart';
import 'package:my_lib/my_lib.dart';

void main() {}
''');

      expect(bundle.modules, hasLength(1));
    });

    test('includes explicit sources', () async {
      final bundler = AstBundler(
        explicitSources: {
          'package:helper/helper.dart': 'int add(int a, int b) => a + b;',
        },
      );
      final bundle = await bundler.createFromSource('''
import 'package:helper/helper.dart';

void main() { add(1, 2); }
''');

      expect(bundle.modules, hasLength(2));
      expect(
        bundle.modules.containsKey('package:helper/helper.dart'),
        isTrue,
      );
    });

    test('errors on unresolvable package imports', () async {
      final bundler = AstBundler();
      expect(
        () => bundler.createFromSource('''
import 'package:unknown/unknown.dart';

void main() {}
'''),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('not bridged'),
          ),
        ),
      );
    });

    test('handles export directives', () async {
      final bundler = AstBundler(
        bridgedLibraries: {'package:reexported/reexported.dart'},
      );
      final bundle = await bundler.createFromSource('''
export 'dart:math';
export 'package:reexported/reexported.dart';

void main() {}
''');

      // dart:math and bridged library are skipped
      expect(bundle.modules, hasLength(1));
    });

    test('deduplicates imports', () async {
      // Two explicit source modules that both "import" each other
      // via a chain: entry → A → (dart:core), entry → A (again)
      final bundler = AstBundler(
        explicitSources: {
          'package:a/a.dart': '''
import 'dart:core';
int aValue = 1;
''',
        },
      );
      final bundle = await bundler.createFromSource('''
import 'package:a/a.dart';
import 'package:a/a.dart';

void main() {}
''');

      // entry + a = 2 modules
      expect(bundle.modules, hasLength(2));
    });

    test('recurses through explicit source imports', () async {
      final bundler = AstBundler(
        explicitSources: {
          'package:a/a.dart': '''
import 'package:b/b.dart';
int aValue = 1;
''',
          'package:b/b.dart': '''
int bValue = 2;
''',
        },
      );
      final bundle = await bundler.createFromSource('''
import 'package:a/a.dart';

void main() {}
''');

      // entry + a + b = 3 modules
      expect(bundle.modules, hasLength(3));
      expect(bundle.modules.containsKey('package:a/a.dart'), isTrue);
      expect(bundle.modules.containsKey('package:b/b.dart'), isTrue);
    });

    test('respects custom stdlib schemes', () async {
      final bundler = AstBundler(
        config: const AstBundlerConfig(
          stdlibSchemes: {'dart', 'ffi'},
        ),
      );
      // dart: and ffi: should both be skipped
      final bundle = await bundler.createFromSource('''
import 'dart:core';

void main() {}
''');

      expect(bundle.modules, hasLength(1));
    });

    test('detects circular imports without infinite loop', () async {
      // a imports b, b imports a — should not infinite loop because
      // deduplication prevents re-processing
      final bundler = AstBundler(
        explicitSources: {
          'package:a/a.dart': '''
import 'package:b/b.dart';
int aValue = 1;
''',
          'package:b/b.dart': '''
import 'package:a/a.dart';
int bValue = 2;
''',
        },
      );
      final bundle = await bundler.createFromSource('''
import 'package:a/a.dart';

void main() {}
''');

      expect(bundle.modules, hasLength(3));
    });

    test('returns valid AstBundle', () async {
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource(
        'void main() {}',
        sourcePath: 'test.dart',
      );

      expect(bundle, isA<AstBundle>());
      expect(bundle.entryPointUri, 'test.dart');

      // Verify the AST has declarations
      final entryUnit = bundle.modules['test.dart']!;
      expect(entryUnit.declarations, isNotEmpty);
    });

    test('throws FormatException on parse errors by default', () async {
      final bundler = AstBundler();
      expect(
        () => bundler.createFromSource(
          'void main( { }',
          sourcePath: 'bad.dart',
        ),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('AstBundler.createFromFile', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('ast_bundler_test_');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('bundles a simple file', () async {
      final mainFile = File(p.join(tempDir.path, 'main.dart'));
      mainFile.writeAsStringSync('void main() { print("hello"); }');

      final bundler = AstBundler(projectRoot: tempDir.path);
      final bundle = await bundler.createFromFile(mainFile.path);

      expect(bundle.modules, hasLength(1));
      expect(bundle.modules.values.first, isA<SCompilationUnit>());
    });

    test('throws on non-existent file', () async {
      final bundler = AstBundler();
      expect(
        () => bundler.createFromFile('/nonexistent/main.dart'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('resolves relative imports from disk', () async {
      // Create project structure:
      // tempDir/
      //   main.dart (imports helper.dart)
      //   helper.dart
      final mainFile = File(p.join(tempDir.path, 'main.dart'));
      mainFile.writeAsStringSync('''
import 'helper.dart';

void main() { greet(); }
''');

      final helperFile = File(p.join(tempDir.path, 'helper.dart'));
      helperFile.writeAsStringSync('''
void greet() { print("hello"); }
''');

      final bundler = AstBundler(projectRoot: tempDir.path);
      final bundle = await bundler.createFromFile(mainFile.path);

      expect(bundle.modules, hasLength(2));
    });

    test('resolves package: imports for same package from disk', () async {
      // Create package structure:
      // tempDir/
      //   pubspec.yaml
      //   lib/
      //     src/
      //       utils.dart
      //   bin/
      //     main.dart (imports package:test_pkg/src/utils.dart)
      Directory(p.join(tempDir.path, 'lib', 'src')).createSync(recursive: true);
      Directory(p.join(tempDir.path, 'bin')).createSync(recursive: true);

      File(p.join(tempDir.path, 'pubspec.yaml')).writeAsStringSync('''
name: test_pkg
version: 0.0.1
''');

      final utilsFile = File(
        p.join(tempDir.path, 'lib', 'src', 'utils.dart'),
      );
      utilsFile.writeAsStringSync('String greet() => "hello";');

      final mainFile = File(p.join(tempDir.path, 'bin', 'main.dart'));
      mainFile.writeAsStringSync('''
import 'package:test_pkg/src/utils.dart';

void main() { greet(); }
''');

      final bundler = AstBundler(
        packageName: 'test_pkg',
        projectRoot: tempDir.path,
      );
      final bundle = await bundler.createFromFile(mainFile.path);

      expect(bundle.modules, hasLength(2));
      expect(
        bundle.modules.containsKey('package:test_pkg/src/utils.dart'),
        isTrue,
      );
    });

    test('resolves nested relative imports recursively', () async {
      // tempDir/
      //   main.dart → imports a.dart
      //   a.dart → imports sub/b.dart
      //   sub/
      //     b.dart
      Directory(p.join(tempDir.path, 'sub')).createSync();

      File(p.join(tempDir.path, 'main.dart')).writeAsStringSync('''
import 'a.dart';
void main() {}
''');

      File(p.join(tempDir.path, 'a.dart')).writeAsStringSync('''
import 'sub/b.dart';
int aVal = 1;
''');

      File(p.join(tempDir.path, 'sub', 'b.dart')).writeAsStringSync('''
int bVal = 2;
''');

      final bundler = AstBundler(projectRoot: tempDir.path);
      final bundle = await bundler.createFromFile(
        p.join(tempDir.path, 'main.dart'),
      );

      // main + a + sub/b = 3
      expect(bundle.modules, hasLength(3));
    });

    test('combines bridged, explicit, and file-system imports', () async {
      File(p.join(tempDir.path, 'main.dart')).writeAsStringSync('''
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:extra/extra.dart';
import 'local.dart';

void main() {}
''');

      File(p.join(tempDir.path, 'local.dart')).writeAsStringSync('''
int localVal = 42;
''');

      final bundler = AstBundler(
        projectRoot: tempDir.path,
        bridgedLibraries: {'package:flutter/material.dart'},
        explicitSources: {
          'package:extra/extra.dart': 'int extraVal = 99;',
        },
      );
      final bundle = await bundler.createFromFile(
        p.join(tempDir.path, 'main.dart'),
      );

      // main + local + extra = 3 (dart:math skipped, flutter skipped)
      expect(bundle.modules, hasLength(3));
    });

    test('detects project root from pubspec.yaml', () async {
      // Create pubspec so project root is detected
      File(p.join(tempDir.path, 'pubspec.yaml')).writeAsStringSync('''
name: detect_test
version: 0.0.1
''');

      final mainFile = File(p.join(tempDir.path, 'main.dart'));
      mainFile.writeAsStringSync('void main() {}');

      // Don't pass projectRoot — should auto-detect
      final bundler = AstBundler();
      final bundle = await bundler.createFromFile(mainFile.path);

      expect(bundle.modules, hasLength(1));
      // Entry point should be relative to detected project root
      expect(bundle.entryPointUri, 'main.dart');
    });
  });

  group('AstBundler edge cases', () {
    test('handles empty source', () async {
      // An empty .dart file is valid (no declarations or directives)
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource(
        '',
        sourcePath: 'empty.dart',
      );

      expect(bundle.modules, hasLength(1));
      expect(bundle.modules['empty.dart']!.declarations, isEmpty);
    });

    test('handles source with only imports (no declarations)', () async {
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource('''
import 'dart:core';
''');

      expect(bundle.modules, hasLength(1));
    });

    test('part directive import resolution can be disabled', () async {
      final bundler = AstBundler(
        config: const AstBundlerConfig(followPartDirectives: false),
        explicitSources: {
          'my_part.dart': 'part of "main.dart"; int x = 1;',
        },
      );

      // Source with a part directive — should NOT follow it
      final bundle = await bundler.createFromSource('''
part 'my_part.dart';

void main() {}
''');

      // Only the main module (part was not followed)
      expect(bundle.modules, hasLength(1));
    });

    test('AstBundle from bundler is serializable', () async {
      final bundler = AstBundler(
        explicitSources: {
          'package:lib/math.dart': 'int add(int a, int b) => a + b;',
        },
      );
      final bundle = await bundler.createFromSource('''
import 'package:lib/math.dart';
void main() { add(1, 2); }
''');

      // Verify round-trip through JSON
      final json = bundle.toJson();
      final restored = AstBundle.fromJson(json);

      expect(restored.entryPointUri, bundle.entryPointUri);
      expect(restored.modules.length, bundle.modules.length);
      for (final key in bundle.modules.keys) {
        expect(restored.modules.containsKey(key), isTrue);
      }
    });

    test('AstBundle from bundler serializes to bytes', () async {
      final bundler = AstBundler();
      final bundle = await bundler.createFromSource(
        'void main() {}',
        sourcePath: 'entry.dart',
      );

      final bytes = bundle.toBytes();
      final restored = AstBundle.fromBytes(bytes);

      expect(restored.entryPointUri, 'entry.dart');
      expect(restored.modules, hasLength(1));
    });
  });
}
