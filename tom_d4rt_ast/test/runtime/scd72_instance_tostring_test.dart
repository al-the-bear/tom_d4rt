// SCD72/AST — a host sees the script's `toString()` in the analyzer-free tree
// too.
//
// The mirror of `tom_d4rt/test/scd72_instance_tostring_test.dart`, and smaller.
// That file runs source, so it can put the fix through seven contexts cheaply.
// This package cannot execute source at all — it interprets pre-parsed
// `SAstNode` trees — so each case is a bundle built by hand, and a bundle that
// DECLARES A CLASS with a method is the first of its kind in this tree's tests.
//
// SCRIPT-LEVEL AND NOT REGISTRATION-LEVEL, unlike this tree's other mirrors, and
// deliberately: the whole claim is about what a HOST sees when it interpolates a
// value the interpreter handed it. That needs a real `InterpretedInstance` of a
// real declared class with a real overriding method, which is precisely what a
// bundle produces and what no amount of poking at bridges can fake.
//
// WHAT IS PINNED IS THE CLAIM, NOT THE CATALOGUE: that the dispatch is live in
// THIS interpreter, that a class without an override is untouched, and that a
// throwing override degrades instead of escaping. The reference tree covers the
// in-script semantics, the native-container path and the cycle guard, all of
// which are the same code reached through a parser this package does not have.
//
// CONTROL, measured by reverting `toString()` to the diagnostic form: `+2 -1`.
// Only F-SCD72-AST-1 fails, and the two that survive do so for different
// reasons worth separating:
//
//   * -2 (no override keeps the diagnostic form) is a genuine RAIL — it stops
//     the fix from rendering classes that never asked for it, and it would fail
//     against a version that always dispatched.
//   * -3 (a throwing override falls back) has NO teeth against this revert, and
//     saying so is more useful than implying otherwise: the fallback string IS
//     the old behaviour, so asserting it cannot distinguish old from new. Its
//     teeth point forward, at the next change that might let a script's
//     exception escape `toString()` into host code. The reference tree's
//     F-SCD72-4 does discriminate, because it also pins the non-String return.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

/// A bundle for `class <name> { String toString() => <body>; } main() => <name>();`
///
/// [body] is the override's expression; pass null to declare no `toString` at
/// all, which is the case that must keep the interpreter's diagnostic form.
AstBundle instanceBundle({required String name, required SExpression? body}) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          SClassDeclaration(
            offset: 0,
            length: 0,
            name: _id(name),
            members: [
              // An EXPLICIT unnamed constructor, because a hand-built bundle is
              // not a generated one. `class Bare { }` instantiates fine through
              // `tom_d4rt_exec` — measured — so the analyzer-free line does
              // synthesise what source omits somewhere along the generator
              // path; this bundle skips that path, and without a constructor
              // the run fails with "does not have a constructor named ''"
              // before `toString` is ever reached. Declaring one keeps this
              // file about the thing it tests.
              SConstructorDeclaration(
                offset: 0,
                length: 0,
                returnType: _id(name),
                parameters: SFormalParameterList(
                  offset: 0,
                  length: 0,
                  parameters: const [],
                ),
                body: SBlockFunctionBody(
                  offset: 0,
                  length: 0,
                  block: SBlock(offset: 0, length: 0, statements: const []),
                ),
              ),
              if (body != null)
                SMethodDeclaration(
                  offset: 0,
                  length: 0,
                  name: _id('toString'),
                  returnType: SNamedType(
                    offset: 0,
                    length: 0,
                    name: _id('String'),
                  ),
                  parameters: SFormalParameterList(
                    offset: 0,
                    length: 0,
                    parameters: const [],
                  ),
                  body: SExpressionFunctionBody(
                    offset: 0,
                    length: 0,
                    expression: body,
                  ),
                ),
            ],
          ),
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
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: SInstanceCreationExpression(
                  offset: 0,
                  length: 0,
                  constructorName: SConstructorName(
                    offset: 0,
                    length: 0,
                    type: SNamedType(offset: 0, length: 0, name: _id(name)),
                  ),
                  argumentList: SArgumentList(
                    offset: 0,
                    length: 0,
                    arguments: const [],
                  ),
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
  Object? instanceOf({required String name, SExpression? body}) => D4rtRunner()
      .executeBundleAs<Object?>(instanceBundle(name: name, body: body));

  group('SCD72/AST: a host sees the script\'s toString', () {
    test('F-SCD72-AST-1: the override is dispatched for host code '
        '[2026-09-13] (PASS)', () {
      final instance = instanceOf(
        name: 'Named',
        body: SSimpleStringLiteral(offset: 0, length: 0, value: 'I am Named'),
      );
      expect(instance, isA<InterpretedInstance>());
      // The interpreter has finished by now, so there is no ambient visitor —
      // this passes only because the visitor is stored on the class.
      expect('$instance', 'I am Named');
    });

    test('F-SCD72-AST-2: a class with no override keeps the diagnostic form '
        '[2026-09-13] (PASS)', () {
      // THE RAIL. Dispatch must happen only where the script asked for it.
      final instance = instanceOf(name: 'Bare');
      expect('$instance', '<instance of Bare>');
    });

    test('F-SCD72-AST-3: a throwing override falls back rather than escaping '
        '[2026-09-13] (PASS)', () {
      // The override reads a name that does not exist, so dispatching it
      // raises inside the interpreter. A host interpolating the value must get
      // a string back — it is very likely already handling an error.
      final instance = instanceOf(name: 'Broken', body: _id('noSuchName'));
      expect(() => '$instance', returnsNormally);
      expect('$instance', '<instance of Broken>');
    });
  });
}
