// SCF35: `scheduleMicrotask` is bridged, and so is the rest of the top-level
// surface the member-coverage guard could not see.
//
// `scheduleMicrotask(() => ...)` failed with `Undefined variable:
// scheduleMicrotask`, and the name was not in `kUnbridgedReasons` either — so
// it was neither provided nor declared absent. SCC73, the guard that enumerates
// the SDK's surface, read only the constructors and getters of CLASSES; a
// top-level function was invisible to it. F-SCC73-5 now reads those too, and
// its first run found `base64UrlEncode`, the two Unicode rune constants and
// `systemEncoding` in the same state — bridged here as well.
//
// The callback runs under the interpreter-callback discipline Timer uses
// (SCC23 / SCD73): an error it throws escapes unwrapped, so an embedder's
// `onUncaughtError` receives the error the script threw.
//
// The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf35_schedule_microtask_test.dart`.

import 'dart:async';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String source, {List<Object>? escapes}) async {
  // dart:io needs a grant to import at all; nothing here touches the host.
  final d4rt = D4rt()
    ..setDebug(false)
    ..grant(FilesystemPermission.any);
  if (escapes != null) {
    d4rt.onUncaughtError = (error, stackTrace) => escapes.add(error);
  }
  final raw = d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
  final result = raw is Future ? await raw : raw;
  await Future<void>.delayed(const Duration(milliseconds: 20));
  return result;
}

void main() {
  group('SCF35: scheduleMicrotask', () {
    test('F-SCF35-1: the microtask runs before the code after an await '
        '[2026-09-30] (PASS)', () async {
      expect(
        await _run('''
import 'dart:async';
Future<List<String>> main() async {
  final log = <String>[];
  scheduleMicrotask(() => log.add('m'));
  await 5;
  log.add('a');
  return log;
}
'''),
        ['m', 'a'],
      );
    });

    test('F-SCF35-2: it runs after the synchronous rest of the script '
        '[2026-09-30] (PASS)', () async {
      expect(
        await _run('''
import 'dart:async';
Future<List<String>> main() async {
  final log = <String>[];
  scheduleMicrotask(() => log.add('m'));
  log.add('sync');
  await null;
  return log;
}
'''),
        ['sync', 'm'],
      );
    });

    test('F-SCF35-3: an error thrown in the callback reaches onUncaughtError '
        'as the script threw it [2026-09-30] (PASS)', () async {
      final escapes = <Object>[];
      final result = await _run('''
import 'dart:async';
Future<String> main() async {
  scheduleMicrotask(() { throw StateError('from the microtask'); });
  await null;
  return 'done';
}
''', escapes: escapes);
      expect(result, 'done');
      expect(escapes, hasLength(1));
      expect(escapes.single, isA<StateError>());
      expect('${escapes.single}', contains('from the microtask'));
    });

    test('F-SCF35-4: a non-function argument is refused by name '
        '[2026-09-30] (PASS)', () {
      expect(
        () => _run('''
import 'dart:async';
main() => scheduleMicrotask(5);
'''),
        throwsA(predicate((e) => '$e'.contains('scheduleMicrotask'))),
      );
    });
  });

  group('SCF35: the rest of the top-level surface F-SCC73-5 found', () {
    test('F-SCF35-5: base64UrlEncode, the rune constants, systemEncoding '
        '[2026-09-30] (PASS)', () async {
      expect(
        await _run('''
import 'dart:convert';
List<Object> main() => [
  base64UrlEncode([251, 255]),
  unicodeBomCharacterRune,
  unicodeReplacementCharacterRune,
];
'''),
        [
          base64UrlEncode([251, 255]),
          0xFEFF,
          0xFFFD,
        ],
      );
      expect(
        // Only dart:io: `Encoding`'s members reach a value whose bridge lives
        // in dart:convert without that import (SCF44).
        await _run('''
import 'dart:io';
String main() => systemEncoding.name;
'''),
        isA<String>(),
      );
    });
  });
}
