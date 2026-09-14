// SCD96/AST — an escaping error reaches the host as the script raised it, and
// all THREE bundle-executing entry points agree.
//
// This is the tree the todo was written about. `executeBundle` is the entry
// point for the Flutter line: it is what an analyzer-free app calls to run a
// downloaded bundle, and therefore the one API where the caller cannot fall
// back to a different runner. Such an app cannot write `on FormatException`
// around its own script; whatever the host writes around `executeBundle` is all
// the error handling it gets.
//
// WHAT WAS MEASURED, AND HOW IT DIFFERED FROM THE TODO'S PREMISE
//
// The todo expected `InternalInterpreterD4rtException` to leak. It does not —
// `throwAsHostFacingError` has peeled that carrier since SCC27. Re-measuring
// found the leak one peel further in, and found it SPLIT across the three
// entry points, which is the part no reading of the code would have suggested:
//
//   entry point                 before            after
//   executeBundle               BridgedInstance   FormatException
//   executeBundleAs<T>          BridgedInstance   FormatException
//   executeBundleAsAsync<T>     FormatException   FormatException
//
// The async variant was already right because it goes through the zone
// callbacks SCD73 wrapped, and those call `unwrapScriptError`, which does BOTH
// peels. The synchronous pair went through `throwAsHostFacingError`, which did
// one. So the todo's "check the typed variants too — a fix that lands on one of
// the three and not the others recreates the same problem" was pointing at a
// split that already existed.
//
// The four cases below are the minimum that cannot pass by accident:
//
//   -1 all three entry points deliver FormatException  — the fix, and the
//                                                        agreement the todo
//                                                        requires
//   -2 an operation-raised error was already correct   — half the shapes here
//                                                        were always right,
//                                                        which is what made the
//                                                        defect hard to see
//   -3 an undefined name is NOT peeled                 — SCC31's signal has no
//                                                        native counterpart and
//                                                        peeling it would undo
//                                                        SCC31
//   -4 a host `on` clause actually matches             — the property an
//                                                        embedder cares about,
//                                                        written as an embedder
//                                                        would write it

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: 0, name: n);

/// The bundle for `Object? main() { <statement> }`.
AstBundle bundleOf(SStatement statement, {bool isAsync = false}) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: const [],
              ),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                isAsync: isAsync,
                block: SBlock(offset: 0, length: 0, statements: [statement]),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

/// `throw FormatException('boom');` — a BRIDGED exception, which is the shape
/// that carries a native object one peel inside the interpreter's carrier.
SStatement throwFormatException() => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: SThrowExpression(
    offset: 0,
    length: 0,
    expression: SMethodInvocation(
      offset: 0,
      length: 0,
      methodName: _id('FormatException'),
      argumentList: SArgumentList(
        offset: 0,
        length: 0,
        arguments: [SSimpleStringLiteral(offset: 0, length: 0, value: 'boom')],
      ),
    ),
  ),
);

/// `<int>[].first` — a StateError raised by an OPERATION rather than a `throw`,
/// so it never passes through a BridgedInstance.
SStatement emptyListFirst() => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: SPropertyAccess(
    offset: 0,
    length: 0,
    target: SListLiteral(offset: 0, length: 0, elements: const []),
    operator: '.',
    propertyName: _id('first'),
  ),
);

/// A bare undefined name — the SCC31 case the todo names explicitly.
SStatement undefinedName() => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: _id('totallyUndefinedThing'),
);

void main() {
  group('SCD96/AST: every bundle entry point delivers the script\'s error', () {
    test('F-SCD96-AST-1: all three entry points deliver FormatException '
        '[2026-09-14] (PASS)', () {
      // The agreement the todo requires. Before the fix the first two handed
      // back `BridgedInstance<Object>` and only the third was right.
      expect(
        () => D4rtRunner().executeBundle(bundleOf(throwFormatException())),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => D4rtRunner().executeBundleAs<Object?>(
          bundleOf(throwFormatException()),
        ),
        throwsA(isA<FormatException>()),
      );
      expect(
        () => D4rtRunner().executeBundleAsAsync<Object?>(
          bundleOf(throwFormatException(), isAsync: true),
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('F-SCD96-AST-2: an operation-raised error was already correct '
        '[2026-09-14] (PASS)', () {
      // A native callee throws a native value, so this shape never went
      // through a BridgedInstance. Pinned because it is what made the defect
      // hard to see: half the shapes at this boundary were always right.
      expect(
        () => D4rtRunner().executeBundle(bundleOf(emptyListFirst())),
        throwsA(isA<StateError>()),
      );
    });

    test(
      'F-SCD96-AST-3: an undefined name is NOT peeled [2026-09-14] (PASS)',
      () {
        // SCC31 made this type reach the host rather than be swallowed. It has
        // no native counterpart, and peeling it would undo SCC31 on the very
        // line the Flutter app runs on.
        expect(
          () => D4rtRunner().executeBundle(bundleOf(undefinedName())),
          throwsA(isA<UndefinedNameD4rtException>()),
        );
      },
    );

    test('F-SCD96-AST-4: a host `on` clause around executeBundle matches '
        '[2026-09-14] (PASS)', () {
      // Written the way the Flutter host would write it. An `isA` matcher
      // would pass against a subtype relationship this test cannot see; an
      // `on` clause is the thing that was actually broken.
      String caught() {
        try {
          D4rtRunner().executeBundle(bundleOf(throwFormatException()));
          return 'no throw';
        } on FormatException {
          return 'on FormatException';
        } catch (e) {
          return 'bare catch: ${e.runtimeType}';
        }
      }

      expect(caught(), 'on FormatException');
    });
  });
}
