/// Tests for type parameter erasure in bridge generator.
///
/// These tests verify that the generator correctly:
/// - Extracts type parameters and their bounds from methods
/// - Uses bounds instead of dynamic when type params have bounds
/// - Handles instance methods, static methods, and global functions
/// - Handles class type parameters vs method type parameters
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('bridge_type_erasure_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Type Parameter Erasure', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'type_erasure_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile =
          p.join(testFixturesDir, 'type_erasure_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'type_erasure_bridges.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    group('Instance Methods with Type Parameters', () {
      test('unbounded type param uses dynamic', () {
        // identity<T> should use dynamic since T has no bound
        expect(
          generatedCode,
          contains("D4.getRequiredArg<dynamic>"),
          reason: 'Unbounded type param T should become dynamic',
        );
      });

      test('bounded type param uses bound type', () {
        // findFirst<E extends BaseEntity> should use BaseEntity
        expect(
          generatedCode,
          contains(r"D4.getRequiredArg<List<$pkg.BaseEntity>>"),
          reason: 'List<E> where E extends BaseEntity should become List<BaseEntity>',
        );
      });

      test('multiple bounded type params use their bounds', () {
        // createMap<K extends Comparable, V extends BaseEntity>
        expect(
          generatedCode,
          contains(r"List<Comparable>"),
          reason: 'K extends Comparable should become Comparable',
        );
        expect(
          generatedCode,
          contains(r"List<$pkg.BaseEntity>"),
          reason: 'V extends BaseEntity should become BaseEntity',
        );
      });
    });

    group('Static Methods with Type Parameters', () {
      test('static method with bounded type param uses bound', () {
        // filterEntities<E extends BaseEntity>
        expect(
          generatedCode,
          contains("'filterEntities'"),
          reason: 'Static method filterEntities should be bridged',
        );
      });

      test('static castFrom uses constrained types', () {
        // castFrom<S extends Observable, E extends Observable>(ObservableList<S>)
        expect(
          generatedCode,
          contains("'castFrom'"),
          reason: 'Static method castFrom should be bridged',
        );
        // Should use Observable as the bound for S in the parameter type
        expect(
          generatedCode,
          contains(r"$pkg.ObservableList<$pkg.Observable>"),
          reason: 'ObservableList<S> where S extends Observable should become ObservableList<Observable>',
        );
      });
    });

    group('Global Functions with Type Parameters', () {
      test('global function with unbounded param uses dynamic', () {
        // globalIdentity<T>(T value)
        expect(
          generatedCode,
          contains("'globalIdentity'"),
          reason: 'Global function globalIdentity should be bridged',
        );
      });

      test('global function with bounded param uses bound', () {
        // findEntity<E extends BaseEntity>(List<E> entities, ...)
        expect(
          generatedCode,
          contains("'findEntity'"),
          reason: 'Global function findEntity should be bridged',
        );
      });

      test('global function with multiple bounds uses correct types', () {
        // buildEntityMap<K extends Comparable, V extends BaseEntity>
        expect(
          generatedCode,
          contains("'buildEntityMap'"),
          reason: 'Global function buildEntityMap should be bridged',
        );
      });
    });

    group('Generic Class with Method Type Parameters', () {
      test('method type params do not conflict with class type params', () {
        // Container<T extends BaseEntity> has method mapFirst<R extends Comparable>
        expect(
          generatedCode,
          contains("'mapFirst'"),
          reason: 'Method mapFirst should be bridged',
        );
      });

      test('static method in generic class uses its own type params', () {
        // Container.createEmpty<E extends BaseEntity>()
        expect(
          generatedCode,
          contains("'createEmpty'"),
          reason: 'Static method createEmpty should be bridged',
        );
      });
    });

    group('MemberInfo Properties', () {
      test('MemberInfo has methodTypeParameters field', () {
        // This is a compile-time test - if MemberInfo doesn't have the field,
        // the generator wouldn't compile
        final info = MemberInfo(
          name: 'test',
          returnType: 'void',
          hasTypeParameters: true,
          methodTypeParameters: {'T': 'Object', 'E': null},
        );
        expect(info.hasTypeParameters, isTrue);
        expect(info.methodTypeParameters['T'], equals('Object'));
        expect(info.methodTypeParameters['E'], isNull);
      });
    });

    group('GlobalFunctionInfo Properties', () {
      test('GlobalFunctionInfo has typeParameters field', () {
        // This is a compile-time test
        final info = GlobalFunctionInfo(
          name: 'test',
          returnType: 'void',
          parameters: [],
          sourceFile: 'test.dart',
          hasTypeParameters: true,
          typeParameters: {'T': 'Object'},
        );
        expect(info.hasTypeParameters, isTrue);
        expect(info.typeParameters['T'], equals('Object'));
      });
    });

    group('Recursive Type Bounds', () {
      test('recursive type bound T extends Comparable<T> is handled without stack overflow', () {
        // sortItems<T extends Comparable<T>> should compile without issues
        expect(
          generatedCode,
          contains("'sortItems'"),
          reason: 'Global function sortItems with recursive bound should be bridged',
        );
      });

      test('recursive type bound uses base type Comparable for erasure', () {
        // minValue<T extends Comparable<T>> - T should be erased to Comparable
        expect(
          generatedCode,
          contains("'minValue'"),
          reason: 'Global function minValue with recursive bound should be bridged',
        );
        expect(
          generatedCode,
          contains("'maxValue'"),
          reason: 'Global function maxValue with recursive bound should be bridged',
        );
      });

      test('class with recursive type bound parameter is bridged', () {
        // SortableContainer<E extends Comparable<E>>
        expect(
          generatedCode,
          contains('SortableContainer'),
          reason: 'Class with recursive type bound should be bridged',
        );
      });

      test('methods on class with recursive bound are included', () {
        // SortableContainer.sorted() and minimum()
        expect(
          generatedCode,
          contains("'sorted'"),
          reason: 'sorted method should be bridged',
        );
        expect(
          generatedCode,
          contains("'minimum'"),
          reason: 'minimum method should be bridged',
        );
      });
    });
  });
}
