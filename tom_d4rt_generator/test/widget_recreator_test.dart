/// Tests for the MCI#5 / A5 generic-widget re-creator emitter
/// ([generateWidgetReCreator]).
///
/// Some immutable Flutter widgets (`DropdownMenuItem<T>`,
/// `DropdownMenuEntry<T>`, `ButtonSegment<T>`) cannot be relaxer-wrapped; they
/// are instead RE-CONSTRUCTED with the script's `<T>` by reading each
/// constructor parameter back from its same-named instance getter. The emitter
/// replaces the previously hand-written re-creators in
/// `tom_d4rt_flutter*/lib/src/d4rt_runtime_registrations.dart`.
///
/// These tests pin: byte-for-byte parity with the hand-written
/// `DropdownMenuItem` re-creator (the nullable-`value` form), the
/// non-nullable-`value` cast for `DropdownMenuEntry`/`ButtonSegment`, the
/// custom-inner-types path, and the conservative bail conditions (multi-param
/// generics, missing default constructor, a constructor parameter without a
/// matching getter, and a parameter that references the type parameter in a
/// non-bare form).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('generateWidgetReCreator (MCI#5)', () {
    /// Builds a single-type-parameter widget [ClassInfo] with a default
    /// constructor and a matching instance getter for every parameter.
    ClassInfo widget(
      String name,
      List<ParameterInfo> ctorParams, {
      String typeParam = 'T',
    }) {
      return ClassInfo(
        name: name,
        sourceFile: 'package:flutter/material.dart',
        typeParameters: {typeParam: null},
        constructors: [ConstructorInfo(parameters: ctorParams)],
        members: [
          for (final p in ctorParams)
            MemberInfo(name: p.name, returnType: p.type, isGetter: true),
        ],
      );
    }

    ParameterInfo named(String name, String type) =>
        ParameterInfo(name: name, type: type, isNamed: true, isRequired: false);

    List<String> warnings = [];
    void warn(String m) => warnings.add(m);
    setUp(() => warnings = []);

    final dropdownMenuItem = widget('DropdownMenuItem', [
      named('key', 'Key?'),
      named('onTap', 'VoidCallback?'),
      named('value', 'T?'),
      named('enabled', 'bool'),
      named('alignment', 'AlignmentGeometry'),
      named('child', 'Widget?'),
    ]);

    final dropdownMenuEntry = widget('DropdownMenuEntry', [
      named('value', 'T'),
      named('label', 'String'),
      named('labelWidget', 'Widget?'),
      named('leadingIcon', 'Widget?'),
      named('trailingIcon', 'Widget?'),
      named('enabled', 'bool'),
      named('style', 'ButtonStyle?'),
    ]);

    final buttonSegment = widget('ButtonSegment', [
      named('value', 'T'),
      named('icon', 'Widget?'),
      named('label', 'Widget?'),
      named('tooltip', 'String?'),
      named('enabled', 'bool'),
    ]);

    test('G-RCR-1: DropdownMenuItem matches the hand-written re-creator byte-for-byte. [2026-06-07 00:00] (PASS)', () {
      final block = generateWidgetReCreator(
        'DropdownMenuItem',
        dropdownMenuItem,
        RecreatorClassConfig.defaultInnerTypes,
        {'DropdownMenuItem': dropdownMenuItem},
        warn,
      );

      const expected = '''
  D4.registerGenericTypeWrapper('DropdownMenuItem', (
    Object value,
    String innerTypeArg,
  ) {
    if (value is! DropdownMenuItem) return null;
    final v = value;
    return switch (innerTypeArg) {
      'dynamic' || 'Object' || 'Object?' => DropdownMenuItem<dynamic>(
        key: v.key,
        onTap: v.onTap,
        value: v.value,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'String' => DropdownMenuItem<String>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as String?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'int' => DropdownMenuItem<int>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as int?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'double' => DropdownMenuItem<double>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as double?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'bool' => DropdownMenuItem<bool>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as bool?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      'num' => DropdownMenuItem<num>(
        key: v.key,
        onTap: v.onTap,
        value: v.value as num?,
        enabled: v.enabled,
        alignment: v.alignment,
        child: v.child,
      ),
      _ => null,
    };
  });
''';

      expect(block, equals(expected));
      expect(warnings, isEmpty);
    });

    test('G-RCR-2: DropdownMenuEntry casts a required value to a non-null type. [2026-06-07 00:00] (PASS)', () {
      final block = generateWidgetReCreator(
        'DropdownMenuEntry',
        dropdownMenuEntry,
        RecreatorClassConfig.defaultInnerTypes,
        {'DropdownMenuEntry': dropdownMenuEntry},
        warn,
      );

      expect(block, contains('value: v.value as String,'));
      expect(block, contains('value: v.value as int,'));
      // The non-null T must NOT produce a nullable cast.
      expect(block, isNot(contains('value: v.value as String?,')));
      // The dynamic arm never casts.
      expect(
        block,
        contains(
          "'dynamic' || 'Object' || 'Object?' => DropdownMenuEntry<dynamic>(",
        ),
      );
      expect(warnings, isEmpty);
    });

    test('G-RCR-3: ButtonSegment re-creator carries every constructor parameter through. [2026-06-07 00:00] (PASS)', () {
      final block = generateWidgetReCreator(
        'ButtonSegment',
        buttonSegment,
        RecreatorClassConfig.defaultInnerTypes,
        {'ButtonSegment': buttonSegment},
        warn,
      )!;

      for (final field in ['value', 'icon', 'label', 'tooltip', 'enabled']) {
        expect(block, contains('$field: v.$field'));
      }
      expect(block, contains('value: v.value as num,'));
      expect(warnings, isEmpty);
    });

    test('G-RCR-4: custom inner types limit the emitted switch arms. [2026-06-07 00:00] (PASS)', () {
      final block = generateWidgetReCreator(
        'ButtonSegment',
        buttonSegment,
        const ['String', 'int'],
        {'ButtonSegment': buttonSegment},
        warn,
      )!;

      expect(block, contains("'String' => ButtonSegment<String>("));
      expect(block, contains("'int' => ButtonSegment<int>("));
      expect(block, isNot(contains("'double' =>")));
      expect(block, isNot(contains("'bool' =>")));
      expect(block, isNot(contains("'num' =>")));
    });

    test('G-RCR-5: bails when the class has more than one type parameter. [2026-06-07 00:00] (PASS)', () {
      final twoParams = ClassInfo(
        name: 'Pair',
        sourceFile: 'package:x/x.dart',
        typeParameters: const {'K': null, 'V': null},
        constructors: const [
          ConstructorInfo(
            parameters: [ParameterInfo(name: 'k', type: 'K', isNamed: true)],
          ),
        ],
        members: const [
          MemberInfo(name: 'k', returnType: 'K', isGetter: true),
        ],
      );

      final block = generateWidgetReCreator(
        'Pair',
        twoParams,
        RecreatorClassConfig.defaultInnerTypes,
        {'Pair': twoParams},
        warn,
      );

      expect(block, isNull);
      expect(warnings.single, contains('exactly 1 type parameter'));
    });

    test('G-RCR-6: bails when there is no default constructor. [2026-06-07 00:00] (PASS)', () {
      final namedOnly = ClassInfo(
        name: 'Boxed',
        sourceFile: 'package:x/x.dart',
        typeParameters: const {'T': null},
        constructors: const [
          ConstructorInfo(
            name: 'create',
            parameters: [ParameterInfo(name: 'value', type: 'T', isNamed: true)],
          ),
        ],
        members: const [
          MemberInfo(name: 'value', returnType: 'T', isGetter: true),
        ],
      );

      final block = generateWidgetReCreator(
        'Boxed',
        namedOnly,
        RecreatorClassConfig.defaultInnerTypes,
        {'Boxed': namedOnly},
        warn,
      );

      expect(block, isNull);
      expect(warnings.single, contains('no default'));
    });

    test('G-RCR-7: bails when a constructor parameter has no matching getter. [2026-06-07 00:00] (PASS)', () {
      final noGetter = ClassInfo(
        name: 'Holder',
        sourceFile: 'package:x/x.dart',
        typeParameters: const {'T': null},
        constructors: const [
          ConstructorInfo(
            parameters: [
              ParameterInfo(name: 'value', type: 'T', isNamed: true),
              ParameterInfo(name: 'secret', type: 'int', isNamed: true),
            ],
          ),
        ],
        // 'secret' has no getter.
        members: const [
          MemberInfo(name: 'value', returnType: 'T', isGetter: true),
        ],
      );

      final block = generateWidgetReCreator(
        'Holder',
        noGetter,
        RecreatorClassConfig.defaultInnerTypes,
        {'Holder': noGetter},
        warn,
      );

      expect(block, isNull);
      expect(warnings.single, contains('secret'));
      expect(warnings.single, contains('no matching instance getter'));
    });

    test('G-RCR-8: bails when a parameter references the type parameter in a non-bare form. [2026-06-07 00:00] (PASS)', () {
      final listOfT = ClassInfo(
        name: 'Listy',
        sourceFile: 'package:x/x.dart',
        typeParameters: const {'T': null},
        constructors: const [
          ConstructorInfo(
            parameters: [
              ParameterInfo(name: 'items', type: 'List<T>', isNamed: true),
            ],
          ),
        ],
        members: const [
          MemberInfo(name: 'items', returnType: 'List<T>', isGetter: true),
        ],
      );

      final block = generateWidgetReCreator(
        'Listy',
        listOfT,
        RecreatorClassConfig.defaultInnerTypes,
        {'Listy': listOfT},
        warn,
      );

      expect(block, isNull);
      expect(warnings.single, contains('non-bare form'));
    });
  });
}
