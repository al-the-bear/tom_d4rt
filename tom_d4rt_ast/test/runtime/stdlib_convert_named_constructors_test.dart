import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`;
// `dart:convert` is registered lazily by `ast_module_loader.dart` when a script
// imports it. Driving that path from a unit test would mean building a parsed
// AST module, so we reach for the same-package registrar directly rather than
// widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';

/// SCB25 mirror coverage for `tom_d4rt_ast` — the two `dart:convert` named
/// constructors that were absent from shipped, registered bridges:
/// `JsonEncoder.withIndent` and `JsonCodec.withReviver`.
///
/// Registration-level rather than script-level, for the same reason as the SC5
/// through SC9 mirrors: the script-level equivalents live in
/// `tom_d4rt/test/stdlib/convert/json_named_constructors_test.dart`, and
/// `tom_d4rt_exec` — the only runner that could execute a script against *this*
/// tree — resolves `tom_d4rt_ast` from pub.dev rather than by path, so it cannot
/// see unpublished local edits.
///
/// The `toEncodable` / `reviver` happy paths need a real `InterpretedFunction`,
/// which is not constructible at this level; those are asserted script-side in
/// `tom_d4rt`. What is verified here is that the constructors exist, that the
/// indent value is actually threaded into the native object, and that every
/// rejection path fires — which is what a silent re-drop of either constructor
/// would break.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    ConvertStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass bridge(String name) => env.findBridgedClassByName(name)!;

  group('SCB25: JsonEncoder.withIndent', () {
    test('F-SCB25-AST-1: the withIndent constructor is registered [2026-09-03]',
        () {
      expect(bridge('JsonEncoder').constructors.keys, contains('withIndent'));
    });

    test('F-SCB25-AST-2: the indent value reaches the native encoder '
        '[2026-09-03]', () {
      final ctor = bridge('JsonEncoder').constructors['withIndent']!;
      final pretty = ctor(visitor, ['  '], {}) as JsonEncoder;
      expect(pretty.indent, '  ');
      expect(pretty.convert({'a': 1}), '{\n  "a": 1\n}');
    });

    test('F-SCB25-AST-3: an explicit null indent is honoured and selects '
        'compact output, so presence cannot stand in for the value '
        '[2026-09-03]', () {
      final ctor = bridge('JsonEncoder').constructors['withIndent']!;
      final compact = ctor(visitor, [null], {}) as JsonEncoder;
      expect(compact.indent, isNull);
      expect(compact.convert({'a': 1}), '{"a":1}');
    });

    test('F-SCB25-AST-4: a missing indent is rejected — the SDK requires it '
        'positionally even though it is nullable [2026-09-03]', () {
      final ctor = bridge('JsonEncoder').constructors['withIndent']!;
      expect(() => ctor(visitor, [], {}), throwsA(isA<RuntimeD4rtException>()));
    });

    test('F-SCB25-AST-5: mistyped arguments are rejected [2026-09-03]', () {
      final ctor = bridge('JsonEncoder').constructors['withIndent']!;
      expect(
          () => ctor(visitor, [42], {}), throwsA(isA<RuntimeD4rtException>()));
      expect(() => ctor(visitor, [null, 42], {}),
          throwsA(isA<RuntimeD4rtException>()));
    });

    test('F-SCB25-AST-6: indent is exposed as a getter [2026-09-03]', () {
      final getter = bridge('JsonEncoder').getters['indent'];
      expect(getter, isNotNull);
      expect(getter!(visitor, const JsonEncoder.withIndent('\t')), '\t');
      expect(getter(visitor, const JsonEncoder()), isNull);
    });
  });

  group('SCB25: JsonCodec.withReviver', () {
    test('F-SCB25-AST-7: the withReviver constructor is registered '
        '[2026-09-03]', () {
      expect(bridge('JsonCodec').constructors.keys, contains('withReviver'));
    });

    test('F-SCB25-AST-8: a missing or mistyped reviver is rejected — unlike '
        'the default constructor null is not legal here [2026-09-03]', () {
      final ctor = bridge('JsonCodec').constructors['withReviver']!;
      expect(() => ctor(visitor, [], {}), throwsA(isA<RuntimeD4rtException>()));
      expect(() => ctor(visitor, [null], {}),
          throwsA(isA<RuntimeD4rtException>()));
      expect(
          () => ctor(visitor, [42], {}), throwsA(isA<RuntimeD4rtException>()));
    });
  });

  group('SCB25: already-shipped convert named constructors', () {
    test('F-SCB25-AST-9: Base64Codec.urlSafe and Base64Encoder.urlSafe remain '
        'registered and use the URL-safe alphabet [2026-09-03]', () {
      // 0xFB 0xFF encodes to "-_8=" url-safe and "+/8=" standard, so the two
      // alphabets are distinguishable from the output alone.
      final codecCtor = bridge('Base64Codec').constructors['urlSafe']!;
      expect((codecCtor(visitor, [], {}) as Base64Codec).encode([251, 255]),
          '-_8=');
      final encoderCtor = bridge('Base64Encoder').constructors['urlSafe']!;
      expect((encoderCtor(visitor, [], {}) as Base64Encoder).convert([251, 255]),
          '-_8=');
    });
  });
}
