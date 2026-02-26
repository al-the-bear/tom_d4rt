/// Tests for bridge generator Flutter-specific patterns.
///
/// Reproduces compilation error patterns found when generating bridges
/// for Flutter SDK APIs. Each test group corresponds to an RC (Root Cause)
/// from the bridge_generator_flutter_analysis.md.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp
        .createTempSync('bridge_flutter_patterns_')
        .path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Flutter Pattern Generation', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'flutter_patterns_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(
        testFixturesDir,
        'flutter_patterns_source.dart',
      );
      final outputFile = p.join(tempOutputDir, 'flutter_patterns_bridges.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'flutter_test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    // =========================================================================
    // RC-3: Enum as built-in type (must be emitted unprefixed)
    // =========================================================================
    group('RC-3: Enum built-in type', () {
      test(
        'G-FLP-01: Enum type param emitted unprefixed in RestorableEnumLike. [2026-02-26] (PASS)',
        () {
          // The generator must NOT prefix Enum with $test_package_N.Enum
          // because Enum is a dart:core built-in type
          expect(generatedCode, contains("name: 'RestorableEnumLike'"));

          // Should NOT contain prefixed Enum like $test_package_1.Enum
          final prefixedEnumPattern = RegExp(r'\$\w+\.\bEnum\b');
          expect(
            generatedCode,
            isNot(matches(prefixedEnumPattern)),
            reason: 'Enum should be unprefixed (dart:core built-in type)',
          );
        },
      );

      test(
        'G-FLP-02: Enum used directly as parameter type is unprefixed. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'EnumHolder'"));
          // Check that Enum appears without prefix in getRequiredArg calls
          // Should be: D4.getRequiredArg<Enum>(...) not D4.getRequiredArg<$xxx.Enum>(...)
          expect(
            generatedCode,
            contains('getRequiredArg<Enum>'),
            reason: 'Enum parameter should use unprefixed Enum type',
          );
        },
      );
    });

    // =========================================================================
    // RC-1: Non-wrappable const constructor defaults
    // =========================================================================
    group('RC-1: Non-wrappable defaults', () {
      test(
        'G-FLP-03: const SimpleValue(0, 0) default uses non-nullable type. [2026-02-26] (FAIL)',
        () {
          // The generated code for WidgetWithDefaults constructor must NOT
          // produce getOptionalNamedArg<SimpleValue?> for the offset parameter
          // because that makes the type nullable, causing compile errors.
          expect(generatedCode, contains("name: 'WidgetWithDefaults'"));

          // Should NOT have nullable fallback for non-nullable params with defaults
          expect(
            generatedCode,
            isNot(
              contains("getOptionalNamedArg<\$test_package_1.SimpleValue?>"),
            ),
            reason:
                'Non-wrappable defaults should not fall back to nullable type',
          );
        },
      );

      test(
        'G-FLP-04: const BoxSideLike() default uses non-nullable type. [2026-02-26] (FAIL)',
        () {
          expect(
            generatedCode,
            isNot(
              contains("getOptionalNamedArg<\$test_package_1.BoxSideLike?>"),
            ),
            reason:
                'Non-wrappable defaults should not fall back to nullable type',
          );
        },
      );

      test(
        'G-FLP-05: Static access defaults remain wrappable. [2026-02-26] (FAIL)',
        () {
          // SimpleValue.origin and BoxSideLike.none should be wrappable
          // (ClassName.value pattern)
          expect(
            generatedCode,
            contains('SimpleValue.origin'),
            reason: 'Static access default should be inlined',
          );
        },
      );

      test(
        'G-FLP-06: const SimpleValue.zero() named ctor default handled. [2026-02-26] (FAIL)',
        () {
          // const SimpleValue.zero() is a named constructor with no args
          // Should produce non-nullable type, not nullable fallback
          expect(
            generatedCode,
            isNot(
              contains(
                "getOptionalNamedArg<\$test_package_1.SimpleValue?>(named, 'offset')",
              ),
            ),
            reason:
                'Named constructor defaults should not produce nullable fallback',
          );
        },
      );
    });

    // =========================================================================
    // RC-1b: Many non-wrappable defaults (exceeds combinatorial threshold)
    // =========================================================================
    group('RC-1b: Non-wrappable defaults exceeding threshold', () {
      test(
        'G-FLP-08: ManyDefaultsWidget with 5 non-wrappable defaults uses non-nullable types. [2026-02-26] (PASS)',
        () {
          // With 5 non-wrappable defaults (> 4 threshold), combinatorial
          // dispatch is disabled. The generator falls back to individual
          // parameter extraction. It MUST NOT produce nullable types for
          // non-nullable parameters.
          expect(generatedCode, contains("name: 'ManyDefaultsWidget'"));

          // Should NOT use getOptionalNamedArg with nullable type for any
          // of the SimpleValue or BoxSideLike parameters
          expect(
            generatedCode,
            isNot(matches(RegExp(r'getOptionalNamedArg<[^>]*SimpleValue\?>'))),
            reason:
                'Non-nullable SimpleValue params should not use nullable fallback',
          );
          expect(
            generatedCode,
            isNot(matches(RegExp(r'getOptionalNamedArg<[^>]*BoxSideLike\?>'))),
            reason:
                'Non-nullable BoxSideLike params should not use nullable fallback',
          );
        },
      );

      test(
        'G-FLP-09: Const constructor defaults become wrappable with prefix. [2026-02-26] (PASS)',
        () {
          // The generator should be able to prefix const constructor defaults:
          // const SimpleValue(0, 0) → const $prefix.SimpleValue(0, 0)
          // This makes them wrappable, potentially enabling combinatorial dispatch
          // or direct default value usage.
          expect(generatedCode, contains("name: 'ManyDefaultsWidget'"));

          // Should use getNamedArgWithDefault (wrappable default) OR
          // getRequiredNamedArgTodoDefault (non-nullable fallback) —
          // NOT getOptionalNamedArg with nullable type
          final hasProperHandling =
              generatedCode.contains(
                RegExp(r'getNamedArgWithDefault<[^>]*SimpleValue>'),
              ) ||
              generatedCode.contains(
                RegExp(r'getRequiredNamedArgTodoDefault<[^>]*SimpleValue>'),
              );
          expect(
            hasProperHandling,
            isTrue,
            reason:
                'Const constructor defaults should use either wrappable default or non-nullable todo default',
          );
        },
      );
    });

    // =========================================================================
    // RC-5: Typed empty collection defaults with type resolution
    // =========================================================================
    group('RC-5: Typed collection defaults', () {
      test(
        'G-FLP-10: Typed empty list default has resolved type prefix. [2026-02-26] (PASS)',
        () {
          // const <SimpleValue>[] should become const <$prefix.SimpleValue>[]
          // in the generated code, not preserve the source file's prefix
          expect(
            generatedCode,
            contains("name: 'WidgetWithCollectionDefaults'"),
          );

          // The type arg in the typed list should be prefixed
          expect(
            generatedCode,
            contains(r'const <$test_package_1.SimpleValue>[]'),
            reason: 'Typed empty list default should have resolved type prefix',
          );
        },
      );

      test(
        'G-FLP-11: Typed empty map default has resolved type prefixes. [2026-02-26] (PASS)',
        () {
          // const <String, BoxSideLike>{} should become
          // const <String, $prefix.BoxSideLike>{} in the generated code
          expect(
            generatedCode,
            contains("name: 'WidgetWithCollectionDefaults'"),
          );

          expect(
            generatedCode,
            contains(r'const <String, $test_package_1.BoxSideLike>{}'),
            reason:
                'Typed empty map default should have resolved type prefixes',
          );
        },
      );
    });

    // =========================================================================
    // RC-7: Map value type erased when it's a function type alias
    // =========================================================================
    group('RC-7: Map value function type alias', () {
      test(
        'G-FLP-12: Map value function type alias is not erased to dynamic. [2026-02-26] (PASS)',
        () {
          // Map<String, BuilderCallback> should NOT become Map<String, dynamic>
          // in the generated coercion code. The function type alias should be
          // expanded or preserved.
          expect(generatedCode, contains("name: 'RouterLike'"));

          // The generated code should NOT use coerceMap<String, dynamic>
          expect(
            generatedCode,
            isNot(contains('coerceMap<String, dynamic>')),
            reason:
                'Map value function type alias should not be erased to dynamic',
          );
        },
      );
    });

    // =========================================================================
    // RC-4: dart: SDK type name clashes — DEFERRED
    // Requires architectural change: all code paths (nativeType, constructor
    // bodies, extension casts, etc.) must honor dart: prefixes. Too many code
    // paths to update safely in this batch. See bridge_generator_flutter_analysis.md.
    // =========================================================================

    // =========================================================================
    // RC-2: Callback with non-nullable optional named params
    // =========================================================================
    group('RC-2: Callback named params', () {
      test(
        'G-FLP-07: Callback with non-nullable optional named bool param. [2026-02-26] (PASS)',
        () {
          // The generated closure for DecoderCallback must not have
          // `bool allowUpscaling` without a default value or `required` keyword.
          // Either `required bool allowUpscaling` or `bool allowUpscaling = false`
          // is acceptable.
          expect(generatedCode, contains("name: 'ImageProviderLike'"));

          // Check that the generated callback wrapper has either:
          // 1. `required bool allowUpscaling` or
          // 2. `bool allowUpscaling = false` (or some default)
          // But NOT bare `bool allowUpscaling` (which would have null implicit default)
          final bareNonNullableNamedBool = RegExp(
            r'\{\s*(?!required\s)bool\s+allowUpscaling\s*[,}]',
          );
          expect(
            generatedCode,
            isNot(matches(bareNonNullableNamedBool)),
            reason:
                'Non-nullable optional named bool in callback must have default or required',
          );
        },
      );
    });

    // =========================================================================
    // RC-8.1: Optional positional callback made nullable
    // =========================================================================
    group('RC-8.1: Optional positional callback nullability', () {
      test(
        'G-FLP-15: Optional positional callback with non-nullable type stays non-nullable. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'DecorationLike'"));

          // The generated wrapper for createBoxPainter's optional positional
          // onChanged parameter must NOT be nullable (void Function()? → wrong).
          // The API type is void Function() (non-nullable). Being optional
          // means the param can be omitted, not that nulls are accepted.
          //
          // Bad: onChangedRaw == null ? null : (...) { ... }
          // Good: (...) { ... }  (just the wrapper, non-nullable)
          expect(
            generatedCode,
            isNot(contains(RegExp(r'onChangedRaw == null \? null'))),
            reason:
                'Optional positional with non-nullable function type should not generate null-check wrapper',
          );
        },
      );
    });

    // =========================================================================
    // RC-8.2: Callback return type preserved (not erased to dynamic)
    // =========================================================================
    group('RC-8.2: Callback return type preservation', () {
      test(
        'G-FLP-16: Typedef callback return type Future<ConcreteType> is preserved in cast. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'ImageDecoderLike'"));

          // The CodecDecoderCallback typedef returns Future<CodecLike>.
          // The generated wrapper must cast the return value to the concrete type:
          //   as Future<$test_package_1.CodecLike>
          // NOT: as Future<dynamic> or as Future<Object>
          expect(
            generatedCode,
            contains(r'as Future<$test_package_1.CodecLike>'),
            reason:
                'Callback return type Future<CodecLike> should be preserved in the cast, not erased to dynamic',
          );
        },
      );
    });

    // =========================================================================
    // RC-8.3: Type parameter nullability preserved in callbacks
    // =========================================================================
    group('RC-8.3: Type parameter nullability in callbacks', () {
      test(
        'G-FLP-17: Callback with List<T?> where T extends Object resolves to List<Object?>. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'DragTargetLike'"));

          // DragTargetLike<T extends Object>.build(void Function(List<T?>, List<dynamic>))
          // When T is erased, List<T?> must become List<Object?> not List<Object>.
          // T's bound is Object, so T? = Object?.
          expect(
            generatedCode,
            contains('List<Object?>'),
            reason:
                'List<T?> where T extends Object should resolve to List<Object?>, not List<Object>',
          );
          expect(
            generatedCode,
            isNot(contains(RegExp(r'List<Object>[^?]'))),
            reason:
                'Should not have List<Object> without ? when the source type is List<T?>',
          );
        },
      );
    });
  });
}
