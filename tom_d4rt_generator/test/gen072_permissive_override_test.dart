/// GEN-072: Direct export (no show/hide clause) didn't override restrictive
/// re-export from the same package when processed in wrong order.
///
/// Example: Flutter's animation.dart has:
/// 1. `export 'src/animation/animation_controller.dart';`
///    → animation_controller.dart has `export 'curves.dart' show Curve;`
/// 2. `export 'src/animation/curves.dart';` (no show clause - all symbols)
///
/// When animation_controller.dart is processed first, curves.dart gets
/// showClause=[Curve]. Then when the direct curves.dart export is processed,
/// the shouldOverride logic incorrectly kept the restrictive entry because
/// both are same-package.
///
/// The fix adds: `(isCurrentMorePermissive && !isExistingMorePermissive)`
/// to shouldOverride, so a permissive export always overrides a restrictive one.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late Directory tempDir;
  late String root;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('gen072_test_');
    root = tempDir.path;
  });

  tearDown(() {
    try {
      tempDir.deleteSync(recursive: true);
    } catch (_) {}
  });

  /// Creates a file with content, creating parent directories as needed.
  void writeFile(String relativePath, String content) {
    final file = File(p.join(root, relativePath));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(content);
  }

  group('GEN-072: permissive export overrides restrictive same-package re-export', () {
    // This simulates the Flutter animation.dart pattern:
    // - barrel.dart exports intermediate.dart (which re-exports source.dart show ClassA)
    // - barrel.dart also exports source.dart directly (no show clause)
    //
    // When intermediate.dart is processed first, source.dart gets showClause=[ClassA].
    // When the direct source.dart export is processed, it should override to null
    // showClause, allowing all symbols (ClassA and ClassB) to be visible.

    test('G-ISS-16: Direct export (no show) overrides restrictive re-export. [2026-03-01] (PASS)', () async {
      // Source file with multiple classes
      writeFile('pkg/lib/src/source.dart', '''
class ClassA {
  String get name => 'A';
}

class ClassB {
  String get name => 'B';
}

/// Static-only class like Flutter's Curves
abstract final class StaticContainer {
  static const String value1 = 'value1';
  static const String value2 = 'value2';
}
''');

      // Intermediate file that re-exports source.dart with show clause
      writeFile('pkg/lib/src/intermediate.dart', '''
// Re-export only ClassA from source (like tween.dart exports curves.dart show Curve)
export 'source.dart' show ClassA;

class IntermediateClass {
  String get name => 'Intermediate';
}
''');

      // Main barrel - exports intermediate BEFORE source (simulates order in animation.dart)
      // The intermediate has a restrictive re-export, but the direct export should win
      writeFile('pkg/lib/barrel.dart', '''
// This order triggers the bug: intermediate is processed first
export 'src/intermediate.dart';
// Direct export should override the restrictive re-export from intermediate
export 'src/source.dart';
''');

      Directory(p.join(root, 'pkg/lib/src/bridges')).createSync(recursive: true);

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'pkg'),
        packageName: 'pkg',
        sourceImport: 'package:pkg/barrel.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      // Parse exports from the barrel
      final barrelPath = p.join(root, 'pkg/lib/barrel.dart');
      final exports = await generator.parseExportFiles([barrelPath]);

      // Verify source.dart is in exports
      final sourcePath = p.normalize(p.join(root, 'pkg/lib/src/source.dart'));
      expect(exports.containsKey(sourcePath), isTrue,
          reason: 'source.dart should be in exports map');

      final sourceExport = exports[sourcePath]!;
      
      // GEN-072 FIX: The direct export (no show clause) should result in
      // showClause being null, making ALL symbols visible
      expect(sourceExport.showClause, isNull,
          reason: 'GEN-072: Direct export should override restrictive re-export');
      
      // All classes should be exported
      expect(sourceExport.isSymbolExported('ClassA'), isTrue,
          reason: 'ClassA should be exported');
      expect(sourceExport.isSymbolExported('ClassB'), isTrue,
          reason: 'ClassB should be exported (would fail before GEN-072 fix)');
      expect(sourceExport.isSymbolExported('StaticContainer'), isTrue,
          reason: 'StaticContainer should be exported (like Flutter Curves)');
    });

    test('G-ISS-17: Multiple restrictive re-exports still get overridden by direct export. [2026-03-01] (PASS)', () async {
      // Source file with multiple classes
      writeFile('pkg/lib/src/source.dart', '''
class ClassA {}
class ClassB {}
class ClassC {}
''');

      // Multiple intermediate files with restrictive re-exports
      writeFile('pkg/lib/src/intermediate1.dart', '''
export 'source.dart' show ClassA;
''');

      writeFile('pkg/lib/src/intermediate2.dart', '''
export 'source.dart' show ClassB;
''');

      // Main barrel
      writeFile('pkg/lib/barrel.dart', '''
export 'src/intermediate1.dart';
export 'src/intermediate2.dart';
// Direct export should override both restrictive re-exports
export 'src/source.dart';
''');

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'pkg'),
        packageName: 'pkg',
        sourceImport: 'package:pkg/barrel.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      final barrelPath = p.join(root, 'pkg/lib/barrel.dart');
      final exports = await generator.parseExportFiles([barrelPath]);

      final sourcePath = p.normalize(p.join(root, 'pkg/lib/src/source.dart'));
      final sourceExport = exports[sourcePath]!;
      
      // Direct export should make all classes visible
      expect(sourceExport.showClause, isNull,
          reason: 'Direct export should override all restrictive re-exports');
      expect(sourceExport.isSymbolExported('ClassA'), isTrue);
      expect(sourceExport.isSymbolExported('ClassB'), isTrue);
      expect(sourceExport.isSymbolExported('ClassC'), isTrue,
          reason: 'ClassC should be visible via direct export');
    });

    test('G-ISS-18: Restrictive export order: direct export first is preserved. [2026-03-01] (PASS)', () async {
      // Verify that when direct export is processed FIRST, 
      // subsequent restrictive re-exports don't override it

      writeFile('pkg/lib/src/source.dart', '''
class ClassA {}
class ClassB {}
''');

      writeFile('pkg/lib/src/intermediate.dart', '''
export 'source.dart' show ClassA;
''');

      // Direct export FIRST, then restrictive re-export
      writeFile('pkg/lib/barrel.dart', '''
export 'src/source.dart';
export 'src/intermediate.dart';
''');

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'pkg'),
        packageName: 'pkg',
        sourceImport: 'package:pkg/barrel.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      final barrelPath = p.join(root, 'pkg/lib/barrel.dart');
      final exports = await generator.parseExportFiles([barrelPath]);

      final sourcePath = p.normalize(p.join(root, 'pkg/lib/src/source.dart'));
      final sourceExport = exports[sourcePath]!;
      
      // Direct export was first - existing logic already preserves permissive
      expect(sourceExport.showClause, isNull,
          reason: 'Permissive entry should be preserved');
      expect(sourceExport.isSymbolExported('ClassA'), isTrue);
      expect(sourceExport.isSymbolExported('ClassB'), isTrue);
    });

    test('G-ISS-19: Full bridge generation includes all classes from direct export. [2026-03-01] (PASS)', () async {
      // Verify the fix works end-to-end with actual bridge generation

      writeFile('pkg/lib/src/source.dart', '''
class PublicClass {
  PublicClass();
  String get label => 'public';
}

abstract final class StaticOnly {
  static const String value = 'static';
  static String getValue() => value;
}
''');

      writeFile('pkg/lib/src/intermediate.dart', '''
// Only re-exports PublicClass, not StaticOnly
export 'source.dart' show PublicClass;
''');

      writeFile('pkg/lib/barrel.dart', '''
export 'src/intermediate.dart';
export 'src/source.dart';  // Direct export - should include StaticOnly
''');

      Directory(p.join(root, 'pkg/lib/src/bridges')).createSync(recursive: true);

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'pkg'),
        packageName: 'pkg',
        sourceImport: 'package:pkg/barrel.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      final outputPath = p.join(root, 'pkg/lib/src/bridges/test.b.dart');
      final result = await generator.generateBridgesFromExports(
        barrelFiles: [p.join(root, 'pkg/lib/barrel.dart')],
        outputPath: outputPath,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty,
          reason: 'Generation should succeed');
      expect(result.classesGenerated, equals(2),
          reason: 'Both PublicClass and StaticOnly should be generated');

      final generatedCode = File(outputPath).readAsStringSync();
      expect(generatedCode, contains('PublicClass'),
          reason: 'PublicClass should be in generated code');
      expect(generatedCode, contains('StaticOnly'),
          reason: 'StaticOnly should be in generated code (would fail before GEN-072)');
    });
  });
}
