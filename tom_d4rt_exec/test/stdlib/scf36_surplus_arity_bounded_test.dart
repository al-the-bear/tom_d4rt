// SCF36 — every stdlib adapter that dropped a surplus positional argument is
// bounded, at the SDK's own positional count.
//
// SCE245's census measured 315 adapters per tree that read `positionalArgs[k]`
// and never looked at the length, so a call with an extra argument ran and the
// extra vanished: `Stream.value(1).asyncMap((x) => x + 1, 99)` yielded [2].
// Native Dart rejects every one of these at compile time.
//
// `tool/bound_surplus_arity.dart` inserted `D4.checkArity(positionalArgs,
// '<Class>.<member>', atMost: N)`, with N read from the SDK through
// `dart:mirrors`, NOT from the highest index the adapter reads. The difference
// is the second group below: a member with an optional positional parameter
// keeps accepting it. Two adapters turned out to ignore such a parameter, and
// now forward it (F-SCF36-6, -7).
//
// The census itself is held at zero by F-SCE245-1 in
// `scd204_surplus_arity_guard_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Future<Object?> _run(String body) async {
  final raw = D4rt().execute(
    source:
        '''
import 'dart:async';
$body
''',
  );
  return raw is Future ? await raw : raw;
}

Matcher _arityError(String member) => throwsA(
  predicate(
    (e) => '$e'.contains('$member accepts at most'),
    'an arity error naming $member',
  ),
);

void main() {
  group('SCF36: a surplus positional argument is an error', () {
    test('F-SCF36-1: Stream.asyncMap [2026-09-30] (PASS)', () {
      expect(
        () => _run(
          'Future<List> main() => '
          'Stream.value(1).asyncMap((x) => x + 1, 99).toList();',
        ),
        _arityError('Stream.asyncMap'),
      );
    });

    test('F-SCF36-2: Stream.contains [2026-09-30] (PASS)', () {
      expect(
        () => _run('Future<bool> main() => Stream.value(1).contains(1, 2);'),
        _arityError('Stream.contains'),
      );
    });

    test('F-SCF36-3: Error.safeToString [2026-09-30] (PASS)', () {
      expect(
        () => _run('String main() => Error.safeToString(1, 2);'),
        _arityError('Error.safeToString'),
      );
    });

    test('F-SCF36-4: a collection adapter, from the heaviest file '
        '[2026-09-30] (PASS)', () {
      expect(
        () => _run(
          "import 'dart:collection';\n"
          'bool main() => SplayTreeSet.of([1]).contains(1, 2);',
        ),
        _arityError('SplayTreeSet.contains'),
      );
    });
  });

  group('SCF36: the bound is the SDK count, not the indices read', () {
    test('F-SCF36-5: optional positional parameters are still accepted '
        '[2026-09-30] (PASS)', () async {
      // Each passes the SDK's full positional count.
      expect(
        await _run(
          'Future<List> main() => '
          "Stream.periodic(Duration(milliseconds: 1), (i) => i).take(2).toList();",
        ),
        [0, 1],
      );
      expect(
        await _run(
          'Future<int> main() => Stream.fromIterable([1, 2, 3]).fold(10, '
          '(a, b) => a + b);',
        ),
        16,
      );
    });

    test('F-SCF36-6: num.parse honours its onError parameter '
        '[2026-09-30] (PASS)', () async {
      expect(await _run("num main() => num.parse('x', (s) => -1);"), -1);
      expect(await _run("num main() => num.parse('2.5', (s) => -1);"), 2.5);
      expect(
        () => _run("num main() => num.parse('x');"),
        throwsA(predicate((e) => '$e'.contains('FormatException'))),
      );
    });

    test('F-SCF36-7: Uri.parseIPv4Address forwards start and end '
        '[2026-09-30] (PASS)', () async {
      expect(
        await _run(
          "List<int> main() => Uri.parseIPv4Address('ip=10.0.0.7;', 3, 11);",
        ),
        [10, 0, 0, 7],
      );
    });
  });
}
