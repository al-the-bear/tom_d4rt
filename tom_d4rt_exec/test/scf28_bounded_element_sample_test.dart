// SCF28: binding a typed collection reads a bounded prefix of it.
//
// A native collection carries no element type d4rt can read back, so SCD92
// checks a declared `List<T>` against the type the collection's CONTENTS
// share. It read every element, on every binding: measured 2026-09-22 at
// about 0.096 us per element, half a millisecond per binding of a
// 5000-element list, at a site a script author cannot see. It now reads
// `Environment.elementTypeSample` (8) elements; the constant's doc records the
// measurement that chose the bound and the flat timing that resulted.
//
// These cases are deterministic rather than timed: a host list counts its
// element reads, so "O(1) in the length" is asserted as "at most 8 reads".

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// The prefix the derivation reads — the value `Environment.elementTypeSample`
/// holds, which the AST twin pins. Written out rather than named so this file
/// also compiles against an interpreter that predates the constant, which is
/// what lets exec carry a copy of it.
const _sample = 8;

/// A native list that counts how often an element is read.
class CountingList extends ListBase<Object?> {
  CountingList(this._inner);
  final List<Object?> _inner;
  static int reads = 0;

  @override
  int get length => _inner.length;
  @override
  set length(int value) => _inner.length = value;
  @override
  Object? operator [](int i) {
    reads++;
    return _inner[i];
  }

  @override
  void operator []=(int i, Object? value) => _inner[i] = value;
}

void main() {
  // A host list the script binds as a `List`, as a bridged collection is.
  BridgedClass.registerSupertypes({
    'CountingList': ['List', 'Iterable'],
  });
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: CountingList,
        name: 'CountingList',
        constructors: {
          'ints': (visitor, positional, named) => CountingList(
            List<Object?>.generate(positional.first as int, (i) => i),
          ),
        },
      ),
      'package:probe/counting.dart',
    );

  Object? run(String body) => d4rt.execute(
    source: "import 'package:probe/counting.dart';\nmain() {\n$body\n}",
  );

  group('SCF28: the element-type derivation reads a bounded prefix', () {
    test('F-SCF28-1: binding a 5000-element typed list reads at most '
        '$_sample elements [2026-09-29] (PASS)', () {
      final c = run('return CountingList.ints(5000);');
      expect(c, isA<CountingList>());
      CountingList.reads = 0;
      d4rt.execute(
        source:
            "import 'package:probe/counting.dart';\n"
            'check(List<int> v) => v.length;\n'
            'main() { var c = CountingList.ints(5000); '
            'var n = 0; for (var i = 0; i < 10; i++) { n = check(c); } '
            'return n; }',
      );
      // Ten bindings of one list: the full walk read 50 000 elements.
      expect(CountingList.reads, lessThanOrEqualTo(10 * _sample));
    });

    test('F-SCF28-2: a long homogeneous list of the wrong type is still '
        'refused [2026-09-29] (PASS)', () {
      expect(
        () => run('List<String> v = CountingList.ints(5000); return v;'),
        throwsA(anything),
      );
      expect(
        run('List<int> v = CountingList.ints(5000); return v.length;'),
        5000,
      );
    });

    test('F-SCF28-3: a list that disagrees within the prefix still passes as '
        'heterogeneous [2026-09-29] (PASS)', () {
      // F-SCD92-6's shape, unchanged.
      expect(run("List<String> v = [1, 'a']; return v.length;"), 2);
    });

    test('F-SCF28-4: a list that disagrees only AFTER the prefix is checked '
        'against the prefix [2026-09-29] (PASS)', () {
      // The one answer the bound changes. The full walk called this list
      // heterogeneous and let `List<String>` bind it; the prefix is eight
      // ints, which are provably not Strings — and Dart refuses it too.
      const list = "<Object>[1, 2, 3, 4, 5, 6, 7, 8, 'late']";
      expect(
        () => run('List<String> v = $list; return v.length;'),
        throwsA(anything),
      );
      expect(run('List<Object> v = $list; return v.length;'), 9);
    });
  });
}
