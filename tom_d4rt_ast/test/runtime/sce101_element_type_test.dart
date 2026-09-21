// SCE101/AST — a generic element is asked the same question as `is`, in the
// analyzer-free tree.
//
// The mirror of `tom_d4rt/test/sce101_element_type_test.dart`, and much
// smaller for the reason every mirror here is: that package runs source, so it
// can register two bridges and pin nine cases cheaply. This one interprets
// pre-parsed `SAstNode` trees, so each case is a bundle built by hand.
//
// WHAT IS PINNED HERE IS THAT THE FIX IS LIVE IN THIS INTERPRETER. The two
// predicates and the five arms are the same code in both trees — the mirror
// rule is what keeps them so — and the reference file demonstrates the bridged
// forms, which need a registered bridge and are the expensive half to build
// twice.
//
// THE THREE CASES ARE THE MINIMUM THAT CANNOT PASS BY ACCIDENT: an element
// must satisfy `Null` and `dynamic`, and a NON-null element must still be
// rejected by `Null`. A fix of "answer true for elements" passes the first two
// and fails the third; the pre-fix code fails the first two and passes the
// third.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// `Object? main() => [<element>] is List<typeName>;`
AstBundle elementIsBundle(SExpression element, String typeName) {
  const entry = 'package:probe/main.dart';
  SNamedType named(String name, {STypeArgumentList? args}) => SNamedType(
    offset: 0,
    length: 0,
    name: SSimpleIdentifier(offset: 0, length: 0, name: name),
    typeArguments: args,
  );
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
            name: SSimpleIdentifier(offset: 0, length: 0, name: 'main'),
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
                expression: SIsExpression(
                  offset: 0,
                  length: 0,
                  expression: SListLiteral(
                    offset: 0,
                    length: 0,
                    elements: [element],
                  ),
                  type: named(
                    'List',
                    args: STypeArgumentList(
                      offset: 0,
                      length: 0,
                      arguments: [named(typeName)],
                    ),
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
  Object? run(SExpression element, String typeName) =>
      D4rtRunner().executeBundle(elementIsBundle(element, typeName));

  SExpression nullLiteral() => SNullLiteral(offset: 0, length: 0);
  SExpression oneLiteral() => SIntegerLiteral(offset: 0, length: 0, value: 1);

  group('SCE101/AST: the element predicate agrees with `is`', () {
    test('F-SCE101-AST-1: null satisfies Null as an element [2026-09-22] '
        '(PASS)', () {
      expect(run(nullLiteral(), 'Null'), isTrue);
    });

    test('F-SCE101-AST-2: null satisfies dynamic as an element [2026-09-22] '
        '(PASS)', () {
      // `Object` and `dynamic` were one arm answering "non-null". This is the
      // half that had to change; F-SCE101-AST-4 is the half that must not.
      expect(run(nullLiteral(), 'dynamic'), isTrue);
    });

    test('F-SCE101-AST-3 (control): a non-null element is still not Null '
        '[2026-09-22] (PASS)', () {
      expect(run(oneLiteral(), 'Null'), isFalse);
    });

    test('F-SCE101-AST-4 (control): Object still rejects null as an element '
        '[2026-09-22] (PASS)', () {
      expect(run(nullLiteral(), 'Object'), isFalse);
      expect(run(oneLiteral(), 'Object'), isTrue);
    });
  });
}
