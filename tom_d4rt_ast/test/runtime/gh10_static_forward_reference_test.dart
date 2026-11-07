// GH10/AST — a static or top-level initializer that reads a declaration made
// after it, in the analyzer-free tree (GitHub al-the-bear/tom_d4rt#10).
//
// The mirror of `tom_d4rt/test/gh10_static_forward_reference_test.dart`, which
// runs source and covers every shape. Here each script is a hand-built bundle,
// so the set is the issue's fixtures and the cycle: an unqualified and a
// qualified forward reference, an unread class, a self-dependent field, a
// top-level forward reference, and calling a function-valued static through
// its class (`K.f()`, refused before by both trees).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SListLiteral _list(List<SExpression> e) =>
    SListLiteral(offset: 0, length: 0, elements: e);

/// `Class.member`
SPrefixedIdentifier _qual(String prefix, String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id(prefix),
  identifier: _id(name),
);

SReturnStatement _ret(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SBlockFunctionBody _body(List<SStatement> s) => SBlockFunctionBody(
  offset: 0,
  length: 0,
  block: SBlock(offset: 0, length: 0, statements: s),
);

SVariableDeclarationList _vars(
  String name,
  SExpression init, {
  bool isConst = false,
  bool isFinal = false,
}) => SVariableDeclarationList(
  offset: 0,
  length: 0,
  isConst: isConst,
  isFinal: isFinal,
  variables: [
    SVariableDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      initializer: init,
    ),
  ],
);

/// `static const <name> = <init>;`
SFieldDeclaration _static(String name, SExpression init) => SFieldDeclaration(
  offset: 0,
  length: 0,
  isStatic: true,
  fields: _vars(name, init, isConst: true),
);

SClassDeclaration _class(String name, List<SClassMember> members) =>
    SClassDeclaration(
      offset: 0,
      length: 0,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id(name),
      ),
      body: SBlockClassBody(offset: 0, length: 0, members: members),
    );

SFunctionDeclaration _function(String name, List<SStatement> body) =>
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: _body(body),
      ),
    );

/// A bundle of [declarations] plus `main() { return <result>; }`.
Object? _run(List<SCompilationUnitMember> declarations, SExpression result) {
  const entry = 'package:probe/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            ...declarations,
            _function('main', [_ret(result)]),
          ],
        ),
      },
    ),
  );
}

void main() {
  group('GH10/AST: initializers read declarations made after them', () {
    test('GH10-AST-1: unqualified forward reference [2026-11-07]', () {
      // class Config { static const values = [base]; static const base = 'x'; }
      expect(
        _run([
          _class('Config', [
            _static('values', _list([_id('base')])),
            _static('base', _str('x')),
          ]),
        ], _qual('Config', 'values')),
        ['x'],
      );
    });

    test('GH10-AST-2: qualified forward reference [2026-11-07]', () {
      expect(
        _run([
          _class('Config', [
            _static('values', _list([_qual('Config', 'base')])),
            _static('base', _str('x')),
          ]),
        ], _qual('Config', 'values')),
        ['x'],
      );
    });

    test('GH10-AST-3: a class nobody reads is not initialized '
        '[2026-11-07]', () {
      expect(
        _run([
          _class('Config', [
            _static('values', _list([_id('base')])),
            _static('base', _str('x')),
          ]),
        ], _str('ready')),
        'ready',
      );
    });

    test('GH10-AST-4: a self-dependent field is an error, not a hang '
        '[2026-11-07]', () {
      expect(
        () => _run([
          _class('Config', [_static('a', _id('b')), _static('b', _id('a'))]),
        ], _qual('Config', 'a')),
        throwsA(
          predicate(
            (Object e) => e.toString().contains('during its initialization'),
          ),
        ),
      );
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('GH10-AST-5: a top-level variable reads one declared later '
        '[2026-11-07]', () {
      // final values = [base]; const base = 'x';
      expect(
        _run([
          STopLevelVariableDeclaration(
            offset: 0,
            length: 0,
            variables: _vars('values', _list([_id('base')]), isFinal: true),
          ),
          STopLevelVariableDeclaration(
            offset: 0,
            length: 0,
            variables: _vars('base', _str('x'), isConst: true),
          ),
        ], _id('values')),
        ['x'],
      );
    });

    test('GH10-AST-6: K.f() calls the function a static field holds '
        '[2026-11-07]', () {
      // String helper() { return 'f'; }  class K { static const f = helper; }
      expect(
        _run(
          [
            _function('helper', [_ret(_str('f'))]),
            _class('K', [_static('f', _id('helper'))]),
          ],
          SMethodInvocation(
            offset: 0,
            length: 0,
            target: _id('K'),
            operator: '.',
            methodName: _id('f'),
            argumentList: SArgumentList(offset: 0, length: 0),
          ),
        ),
        'f',
      );
    });
  });
}
