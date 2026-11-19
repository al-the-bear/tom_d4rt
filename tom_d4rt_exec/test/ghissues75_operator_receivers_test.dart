// ghissues75 — tom_d4rt notes the receiver of extension operators, index
// operators and setters as it does for method calls (GitHub
// al-the-bear/tom_d4rt#18).
//
// tom_d4rt runs source and has no static facts, so it binds an extension's
// type parameters from the receiver's written type (a typed local) or its
// run-time value, and takes the first extension in scope whose `on` type
// matches. The program is tom_d4rt_ast's fixture
// `test/runtime/fixtures/ghissues75_operator_cases.dart.txt`; its answers are
// the ones tom_d4rt_ast gives that bundle without facts
// (`ghissues75_static_facts_operators_test.dart` there, GH75-2). An extension
// `operator []=` on a bridged receiver (a `Set`) is reached too.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _source = '''
import 'package:map_repro/native.dart';

final log = <String>[];

extension KeyOps<K, V> on Map<K, V> {
  String operator +(Object? other) => 'plus \$K';
  String operator ~() => 'tilde \$K';
  set tag(Object? value) => log.add('tag \$K');
}

extension WideOp on Map<dynamic, dynamic> {
  String operator -(Object? other) => 'wide';
}

extension NarrowOp on Map<String, int> {
  String operator -(Object? other) => 'narrow';
}

extension ElementOps<E> on Set<E> {
  String operator [](int index) => 'index \$E';
  void operator []=(int index, Object? value) => log.add('index set \$E');
}

Object main() {
  final Map<String, int> narrow = sameMap();
  final Map<dynamic, dynamic> wide = narrow;
  final Set<String> narrowSet = sameSet();
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
  return [...results, ...log];
}
''';

List<String> _run() {
  final d4rt = D4rt()
    ..registertopLevelFunction(
      'sameMap',
      (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
      'package:map_repro/native.dart',
    )
    ..registertopLevelFunction(
      'sameSet',
      (visitor, positional, named, typeArgs) => <String>{'a'},
      'package:map_repro/native.dart',
    );
  final result = d4rt.execute(
    library: 'package:map_repro/entry.dart',
    sources: {'package:map_repro/entry.dart': _source},
  );
  return [for (final e in result as List) '$e'];
}

void main() {
  group('ghissues75: tom_d4rt has no static facts', () {
    test('GH75-T1: extension operators, index operators and setters bind '
        'from the written type or the run-time value [2026-11-18]', () {
      // Native Dart (and tom_d4rt_ast with a resolved bundle) differs at
      // indices 2, 5, 9 and 12: `plus String`, `narrow`, `index String`,
      // `tag String`.
      expect(_run(), [
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
      ]);
    });
  });
}
