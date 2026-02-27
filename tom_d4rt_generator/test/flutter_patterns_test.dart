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
        'G-FLP-27: nested static refs in const defaults are prefixed (Colors-like)',
        () {
          expect(
            generatedCode,
            contains("name: 'WidgetWithNestedStaticConstDefault'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createWidgetWithNestedStaticConstDefaultBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final bridgeSection = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            bridgeSection,
            contains(
              r'const $test_package_1.BoxSideLike(width: $test_package_1.ScalarPaletteLike.thick)',
            ),
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
        'G-FLP-38: Private const identifiers in defaults are not emitted directly. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'WidgetWithPrivateConstArgDefault'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createWidgetWithPrivateConstArgDefaultBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(
              contains(
                r"getNamedArgWithDefault<$test_package_1.BoxSideLike>(named, 'side', const $test_package_1.BoxSideLike(width: _privateDefaultWidth))",
              ),
            ),
            reason:
                'Private identifiers from source defaults are not visible in generated bridge library and must not be emitted directly',
          );
          expect(
            section,
            contains('return \$test_package_1.WidgetWithPrivateConstArgDefault();'),
            reason:
                'Private const arg defaults should use combinatorial fallback path (omitted named arg => constructor default)',
          );
        },
      );

      test(
        'G-FLP-42: Bare identifier values in const-arg defaults are not emitted directly. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'WidgetWithIdentifierConstArgDefault'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createWidgetWithIdentifierConstArgDefaultBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(
              contains(
                r"getNamedArgWithDefault<$test_package_1.BoxSideLike>(named, 'side', const $test_package_1.BoxSideLike(width: touchSlopLike))",
              ),
            ),
            reason:
                'Bare identifier values inside const-ctor defaults are often unresolved across generated library boundaries and must not be emitted directly',
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

      test(
        'G-FLP-47: Required named Future<ConcreteType> parameter is not degraded to Future<dynamic>. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'FutureCodecHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createFutureCodecHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(
              "getRequiredNamedArg<Future<\$test_package_1.CodecLike>>(named, 'codec'",
            ),
            reason:
                'Concrete Future<T> named args should keep T instead of collapsing to dynamic',
          );
          expect(
            section,
            isNot(contains("getRequiredNamedArg<Future<dynamic>>(named, 'codec'")),
          );
        },
      );

      test(
        'G-FLP-48: Generic render-object subtype is preserved in updateRenderObject extraction. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'SlottedWidgetImplLike2'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedWidgetImplLike2Bridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(
              'getRequiredArg<\$test_package_1.SlottedContainerRenderObjectMixinLike2<dynamic, \$test_package_1.RenderObjectLike>>(positional, 0, \'renderObject\'',
            ),
            reason:
                'Concrete child type argument should be preserved instead of collapsing to RenderObjectLike base bound',
          );
          expect(
            section,
            isNot(
              contains(
                "getRequiredArg<\$test_package_1.RenderObjectLike>(positional, 0, 'renderObject'",
              ),
            ),
          );
        },
      );

      test(
        'G-FLP-49: Prefixed generic type argument in Future<T> does not collapse to dynamic. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'PrefixedFutureExternalTypeHostLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createPrefixedFutureExternalTypeHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains('getRequiredNamedArg<Future<'),
          );
          expect(
            section,
            contains('ExternalBoundLike>>(named, \'value\''),
            reason:
                'Aliased/prefixed type arguments should resolve to their actual type instead of dynamic',
          );
          expect(
            section,
            isNot(contains("getRequiredNamedArg<Future<dynamic>>(named, 'value'")),
          );
        },
      );

      test(
        'G-FLP-50: Recursive slotted render-object generic uses concrete child type, not base RenderObjectLike. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains(
              "name: 'SlottedMultiChildRenderObjectWidgetRecursiveImplLike'",
            ),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedMultiChildRenderObjectWidgetRecursiveImplLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(
              "getRequiredArg<\$test_package_1.ConcreteSlottedContainerRenderObjectLike>(positional, 1, 'renderObject'",
            ),
            reason:
                'Concrete recursive child type should be preserved for updateRenderObject argument extraction',
          );
          expect(
            section,
            isNot(
              contains(
                "getRequiredArg<\$test_package_1.RenderObjectLike>(positional, 1, 'renderObject'",
              ),
            ),
          );
        },
      );

      test(
        'G-FLP-51: Covariant slotted render-object parameter keeps mixin type, not base RenderObjectLike. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains(
              "name: 'SlottedMultiChildRenderObjectWidgetCovariantImplLike'",
            ),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedMultiChildRenderObjectWidgetCovariantImplLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(
              "getRequiredArg<\$test_package_1.SlottedContainerRenderObjectMixinRecursiveLike<dynamic, \$test_package_1.ConcreteSlottedContainerRenderObjectLike>>(positional, 1, 'renderObject'",
            ),
            reason:
                'Covariant self-bounded slotted parameter should keep concrete mixin type argument chain',
          );
          expect(
            section,
            isNot(
              contains(
                "getRequiredArg<\$test_package_1.RenderObjectLike>(positional, 1, 'renderObject'",
              ),
            ),
          );
        },
      );

      test(
        'G-FLP-52: Raw recursive RenderObject-bound generic method arg uses dynamic extraction. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'RecursiveRenderObjectWidgetLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createRecursiveRenderObjectWidgetLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(
              "getRequiredArg<dynamic>(positional, 0, 'renderObject', 'updateRenderObject')",
            ),
            reason:
                'Raw recursive RenderObject-bound generics should avoid narrowing to RenderObject in bridge extraction',
          );
          expect(
            section,
            isNot(
              contains(
                "getRequiredArg<\$test_package_1.RenderObject>(positional, 0, 'renderObject', 'updateRenderObject')",
              ),
            ),
          );
        },
      );

      test(
        'G-FLP-53: Inherited mixin method signature should win over broad superclass signature. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'SlottedInheritedPrecedenceWidgetLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedInheritedPrecedenceWidgetLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(
              "getRequiredArg<\$test_package_1.SlottedContainerRenderObjectMixinLike2<dynamic, \$test_package_1.RenderObjectLike>>(positional, 1, 'renderObject', 'updateRenderObject')",
            ),
            reason:
                'Mixin override signature should be used instead of broad superclass RenderObjectLike parameter',
          );
          expect(
            section,
            isNot(
              contains(
                "getRequiredArg<\$test_package_1.RenderObjectLike>(positional, 1, 'renderObject', 'updateRenderObject')",
              ),
            ),
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

    // =========================================================================
    // RC-6: Generic function types in callback wrappers
    // =========================================================================
    group('RC-6: Generic function type callbacks', () {
      test(
        'G-FLP-18: Generic callback wrapper preserves function-level type params. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'GenericRouteHostLike'"));

          // Generic function callback wrappers must preserve `<T>`.
          // We should see `<T>(...)` in the generated wrapper expression,
          // not an erased non-generic `( ... )` closure.
          expect(
            generatedCode,
            contains(RegExp(r'<T>\s*\(')),
            reason:
                'Function<T>(...) callbacks should preserve function-level type parameters',
          );
        },
      );
    });

    // =========================================================================
    // RC-9b: Imported generic type bounds preserved (cross-file)
    // =========================================================================
    group('RC-9b: Imported generic bounds', () {
      test(
        'G-FLP-19: Imported bound type is preserved (not erased to dynamic). [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'ImportedBoundHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createImportedBoundHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final bridgeSection = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          // T extends ExternalBoundLike should resolve to ExternalBoundLike,
          // not dynamic, in argument extraction/casts.
          expect(
            bridgeSection,
            contains('ExternalBoundLike'),
            reason:
                'Imported generic bound should be preserved in generated type arguments',
          );
          expect(
            bridgeSection,
            isNot(contains("getRequiredArg<dynamic>(positional, 0, 'value'")),
            reason:
                'Bounded generic argument should not degrade to dynamic for constructor parameter',
          );
        },
      );
    });

    // =========================================================================
    // RC-8.4b: void callback parameter handling
    // =========================================================================
    group('RC-8.4b: void callback parameter handling', () {
      test(
        'G-FLP-20: Wrapper for Function(void) does not pass void param as value. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'VoidValueCallbackHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createVoidValueCallbackHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final bridgeSection = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            bridgeSection,
            isNot(
              contains(RegExp(r'\(\s*void\s+p0\s*\)\s*\{[^}]*\[\s*p0\s*\]')),
            ),
            reason:
                'void-typed callback params cannot be used as expression values in argument lists',
          );
        },
      );
    });

    // =========================================================================
    // RC-7b: Imported function typedef map values
    // =========================================================================
    group('RC-7b: Imported typedef in Map values', () {
      test(
        'G-FLP-21: Imported function typedef map values are not erased to dynamic. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'ImportedRoutesHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createImportedRoutesHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('coerceMap<String, dynamic>')),
            reason:
                'Map<String, ExternalBuilderLike> should preserve function value type instead of dynamic',
          );
        },
      );
    });

    // =========================================================================
    // RC-8.5: Optional named callback with default should stay non-nullable
    // =========================================================================
    group('RC-8.5: Optional named callback defaults', () {
      test(
        'G-FLP-22: Optional named callback with default is not wrapped as nullable. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'NavigatorLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createNavigatorLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('onGenerateInitialRoutesRaw == null ? null')),
            reason:
                'Non-nullable callback with a default should not become nullable wrapper',
          );
        },
      );
    });

    // =========================================================================
    // RC-8.6: Contravariance — callback parameter nullability must be preserved
    // =========================================================================
    group('RC-8.6: Callback contravariance nullability', () {
      test(
        'G-FLP-28: Nullable callback arg Object? is preserved (not narrowed to Object). [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'GestureMatcherLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createGestureMatcherLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains('bool Function(Object?)'),
            reason:
                'Generated callback types must keep Object? parameter nullability',
          );
          expect(
            section,
            isNot(contains('bool Function(Object value)')),
            reason:
                'Narrowing Object? to Object breaks contravariant assignment compatibility',
          );
        },
      );
    });

    // =========================================================================
    // RC-9e: Generic upper bound num should not degrade to dynamic
    // =========================================================================
    group('RC-9e: Generic num bound preservation', () {
      test(
        'G-FLP-29: LayoutBuilderLike<T extends num> does not extract T as dynamic. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'LayoutBuilderLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createLayoutBuilderLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(
              contains("getRequiredArg<dynamic>(positional, 0, 'constraint'"),
            ),
            reason:
                'Bounded type parameter T extends num should not be extracted as dynamic',
          );
          expect(
            section,
            contains("getRequiredArg<num>(positional, 0, 'constraint'"),
            reason:
                'Expected upper bound num to be used for constructor argument extraction',
          );
        },
      );

      test(
        'G-FLP-31: AbstractLayoutBuilderLike<ConstraintsLike> is not degraded to dynamic. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'LayoutHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createLayoutHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('AbstractLayoutBuilderLike<dynamic>')),
            reason:
                'Concrete bounded generic argument should not be erased to dynamic',
          );
          expect(
            section,
            contains(
              'AbstractLayoutBuilderLike<\$test_package_1.ConstraintsLike>',
            ),
            reason: 'Expected preserved bounded type argument ConstraintsLike',
          );
        },
      );

      test(
        'G-FLP-32: AbstractLayoutBuilderGenericLike<C> method arg keeps bound type instead of dynamic. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'ConcreteLayoutBuilderLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createConcreteLayoutBuilderLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('AbstractLayoutBuilderGenericLike<dynamic>')),
            reason:
                'updateShouldRebuild oldWidget should preserve bounded generic argument',
          );
          expect(
            section,
            contains(
              'AbstractLayoutBuilderGenericLike<\$test_package_1.ConcreteConstraintsLike>',
            ),
            reason:
                'Expected preserved concrete bounded argument in method extraction',
          );
        },
      );

      test(
        'G-FLP-34: AbstractLayoutBuilderGenericLike bridge self-type arg is not dynamic. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'AbstractLayoutBuilderGenericLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createAbstractLayoutBuilderGenericLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('AbstractLayoutBuilderGenericLike<dynamic>')),
            reason:
                'Self-referential bounded generic parameter should keep bound type in abstract bridge methods',
          );
          expect(
            section,
            contains(
              'AbstractLayoutBuilderGenericLike<\$test_package_1.ConstraintsLike>',
            ),
            reason: 'Expected bound-based type substitution instead of dynamic',
          );
        },
      );

      test(
        'G-FLP-35: ConstrainedLayoutBuilderLike inherited oldWidget arg is not dynamic. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'ConstrainedLayoutBuilderLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createConstrainedLayoutBuilderLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('AbstractLayoutBuilderFamilyLike<dynamic>')),
            reason:
                'Inherited generic method argument should preserve class bound type instead of dynamic',
          );
          expect(
            section,
            contains('AbstractLayoutBuilderFamilyLike<\$test_package_1.ConstraintsLike>'),
            reason:
                'Expected oldWidget extraction to use bound ConstraintsLike for ConstraintType',
          );
        },
      );

      test(
        'G-FLP-36: Inherited generic updateShouldRebuild oldWidget does not degrade to dynamic. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'ConstrainedLayoutBuilderInheritedLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createConstrainedLayoutBuilderInheritedLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('AbstractLayoutBuilderFamilyLike<dynamic>')),
            reason:
                'Inherited generic method arg should preserve bound type instead of dynamic',
          );
          expect(
            section,
            contains('AbstractLayoutBuilderFamilyLike<\$test_package_1.ConstraintsLike>'),
            reason:
                'Expected bound-based substitution for inherited oldWidget argument type',
          );
        },
      );

      test(
        'G-FLP-33: SlottedRenderObjectElementGenericLike keeps second arg bound R extends RenderObjectLike. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'SlottedRenderObjectElementGenericLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedRenderObjectElementGenericLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(
              contains(
                'SlottedMultiChildRenderObjectWidgetMixinLike<dynamic, dynamic>',
              ),
            ),
            reason:
                'Second generic arg should preserve RenderObjectLike bound, not degrade to dynamic',
          );
          expect(
            section,
            isNot(
              contains(
                'SlottedMultiChildRenderObjectWidgetMixinLike<\$test_package_1.ChildType,',
              ),
            ),
            reason:
                'Unresolved generic parameter ChildType must not be prefixed as a concrete source type',
          );
          expect(
            section,
            contains(
              'SlottedMultiChildRenderObjectWidgetMixinLike<dynamic, \$test_package_1.RenderObjectLike>',
            ),
            reason:
                'Expected first arg fallback to dynamic with second bound preserved as RenderObjectLike',
          );
        },
      );
    });

    // =========================================================================
    // RC-6b: Generic callback with nested generic return type
    // =========================================================================
    group('RC-6b: Generic callback return type preservation', () {
      test(
        'G-FLP-23: Nullable generic callback keeps <T> and return cast PageRouteLike<T>. [2026-02-26] (PASS)',
        () {
          expect(generatedCode, contains("name: 'WidgetsAppLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createWidgetsAppLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(RegExp(r'<T>\s*\(')),
            reason: 'Generic function callback should preserve <T> in wrapper',
          );
          expect(
            section,
            contains(RegExp(r'as\s+\$test_package_1\.PageRouteLike<T>')),
            reason:
                'Generic return type should preserve T in cast, not degrade to dynamic',
          );
          expect(
            section,
            isNot(contains('PageRouteLike<dynamic>')),
            reason:
                'Generic return type must not be erased to PageRouteLike<dynamic>',
          );
        },
      );
    });

    // =========================================================================
    // RC-9c: Generic upper bounds should not degrade to dynamic
    // =========================================================================
    group('RC-9c: Generic upper bound preservation', () {
      test(
        'G-FLP-24: SlottedWidgetLike preserves R extends Object in constructor extraction. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'SlottedWidgetLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedWidgetLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(
              contains("getRequiredArg<dynamic>(positional, 1, 'renderObject'"),
            ),
            reason:
                'Type parameter R has upper bound Object and should not be extracted as dynamic',
          );
        },
      );

      test(
        'G-FLP-26: Slotted mixin-like bound R extends RenderObjectLike is not erased to dynamic. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'SlottedRenderObjectElementLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createSlottedRenderObjectElementLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(
              contains(
                'SlottedMultiChildRenderObjectWidgetMixinLike<dynamic, dynamic>',
              ),
            ),
            reason:
                'Upper bound RenderObjectLike should be preserved instead of erasing second type argument to dynamic',
          );
          expect(
            section,
            contains(
              r'SlottedMultiChildRenderObjectWidgetMixinLike<dynamic, $test_package_1.RenderObjectLike>',
            ),
            reason:
                'Expected bound-preserved mixin-like type in generated bridge signatures',
          );
        },
      );
    });

    // =========================================================================
    // RC-4b: SDK type names should be explicitly namespaced to avoid clashes
    // =========================================================================
    group('RC-4b: SDK type prefixing for clash-prone names', () {
      test(
        'G-FLP-25: WidgetWithSdkType uses prefixed dart:math types instead of bare Point/Random. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'WidgetWithSdkType'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createWidgetWithSdkTypeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(RegExp(r'\$dart_math(?:_\d+)?\.Point<double>')),
            reason:
                'Point should be namespaced with resolved dart:math import prefix',
          );
          expect(
            section,
            contains(RegExp(r'\$dart_math(?:_\d+)?\.Random')),
            reason:
                'Random should be namespaced with resolved dart:math import prefix',
          );
        },
      );

      test(
        'G-FLP-30: Callback typedef return Point<double> is prefixed with dart:math alias. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'PointFactoryHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createPointFactoryHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(RegExp(r'as\s+\$dart_math(?:_\d+)?\.Point<double>')),
            reason:
                'Wrapper callback return cast should use resolved dart:math alias for Point<double>',
          );
        },
      );

      test(
        'G-FLP-37: dart:collection Queue is prefixed when local Queue exists. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'QueueHostLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createQueueHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains(RegExp(r'\$dart_collection(?:_\d+)?\.Queue<int>')),
            reason:
                'SDK Queue should be explicitly namespaced to avoid clashing with local Queue type',
          );
        },
      );

      test(
        'G-FLP-40: SDK imports are aliased when prefixed SDK types are emitted. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("import 'dart:collection' as \$dart_collection;"),
            reason:
                'When generated code uses \$dart_collection-prefixed symbols, import must carry matching alias',
          );
          expect(
            generatedCode,
            contains("import 'dart:math' as \$dart_math;"),
            reason:
                'When generated code uses \$dart_math-prefixed symbols, import must carry matching alias',
          );
        },
      );
    });

    // =========================================================================
    // RC-1c: External-style optional non-nullable params without visible defaults
    // =========================================================================
    group('RC-1c: External default gaps', () {
      test(
        'G-FLP-39: External non-nullable named params do not degrade to nullable extraction. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'ExternalDefaultGapLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createExternalDefaultGapLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains("getOptionalNamedArg<bool?>(named, 'scrollable')")),
            reason:
                'Non-nullable optional bool should not be extracted as nullable bool?',
          );
          expect(
            section,
            isNot(contains("getOptionalNamedArg<int?>(named, 'maxLines')")),
            reason:
                'Non-nullable optional int should not be extracted as nullable int?',
          );
        },
      );

      test(
        'G-FLP-41: Wide external non-nullable named params avoid nullable extraction. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'ExternalWideDefaultGapLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createExternalWideDefaultGapLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('getOptionalNamedArg<bool?>')),
            reason:
                'Non-nullable bool should not be extracted through nullable helper',
          );
          expect(
            section,
            isNot(contains('getOptionalNamedArg<Duration?>')),
            reason:
                'Non-nullable Duration should not be extracted through nullable helper',
          );
          expect(
            section,
            contains('getRequiredNamedArgTodoDefault'),
            reason:
                'When defaults are unavailable, non-nullable optional params should use TODO-default helper path',
          );
        },
      );

      test(
        'G-FLP-43: Nested callback typedef argument shape is preserved. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'StatefulBuilderHostLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createStatefulBuilderHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('void Function(void)')),
            reason:
                'Nested callback typedefs must not degrade inner callback argument to void-typed value',
          );
          expect(
            section,
            contains('void Function(void Function())'),
            reason:
                'Expected preserved nested callback signature for StateSetterLike',
          );
        },
      );

      test(
        'G-FLP-44: Imported nested callback typedef argument shape is preserved. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'ExternalStatefulBuilderHostLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createExternalStatefulBuilderHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('void Function(void)')),
            reason:
                'Imported nested callback typedefs must not degrade inner callback argument to void-typed value',
          );
          expect(
            section,
            contains('void Function(void Function())'),
            reason:
                'Expected preserved imported nested callback signature for ExternalStateSetterLike',
          );
        },
      );

      test(
        'G-FLP-45: Imported alias-of-alias nested callback typedef is preserved. [2026-02-27] (FAIL)',
        () {
          expect(
            generatedCode,
            contains("name: 'ExternalStatefulBuilderViaAliasHostLike'"),
          );

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createExternalStatefulBuilderViaAliasHostLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            isNot(contains('void Function(void)')),
            reason:
                'Alias-of-alias nested callback typedefs must not collapse inner callback to void-typed value',
          );
          expect(
            section,
            contains('void Function(void Function())'),
            reason:
                'Expected preserved nested callback signature through typedef indirection (VoidCallback-like)',
          );
        },
      );

      test(
        'G-FLP-46: Imported generic nullable predicate keeps T? parameter. [2026-02-27] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'ExternalDragTargetLike'"));

          final sectionStart = generatedCode.indexOf(
            'BridgedClass _createExternalDragTargetLikeBridge()',
          );
          expect(sectionStart, greaterThanOrEqualTo(0));
          final sectionEnd = generatedCode.indexOf(
            'BridgedClass _create',
            sectionStart + 1,
          );
          final section = sectionEnd == -1
              ? generatedCode.substring(sectionStart)
              : generatedCode.substring(sectionStart, sectionEnd);

          expect(
            section,
            contains('(Object? p0) {'),
            reason:
                'Imported generic predicate typedef should preserve nullable parameter in callback wrapper',
          );
          expect(
            section,
            isNot(contains('(Object p0) {')),
            reason:
                'Narrowing T? to T in callback parameters breaks contravariant assignment compatibility',
          );
        },
      );
    });
  });
}
