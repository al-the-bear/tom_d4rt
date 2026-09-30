/// SCD137 — the generator emits each function typedef's POSITIONAL ARITY, so
/// the interpreter can tell `VoidCallback` from `ValueChanged`.
///
/// A function typedef has no bridgeable class, so it is registered as
/// `BridgedClass(nativeType: Function, name: typedef.name)`. That discarded the
/// signature, and scd136 had to make the resulting bridge accept any callable
/// arity-blind, because there was nothing at runtime to check a closure's shape
/// against.
///
/// The data was never missing from the GENERATOR — `_typedefExpansions` has
/// held `'void Function(double)'` all along, for barrel fallback. It was thrown
/// away at emission, where `functionTypedefs()` returned bare names. This suite
/// pins the emission that fixes that.
///
/// **What is emitted, and what is deliberately not.** Only positional arity,
/// as `(required, max)`. Return types are not carried: an interpreted closure
/// always resolves to `dynamic Function(...)`, so a return-type check would
/// refuse working callbacks wholesale. Named parameters are not counted either
/// — Dart only passes a named argument the callee declares, so their presence
/// cannot make a callback uncallable.
///
/// The consuming rule, and the reasoning for its conservatism, is
/// `tom_d4rt/test/scd137_typedef_arity_test.dart`.
@Tags(['generation'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

/// Every shape the arity rule has to distinguish, in one fixture.
const _fixtureSource = '''
typedef ZeroArg = void Function();
typedef OneArg = void Function(int value);
typedef TwoArg = void Function(int a, String b);
typedef OneRequiredOneOptional = void Function(int a, [String? b]);
typedef NamedOnly = void Function({int? count});
typedef ReturnsSomething = String Function(int value);

class ZomHost {
  ZomHost({
    this.onZero,
    this.onOne,
    this.onTwo,
    this.onMixed,
    this.onNamed,
    this.onReturns,
  });
  final ZeroArg? onZero;
  final OneArg? onOne;
  final TwoArg? onTwo;
  final OneRequiredOneOptional? onMixed;
  final NamedOnly? onNamed;
  final ReturnsSomething? onReturns;
}
''';

void _writePackageConfig(Directory root, String generatorRoot) {
  final own = File(p.join(generatorRoot, '.dart_tool', 'package_config.json'));
  if (!own.existsSync()) {
    fail(
      'The generator package has no resolved .dart_tool/package_config.json '
      'at ${own.path}. This suite borrows its absolute entries. Run '
      '`dart pub get` in tom_d4rt_generator.',
    );
  }
  final config = jsonDecode(own.readAsStringSync()) as Map<String, dynamic>;
  Directory(p.join(root.path, '.dart_tool')).createSync(recursive: true);
  File(
    p.join(root.path, '.dart_tool', 'package_config.json'),
  ).writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({
      'configVersion': 2,
      'packages': [
        ...(config['packages'] as List).cast<Map<String, dynamic>>(),
        {
          'name': 'zom_scd137',
          'rootUri': root.uri.toString(),
          'packageUri': 'lib/',
          'languageVersion': '3.0',
        },
      ],
    }),
  );
}

void main() {
  late String generated;

  setUpAll(() async {
    // systemTemp, not the repo tree: an ancestor pubspec/package config
    // hijacks resolution for anything nested inside it, which is what GEN-121
    // measured and why its own fixture lives here too.
    final root = Directory.systemTemp.createTempSync('scd137_arity_');
    addTearDown(() => root.deleteSync(recursive: true));
    File(
      p.join(root.path, 'pubspec.yaml'),
    ).writeAsStringSync('name: zom_scd137\nenvironment:\n  sdk: ^3.0.0\n');
    final lib = Directory(p.join(root.path, 'lib'))..createSync();
    final source = File(p.join(lib.path, 'handlers.dart'))
      ..writeAsStringSync(_fixtureSource);
    _writePackageConfig(root, Directory.current.path);

    final result =
        await BridgeGenerator(
          workspacePath: root.path,
          skipPrivate: true,
          helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
          packageName: 'zom_scd137',
        ).generateBridges(
          sourceFiles: [source.path],
          outputPath: p.join(lib.path, 'zom_scd137_bridges.dart'),
          moduleName: 'scd137',
        );
    expect(result.errors, isEmpty, reason: 'fixture must generate cleanly');
    generated = File(
      p.join(lib.path, 'zom_scd137_bridges.dart'),
    ).readAsStringSync();
  });

  /// The emitted `'Name': (required: R, max: M),` line for [name].
  String? arityLine(String name) => RegExp(
    "'$name': \\(required: (\\d+), max: (\\d+)\\),",
  ).firstMatch(generated)?.group(0);

  group('SCD137: the generator emits typedef arity', () {
    test(
      'F-SCD137-GEN-1: the fixture generated something with typedefs in it',
      () {
        // Anti-vacuity: every assertion below is a regex over this string, so
        // a generation that silently emitted nothing would satisfy all of them
        // by matching nothing. Pin that the names arrived first.
        expect(generated, contains('functionTypedefArity()'));
        for (final name in ['ZeroArg', 'OneArg', 'TwoArg']) {
          expect(
            generated,
            contains("'$name'"),
            reason: '$name did not reach the generated output at all',
          );
        }
      },
    );

    test('F-SCD137-GEN-2: required and optional positionals are counted '
        'separately', () {
      expect(arityLine('ZeroArg'), "'ZeroArg': (required: 0, max: 0),");
      expect(arityLine('OneArg'), "'OneArg': (required: 1, max: 1),");
      expect(arityLine('TwoArg'), "'TwoArg': (required: 2, max: 2),");
      expect(
        arityLine('OneRequiredOneOptional'),
        "'OneRequiredOneOptional': (required: 1, max: 2),",
        reason:
            'an optional positional raises `max` without raising `required` — '
            'the distinction the consuming rule depends on, because it checks '
            'only what the typedef GUARANTEES it will pass',
      );
    });

    test('F-SCD137-GEN-3: named parameters are not counted as positional', () {
      // `void Function({int? count})` can always be invoked with no arguments,
      // so a zero-argument callback serves it. Counting the named parameter
      // would refuse one.
      expect(arityLine('NamedOnly'), "'NamedOnly': (required: 0, max: 0),");
    });

    test('F-SCD137-GEN-4: the return type does not appear in the arity', () {
      // Two typedefs differing only in return type must emit identical arity.
      // An interpreted closure always returns `dynamic`, so a return-type
      // check would refuse working callbacks wholesale.
      expect(
        arityLine('ReturnsSomething'),
        "'ReturnsSomething': (required: 1, max: 1),",
      );
      expect(arityLine('OneArg'), "'OneArg': (required: 1, max: 1),");
    });

    test(
      'F-SCD137-GEN-5: the registration call site passes the arity through',
      () {
        // Emitting the map is useless if nothing reads it. This is the line that
        // turns generated data into a runtime check.
        expect(
          generated,
          contains('final typedefArity = functionTypedefArity()'),
        );
        expect(generated, contains('requiredPositional: arity?.required'));
        expect(generated, contains('maxPositional: arity?.max'));
      },
    );
  });
}
