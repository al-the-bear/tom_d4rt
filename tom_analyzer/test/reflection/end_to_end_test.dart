import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_analyzer/src/reflection/generator/reflection_generator.dart';
import 'package:tom_analyzer/src/reflection/generator/entry_point_analyzer.dart';

/// End-to-end tests for reflection code generation with sample projects.
///
/// These tests analyze real Dart source files and verify that
/// the generated reflection code is correct and complete.
void main() {
  group('ReflectionGenerator - End-to-End Tests', () {
    final fixturesPath = p.join(
      Directory.current.path,
      'test',
      'reflection',
      'fixtures',
    );

    group('sample_models.dart analysis', () {
      late ReflectionGenerator generator;
      late ReflectionAnalysisResult result;

      setUpAll(() async {
        final entryPoint = p.join(fixturesPath, 'sample_models.dart');
        generator = ReflectionGenerator.fromMap({
          'entry_points': [entryPoint],
        });
        result = await generator.analyze();
      });

      test('discovers User class', () {
        expect(
          result.classes.map((c) => c.name),
          contains('User'),
        );
      });

      test('discovers TrackedUser class', () {
        expect(
          result.classes.map((c) => c.name),
          contains('TrackedUser'),
        );
      });

      test('discovers Entity abstract class', () {
        expect(
          result.classes.map((c) => c.name),
          contains('Entity'),
        );
      });

      test('discovers Repository generic class', () {
        expect(
          result.classes.map((c) => c.name),
          contains('Repository'),
        );
      });

      test('discovers Trackable mixin', () {
        expect(
          result.mixins.map((m) => m.name),
          contains('Trackable'),
        );
      });

      test('discovers UserRole enum', () {
        expect(
          result.enums.map((e) => e.name),
          contains('UserRole'),
        );
      });

      test('discovers StringUtils extension', () {
        expect(
          result.extensions.map((e) => e.name),
          contains('StringUtils'),
        );
      });

      test('discovers greet global function', () {
        expect(
          result.globalFunctions.map((f) => f.name),
          contains('greet'),
        );
      });

      test('discovers appVersion global variable', () {
        expect(
          result.globalVariables.map((v) => v.name),
          contains('appVersion'),
        );
      });

      test('discovers requestCounter global variable', () {
        expect(
          result.globalVariables.map((v) => v.name),
          contains('requestCounter'),
        );
      });

      test('result has correct type count', () {
        // User, TrackedUser, Entity, Repository = 4 classes
        // Trackable = 1 mixin
        // UserRole = 1 enum
        // StringUtils = 1 extension
        expect(result.classes.length, greaterThanOrEqualTo(4));
        expect(result.mixins.length, greaterThanOrEqualTo(1));
        expect(result.enums.length, greaterThanOrEqualTo(1));
        expect(result.extensions.length, greaterThanOrEqualTo(1));
      });

      test('result has correct global member count', () {
        // greet = 1 function
        // appVersion, requestCounter = 2 variables
        expect(result.globalFunctions.length, greaterThanOrEqualTo(1));
        expect(result.globalVariables.length, greaterThanOrEqualTo(2));
      });
    });

    group('code generation from sample_models', () {
      late ReflectionGenerator generator;
      late String generatedCode;

      setUpAll(() async {
        final entryPoint = p.join(fixturesPath, 'sample_models.dart');
        generator = ReflectionGenerator.fromMap({
          'entry_points': [entryPoint],
        });
        generatedCode = await generator.generate();
      });

      test('generated code imports the fixture library', () {
        expect(generatedCode, contains('sample_models.dart'));
      });

      test('generated code contains User type reference', () {
        expect(generatedCode, contains('User'));
      });

      test('generated code contains UserRole type reference', () {
        expect(generatedCode, contains('UserRole'));
      });

      test('generated code contains Trackable type reference', () {
        expect(generatedCode, contains('Trackable'));
      });

      test('generated code has constructor invokers', () {
        // User has constructors, should have invokers
        expect(generatedCode, contains('name'));
        expect(generatedCode, contains('age'));
      });

      test('generated code has method references', () {
        expect(generatedCode, contains('isAdult'));
        expect(generatedCode, contains('toString'));
      });

      test('generated code is syntactically valid', () {
        // Check balanced delimiters
        final openBraces = '{'.allMatches(generatedCode).length;
        final closeBraces = '}'.allMatches(generatedCode).length;
        expect(openBraces, equals(closeBraces));

        final openParens = '('.allMatches(generatedCode).length;
        final closeParens = ')'.allMatches(generatedCode).length;
        expect(openParens, equals(closeParens));

        final openBrackets = '['.allMatches(generatedCode).length;
        final closeBrackets = ']'.allMatches(generatedCode).length;
        expect(openBrackets, equals(closeBrackets));
      });

      test('generated code length is reasonable', () {
        // Small fixture should generate reasonable amount of code
        expect(generatedCode.length, greaterThan(1000));
        // Code can be large due to invokers and declarations
        expect(generatedCode.length, lessThan(500000));
      });
    });

    group('multiple entry points', () {
      test('generator handles single entry point', () async {
        final entryPoint = p.join(fixturesPath, 'sample_models.dart');
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [entryPoint],
        });

        final result = await generator.analyze();
        expect(result.classes, isNotEmpty);
      });

      test('generator returns empty for non-existent entry point', () async {
        final generator = ReflectionGenerator.fromMap({
          'entry_points': ['/non/existent/path.dart'],
        });

        final result = await generator.analyze();
        // Should handle gracefully
        expect(result.classes, isEmpty);
      });
    });

    group('library metadata', () {
      test('result contains library types mapping', () async {
        final entryPoint = p.join(fixturesPath, 'sample_models.dart');
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [entryPoint],
        });

        final result = await generator.analyze();

        // Should have library to types mapping
        expect(result.libraryTypes, isNotEmpty);
      });

      test('result contains classes from entry point', () async {
        final entryPoint = p.join(fixturesPath, 'sample_models.dart');
        final generator = ReflectionGenerator.fromMap({
          'entry_points': [entryPoint],
        });

        final result = await generator.analyze();

        // Should have discovered classes
        expect(result.classes, isNotEmpty);
      });
    });
  });
}
