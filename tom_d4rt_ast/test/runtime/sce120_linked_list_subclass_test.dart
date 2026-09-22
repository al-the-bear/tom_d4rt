// SCE120/AST — the analyzer-free twin of
// `tom_d4rt/test/sce120_linked_list_subclass_test.dart`.
//
// `class E extends LinkedListEntry<E>` is the idiom the SDK documents, and it
// could not be put in a `LinkedList`. The two walls the todo measured are
// closed; what this commit adds is the last leak, where a read-back entry
// rendered as `LinkedListEntry(E:1)` instead of the script's own `toString`.
//
// WHAT THIS SIDE UNIQUELY ANSWERS is the PROXY UNWRAP. The bridge file is
// code-identical between the trees (F-SCD49-2 asserts it), so nothing about
// `_OwnedLinkedListEntry` differs — but `D4InterpretedProxy` is consulted by
// the interpreter, and this tree's `interpreter_visitor.dart` is its own copy.
// `l.first.v` reaching the script's field is that copy working; the reference
// suite runs none of it.
//
// ABLATED 2026-09-22 by restoring `'LinkedListEntry(${owner ?? 'unowned'})'`:
// F-SCE120-AST-2 fails. -1 passes under both, and that is the point — it is
// the round-trip the todo is named for, and it was already working.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n, [List<STypeAnnotation> args = const []]) =>
    SNamedType(
      offset: 0,
      length: 0,
      name: _id(n),
      typeArguments: args.isEmpty
          ? null
          : STypeArgumentList(offset: 0, length: 0, arguments: args),
    );

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(args),
);

SInstanceCreationExpression _new(
  String type, [
  List<SExpression> args = const [],
  List<STypeAnnotation> typeArgs = const [],
]) => SInstanceCreationExpression(
  offset: 0,
  length: 0,
  constructorName: SConstructorName(
    offset: 0,
    length: 0,
    type: _type(type, typeArgs),
  ),
  argumentList: _args(args),
);

/// ```
/// class E extends LinkedListEntry<E> {
///   final int v;
///   E(this.v);
///   String toString() => 'E:' + v.toString();
/// }
/// ```
SClassDeclaration _entryClass() => SClassDeclaration(
  offset: 0,
  length: 0,
  name: _id('E'),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: _type('LinkedListEntry', [_type('E')]),
  ),
  members: [
    SFieldDeclaration(
      offset: 0,
      length: 0,
      fields: SVariableDeclarationList(
        offset: 0,
        length: 0,
        type: _type('int'),
        isFinal: true,
        variables: [SVariableDeclaration(offset: 0, length: 0, name: _id('v'))],
      ),
    ),
    SConstructorDeclaration(
      offset: 0,
      length: 0,
      returnType: _id('E'),
      parameters: SFormalParameterList(
        offset: 0,
        length: 0,
        parameters: [
          SFieldFormalParameter(
            offset: 0,
            length: 0,
            name: _id('v'),
            isRequired: true,
          ),
        ],
      ),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(offset: 0, length: 0, statements: const []),
      ),
    ),
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id('toString'),
      returnType: _type('String'),
      parameters: _noParams(),
      body: SExpressionFunctionBody(
        offset: 0,
        length: 0,
        expression: SBinaryExpression(
          offset: 0,
          length: 0,
          leftOperand: SSimpleStringLiteral(offset: 0, length: 2, value: 'E:'),
          operator: '+',
          rightOperand: _call(_id('v'), 'toString'),
        ),
      ),
    ),
  ],
);

/// `main() { var l = LinkedList<E>(); l.add(E(1)); return <expression>; }`
AstBundle _bundle(SExpression result) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          SImportDirective(
            offset: 0,
            length: 0,
            uri: SSimpleStringLiteral(
              offset: 0,
              length: 0,
              value: 'dart:collection',
            ),
          ),
        ],
        declarations: [
          _entryClass(),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _noParams(),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    SVariableDeclarationStatement(
                      offset: 0,
                      length: 0,
                      variables: SVariableDeclarationList(
                        offset: 0,
                        length: 0,
                        variables: [
                          SVariableDeclaration(
                            offset: 0,
                            length: 0,
                            name: _id('l'),
                            initializer: _new('LinkedList', const [], [
                              _type('E'),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SExpressionStatement(
                      offset: 0,
                      length: 0,
                      expression: _call(_id('l'), 'add', [
                        _new('E', [
                          SIntegerLiteral(offset: 0, length: 1, value: 1),
                        ]),
                      ]),
                    ),
                    SReturnStatement(offset: 0, length: 0, expression: result),
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

Object? _run(SExpression result) => D4rtRunner().executeBundle(_bundle(result));

/// `l.first`
SExpression get _first => SPropertyAccess(
  offset: 0,
  length: 0,
  target: _id('l'),
  operator: '.',
  propertyName: _id('first'),
);

void main() {
  group('SCE120/AST: a script subclass of LinkedListEntry', () {
    test('F-SCE120-AST-1: the list round-trips the script\'s own object '
        '[2026-09-22] (PASS)', () {
      // `v` is a field the NATIVE entry does not have, so answering 1 is the
      // proxy unwrap in this tree's interpreter working — the list holds a
      // native entry and hands the script's instance back.
      expect(
        _run(
          SPropertyAccess(
            offset: 0,
            length: 0,
            target: _first,
            operator: '.',
            propertyName: _id('v'),
          ),
        ),
        1,
      );
      expect(
        _run(
          SPropertyAccess(
            offset: 0,
            length: 0,
            target: _id('l'),
            operator: '.',
            propertyName: _id('length'),
          ),
        ),
        1,
      );
    });

    test('F-SCE120-AST-2: a read-back entry renders the script\'s toString '
        '[2026-09-22] (PASS)', () {
      // The leak this commit closes: the proxy unwrap is a fallback after the
      // bridge's own members fail, and `toString` succeeded on the wrapper.
      expect(_run(_call(_first, 'toString')), 'E:1');
    });
  });
}
