// ghissues75 — a resolved bundle's static facts for extension operators,
// index operators and setters (GitHub al-the-bear/tom_d4rt#18).
//
// ghissues70 used the facts for extension member calls reached by a method
// invocation, a property access or a prefixed identifier. The bundler also
// records facts for an extension binary or prefix operator (keyed by the
// operator expression), an index operator (the index expression) and an
// extension setter or index setter (the assignment's left-hand side); the
// interpreter now notes those accesses too, so the facts bind the
// extension's type parameters and pick the extension.
//
// The fixture `fixtures/ghissues75_operator_cases.bundle.json` is bundled by
// tom_ast_generator in resolving mode (`tool/write_resolved_bundle_fixture.dart`
// there). The same code runs natively below:
//
// * with the facts the interpreter answers as native Dart;
// * without them it binds from the receiver's written type where there is
//   one (a typed local), else from its run-time value, and picks the first
//   extension in scope whose `on` type matches (pinned below).
//
// `Map` declares `[]` and `[]=` itself, and an instance member always wins
// over an extension, so the index operators are declared on `Set`.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

// ---------------------------------------------------------------------------
// The fixture's code, natively.
// ---------------------------------------------------------------------------

Map<String, int> _sameMap() => <String, int>{'x': 7};
Set<String> _sameSet() => <String>{'a'};

final _log = <String>[];

extension _KeyOps<K, V> on Map<K, V> {
  String operator +(Object? other) => 'plus $K';
  String operator ~() => 'tilde $K';
  set tag(Object? value) => _log.add('tag $K');
}

extension _WideOp on Map<dynamic, dynamic> {
  String operator -(Object? other) => 'wide';
}

extension _NarrowOp on Map<String, int> {
  String operator -(Object? other) => 'narrow';
}

extension _ElementOps<E> on Set<E> {
  String operator [](int index) => 'index $E';
  void operator []=(int index, Object? value) => _log.add('index set $E');
}

List<String> _native() {
  _log.clear();
  final Map<String, int> narrow = _sameMap();
  final Map<dynamic, dynamic> wide = narrow;
  final Set<String> narrowSet = _sameSet();
  final Set<dynamic> wideSet = narrowSet;
  final results = [
    narrow + 1,
    wide + 1,
    {'x': 7} + 1,
    ~narrow,
    ~wide,
    narrow - 1,
    wide - 1,
    narrowSet[0],
    wideSet[0],
    {'a'}[0],
  ];
  narrow.tag = 1;
  wide.tag = 1;
  ({'x': 7}).tag = 1;
  narrowSet[0] = 1;
  wideSet[0] = 1;
  return [...results, ..._log];
}

// ---------------------------------------------------------------------------
// The fixture, interpreted.
// ---------------------------------------------------------------------------

final _fixture = File(
  'test/runtime/fixtures/ghissues75_operator_cases.bundle.json',
).readAsStringSync();

Map<String, dynamic> _json() => jsonDecode(_fixture) as Map<String, dynamic>;

D4rtRunner _runner() => D4rtRunner()
  ..registerTopLevelFunction(
    'sameMap',
    (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
    'package:map_repro/native.dart',
  )
  ..registerTopLevelFunction(
    'sameSet',
    (visitor, positional, named, typeArgs) => <String>{'a'},
    'package:map_repro/native.dart',
  );

List<String> _run(AstBundle bundle) => [
  for (final e in _runner().executeBundle(bundle) as List) '$e',
];

/// What tom_d4rt_ast answers without static facts (2026-11-18): a typed
/// local binds from its written type, an untyped literal from its run-time
/// value (`dynamic` keys and elements, indices 2, 9 and 12), and the first
/// extension in scope whose `on` type matches is taken (`narrow - 1`, index
/// 5). tom_d4rt, which has no facts, answers the same
/// (`tom_d4rt/test/ghissues75_operator_receivers_test.dart`). Lim-13.
const _approximated = [
  'plus String',
  'plus dynamic',
  'plus dynamic',
  'tilde String',
  'tilde dynamic',
  'wide',
  'wide',
  'index String',
  'index dynamic',
  'index dynamic',
  'tag String',
  'tag dynamic',
  'tag dynamic',
  'index set String',
  'index set dynamic',
];

void main() {
  group('ghissues75: extension operators, index operators and setters', () {
    test('GH75-1: with the static facts the interpreter answers as native '
        'Dart [2026-11-18]', () {
      expect(_run(AstBundle.fromJson(_json())), _native());
      // Native Dart's answers, written out.
      expect(_native(), [
        'plus String',
        'plus dynamic',
        'plus String',
        'tilde String',
        'tilde dynamic',
        'narrow',
        'wide',
        'index String',
        'index dynamic',
        'index String',
        'tag String',
        'tag dynamic',
        'tag String',
        'index set String',
        'index set dynamic',
      ]);
    });

    test('GH75-2: without them it approximates, as tom_d4rt does '
        '[2026-11-18]', () {
      expect(_run(AstBundle.fromJson(_json()..remove('facts'))), _approximated);
    });

    test('GH75-3: the bundle records a fact for each kind of access: the '
        'binary and prefix operators, the index read, and the left-hand '
        'side of each setter and index assignment [2026-11-18]', () {
      final facts =
          (_json()['facts'] as Map<String, dynamic>)['modules']
              as Map<String, dynamic>;
      final module = facts.values.single as Map<String, dynamic>;
      final source = File(
        'test/runtime/fixtures/ghissues75_operator_cases.dart.txt',
      ).readAsStringSync();
      final main = source.indexOf('Object main()');
      String keyOf(String snippet) {
        final offset = source.indexOf(snippet, main);
        expect(offset, isNot(-1), reason: snippet);
        return '$offset:${snippet.length}';
      }

      for (final access in [
        'narrow + 1',
        '~narrow',
        'narrow - 1',
        'narrowSet[0]',
        'narrow.tag',
        '({\'x\': 7}).tag',
      ]) {
        expect((module[keyOf(access)] as Map<String, dynamic>?)?.keys, [
          'x',
        ], reason: access);
      }
    });
  });
}
