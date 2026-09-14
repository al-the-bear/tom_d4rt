// SCD94/AST — an SDK type is nameable in an `on` clause in the analyzer-free
// tree too.
//
// The mirror of `tom_d4rt/test/scd94_sdk_type_nameability_test.dart`, and
// deliberately much smaller. That file runs source, so it can put sixteen types
// through a `try`/`on` for three lines each, and it owns the two source scans
// that ratchet the registration (including the one that asserts THIS tree's
// `core/error.dart` registers the same set — a comparison only a test that can
// see both trees can make).
//
// WHAT IS PINNED HERE IS THE CLAIM, NOT THE CATALOGUE: that `on <Type>`
// resolution is live in THIS interpreter — that a registered name is reached
// and an unregistered one is not — because the reference tree's evidence is
// taken entirely on the analyzer-based line and the registration is shared
// rather than duplicated.
//
// The three cases are the minimum that cannot pass by accident:
//
//   -1 `on StateError` is ENTERED       — the registration is reachable here
//   -2 `on <unregistered>` FALLS
//      THROUGH to the bare catch        — the hazard, which is what makes -1
//                                         mean something: a clause that always
//                                         matched would pass -1 too
//   -3 `on Error` catches a StateError  — the supertype chain from
//                                         `ErrorHierarchyCore` is walked, not
//                                         just the exact name
//
// A stub `on` that matched everything passes -1 and -3 and fails -2. A stub
// that matched only on exact name passes -1 and -2 and fails -3.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

SStatement _ret(String literal) => SReturnStatement(
  offset: 0,
  length: 0,
  expression: SSimpleStringLiteral(offset: 0, length: 0, value: literal),
);

/// The bundle for:
///
/// ```dart
/// Object? main() {
///   try { <int>[].first; }
///   on <typeName> { return 'CAUGHT'; }
///   catch (e) { return 'FELL-THROUGH'; }
///   return 'NO THROW';
/// }
/// ```
///
/// `<int>[].first` on an empty list raises `StateError` — an operation rather
/// than a staged `throw`, so the interpreter reaches the name on the path a
/// script actually takes.
AstBundle onClauseBundle(String typeName) {
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
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    STryStatement(
                      offset: 0,
                      length: 0,
                      body: SBlock(
                        offset: 0,
                        length: 0,
                        statements: [
                          SExpressionStatement(
                            offset: 0,
                            length: 0,
                            expression: SPropertyAccess(
                              offset: 0,
                              length: 0,
                              target: SListLiteral(
                                offset: 0,
                                length: 0,
                                elements: const [],
                              ),
                              operator: '.',
                              propertyName: _id('first'),
                            ),
                          ),
                        ],
                      ),
                      catchClauses: [
                        SCatchClause(
                          offset: 0,
                          length: 0,
                          exceptionType: SNamedType(
                            offset: 0,
                            length: 0,
                            name: _id(typeName),
                          ),
                          body: SBlock(
                            offset: 0,
                            length: 0,
                            statements: [_ret('CAUGHT')],
                          ),
                        ),
                        // The bare `catch` is what makes a failure legible:
                        // without it an inert clause reports as an escaped
                        // exception and reads like a bug in `.first`.
                        SCatchClause(
                          offset: 0,
                          length: 0,
                          exceptionParameter: _id('e'),
                          body: SBlock(
                            offset: 0,
                            length: 0,
                            statements: [_ret('FELL-THROUGH')],
                          ),
                        ),
                      ],
                    ),
                    _ret('NO THROW'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

void main() {
  Object? run(String typeName) =>
      D4rtRunner().executeBundleAs<Object?>(onClauseBundle(typeName));

  group('SCD94/AST: an SDK type is nameable in an `on` clause', () {
    test('F-SCD94-AST-1: a registered type is reached by name '
        '[2026-09-14] (PASS)', () {
      expect(run('StateError'), 'CAUGHT');
    });

    test('F-SCD94-AST-2: an unregistered type falls through silently '
        '[2026-09-14] (PASS)', () {
      // The hazard, and the control that makes -1 mean something. Real Dart
      // rejects this at compile time (`non_type_in_catch_clause`); d4rt runs
      // the program and takes another branch without saying anything.
      expect(run('NotARegisteredError'), 'FELL-THROUGH');
    });

    test('F-SCD94-AST-3: the supertype chain is walked [2026-09-14] (PASS)', () {
      // `on Error` reaching a `StateError` is the second half of the contract:
      // the `BridgedClass` registration alone is not enough, the hierarchy
      // entry in `ErrorHierarchyCore.register()` has to be there too.
      expect(run('Error'), 'CAUGHT');
    });
  });
}
