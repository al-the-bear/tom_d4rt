/// GEN-070: Classes re-exported through intermediate barrel files with show
/// clauses were incorrectly skipped when the target barrel was already visited
/// through a different export chain.
///
/// Example: dcli.dart both exports dcli_core directly (with a show list that
/// does NOT include Find) AND through find.dart which re-exports dcli_core
/// with `show Find`. The visited set prevented re-processing dcli_core through
/// the find.dart chain, causing Find to be missed.
///
/// The fix has two parts:
/// 1. Convert visited set to recursion-stack (remove after return) so barrels
///    can be reached through multiple chains.
/// 2. Union show clauses when merging (multiple export chains are additive).
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
    tempDir = Directory.systemTemp.createTempSync('gen070_test_');
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

  group('GEN-070: re-export through show clause with visited barrel', () {
    // This simulates the dcli pattern:
    // - main_barrel.dart exports dep_barrel.dart with show [A, B] (no C)
    // - main_barrel.dart also exports reexporter.dart with show [C, helper]
    // - reexporter.dart re-exports dep_barrel.dart with show [C]
    //
    // Class C is defined in dep source files. The generator must recognize
    // that C is visible through the reexporter.dart chain even though
    // dep_barrel.dart was already visited via the first chain without C.

    test('G-ISS-10: Class exported through re-export show chain is bridged correctly. [2026-02-15] (PASS)', () async {
      // dep package source files
      writeFile('dep/lib/src/class_a.dart', '''
class ClassA {
  String get name => 'A';
}
''');
      writeFile('dep/lib/src/class_b.dart', '''
class ClassB {
  String get name => 'B';
}
''');
      writeFile('dep/lib/src/class_c.dart', '''
class ClassC {
  String get name => 'C';
}
''');

      // dep barrel - exports all three classes
      writeFile('dep/lib/dep.dart', '''
export 'src/class_a.dart';
export 'src/class_b.dart';
export 'src/class_c.dart';
''');

      // main package reexporter - re-exports ClassC from dep
      writeFile('main/lib/src/reexporter.dart', '''
export '../../../dep/lib/dep.dart' show ClassC;

String helper() => 'helper';
''');

      // main barrel - exports dep with show [ClassA, ClassB] (no ClassC!)
      // AND exports reexporter.dart with show [ClassC, helper]
      writeFile('main/lib/main.dart', '''
export '../../dep/lib/dep.dart' show ClassA, ClassB;
export 'src/reexporter.dart' show ClassC, helper;
''');

      // Output directory
      Directory(p.join(root, 'main/lib/src/bridges')).createSync(recursive: true);

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'main'),
        packageName: 'main',
        sourceImport: 'package:main/main.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      // Parse exports from the main barrel
      final barrelPath = p.join(root, 'main/lib/main.dart');
      final exports = await generator.parseExportFiles([barrelPath]);

      // Verify ClassC's source file is in exports with a show clause 
      // that includes ClassC
      final classCSourcePath = p.normalize(
        p.join(root, 'dep/lib/src/class_c.dart'),
      );

      expect(exports.containsKey(classCSourcePath), isTrue,
          reason: 'ClassC source file should be in exports map');

      final classCExport = exports[classCSourcePath];
      expect(classCExport, isNotNull,
          reason: 'ClassC export info should not be null');
      expect(classCExport!.isSymbolExported('ClassC'), isTrue,
          reason: 'ClassC should be exported (visible through reexporter chain)');

      // Also verify ClassA and ClassB are still exported
      final classASourcePath = p.normalize(
        p.join(root, 'dep/lib/src/class_a.dart'),
      );
      final classBSourcePath = p.normalize(
        p.join(root, 'dep/lib/src/class_b.dart'),
      );

      expect(exports[classASourcePath]?.isSymbolExported('ClassA'), isTrue,
          reason: 'ClassA should be exported from direct chain');
      expect(exports[classBSourcePath]?.isSymbolExported('ClassB'), isTrue,
          reason: 'ClassB should be exported from direct chain');
    });

    test('G-ISS-11: Function exported through re-export show chain is bridged correctly. [2026-02-15] (PASS)', () async {
      // dep package with a function and a class
      writeFile('dep/lib/src/funcs.dart', '''
void funcA() {}
void funcB() {}
''');

      // dep barrel
      writeFile('dep/lib/dep.dart', '''
export 'src/funcs.dart';
''');

      // main reexporter - only re-exports funcB from dep
      writeFile('main/lib/src/reexporter.dart', '''
export '../../../dep/lib/dep.dart' show funcB;
''');

      // main barrel - exports dep with show [funcA] AND reexporter with show [funcB]
      writeFile('main/lib/main.dart', '''
export '../../dep/lib/dep.dart' show funcA;
export 'src/reexporter.dart' show funcB;
''');

      Directory(p.join(root, 'main/lib/src/bridges')).createSync(recursive: true);

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'main'),
        packageName: 'main',
        sourceImport: 'package:main/main.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      final barrelPath = p.join(root, 'main/lib/main.dart');
      final exports = await generator.parseExportFiles([barrelPath]);

      final funcsSourcePath = p.normalize(
        p.join(root, 'dep/lib/src/funcs.dart'),
      );

      expect(exports.containsKey(funcsSourcePath), isTrue,
          reason: 'funcs.dart should be in exports');

      final funcsExport = exports[funcsSourcePath]!;
      expect(funcsExport.isSymbolExported('funcA'), isTrue,
          reason: 'funcA should be exported from direct chain');
      expect(funcsExport.isSymbolExported('funcB'), isTrue,
          reason: 'funcB should be exported through reexporter chain');
    });

    test('G-ISS-12: Full bridge generation includes re-exported class. [2026-02-15] (PASS)', () async {
      // dep source
      writeFile('dep/lib/src/my_class.dart', '''
class MyReexportedClass {
  String get label => 'from dep';
  
  MyReexportedClass();
}
''');

      // dep barrel
      writeFile('dep/lib/dep.dart', '''
export 'src/my_class.dart';
''');

      // main reexporter
      writeFile('main/lib/src/reexporter.dart', '''
export '../../../dep/lib/dep.dart' show MyReexportedClass;
''');

      // main barrel - does NOT directly export MyReexportedClass from dep,
      // only through the reexporter
      writeFile('main/lib/main.dart', '''
export 'src/reexporter.dart' show MyReexportedClass;
''');

      Directory(p.join(root, 'main/lib/src/bridges')).createSync(recursive: true);

      final generator = BridgeGenerator(
        workspacePath: p.join(root, 'main'),
        packageName: 'main',
        sourceImport: 'package:main/main.dart',
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        verbose: true,
      );

      final outputPath = p.join(root, 'main/lib/src/bridges/test.b.dart');
      final result = await generator.generateBridgesFromExports(
        barrelFiles: [p.join(root, 'main/lib/main.dart')],
        outputPath: outputPath,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty,
          reason: 'Generation should succeed without errors');
      expect(result.classesGenerated, greaterThanOrEqualTo(1),
          reason: 'At least MyReexportedClass should be generated');

      // Read generated code
      final generatedFile = File(outputPath);
      expect(generatedFile.existsSync(), isTrue,
          reason: 'Output file should exist');

      final generatedCode = generatedFile.readAsStringSync();
      expect(generatedCode, contains('MyReexportedClass'),
          reason: 'Generated bridge should include MyReexportedClass');
    });
  });
}
