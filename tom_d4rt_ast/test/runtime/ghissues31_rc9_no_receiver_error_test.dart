// GH31/AST — a member a script class inherits from an abstract bridged class,
// with no native object to run it on, is an error instead of null, in the
// analyzer-free tree (ghissues31).
//
// The mirror of `tom_d4rt/test/ghissues31_rc9_no_receiver_error_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// an inherited method answered null, an inherited getter null, and
// `super.m()` was a no-op (RC-9). One named exception stays a no-op: a
// `super.m()` on a script State whose State proxy runs it (`nativeStateProxy`).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

abstract class Gh31AstBase {
  String greet() => 'hello';
  int get size => 3;
}

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

/// `<target>.<name>(<args>)`
SMethodInvocation _call(
  SExpression? target,
  String name, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(name),
  argumentList: _args(args),
);

SExpression _super() => SSuperExpression(offset: 0, length: 0);

/// `String <name>() <body>`
SMethodDeclaration _method(String name, SFunctionBody body) =>
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      returnType: _type('String'),
      parameters: SFormalParameterList(offset: 0, length: 0),
      body: body,
    );

/// `class <name> extends Gh31AstBase { <members> }`
SClassDeclaration _class(
  String name, [
  List<SClassMember> members = const [],
]) => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: _type('Gh31AstBase'),
  ),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

final _declarations = <SCompilationUnitMember>[
  _class('C'),
  // String greet() => 'd:' + super.greet();
  _class('D', [
    _method(
      'greet',
      SExpressionFunctionBody(
        offset: 0,
        length: 0,
        expression: SBinaryExpression(
          offset: 0,
          length: 0,
          leftOperand: _str('d:'),
          operator: '+',
          rightOperand: _call(_super(), 'greet'),
        ),
      ),
    ),
  ]),
  // String greet() { super.greet(); return 'state'; }
  _class('S', [
    _method(
      'greet',
      SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(
          offset: 0,
          length: 0,
          statements: [
            SExpressionStatement(
              offset: 0,
              length: 0,
              expression: _call(_super(), 'greet'),
            ),
            SReturnStatement(offset: 0, length: 0, expression: _str('state')),
          ],
        ),
      ),
    ),
  ]),
];

/// Runs `main() => <result>` after the declarations above.
Object? _run(SExpression result) {
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh31AstBase,
        name: 'Gh31AstBase',
        isAbstract: true,
        methods: {
          'greet': (visitor, target, positional, named, typeArgs) =>
              (target as Gh31AstBase).greet(),
        },
        getters: {'size': (visitor, target) => (target as Gh31AstBase).size},
      ),
      'package:g/g.dart',
    )
    // Stands in for the Flutter twins' `_InterpretedStatefulWidget`, which
    // sets `nativeStateProxy` on a script State it runs.
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Object,
        name: 'Gh31AstHost',
        staticMethods: {
          'adopt': (visitor, positional, named, typeArgs) {
            (positional[0] as InterpretedInstance).nativeStateProxy = Object();
            return positional[0];
          },
        },
      ),
      'package:g/g.dart',
    );
  return runner.executeBundle(
    AstBundle(
      entryPointUri: _entry,
      modules: {
        _entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            SImportDirective(
              offset: 0,
              length: 0,
              uri: _str('package:g/g.dart'),
            ),
          ],
          declarations: [
            ..._declarations,
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: result,
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

Matcher _noReceiver(String scriptClass, String member) => throwsA(
  predicate(
    (Object? e) =>
        e is RuntimeD4rtException &&
        e.message.contains("'$scriptClass'") &&
        e.message.contains("'Gh31AstBase.$member'") &&
        e.message.contains('markProxyIsReceiver'),
    "a RuntimeD4rtException naming '$scriptClass' and 'Gh31AstBase.$member'",
  ),
);

void main() {
  group('GH31/AST: an inherited bridged member with no receiver is an '
      'error', () {
    test('F-GH31-AST-1: an inherited method and getter [2026-11-10]', () {
      expect(
        () => _run(_call(_call(null, 'C'), 'greet')),
        _noReceiver('C', 'greet'),
      );
      expect(
        () => _run(
          SPropertyAccess(
            offset: 0,
            length: 0,
            target: _call(null, 'C'),
            operator: '.',
            propertyName: _id('size'),
          ),
        ),
        _noReceiver('C', 'size'),
      );
    });

    test('F-GH31-AST-2: super.m() in an override [2026-11-10]', () {
      expect(
        () => _run(_call(_call(null, 'D'), 'greet')),
        _noReceiver('D', 'greet'),
      );
    });

    test('F-GH31-AST-3: the named exception - super.m() on a State the '
        'State proxy runs stays a no-op [2026-11-10]', () {
      expect(
        _run(
          _call(
            _call(_id('Gh31AstHost'), 'adopt', [_call(null, 'S')]),
            'greet',
          ),
        ),
        'state',
      );
      expect(
        () => _run(_call(_call(null, 'S'), 'greet')),
        _noReceiver('S', 'greet'),
      );
    });
  });
}
