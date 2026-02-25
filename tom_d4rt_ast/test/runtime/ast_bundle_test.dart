import 'dart:convert';
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  // ---------------------------------------------------------------------------
  // Test Helpers
  // ---------------------------------------------------------------------------

  /// Creates a minimal [SCompilationUnit] for testing.
  SCompilationUnit createTestUnit({
    int offset = 0,
    int length = 100,
    List<SDirective>? directives,
    List<SDeclaration>? declarations,
  }) {
    return SCompilationUnit(
      offset: offset,
      length: length,
      directives: directives ?? const [],
      declarations: declarations ?? const [],
    );
  }

  /// Creates a multi-module test bundle.
  AstBundle createTestBundle() {
    return AstBundle(
      entryPointUri: 'bin/main.dart',
      modules: {
        'bin/main.dart': createTestUnit(offset: 0, length: 50),
        'lib/utils.dart': createTestUnit(offset: 0, length: 80),
        'lib/models/user.dart': createTestUnit(offset: 0, length: 120),
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Constructor
  // ---------------------------------------------------------------------------

  group('AstBundle constructor', () {
    test('creates bundle with valid entry point', () {
      final bundle = AstBundle(
        entryPointUri: 'bin/main.dart',
        modules: {'bin/main.dart': createTestUnit()},
      );

      expect(bundle.entryPointUri, 'bin/main.dart');
      expect(bundle.moduleCount, 1);
      expect(bundle.isSingleModule, isTrue);
    });

    test('rejects entry point not in modules', () {
      expect(
        () => AstBundle(
          entryPointUri: 'bin/missing.dart',
          modules: {'bin/main.dart': createTestUnit()},
        ),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('exposes entryPoint getter', () {
      final unit = createTestUnit(length: 42);
      final bundle = AstBundle(
        entryPointUri: 'bin/main.dart',
        modules: {'bin/main.dart': unit},
      );

      expect(bundle.entryPoint.length, 42);
    });

    test('reports moduleCount and isSingleModule correctly', () {
      final multi = createTestBundle();
      expect(multi.moduleCount, 3);
      expect(multi.isSingleModule, isFalse);

      final single = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit()},
      );
      expect(single.moduleCount, 1);
      expect(single.isSingleModule, isTrue);
    });
  });

  // ---------------------------------------------------------------------------
  // JSON Serialization
  // ---------------------------------------------------------------------------

  group('AstBundle JSON serialization', () {
    test('round-trips single module', () {
      final original = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit(offset: 5, length: 99)},
      );

      final json = original.toJson();
      final restored = AstBundle.fromJson(json);

      expect(restored.entryPointUri, 'main.dart');
      expect(restored.moduleCount, 1);
      expect(restored.entryPoint.offset, 5);
      expect(restored.entryPoint.length, 99);
    });

    test('round-trips multiple modules', () {
      final original = createTestBundle();
      final restored = AstBundle.fromJson(original.toJson());

      expect(restored.entryPointUri, original.entryPointUri);
      expect(restored.moduleCount, original.moduleCount);
      expect(restored.modules.keys, containsAll(original.modules.keys));
    });

    test('includes version in JSON', () {
      final bundle = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit()},
      );

      final json = bundle.toJson();
      expect(json[AstBundleFormat.keyVersion], AstBundleFormat.version);
    });

    test('rejects JSON without version', () {
      final json = {
        AstBundleFormat.keyEntryPoint: 'main.dart',
        AstBundleFormat.keyModules: {'main.dart': createTestUnit().toJson()},
      };
      expect(
        () => AstBundle.fromJson(json),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('rejects JSON without entry point', () {
      final json = {
        AstBundleFormat.keyVersion: '1.0',
        AstBundleFormat.keyModules: {'main.dart': createTestUnit().toJson()},
      };
      expect(
        () => AstBundle.fromJson(json),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('rejects JSON without modules', () {
      final json = {
        AstBundleFormat.keyVersion: '1.0',
        AstBundleFormat.keyEntryPoint: 'main.dart',
      };
      expect(
        () => AstBundle.fromJson(json),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('rejects JSON with invalid module', () {
      final json = {
        AstBundleFormat.keyVersion: '1.0',
        AstBundleFormat.keyEntryPoint: 'main.dart',
        AstBundleFormat.keyModules: {'main.dart': 'not-a-map'},
      };
      expect(
        () => AstBundle.fromJson(json),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // Bytes Serialization (gzip-compressed JSON)
  // ---------------------------------------------------------------------------

  group('AstBundle bytes serialization', () {
    test('round-trips via gzip bytes', () {
      final original = createTestBundle();
      final bytes = original.toBytes();
      final restored = AstBundle.fromBytes(bytes);

      expect(restored.entryPointUri, original.entryPointUri);
      expect(restored.moduleCount, original.moduleCount);
    });

    test('produces gzip-compressed output', () {
      final bundle = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit()},
      );

      final bytes = bundle.toBytes();
      // Gzip magic bytes
      expect(bytes[0], 0x1F);
      expect(bytes[1], 0x8B);
    });

    test('bytes are smaller than raw JSON', () {
      final bundle = createTestBundle();
      final bytes = bundle.toBytes();
      final rawJson = jsonEncode(bundle.toJson());

      expect(bytes.length, lessThan(rawJson.length));
    });

    test('rejects invalid bytes', () {
      expect(
        () => AstBundle.fromBytes([0x00, 0x01, 0x02]),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // ZIP Archive Serialization
  // ---------------------------------------------------------------------------

  group('AstBundle ZIP serialization', () {
    test('round-trips via ZIP', () {
      final original = createTestBundle();
      final zip = original.toZip();
      final restored = AstBundle.fromZip(zip);

      expect(restored.entryPointUri, original.entryPointUri);
      expect(restored.moduleCount, original.moduleCount);
      expect(restored.modules.keys, containsAll(original.modules.keys));
    });

    test('produces valid ZIP with PK magic bytes', () {
      final bundle = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit()},
      );

      final zip = bundle.toZip();
      expect(zip[0], 0x50); // P
      expect(zip[1], 0x4B); // K
    });

    test('ZIP contains manifest and module files', () {
      final bundle = createTestBundle();
      final zip = bundle.toZip();

      final archive = ZipDecoder().decodeBytes(zip);
      final fileNames = archive.map((f) => f.name).toSet();

      expect(fileNames, contains(AstBundleFormat.manifestFileName));
      expect(fileNames, contains('0${AstBundleFormat.astJsonSuffix}'));
      expect(fileNames, contains('1${AstBundleFormat.astJsonSuffix}'));
      expect(fileNames, contains('2${AstBundleFormat.astJsonSuffix}'));
    });

    test('manifest correctly maps files to URIs', () {
      final bundle = createTestBundle();
      final zip = bundle.toZip();

      final archive = ZipDecoder().decodeBytes(zip);
      final manifestFile = archive.findFile(AstBundleFormat.manifestFileName)!;
      final manifestJson =
          jsonDecode(utf8.decode(manifestFile.content))
              as Map<String, dynamic>;
      final manifest = AstBundleManifest.fromJson(manifestJson);

      expect(manifest.version, AstBundleFormat.version);
      expect(manifest.entryPoint, 'bin/main.dart');
      expect(manifest.files.values, containsAll(bundle.modules.keys));
    });

    test('module entries are gzip-compressed', () {
      final bundle = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit()},
      );

      final zip = bundle.toZip();
      final archive = ZipDecoder().decodeBytes(zip);

      // Find the first .ast.json file
      final moduleFile = archive.firstWhere(
        (f) => f.name.endsWith(AstBundleFormat.astJsonSuffix),
      );
      final content = moduleFile.content;

      // Should start with gzip magic bytes
      expect(content[0], 0x1F);
      expect(content[1], 0x8B);
    });

    test('rejects invalid ZIP bytes', () {
      expect(
        () => AstBundle.fromZip([0x00, 0x01, 0x02, 0x03]),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('rejects ZIP without manifest', () {
      final archive = Archive();
      archive.addFile(ArchiveFile.string('unrelated.txt', 'hello'));
      final zip = ZipEncoder().encode(archive);

      expect(
        () => AstBundle.fromZip(zip),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // File I/O
  // ---------------------------------------------------------------------------

  group('AstBundle file I/O', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('ast_bundle_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('round-trips via file (ZIP format)', () {
      final original = createTestBundle();
      final path = '${tempDir.path}/test_bundle${AstBundleFormat.bundleExtension}';

      original.saveToFile(path);
      expect(File(path).existsSync(), isTrue);

      final restored = AstBundle.fromFile(path);
      expect(restored.entryPointUri, original.entryPointUri);
      expect(restored.moduleCount, original.moduleCount);
    });

    test('creates parent directories', () {
      final bundle = AstBundle(
        entryPointUri: 'main.dart',
        modules: {'main.dart': createTestUnit()},
      );
      final path = '${tempDir.path}/nested/deep/bundle.ast';

      bundle.saveToFile(path);
      expect(File(path).existsSync(), isTrue);
    });

    test('fromFile auto-detects ZIP format', () {
      final original = createTestBundle();
      final path = '${tempDir.path}/bundle.ast';

      File(path).writeAsBytesSync(original.toZip());
      final restored = AstBundle.fromFile(path);

      expect(restored.entryPointUri, original.entryPointUri);
    });

    test('fromFile auto-detects gzip format', () {
      final original = createTestBundle();
      final path = '${tempDir.path}/bundle.ast.gz';

      File(path).writeAsBytesSync(original.toBytes());
      final restored = AstBundle.fromFile(path);

      expect(restored.entryPointUri, original.entryPointUri);
    });

    test('fromFile auto-detects plain JSON', () {
      final original = createTestBundle();
      final path = '${tempDir.path}/bundle.json';

      File(path).writeAsStringSync(jsonEncode(original.toJson()));
      final restored = AstBundle.fromFile(path);

      expect(restored.entryPointUri, original.entryPointUri);
    });

    test('fromFile throws on missing file', () {
      expect(
        () => AstBundle.fromFile('${tempDir.path}/nonexistent.ast'),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('fromFile throws on empty file', () {
      final path = '${tempDir.path}/empty.ast';
      File(path).writeAsBytesSync([]);

      expect(
        () => AstBundle.fromFile(path),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('fromFile throws on unrecognized format', () {
      final path = '${tempDir.path}/garbage.ast';
      File(path).writeAsBytesSync([0xDE, 0xAD, 0xBE, 0xEF]);

      expect(
        () => AstBundle.fromFile(path),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });
  });

  // ---------------------------------------------------------------------------
  // AstBundleManifest
  // ---------------------------------------------------------------------------

  group('AstBundleManifest', () {
    test('round-trips via JSON', () {
      final original = AstBundleManifest(
        version: '1.0',
        entryPoint: 'bin/main.dart',
        files: {
          '0.ast.json': 'bin/main.dart',
          '1.ast.json': 'lib/utils.dart',
        },
      );

      final json = original.toJson();
      final restored = AstBundleManifest.fromJson(json);

      expect(restored.version, '1.0');
      expect(restored.entryPoint, 'bin/main.dart');
      expect(restored.files.length, 2);
      expect(restored.files['0.ast.json'], 'bin/main.dart');
    });

    test('rejects JSON without version', () {
      expect(
        () => AstBundleManifest.fromJson({
          AstBundleFormat.keyEntryPoint: 'main.dart',
          AstBundleFormat.keyFiles: {},
        }),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('rejects JSON without entry point', () {
      expect(
        () => AstBundleManifest.fromJson({
          AstBundleFormat.keyVersion: '1.0',
          AstBundleFormat.keyFiles: {},
        }),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('rejects JSON without files', () {
      expect(
        () => AstBundleManifest.fromJson({
          AstBundleFormat.keyVersion: '1.0',
          AstBundleFormat.keyEntryPoint: 'main.dart',
        }),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('toString is descriptive', () {
      final manifest = AstBundleManifest(
        version: '1.0',
        entryPoint: 'main.dart',
        files: {'0.ast.json': 'main.dart'},
      );

      expect(manifest.toString(), contains('1.0'));
      expect(manifest.toString(), contains('main.dart'));
      expect(manifest.toString(), contains('1'));
    });
  });

  // ---------------------------------------------------------------------------
  // Cross-format consistency
  // ---------------------------------------------------------------------------

  group('Cross-format consistency', () {
    test('JSON → bytes → JSON produces identical bundle', () {
      final original = createTestBundle();
      final bytes = original.toBytes();
      final fromBytes = AstBundle.fromBytes(bytes);
      final fromJson = AstBundle.fromJson(fromBytes.toJson());

      expect(fromJson.entryPointUri, original.entryPointUri);
      expect(fromJson.moduleCount, original.moduleCount);
    });

    test('JSON → ZIP → JSON produces identical bundle', () {
      final original = createTestBundle();
      final zip = original.toZip();
      final fromZip = AstBundle.fromZip(zip);
      final fromJson = AstBundle.fromJson(fromZip.toJson());

      expect(fromJson.entryPointUri, original.entryPointUri);
      expect(fromJson.moduleCount, original.moduleCount);
    });

    test('all formats preserve module URIs and AST structure', () {
      final original = createTestBundle();

      final fromJson = AstBundle.fromJson(original.toJson());
      final fromBytes = AstBundle.fromBytes(original.toBytes());
      final fromZip = AstBundle.fromZip(original.toZip());

      for (final restored in [fromJson, fromBytes, fromZip]) {
        expect(restored.entryPointUri, original.entryPointUri);
        for (final uri in original.modules.keys) {
          expect(restored.modules.containsKey(uri), isTrue,
              reason: 'Missing module: $uri');
          expect(
            restored.modules[uri]!.length,
            original.modules[uri]!.length,
            reason: 'Length mismatch for $uri',
          );
        }
      }
    });
  });

  // ---------------------------------------------------------------------------
  // toString
  // ---------------------------------------------------------------------------

  group('AstBundle toString', () {
    test('is descriptive', () {
      final bundle = createTestBundle();
      final str = bundle.toString();

      expect(str, contains('bin/main.dart'));
      expect(str, contains('3'));
    });
  });
}
