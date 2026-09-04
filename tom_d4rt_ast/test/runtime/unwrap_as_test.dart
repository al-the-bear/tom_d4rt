/// Tests for [D4.unwrapAs] — the canonical lift-and-cast helper that
/// consolidates the three previously-scattered unwrap paths used by
/// embedders (FlutterD4rt._unwrap, generated bridge adapters, ad-hoc
/// callers).
///
/// Step 1 of `d4rt_consolidation_plan.md`. Mirrors the matching test file
/// in `tom_d4rt/test/generator/unwrap_as_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _NativeWidget {
  const _NativeWidget(this.label);
  final String label;
}

class _NativeContainer extends _NativeWidget {
  const _NativeContainer(super.label);
}

class _Unrelated {
  const _Unrelated();
}

enum _NativeAlignment { topLeft, center, bottomRight }

void main() {
  // --- Bridge fixtures ----------------------------------------------------

  late BridgedClass widgetClass;
  late BridgedEnum alignmentEnum;

  setUp(() {
    widgetClass = BridgedClass(
      nativeType: _NativeWidget,
      name: '_NativeWidget',
    );
    alignmentEnum = BridgedEnum('_NativeAlignment', {
      'topLeft': _placeholder(),
      'center': _placeholder(),
      'bottomRight': _placeholder(),
    });
    // Replace placeholders with values that point back to the live enum
    // (BridgedEnumValue holds a reference to its enumType).
    alignmentEnum.values['topLeft'] = BridgedEnumValue(
      alignmentEnum,
      'topLeft',
      0,
      _NativeAlignment.topLeft,
    );
    alignmentEnum.values['center'] = BridgedEnumValue(
      alignmentEnum,
      'center',
      1,
      _NativeAlignment.center,
    );
    alignmentEnum.values['bottomRight'] = BridgedEnumValue(
      alignmentEnum,
      'bottomRight',
      2,
      _NativeAlignment.bottomRight,
    );
  });

  // --- null handling ------------------------------------------------------

  group('null handling', () {
    test('returns null when T is nullable', () {
      expect(D4.unwrapAs<String?>(null), isNull);
      expect(D4.unwrapAs<int?>(null), isNull);
      expect(D4.unwrapAs<_NativeWidget?>(null), isNull);
    });

    test('throws D4UnwrapException when T is non-nullable', () {
      expect(
        () => D4.unwrapAs<String>(null),
        throwsA(
          isA<D4UnwrapException>()
              .having((e) => e.expectedType, 'expectedType', 'String')
              .having((e) => e.actualType, 'actualType', 'null'),
        ),
      );
    });

    test('uses expectedDescription override in error message', () {
      try {
        D4.unwrapAs<String>(null, expectedDescription: 'build() result');
        fail('expected D4UnwrapException');
      } on D4UnwrapException catch (e) {
        expect(e.expectedType, 'build() result');
        expect(e.toString(), contains('build() result'));
        expect(e.toString(), contains('null'));
      }
    });
  });

  // --- BridgedInstance ----------------------------------------------------

  group('BridgedInstance', () {
    test('unwraps native object when assignable to T', () {
      final native = _NativeContainer('hello');
      final bridged = BridgedInstance(widgetClass, native);
      final result = D4.unwrapAs<_NativeWidget>(bridged);
      expect(result, same(native));
    });

    test('unwraps to a more specific T when concretely assignable', () {
      final native = _NativeContainer('child');
      final bridged = BridgedInstance(widgetClass, native);
      final result = D4.unwrapAs<_NativeContainer>(bridged);
      expect(result, same(native));
      expect(result.label, 'child');
    });

    test('throws D4UnwrapException with bridged-class context when '
        'native is not a T', () {
      final native = _NativeWidget('plain');
      final bridged = BridgedInstance(widgetClass, native);
      try {
        D4.unwrapAs<_Unrelated>(bridged);
        fail('expected D4UnwrapException');
      } on D4UnwrapException catch (e) {
        expect(e.expectedType, '_Unrelated');
        expect(e.actualType, '_NativeWidget');
        expect(e.source, contains('BridgedInstance<_NativeWidget>'));
      }
    });
  });

  // --- BridgedEnumValue ---------------------------------------------------

  group('BridgedEnumValue', () {
    test('unwraps native enum value when assignable to T', () {
      final wrapped = alignmentEnum.values['center']!;
      final result = D4.unwrapAs<_NativeAlignment>(wrapped);
      expect(result, _NativeAlignment.center);
    });

    test('throws D4UnwrapException when native enum is not a T', () {
      final wrapped = alignmentEnum.values['center']!;
      try {
        D4.unwrapAs<_NativeWidget>(wrapped);
        fail('expected D4UnwrapException');
      } on D4UnwrapException catch (e) {
        expect(e.expectedType, '_NativeWidget');
        expect(e.actualType, '_NativeAlignment');
        expect(e.source, 'BridgedEnumValue');
      }
    });
  });

  // --- Raw value passthrough ---------------------------------------------

  group('raw value passthrough', () {
    test('returns plain primitives that already match T', () {
      expect(D4.unwrapAs<String>('hello'), 'hello');
      expect(D4.unwrapAs<int>(42), 42);
      expect(D4.unwrapAs<bool>(true), isTrue);
    });

    test('returns plain native objects that already match T', () {
      final w = _NativeWidget('raw');
      expect(D4.unwrapAs<_NativeWidget>(w), same(w));
    });

    test('throws D4UnwrapException when raw value mismatches T', () {
      try {
        D4.unwrapAs<int>('not an int');
        fail('expected D4UnwrapException');
      } on D4UnwrapException catch (e) {
        expect(e.expectedType, 'int');
        expect(e.actualType, 'String');
        expect(e.source, isNull);
      }
    });
  });

  // --- D4UnwrapException registration -------------------------------------

  group('D4UnwrapException', () {
    test('registers itself with ErrorReporter and can be revoked', () {
      // Tracking is off by default (perf); opt in for this assertion.
      ErrorReporter.enableTracking();
      ErrorReporter.clear();
      try {
        D4.unwrapAs<int>('boom');
      } on D4UnwrapException catch (e) {
        expect(ErrorReporter.errors, contains(e));
        expect(e.revoke(), isTrue);
        expect(ErrorReporter.errors, isNot(contains(e)));
      }
      ErrorReporter.clear();
      ErrorReporter.disableTracking();
    });
  });
}

/// Returns a placeholder BridgedEnumValue used during construction of the
/// [BridgedEnum] map; replaced in `setUp` with values bound to the live
/// enumType once it's created.
BridgedEnumValue _placeholder() => BridgedEnumValue(
  BridgedEnum('placeholder', const {}),
  'placeholder',
  -1,
  _NativeAlignment.topLeft,
);
