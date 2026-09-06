// SCC77 — `StringSink` is reachable from every stdlib value that implements it.
//
// WHAT WAS BROKEN, AND WHY IT WAS INVISIBLE
//
// `StringSink` was registered and nothing ever resolved to it. A `StringBuffer`
// resolved to `StringBufferCore`, `stdout` to the `Stdout` bridge, and no
// member lookup or type test landed on the `StringSink` bridge at all. That is
// not merely a missing feature — it is the reason SCB26's member drift survived
// its whole lifetime: the io registrar shipped a second, strictly smaller
// `StringSink` definition that displaced the core one under last-wins, silently
// removing three members, and no script could tell because no script could
// reach the bridge either way.
//
// WHAT FIXED IT, AND WHAT DID NOT
//
// SCC77 was filed asking for two things: an `isAssignable` predicate on
// `StringSinkCore`, and supertype edges from the implementors. Only the second
// was needed. SCC56 declared them — `StringBuffer -> StringSink` in
// `core_hierarchy.dart`, `IOSink -> StreamSink, StringSink` in
// `io_hierarchy.dart` — and that carries the whole answer.
//
// The predicate was measured rather than argued about: added, run, and removed
// again. Resolution is identical with and without it, because every
// `StringSink` the stdlib can hand a script already has a more specific bridge.
// `string_sink.dart` records why adding one anyway would be a latent hazard.
//
// WHY THIS FILE EXISTS WHEN THE BEHAVIOUR ALREADY WORKS
//
// Because nothing pinned it end to end. `core_hierarchy_test.dart` covers
// `StringBuffer() is StringSink` and `io_hierarchy_test.dart` covers the io
// edges, each as one case inside a much larger hierarchy sweep. Neither covers
// the member fall-through — the property SCB26 actually needed and the one that
// makes the drift script-visible — and nothing at all covered
// `ClosableStringSink`, which is the only `StringSink` a script obtains that is
// neither a `StringBuffer` nor an `IOSink`.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String body, {String imports = ''}) async {
  const path = 'd4rt-mem:/scc77_string_sink.dart';
  final d4rt = D4rt();
  // The io cases open a temp file sink.
  d4rt.grant(FilesystemPermission.any);
  return await d4rt.execute(
    library: path,
    name: 'main',
    sources: {path: '$imports\nFuture<Object?> main() async {\n$body\n}\n'},
  );
}

void main() {
  group('SCC77: every stdlib StringSink answers `is StringSink`', () {
    test('F-SCC77-1: a StringBuffer is a StringSink [2026-09-06]', () async {
      expect(await _run('return StringBuffer() is StringSink;'), isTrue);
    });

    test('F-SCC77-2: stdout is a StringSink [2026-09-06]', () async {
      expect(
        await _run(
          'return stdout is StringSink;',
          imports: "import 'dart:io';",
        ),
        isTrue,
      );
    });

    test('F-SCC77-3: a file IOSink is a StringSink [2026-09-06]', () async {
      // `stdout` reaches the edge through the `Stdout` bridge; an openWrite
      // sink is a different native type reaching it through `IOSink`, so the
      // two are not one assertion twice.
      final result = await _run('''
        final dir = Directory.systemTemp.createTempSync('scc77');
        final sink = File('\${dir.path}/out.txt').openWrite();
        final answer = sink is StringSink;
        await sink.close();
        dir.deleteSync(recursive: true);
        return answer;
      ''', imports: "import 'dart:io';");
      expect(result, isTrue);
    });

    test('F-SCC77-4: a ClosableStringSink is a StringSink [2026-09-06]', () async {
      // The case no edge on `StringBuffer` or `IOSink` can answer, and the one
      // an `isAssignable` predicate was supposed to be needed for. It resolves
      // through `ClosableStringSink`'s own bridge and its own edge instead.
      expect(
        await _run(
          'final s = StringConversionSink.withCallback((x) {}).asStringSink();\n'
          'return s is StringSink;',
          imports: "import 'dart:convert';",
        ),
        isTrue,
      );
    });
  });

  group('SCC77: the members work, but NOT by falling through to StringSink', () {
    // SCC77 predicted that the edges would "let member lookup fall through to
    // the `StringSink` bridge for members `StringBufferCore` does not declare
    // itself". Measured, there are none: `StringBufferCore` declares
    // `write`, `writeAll`, `writeCharCode`, `writeln`, `toString`, `hashCode`
    // and `runtimeType` — a strict SUPERSET of the `StringSink` bridge. The
    // same holds for `IOSink`. So no fall-through happens, and the cases below
    // pass with the `StringBuffer -> StringSink` edge deleted, which was
    // checked rather than assumed.
    //
    // They are kept because they pin the members regardless of which bridge
    // answers, and because the prediction is worth recording as tested and
    // false: it was the stated reason SCB26's drift would become
    // script-visible, and it will not.
    //
    // WHAT DOES CATCH THAT DRIFT, verified by deleting `writeAll` from
    // `StringSinkCore` and running the suite: `string_sink_collision_test.dart`
    // F-SCB26-1/-2, and `member_coverage_baseline_test.dart` F-SCC74-2. Both
    // registration-level, which is the right level — nothing resolves TO the
    // `StringSink` bridge (`StringBuffer` resolves to `StringBuffer`, `stdout`
    // to `Stdout`, `ClosableStringSink` to its own), so a script-level guard on
    // its member list has no value to hold.
    test('F-SCC77-5: writeAll on a StringBuffer [2026-09-06]', () async {
      expect(
        await _run(
          "final b = StringBuffer(); b.writeAll(['a', 'b'], '-'); "
          'return b.toString();',
        ),
        equals('a-b'),
      );
    });

    test('F-SCC77-6: writeCharCode on a StringBuffer [2026-09-06]', () async {
      expect(
        await _run(
          'final b = StringBuffer(); b.writeCharCode(65); return b.toString();',
        ),
        equals('A'),
      );
    });

    test('F-SCC77-7: a ClosableStringSink writes through to its callback '
        '[2026-09-06]', () async {
      expect(
        await _run(
          'final seen = <String>[];\n'
          'final s = StringConversionSink.withCallback((x) => seen.add(x))\n'
          '    .asStringSink();\n'
          "s.write('hi');\n"
          's.close();\n'
          'return seen;',
          imports: "import 'dart:convert';",
        ),
        equals(['hi']),
      );
    });
  });

  group('SCC77: StringSink is usable as a declared type', () {
    // The generic-bounded shape the hierarchy work exists for: a script that
    // names `StringSink` in a signature must accept every implementor. Before
    // the edges this was the failure a caller actually hit, and it is a
    // stronger claim than `is` because it goes through parameter checking.
    test('F-SCC77-8: a StringSink parameter accepts a StringBuffer '
        '[2026-09-06]', () async {
      expect(
        await _run(
          'String f(StringSink s) { s.write("x"); return s.toString(); }\n'
          'return f(StringBuffer());',
        ),
        equals('x'),
      );
    });

    test('F-SCC77-9: a StringSink parameter accepts a ClosableStringSink '
        '[2026-09-06]', () async {
      expect(
        await _run(
          'String f(StringSink s) { s.write("x"); return "ok"; }\n'
          'final s = StringConversionSink.withCallback((x) {}).asStringSink();\n'
          'return f(s);',
          imports: "import 'dart:convert';",
        ),
        equals('ok'),
      );
    });
  });
}
