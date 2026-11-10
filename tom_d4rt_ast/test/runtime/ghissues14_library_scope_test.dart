// GHI14/AST — an imported library's code cannot reach the entry's top-level
// declarations, in the analyzer-free tree (ghissues14).
//
// The mirror of `tom_d4rt/test/ghissues14_library_scope_test.dart`, which runs
// source through both entry forms. Here each script is a hand-built bundle:
// `package:rel/types.dart` names something only the entry declares - a
// variable read by a function, a class it extends - and is refused, while a
// library function using its own declarations still works. Before the fix the
// bundle entry ran in the loader's global environment, which every loaded
// module encloses, so `useScript()` returned the entry's `scriptOnly`.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SFormalParameterList _params() => SFormalParameterList(offset: 0, length: 0);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

/// `int <name> = <value>;`
STopLevelVariableDeclaration _intVar(String name, int value) =>
    STopLevelVariableDeclaration(
      offset: 0,
      length: 0,
      variables: SVariableDeclarationList(
        offset: 0,
        length: 0,
        type: _type('int'),
        variables: [
          SVariableDeclaration(
            offset: 0,
            length: 0,
            name: _id(name),
            initializer: _int(value),
          ),
        ],
      ),
    );

/// `<name>() => <body>;`
SFunctionDeclaration _fn(String name, SExpression body) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _params(),
    body: _arrow(body),
  ),
);

/// `class <name> [extends <superclass>] { [int b() => <b>;] }`
SClassDeclaration _class(String name, {String? superclass, int? b}) =>
    SClassDeclaration(
      offset: 0,
      length: 0,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id(name),
      ),
      extendsClause: superclass == null
          ? null
          : SExtendsClause(offset: 0, length: 0, superclass: _type(superclass)),
      body: SBlockClassBody(
        offset: 0,
        length: 0,
        members: [
          if (b != null)
            SMethodDeclaration(
              offset: 0,
              length: 0,
              name: _id('b'),
              returnType: _type('int'),
              parameters: _params(),
              body: _arrow(_int(b)),
            ),
        ],
      ),
    );

/// `<name>()`
SMethodInvocation _call(String name, [SExpression? target]) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      target: target,
      operator: target == null ? null : '.',
      methodName: _id(name),
      argumentList: SArgumentList(offset: 0, length: 0),
    );

/// Runs the entry (importing `package:rel/types.dart`) with [entry]
/// declarations and `main() => <result>`, against [types].
Object? _run(
  List<SCompilationUnitMember> types,
  List<SCompilationUnitMember> entry,
  SExpression result,
) {
  const main = 'package:rel/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: main,
      modules: {
        'package:rel/types.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: types,
        ),
        main: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            SImportDirective(
              offset: 0,
              length: 0,
              uri: SSimpleStringLiteral(
                offset: 0,
                length: 0,
                value: 'package:rel/types.dart',
              ),
            ),
          ],
          declarations: [...entry, _fn('main', result)],
        ),
      },
    ),
  );
}

Matcher _refusedWith(String part) => throwsA(
  predicate((Object e) => e.toString().contains(part), 'an error naming $part'),
);

void main() {
  group('GHI14/AST: a library does not see the entry', () {
    test('F-GHI14-AST-1: a library function reading an entry global is '
        'refused [2026-11-10]', () {
      expect(
        () => _run(
          [_fn('useScript', _id('scriptOnly'))],
          [_intVar('scriptOnly', 5)],
          _call('useScript'),
        ),
        _refusedWith('scriptOnly'),
      );
    });

    test('F-GHI14-AST-2: a library class extending an entry class is refused '
        '[2026-11-10]', () {
      expect(
        () => _run(
          [_class('Child', superclass: 'ScriptBase')],
          [_class('ScriptBase', b: 1)],
          _call('b', _call('Child')),
        ),
        _refusedWith('ScriptBase'),
      );
    });

    test('F-GHI14-AST-3: the library keeps its own declarations, and the entry '
        'keeps its own and the library\'s [2026-11-10]', () {
      expect(
        _run(
          [_intVar('own', 2), _fn('useOwn', _id('own')), _class('Base', b: 3)],
          [_intVar('scriptOnly', 5), _class('Child', superclass: 'Base')],
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              _call('useOwn'),
              _call('b', _call('Child')),
              _id('scriptOnly'),
            ],
          ),
        ),
        [2, 3, 5],
      );
    });
  });
}
