// ghissues72 — an interpreted generic instance's `runtimeType` keeps its type
// arguments: `Box<int>().runtimeType` prints `Box<int>` and compares as Dart's
// does. Every expectation is what native Dart 3.13 answers for the same
// program, except the one noted: a raw instance prints its class name.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(String body) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        '''
class Box<T> {}
class Pair<A, B> {}
class Plain {}
class N<T extends num> {}

Object main() {
$body
}
''',
  },
);

void main() {
  group('ghissues72: runtimeType of an interpreted generic instance', () {
    test('GH72-1: prints with its type arguments [2026-11-18]', () {
      expect(
        _run('''
  return [
    Box<int>().runtimeType.toString(),
    '\${Box<String>().runtimeType}',
    Pair<int, String?>().runtimeType.toString(),
    Box<List<int>>().runtimeType.toString(),
    N<int>().runtimeType.toString(),
  ];'''),
        [
          'Box<int>',
          'Box<String>',
          'Pair<int, String?>',
          'Box<List<int>>',
          'N<int>',
        ],
      );
    });

    test('GH72-2: equal for the same class and arguments only; a Type; '
        'a map and set key [2026-11-18]', () {
      expect(
        _run('''
  final m = <Type, String>{};
  m[Box<int>().runtimeType] = 'int box';
  return [
    Box<int>().runtimeType == Box<int>().runtimeType,
    Box<int>().runtimeType == Box<String>().runtimeType,
    Box<int>().runtimeType == Box,
    N<int>().runtimeType == N<num>().runtimeType,
    Box<int>().runtimeType is Type,
    m[Box<int>().runtimeType],
    m[Box<String>().runtimeType],
    {Box<int>().runtimeType, Box<int>().runtimeType, Box<String>().runtimeType}.length,
    Box<int>().runtimeType.hashCode == Box<int>().runtimeType.hashCode,
  ];'''),
        [true, false, false, false, true, 'int box', null, 2, true],
      );
    });

    test('GH72-3: a non-generic or raw instance answers with its class, as '
        'before [2026-11-18]', () {
      expect(
        _run('''
  return [
    Plain().runtimeType == Plain,
    Plain().runtimeType.toString(),
    Box().runtimeType == Box,
    Box<dynamic>().runtimeType == Box,
    N().runtimeType == N,
    Box().runtimeType.toString(),
  ];'''),
        // Not as Dart: the last prints `Box<dynamic>` in Dart. A raw
        // instance answers with its class, which prints its bare name.
        [true, 'Plain', true, true, true, 'Box'],
      );
    });
  });
}
