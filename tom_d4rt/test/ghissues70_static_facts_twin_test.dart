// ghissues70 — the twin difference a resolved bundle makes (GitHub
// al-the-bear/tom_d4rt#18, option B2).
//
// tom_d4rt_ast runs a resolved bundle with its static facts and answers
// GitHub #18's map cases as native Dart
// (tom_d4rt_ast/test/runtime/ghissues70_static_facts_test.dart, same code).
// tom_d4rt runs source and has no facts, so it approximates from run-time
// values; this pins what it answers for that code (Lim-13), and that a type
// interpolated into a string reads as its name.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _source = r'''
import 'package:map_repro/native.dart';

extension KeyKind<K, V> on Map<K, V> {
  String keyKind() => K.toString();
}

/// A reduced Serverpod `MapJsonExtension`: an empty map's JSON is `{}` when
/// its keys are strings, else `[]`.
extension MapJsonExtension<K, V> on Map<K, V> {
  Object toJson() => K == String ? <String, Object?>{} : <Object?>[];
}

extension WideKind on Map<dynamic, dynamic> {
  String kind() => 'wide';
}

extension NarrowKind on Map<String, int> {
  String kind() => 'narrow';
}

String typeOf<T>(T value) => '$T';

class Box<T> {
  final T value;
  Box(this.value);
  String get kind => '$T';
}

Object main() {
  final Map<String, int> narrow = sameMap();
  final Map<dynamic, dynamic> wide = narrow;
  final Map<String, int> emptyNarrow = emptyMap();
  final Map<dynamic, dynamic> emptyWide = emptyNarrow;
  final Set<int> emptySet = {};
  final list = [1, 2];
  return [
    narrow.keyKind(),
    wide.keyKind(),
    {'x': 7}.keyKind(),
    emptyNarrow.toJson(),
    emptyWide.toJson(),
    <String, int>{}.toJson(),
    wide.kind(),
    narrow.kind(),
    emptySet is Set<int>,
    list.keyKindOfList(),
    typeOf(3),
    Box('s').kind,
  ].map((e) => '$e').toList();
}

extension ListKind<E> on List<E> {
  String keyKindOfList() => E.toString();
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
      'emptyMap',
      (visitor, positional, named, typeArgs) => <String, int>{},
      'package:map_repro/native.dart',
    );
  final result = d4rt.execute(
    library: 'package:map_repro/entry.dart',
    sources: {'package:map_repro/entry.dart': _source},
  );
  return (result as List).cast<String>();
}

void main() {
  group('ghissues70: tom_d4rt has no static facts', () {
    test('GH70-T1: GitHub #18\'s map cases approximate from run-time values '
        '- the answers tom_d4rt_ast gives without facts [2026-11-17]', () {
      // Native Dart (and tom_d4rt_ast with a resolved bundle):
      // [String, dynamic, String, {}, [], {}, wide, narrow, true, int, int,
      // String]. Lim-13 names each difference.
      expect(_run(), [
        'String',
        'dynamic',
        'dynamic',
        '{}',
        '[]',
        '{}',
        'wide',
        'wide',
        'true',
        'dynamic',
        'T',
        'dynamic',
      ]);
    });

    test('GH70-T2: a type interpolated into a string reads as its name '
        '[2026-11-17]', () {
      final result = D4rt().execute(
        library: 'package:p/main.dart',
        sources: {
          'package:p/main.dart': r'''
class C {}
String name<T>() => '$T';
Object main() => ['${C}', name<int>(), '${String}', name<C>()];
''',
        },
      );
      expect(result, ['C', 'int', 'String', 'C']);
    });
  });
}
