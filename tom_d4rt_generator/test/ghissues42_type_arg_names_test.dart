// ghissues42 — name-keyed generic dispatch reads a type argument's name with
// its `?` and its own type arguments.
//
// Since tom_d4rt 1.257.0 / tom_d4rt_ast 0.237.0 a script's type argument
// reaches a generic constructor or interceptor as `int?` or `List<int>`, where
// it used to read `int` / `List`. A dispatch that switched on the plain name
// matched neither and took its default arm. The RC-2 constructor factories
// now match the name with its type arguments taken off and its `?` kept, and
// give the primitives a nullable arm; the templated constructors and
// interceptors do the same and also match a configured variant verbatim.
// GH42-3 compiles and runs a generated RC-2 factory.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// `Holder<T>(T value, {T? spare, Box<T?>? box})`, T unbounded.
final _holder = ClassInfo(
  name: 'Holder',
  sourceFile: 'package:holder/holder.dart',
  typeParameters: {'T': null},
  constructors: [
    ConstructorInfo(
      parameters: [
        ParameterInfo(name: 'value', type: 'T'),
        ParameterInfo(
          name: 'spare',
          type: 'T?',
          isNamed: true,
          isRequired: false,
        ),
      ],
    ),
  ],
);

String _factory(ClassInfo cls, List<String> bridged) =>
    generateGenericConstructorFactoryForTesting(
      cls,
      cls.constructors.single,
      '_rc2${cls.name}',
      bridged,
      {cls.name: cls},
    );

/// Runs the RC-2 factory of [_holder] over the bridged types `Thing` and
/// `Gen`, once per `[typeArgName, value]` case (the values `'gen'` and
/// `'thing'` stand for a `Gen<int>` and a `Thing`), and answers each result's
/// `runtimeType` (or `null`).
Future<List<Object?>> _runHolderFactory(List<List<Object?>> cases) async {
  final dir = Directory.systemTemp.createTempSync('ghissues42_');
  addTearDown(() => dir.deleteSync(recursive: true));
  final program = File('${dir.path}/main.dart')
    ..writeAsStringSync('''
import 'dart:convert';

class Thing {}

class Gen<X> {}

class Holder<T> {
  Holder(this.value, {this.spare});
  final T value;
  final T? spare;
}

class TypeArg {
  TypeArg(this.name);
  final String name;
}

${_factory(_holder, ['Gen', 'Thing'])}
Object? _value(Object? token) => switch (token) {
  'gen' => Gen<int>(),
  'thing' => Thing(),
  _ => token,
};

void main(List<String> args) {
  final cases = jsonDecode(args.single) as List;
  print(jsonEncode([
    for (final c in cases)
      _rc2Holder(null, [_value(c[1])], <String, Object?>{}, [TypeArg(c[0] as String)])
          ?.runtimeType
          .toString(),
  ]));
}
''');
  final result = await Process.run(Platform.resolvedExecutable, [
    'run',
    program.path,
    jsonEncode(cases),
  ]);
  expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
  return jsonDecode((result.stdout as String).trim()) as List<Object?>;
}

void main() {
  group('ghissues42: name-keyed dispatch of nullable and nested type '
      'arguments', () {
    test('GH42-1: the RC-2 factory matches the name without its type '
        'arguments and keeps the `?` [2026-11-11]', () {
      final out = _factory(_holder, ['Gen', 'Thing']);
      expect(
        out,
        contains(
          "  final typeName = rawTypeName.replaceFirst(RegExp(r'<.*>'), '');",
        ),
      );
      for (final prim in ['String', 'int', 'double', 'bool', 'num']) {
        expect(out, contains("'$prim?' => Holder<$prim?>("));
      }
      // No nullable arm per bridged class: those would double the Flutter
      // relaxers.
      expect(out, isNot(contains("'Thing?'")));
      // The GEN-102 guard lets a nullable type argument through.
      expect(
        out,
        contains(
          "if (!typeName.endsWith('?') && (value == null)) return null;",
        ),
      );
      // `T?` with T = `int?` is `int?`, never `int??`.
      expect(out, isNot(contains('??>')));
      expect(out, isNot(contains('as int??')));
      expect(out, contains("'int?' => Holder<int?>(value as int?, "));
    });

    test('GH42-2: substituting a nullable type argument into `Box<T?>` does '
        'not double the `?` [2026-11-11]', () {
      final boxed = ClassInfo(
        name: 'Boxed',
        sourceFile: 'package:holder/holder.dart',
        typeParameters: {'T': null},
        constructors: [
          ConstructorInfo(
            parameters: [ParameterInfo(name: 'box', type: 'Box<T?>')],
          ),
        ],
      );
      final out = _factory(boxed, const []);
      expect(out, contains('D4.extractBridgedArg<Box<int?>>(box, '));
      expect(out, contains('D4.extractBridgedArg<Box<String?>>(box, '));
      expect(out, isNot(contains('??>')));
    });

    test('GH42-3: a generated RC-2 factory builds the nullable instantiation '
        'and dispatches a nested argument by its class [2026-11-11]', () async {
      final results = await _runHolderFactory([
        ['int', 1],
        ['int?', null],
        ['int?', 3],
        ['String?', null],
        ['double?', 2],
        ['int', null],
        ['Gen<int>', 'gen'],
        ['Thing', 'thing'],
        ['Thing?', 'thing'],
        ['Object?', null],
      ]);
      expect(results, [
        'Holder<int>',
        'Holder<int?>',
        'Holder<int?>',
        'Holder<String?>',
        'Holder<double?>',
        // GEN-102: a null value for a non-nullable argument falls through
        // to the bridge constructor.
        null,
        // `Gen<int>` dispatches as `Gen`, which is `Gen<dynamic>`.
        'Holder<Gen<dynamic>>',
        'Holder<Thing>',
        // A nullable class argument has no arm: the bridge constructor
        // infers T, rather than the non-null instantiation being built.
        null,
        'Holder<dynamic>',
      ]);
    });

    test('GH42-4: templated constructors and interceptors strip type '
        'arguments, keep the `?` and match configured nested variants '
        'verbatim [2026-11-11]', () {
      const key = GenericConstructorConfig(
        className: 'GlobalKey',
        kind: GenericConstructorKind.namedPassthrough,
        typeArgVariants: ['FormState', 'PopupMenuButtonState<String>'],
      );
      final keyOut = generateGenericConstructor(key);
      expect(
        keyOut,
        contains(
          "    final typeName = const {'PopupMenuButtonState<String>'}"
          '.contains(rawTypeName)\n'
          '        ? rawTypeName\n'
          "        : rawTypeName?.replaceFirst(RegExp(r'<.*>'), '');",
        ),
      );
      expect(
        keyOut,
        contains(
          "'PopupMenuButtonState<String>' => "
          'GlobalKey<PopupMenuButtonState<String>>(),',
        ),
      );

      const notifier = GenericConstructorConfig(
        className: 'ValueNotifier',
        kind: GenericConstructorKind.nullableValue,
        typeArgVariants: ['String'],
      );
      final notifierOut = generateGenericConstructor(notifier);
      expect(
        notifierOut,
        contains("'String?' => ValueNotifier<String?>(value as String?),"),
      );
      expect(
        notifierOut,
        contains(
          "    final typeName = rawTypeName?.replaceFirst(RegExp(r'<.*>'), '');",
        ),
      );

      const lookup = GenericInterceptorConfig(
        className: 'RadioGroup',
        methodName: 'maybeOf',
        isStatic: true,
        typeArgVariants: ['String', 'String?'],
      );
      final lookupOut = generateGenericInterceptor(lookup);
      expect(lookupOut, contains("'String?' => RadioGroup.maybeOf<String?>("));
      expect(
        lookupOut,
        contains(
          "    final typeName = rawTypeName?.replaceFirst(RegExp(r'<.*>'), '');",
        ),
      );
    });
  });
}
