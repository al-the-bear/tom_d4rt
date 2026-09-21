// SCE62: the copier's unhandled-node behaviour, and the one gap the census
// found that the reference interpreter does not share.
//
// The census (`tool/census_copier.dart --probe`) drove one snippet per
// language construct through `AstConverter` and asked which reached the
// `_SUnknownNode` placeholder. Three did. Comparing each against the
// reference interpreter separated them:
//
//   `library foo;`        tom_d4rt runs it and returns 42; exec crashed.
//                         An exec-only regression -- fixed, and F-SCE62-1
//                         holds it.
//   `class B = A with M;` Unsupported in BOTH lines (tom_d4rt answers
//                         "Undefined variable: B"). Out of scope as a
//                         feature; in scope as a diagnosis.
//   `E e = .a;`           Unsupported in BOTH lines (tom_d4rt answers
//                         "Unsupported AST node 'DotShorthand...'"). Same.
//
// What made the two out-of-scope ones worth changing is HOW they failed. An
// unhandled node became `_SUnknownNode`, and then:
//
//   * a cast through `_as<T>` threw `type '_SUnknownNode' is not a subtype of
//     type 'SIdentifier?' in type cast` -- naming neither construct nor place;
//   * a list built by `_nodesAs<T>` DROPPED it, so an unsupported node in a
//     statement or member list would vanish and the script would run without
//     it.
//
// BOTH WERE HARDENED; ONLY THE FIRST IS TESTED HERE, and the asymmetry is
// deliberate. No construct reaches the list path today: every statement,
// class-member and collection-element type the analyzer can parse is
// dispatched, and `Configuration` -- the one list element that WAS dropped,
// in sce49 -- has had an arm since. A test asserting the list case would pass
// with the drop restored, which is a test that proves nothing. The `_nodesAs`
// change is kept because it costs nothing and closes the path for the next
// unhandled node type to land in a list, but it is recorded here as
// unreachable rather than covered.

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:test/test.dart';
import 'package:tom_ast_generator/src/converter/ast_converter.dart';

/// Parse and copy [source], the way `tom_d4rt_exec` does.
Object? copy(String source) => AstConverter()
    .convertCompilationUnit(
      parseString(content: source, throwIfDiagnostics: false).unit,
    )
    .toJson();

void main() {
  group('SCE62: the copier says what it cannot copy', () {
    test('F-SCE62-1: a library directive converts [2026-09-21]', () {
      // The reference interpreter runs `library foo; main() => 42;` and
      // returns 42 -- a library directive has no runtime effect, and its name
      // is never read. exec threw a cast error on the LibraryIdentifier the
      // directive holds, so valid Dart that the reference accepts could not be
      // interpreted at all. That is a conformance break rather than a missing
      // feature, which is what separates this case from the two below.
      expect(() => copy('library foo;\nmain() => 42;'), returnsNormally);
      expect(
        () => copy('library a.b.c;\nmain() => 42;'),
        returnsNormally,
        reason:
            'three components must work too -- SPrefixedIdentifier could '
            'have carried two, which is why the name is flattened instead',
      );
    });

    test('F-SCE62-2: an unhandled node names itself and its source '
        '[2026-09-21]', () {
      expect(
        () => copy('class A {} mixin M {} class B = A with M;'),
        throwsA(
          isA<UnsupportedError>().having(
            (e) => e.message,
            'message',
            allOf(
              contains('ClassTypeAlias'),
              contains('offset'),
              contains('class B = A with M;'),
            ),
          ),
        ),
        reason:
            'a bare cast error named neither the construct nor where it '
            'was; the reference interpreter answers the same source with '
            '"Unsupported AST node \'X\' at offset N"',
      );
    });

    test('F-SCE62-4 (control): the rejection is not a sledgehammer '
        '[2026-09-21]', () {
      // If `_rejectUnknown` fired on anything other than the placeholder, or
      // if `_nodesAs` had stopped filtering genuine type mismatches, ordinary
      // source would throw. It must not.
      for (final source in const [
        'main() => 42;',
        'class A { int v() => 1; }\nmain() => A().v();',
        'enum E { a(1), b(2); const E(this.v); final int v; }\nmain() => E.a.v;',
        r'main(List l, bool b) => [...l, if (b) 1, for (var x in l) x];',
        'main(Object o) => switch (o) { int i => i, _ => 0 };',
        "import 'dart:math' as math;\nmain() => math.max(1, 2);",
        'extension type Id(int i) { int get v => i; }\nmain() => Id(1).v;',
      ]) {
        expect(() => copy(source), returnsNormally, reason: source);
      }
    });
  });
}
