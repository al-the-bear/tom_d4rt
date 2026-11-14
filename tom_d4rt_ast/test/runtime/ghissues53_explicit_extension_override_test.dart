// GH53/AST — an explicit extension override `E(x).member`, in the
// analyzer-free tree (ghissues53; found by ghissues47, GitHub #14).
//
// The mirror of `tom_d4rt/test/ghissues53_explicit_extension_override_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// every override - `L(list).toJson()`, `ListEncoding(list).toJson()`,
// `api.ListEncoding(list).toJson()` - was refused as calling a non-callable:
// the mirror AST, like the analyzer's unresolved AST, has no override node,
// so `E(x)` is an ordinary call of `E`. Calling an extension by its name -
// bare or through an import prefix - now evaluates to an extension override,
// and the access that follows calls the extension's member with x as `this`.
//
// Compound assignment and increment of a PROPERTY need a getter and a setter
// of one name, which an extension cannot hold yet (ghissues56); they are
// tested on the index operators here.

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

SNamedType _type(
  String name, {
  List<String> args = const [],
  bool nullable = false,
}) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(name),
  isNullable: nullable,
  typeArguments: args.isEmpty ? null : _typeArgs(args),
);

STypeArgumentList _typeArgs(List<String> args) => STypeArgumentList(
  offset: 0,
  length: 0,
  arguments: [for (final a in args) _type(a)],
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

/// `<target><op><name>(<args>)`; `<name><typeArgs>(<args>)` without target.
SMethodInvocation _call(
  SExpression? target,
  String name, [
  List<SExpression> args = const [],
  String op = '.',
  List<String> typeArgs = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : op,
  methodName: _id(name),
  typeArguments: typeArgs.isEmpty ? null : _typeArgs(typeArgs),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
);

/// `<target><op><name>`
SPropertyAccess _get(SExpression target, String name, [String op = '.']) =>
    SPropertyAccess(
      offset: 0,
      length: 0,
      target: target,
      operator: op,
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

SListLiteral _list(List<SExpression> elements, [String? type]) => SListLiteral(
  offset: 0,
  length: 0,
  typeArguments: type == null ? null : _typeArgs([type]),
  elements: elements,
);

final _this = SThisExpression(offset: 0, length: 0);

SExpressionStatement _do(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

/// `<type> <name> = <initializer>;`
SVariableDeclarationStatement _var(
  String name,
  SExpression? initializer, {
  STypeAnnotation? type,
}) => SVariableDeclarationStatement(
  offset: 0,
  length: 0,
  variables: SVariableDeclarationList(
    offset: 0,
    length: 0,
    type: type,
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

/// `<returns> <name>(<params>) => <body>;` (getter / setter / operator).
SMethodDeclaration _member(
  String name,
  SExpression body, {
  String returns = 'int',
  List<(String, String)> params = const [],
  bool isGetter = false,
  bool isSetter = false,
  bool isOperator = false,
}) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  returnType: _type(returns),
  isGetter: isGetter,
  isSetter: isSetter,
  isOperator: isOperator,
  parameters: isGetter ? null : _params(params),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
);

SExtensionDeclaration _extension(
  String name,
  List<SMethodDeclaration> members, {
  List<String> typeParameters = const [],
  String elementType = 'int',
}) => SExtensionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  typeParameters: typeParameters.isEmpty
      ? null
      : STypeParameterList(
          offset: 0,
          length: 0,
          typeParameters: [
            for (final t in typeParameters)
              STypeParameter(offset: 0, length: 0, name: _id(t)),
          ],
        ),
  extendedType: _type('List', args: [elementType]),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

/// ```dart
/// extension E on List<int> {
///   int plus(int a) => a + length;
///   int get len => length;
///   set last2(int v) => add(v);
///   int operator +(int o) => length + o;
///   int operator -() => -length;
///   int operator [](int i) => this[i];
///   void operator []=(int i, int v) => this[i] = v;
/// }
/// extension F on List<int> { int plus(int a) => -a; }
/// extension K<T> on List<T> { String kind() => T.toString(); }
/// ```
final _extensions = [
  _extension('E', [
    _member(
      'plus',
      _binary(_id('a'), '+', _id('length')),
      params: [('int', 'a')],
    ),
    _member('len', _id('length'), isGetter: true),
    _member(
      'last2',
      _call(null, 'add', [_id('v')]),
      returns: 'void',
      params: [('int', 'v')],
      isSetter: true,
    ),
    _member(
      '+',
      _binary(_id('length'), '+', _id('o')),
      params: [('int', 'o')],
      isOperator: true,
    ),
    _member(
      '-',
      SPrefixExpression(
        offset: 0,
        length: 0,
        operator: '-',
        operand: _id('length'),
      ),
      isOperator: true,
    ),
    _member(
      '[]',
      _index(_this, _id('i')),
      params: [('int', 'i')],
      isOperator: true,
    ),
    _member(
      '[]=',
      _assign(_index(_this, _id('i')), '=', _id('v')),
      returns: 'void',
      params: [('int', 'i'), ('int', 'v')],
      isOperator: true,
    ),
  ]),
  _extension('F', [
    _member(
      'plus',
      SPrefixExpression(offset: 0, length: 0, operator: '-', operand: _id('a')),
      params: [('int', 'a')],
    ),
  ]),
  _extension(
    'K',
    [_member('kind', _call(_id('T'), 'toString'), returns: 'String')],
    typeParameters: ['T'],
    elementType: 'T',
  ),
];

/// `package:r/public.dart` exports `ListEncoding` from `src/encoding.dart`.
final _modules = <String, SCompilationUnit>{
  'package:r/src/encoding.dart': SCompilationUnit(
    offset: 0,
    length: 0,
    declarations: [
      _extension('ListEncoding', [_member('toJson', _this, returns: 'List')]),
    ],
  ),
  'package:r/public.dart': SCompilationUnit(
    offset: 0,
    length: 0,
    directives: [
      SExportDirective(offset: 0, length: 0, uri: _str('src/encoding.dart')),
    ],
  ),
};

/// Runs `Object main() { <statements> }` after [imports], with the
/// extensions above declared.
Object? _run(
  List<SStatement> statements, {
  List<SDirective> imports = const [],
  D4rtRunner? runner,
}) => (runner ?? D4rtRunner()).executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      ..._modules,
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: imports,
        declarations: [
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

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

/// `final List<int> l = <int>[5, 6];`
final _l = _var(
  'l',
  _list([_int(5), _int(6)], 'int'),
  type: _type('List', args: ['int']),
);

SMethodInvocation _over(String ext, [List<String> typeArgs = const []]) =>
    _call(null, ext, [_id('l')], '.', typeArgs);

void main() {
  group('GH53/AST: explicit extension overrides', () {
    test('F-GH53-AST-1: method, getter, operators and the index read on a '
        'local extension [2026-11-14]', () {
      expect(
        _run([
          _l,
          _return(
            _list([
              _call(_over('E'), 'plus', [_int(1)]),
              _get(_over('E'), 'len'),
              _binary(_over('E'), '+', _int(2)),
              SPrefixExpression(
                offset: 0,
                length: 0,
                operator: '-',
                operand: _over('E'),
              ),
              _index(_over('E'), _int(0)),
            ]),
          ),
        ]),
        [3, 2, 4, -2, 5],
      );
    });

    test('F-GH53-AST-2: the setter and index write / compound / increment '
        '[2026-11-14]', () {
      expect(
        _run([
          _l,
          _do(_assign(_index(_over('E'), _int(0)), '=', _int(9))),
          _do(_assign(_index(_over('E'), _int(1)), '+=', _int(4))),
          _do(
            SPostfixExpression(
              offset: 0,
              length: 0,
              operand: _index(_over('E'), _int(0)),
              operator: '++',
            ),
          ),
          _do(
            SPrefixExpression(
              offset: 0,
              length: 0,
              operator: '--',
              operand: _index(_over('E'), _int(1)),
            ),
          ),
          _do(_assign(_get(_over('E'), 'last2'), '=', _int(7))),
          _return(_id('l')),
        ]),
        [10, 9, 7],
      );
    });

    test('F-GH53-AST-3: the override resolves a conflict between two '
        'extensions [2026-11-14]', () {
      expect(
        _run([
          _l,
          _return(
            _list([
              _call(_over('E'), 'plus', [_int(1)]),
              _call(_over('F'), 'plus', [_int(1)]),
            ]),
          ),
        ]),
        [3, -1],
      );
    });

    test('F-GH53-AST-4: an imported and a prefixed extension (GitHub #14) '
        '[2026-11-14]', () {
      SExpression toJson(SExpression? prefix) => _call(
        _call(prefix, 'ListEncoding', [
          _list([_int(3)], 'int'),
        ]),
        'toJson',
      );
      expect(
        _run(
          [_return(toJson(_id('api')))],
          imports: [
            SImportDirective(
              offset: 0,
              length: 0,
              uri: _str('package:r/public.dart'),
              prefix: _id('api'),
            ),
          ],
        ),
        [3],
      );
      expect(
        _run(
          [_return(toJson(null))],
          imports: [
            SImportDirective(
              offset: 0,
              length: 0,
              uri: _str('package:r/public.dart'),
            ),
          ],
        ),
        [3],
      );
    });

    test('F-GH53-AST-5: a bridged named extension [2026-11-14]', () {
      final runner = D4rtRunner()
        ..registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'Gh53Shout',
            onTypeName: 'String',
            methods: {
              'shout': (visitor, target, positional, named, typeArgs) =>
                  '${(target as String).toUpperCase()}!',
            },
          ),
          'package:b/b.dart',
        );
      expect(
        _run(
          [
            _return(_call(_call(null, 'Gh53Shout', [_str('hi')]), 'shout')),
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
        'HI!',
      );
    });

    test('F-GH53-AST-6: E<T>(x) binds the type parameters as written; '
        'without them they come from the receiver [2026-11-14]', () {
      expect(
        _run([
          _l,
          _return(
            _list([
              _call(_over('K', ['num']), 'kind'),
              _call(_over('K'), 'kind'),
            ]),
          ),
        ]),
        ['num', 'int'],
      );
    });

    test('F-GH53-AST-7: E(x)?.m() on null short-circuits [2026-11-14]', () {
      expect(
        _run([
          _var('l', null, type: _type('List', args: ['int'], nullable: true)),
          _return(
            _list([
              _call(_over('E'), 'plus', [_int(1)], '?.'),
              _get(_over('E'), 'len', '?.'),
            ]),
          ),
        ]),
        [null, null],
      );
    });

    test('F-GH53-AST-8: a member the extension does not declare is an error '
        'naming the extension [2026-11-14]', () {
      expect(
        () => _run([_l, _return(_get(_over('F'), 'len'))]),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "The extension 'F' does not declare a member 'len'",
            ),
            'the error naming F',
          ),
        ),
      );
    });
  });
}
