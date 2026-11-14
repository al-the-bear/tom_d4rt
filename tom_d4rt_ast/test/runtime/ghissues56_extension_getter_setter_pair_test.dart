// GH56/AST — an extension holds a getter and a setter of one name, in the
// analyzer-free tree (ghissues56).
//
// The mirror of `tom_d4rt/test/ghissues56_extension_getter_setter_pair_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// the setter `w` of `extension E on Box { int get w ...; set w(int x) ... }`
// replaced the getter in the extension's single member map, so `b.w = 3`
// then `b.w` threw `Undefined property 'w' on Box`. Setters now sit apart
// (`InterpretedExtension.setters`); an extension setter also applies on a
// native receiver, and compound updates and `++` / `--` of an extension
// property go through the extension's getter and setter.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String name, {List<String> args = const []}) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(name),
  typeArguments: args.isEmpty
      ? null
      : STypeArgumentList(
          offset: 0,
          length: 0,
          arguments: [for (final a in args) _type(a)],
        ),
);

SFormalParameterList _params([List<(String, String)> params = const []]) =>
    SFormalParameterList(
      offset: 0,
      length: 0,
      parameters: [
        for (final (type, name) in params)
          SRegularFormalParameter(
            offset: 0,
            length: 0,
            name: _id(name),
            type: _type(type),
          ),
      ],
    );

/// `<target>.<name>(<args>)`, or `<name>(<args>)` without a target.
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
  argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
);

/// `<prefix>.<name>` as the parser writes it for a simple prefix.
SPrefixedIdentifier _pid(String prefix, String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id(prefix),
  identifier: _id(name),
);

/// `<target>.<name>` on an expression target.
SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

SIndexExpression _index(SExpression target, SExpression index) =>
    SIndexExpression(offset: 0, length: 0, target: target, index: index);

SBinaryExpression _binary(SExpression left, String op, SExpression right) =>
    SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: left,
      operator: op,
      rightOperand: right,
    );

SAssignmentExpression _assign(SExpression lhs, String op, SExpression rhs) =>
    SAssignmentExpression(
      offset: 0,
      length: 0,
      leftHandSide: lhs,
      operator: op,
      rightHandSide: rhs,
    );

SPostfixExpression _postfix(SExpression operand, String op) =>
    SPostfixExpression(offset: 0, length: 0, operand: operand, operator: op);

SPrefixExpression _prefix(String op, SExpression operand) =>
    SPrefixExpression(offset: 0, length: 0, operator: op, operand: operand);

SListLiteral _list(List<SExpression> elements, [String? type]) => SListLiteral(
  offset: 0,
  length: 0,
  typeArguments: type == null
      ? null
      : STypeArgumentList(offset: 0, length: 0, arguments: [_type(type)]),
  elements: elements,
);

final _this = SThisExpression(offset: 0, length: 0);

SExpressionStatement _do(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

/// `final <name> = <initializer>;`
SVariableDeclarationStatement _var(String name, SExpression initializer) =>
    SVariableDeclarationStatement(
      offset: 0,
      length: 0,
      variables: SVariableDeclarationList(
        offset: 0,
        length: 0,
        isFinal: true,
        variables: [
          SVariableDeclaration(
            offset: 0,
            length: 0,
            name: _id(name),
            initializer: initializer,
          ),
        ],
      ),
    );

SMethodDeclaration _getter(String name, SExpression body) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  returnType: _type('int'),
  isGetter: true,
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
);

SMethodDeclaration _setter(String name, String param, SExpression body) =>
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      returnType: _type('void'),
      isSetter: true,
      parameters: _params([('int', param)]),
      body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
    );

SExtensionDeclaration _extension(
  String name,
  STypeAnnotation on,
  List<SMethodDeclaration> members,
) => SExtensionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  extendedType: on,
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

/// `class Box { int v = 1; }`
final _box = SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('Box')),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SFieldDeclaration(
        offset: 0,
        length: 0,
        fields: SVariableDeclarationList(
          offset: 0,
          length: 0,
          type: _type('int'),
          variables: [
            SVariableDeclaration(
              offset: 0,
              length: 0,
              name: _id('v'),
              initializer: _int(1),
            ),
          ],
        ),
      ),
    ],
  ),
);

/// ```dart
/// extension E on Box { int get w => v * 10; set w(int x) => v = x; }
/// extension Half on List<int> {
///   int get head2 => this[0] * 2;
///   set head2(int x) => this[0] = x ~/ 2;
/// }
/// ```
final _extensions = [
  _extension('E', _type('Box'), [
    _getter('w', _binary(_id('v'), '*', _int(10))),
    _setter('w', 'x', _assign(_id('v'), '=', _id('x'))),
  ]),
  _extension('Half', _type('List', args: ['int']), [
    _getter('head2', _binary(_index(_this, _int(0)), '*', _int(2))),
    _setter(
      'head2',
      'x',
      _assign(_index(_this, _int(0)), '=', _binary(_id('x'), '~/', _int(2))),
    ),
  ]),
];

/// Runs `Object main() { <statements> }` with Box and the extensions above.
Object? _run(
  List<SStatement> statements, {
  List<SDirective> imports = const [],
  D4rtRunner? runner,
}) => (runner ?? D4rtRunner()).executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: imports,
        declarations: [
          _box,
          ..._extensions,
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            returnType: _type('Object'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _params(),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(offset: 0, length: 0, statements: statements),
              ),
            ),
          ),
        ],
      ),
    },
  ),
);

final _newBox = _var('b', _call(null, 'Box'));

void main() {
  group('GH56/AST: a getter and a setter of one name in an extension', () {
    test('F-GH56-AST-1: the measured script answers [3, 30] [2026-11-14]', () {
      expect(
        _run([
          _newBox,
          _do(_assign(_pid('b', 'w'), '=', _int(3))),
          _return(_list([_pid('b', 'v'), _pid('b', 'w')])),
        ]),
        [3, 30],
      );
    });

    test('F-GH56-AST-2: compound assignment and ++ / -- on the extension '
        'property [2026-11-14]', () {
      expect(
        _run([
          _newBox,
          _do(_assign(_pid('b', 'w'), '+=', _int(2))),
          _var('post', _postfix(_pid('b', 'w'), '++')),
          _var('pre', _prefix('++', _pid('b', 'w'))),
          _do(_postfix(_pid('b', 'w'), '--')),
          _return(_list([_pid('b', 'v'), _id('post'), _id('pre')])),
        ]),
        [12109, 120, 1211],
      );
    });

    test('F-GH56-AST-3: an interpreted extension on a native receiver '
        '[2026-11-14]', () {
      expect(
        _run([
          _var('l', _list([_int(1)], 'int')),
          _do(_assign(_pid('l', 'head2'), '=', _int(10))),
          _var('set', _index(_id('l'), _int(0))),
          _do(_assign(_pid('l', 'head2'), '+=', _int(4))),
          _do(_postfix(_pid('l', 'head2'), '++')),
          _return(_list([_id('set'), _id('l'), _pid('l', 'head2')])),
        ]),
        [
          5,
          [7],
          14,
        ],
      );
    });

    test('F-GH56-AST-4: a bridged extension with a getter and a setter of '
        'one name [2026-11-14]', () {
      final runner = D4rtRunner()
        ..registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'Gh56Size',
            onTypeName: 'List',
            getters: {'size': (visitor, target) => (target as List).length},
            setters: {
              'size': (visitor, target, value) {
                (target as List).length = value as int;
              },
            },
          ),
          'package:b/b.dart',
        );
      expect(
        _run(
          [
            _var('l', _list([_int(1), _int(2), _int(3)], 'int?')),
            _do(_assign(_pid('l', 'size'), '=', _int(1))),
            _var('after', _pid('l', 'size')),
            _do(_assign(_pid('l', 'size'), '+=', _int(1))),
            _return(_list([_id('after'), _id('l')])),
          ],
          imports: [
            SImportDirective(
              offset: 0,
              length: 0,
              uri: _str('package:b/b.dart'),
            ),
          ],
          runner: runner,
        ),
        [
          1,
          [1, null],
        ],
      );
    });

    test('F-GH56-AST-5: the explicit override - E(x).p = v, += v, p++ and '
        '++p [2026-11-14]', () {
      SPropertyAccess w() => _get(_call(null, 'E', [_id('b')]), 'w');
      expect(
        _run([
          _newBox,
          _do(_assign(w(), '=', _int(3))),
          _do(_assign(w(), '+=', _int(2))),
          _var('post', _postfix(w(), '++')),
          _var('pre', _prefix('++', w())),
          _return(_list([_pid('b', 'v'), _id('post'), _id('pre')])),
        ]),
        [3211, 320, 3211],
      );
    });
  });
}
