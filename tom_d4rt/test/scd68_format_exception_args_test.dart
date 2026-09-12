// SCD68 — `FormatException`'s three arguments are positional, and all three
// arrive.
//
// The bridge's constructor adapter read `source` and `offset` out of
// `namedArgs`, while the SDK declares
// `FormatException([String message = "", this.source, this.offset])` — three
// POSITIONAL parameters, none of them named. So there was no spelling of the
// constructor that could set either one: the named form the adapter wanted is
// not legal Dart, and the legal positional form reached `positionalArgs[1]` and
// `[2]`, which the adapter never read.
//
// SILENT, WHICH IS WHY IT LASTED. Extra positional arguments are accepted and
// discarded rather than reported as an arity error, so a script passing all
// three got an exception that looked right until something read `.offset`. The
// getters existed and worked — they simply always answered null.
//
// THE FOUR ARITIES ARE THE POINT, not the three-argument case alone. A fix that
// reads `positionalArgs[1]` and `[2]` without guarding the length turns the
// one-argument and zero-argument forms — which are what nearly every real call
// uses — from working into a `RangeError`. F-SCD68-2 is that rail, and it is
// the case most likely to be broken by the next person tidying this adapter.
//
// `toString()` IS THE OBSERVABLE A SCRIPT ACTUALLY SEES. The SDK builds it from
// all three: `FormatException: bad (at character 3)`, then the source line, then
// a caret under the offset. With the arguments dropped it could only ever print
// the message, so a script that caught a parse failure and printed it lost the
// position — which is the whole reason the SDK carries the two fields. Pinned
// against the SDK's exact output in F-SCD68-3, not against a prefix.
//
// THE NEIGHBOURS WERE CHECKED AND ARE CLEAN. Every other exception adapter in
// this file and in `dart:io`'s was probed against its own SDK signature:
// `SocketException(this.message, {this.osError, this.address, this.port})` is
// named and the bridge reads named; `FileSystemException`, `PathNotFoundException`,
// `PathExistsException`, `PathAccessException`, `OSError`, `WebSocketException`,
// `RedirectException`, `TimeoutException` and `IsolateSpawnException` are
// positional and the bridge reads positional. `HttpException(this.message,
// {this.uri})` likewise. One defect, not a family — recorded because a negative
// result nobody writes down gets re-measured.
//
// CONTROL, measured by reverting the adapter: `+0 -4` — every case fails,
// in both trees. That is worth stating plainly because most guards in this
// quest record a split, and the rails there are the cases that keep passing.
// There is no such case here, and none is missing: the fix is four lines with
// no behaviour outside them, so everything this file asks about moves. The
// discrimination lives inside the cases instead —
//
//   * a fix that reads `positionalArgs[1]` and `[2]` UNGUARDED passes -1, -3
//     and -4 and fails -2 on `FormatException('bad')`;
//   * a fix that reads positional AND keeps honouring named passes -1, -2 and
//     -3 and fails -4.
//
// So the degenerate fixes are each caught by exactly one case, which is what a
// rail is for; they just do not survive the revert to advertise it.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String body) => D4rt().execute(source: 'main() {\n$body\n}');

void main() {
  group('SCD68: FormatException takes its arguments positionally', () {
    test(
      'F-SCD68-1: all three positional arguments arrive [2026-09-12] (PASS)',
      () {
        expect(
          run(
            "var e = FormatException('bad', 'src', 2); "
            'return [e.message, e.source, e.offset];',
          ),
          ['bad', 'src', 2],
        );
        // `source` is `Object?` in the SDK, not `String?` — a script parsing
        // structured input passes whatever it was parsing.
        expect(
          run("var e = FormatException('bad', [1, 2], 0); return e.source;"),
          [1, 2],
        );
      },
    );

    test('F-SCD68-2: the shorter arities still work [2026-09-12] (PASS)', () {
      // The rail. Reading index 1 and 2 unguarded would make these throw,
      // and these are the forms real code uses.
      expect(
        run(
          "var e = FormatException('bad'); "
          'return [e.message, e.source, e.offset];',
        ),
        ['bad', null, null],
      );
      expect(
        run(
          'var e = FormatException(); '
          'return [e.message, e.source, e.offset];',
        ),
        ['', null, null],
      );
      expect(
        run(
          "var e = FormatException('bad', 'src'); "
          'return [e.message, e.source, e.offset];',
        ),
        ['bad', 'src', null],
      );
    });

    test('F-SCD68-3: toString() regains the position it is built from '
        '[2026-09-12] (PASS)', () {
      // Character 3, not offset 2: the SDK reports a 1-based column. Asserted
      // verbatim, including the caret line, because that whole block is what
      // the arguments buy — a prefix match would pass against a message that
      // had lost the source excerpt.
      expect(
        run("return FormatException('bad', 'src', 2).toString();"),
        'FormatException: bad (at character 3)\nsrc\n  ^\n',
      );
      // And the message-only form keeps the SDK's short shape rather than
      // gaining an empty position block.
      expect(
        run("return FormatException('bad').toString();"),
        'FormatException: bad',
      );
      expect(run('return FormatException().toString();'), 'FormatException');
    });

    test('F-SCD68-4: the named spelling sets nothing [2026-09-12] (PASS)', () {
      // `FormatException('bad', source: 's', offset: 1)` is not legal Dart —
      // the constructor declares no named parameters. The adapter used to
      // honour it, which is how the defect stayed invisible: the only
      // spelling that worked was one the analyzer rejects, so nobody wrote it
      // and nobody noticed the legal one silently dropping its arguments.
      //
      // Pinned so that "accept both" is a decision rather than a drift back.
      expect(
        run(
          "var e = FormatException('bad', source: 's', offset: 1); "
          'return [e.message, e.source, e.offset];',
        ),
        ['bad', null, null],
      );
    });
  });
}
