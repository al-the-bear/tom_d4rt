// ghissues66/AST — an enum value through an import prefix, an enum's own
// names inside its members, and a field implementing an interface getter, in
// the analyzer-free tree (GitHub al-the-bear/tom_d4rt#21 follow-up).
//
// The mirror of `tom_d4rt/test/ghissues66_prefixed_enum_value_test.dart`,
// which runs eight source shapes against native Dart's output. Here each case
// is a hand-built bundle with the node shapes `AstBundler` emits:
//
// - `e.Color.green` is a property access on the prefixed identifier
//   `e.Color`; its enum branch never looked the enum's values up, so it
//   failed with `Undefined static property 'green' on enum 'Color'` - the
//   reporter's `AppLocale.zhCn` in his Slang suite;
// - inside an enum, a bare value name, `values`, a static field or a static
//   method was undefined in static and instance members and in a static
//   field's initializer, and a static field naming one of the enum's values
//   was evaluated before the values existed;
// - a field implementing an interface getter was refused (`Missing concrete
//   implementation for interface getter`).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _params([List<SFormalParameter> parameters = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: parameters);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

SPrefixedIdentifier _dot(String prefix, String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id(prefix),
  identifier: _id(name),
);

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

SListLiteral _list(List<SExpression> elements) =>
    SListLiteral(offset: 0, length: 0, elements: elements);

SImportDirective _import(String uri, {String? prefix}) => SImportDirective(
  offset: 0,
  length: 0,
  uri: _str(uri),
  prefix: prefix == null ? null : _id(prefix),
);

/// `main() => <result>;`
SFunctionDeclaration _main(SExpression result) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id('main'),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _params(),
    body: _arrow(result),
  ),
);

/// `[static] <name>() => <result>;`
SMethodDeclaration _method(
  String name,
  SExpression result, {
  bool isStatic = false,
}) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  isStatic: isStatic,
  parameters: _params(),
  body: _arrow(result),
);

/// `[static] [const] <type> <name> = <init>;` (or `final <type> <name>;`)
SFieldDeclaration _field(
  String type,
  String name, {
  SExpression? init,
  bool isStatic = false,
}) => SFieldDeclaration(
  offset: 0,
  length: 0,
  isStatic: isStatic,
  fields: SVariableDeclarationList(
    offset: 0,
    length: 0,
    type: _type(type),
    isConst: isStatic,
    isFinal: !isStatic,
    variables: [
      SVariableDeclaration(
        offset: 0,
        length: 0,
        name: _id(name),
        initializer: init,
      ),
    ],
  ),
);

/// `enum Color { red, green; <members> }`
SEnumDeclaration _color([List<SClassMember> members = const []]) =>
    SEnumDeclaration(
      offset: 0,
      length: 0,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id('Color'),
      ),
      body: SBlockEnumBody(
        offset: 0,
        length: 0,
        constants: [
          for (final name in ['red', 'green'])
            SEnumConstantDeclaration(offset: 0, length: 0, name: _id(name)),
        ],
        members: members,
      ),
    );

SCompilationUnit _unit(
  List<SDirective> directives, [
  List<SCompilationUnitMember> declarations = const [],
]) => SCompilationUnit(
  offset: 0,
  length: 0,
  directives: directives,
  declarations: declarations,
);

/// Runs `package:p/main.dart` of [modules].
Object? _run(Map<String, SCompilationUnit> modules) => D4rtRunner()
    .executeBundle(
      AstBundle(entryPointUri: 'package:p/main.dart', modules: modules),
    );

Matcher _refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

void main() {
  group('ghissues66/AST: an enum value through an import prefix', () {
    test('GH66-AST-1: `e.Color.green` - the reporter\'s `AppLocale.zhCn` '
        '[2026-11-17]', () {
      final result = _run({
        'package:p/main.dart': _unit(
          [_import('package:p/e.dart', prefix: 'e')],
          [
            _main(
              _list([
                SPropertyAccess(
                  offset: 0,
                  length: 0,
                  target: _dot('e', 'Color'),
                  operator: '.',
                  propertyName: _id('green'),
                ),
                SPropertyAccess(
                  offset: 0,
                  length: 0,
                  target: SPropertyAccess(
                    offset: 0,
                    length: 0,
                    target: _dot('e', 'Color'),
                    operator: '.',
                    propertyName: _id('values'),
                  ),
                  operator: '.',
                  propertyName: _id('length'),
                ),
              ]),
            ),
          ],
        ),
        'package:p/e.dart': _unit([], [_color()]),
      });
      expect([for (final v in result! as List) '$v'], ['Color.green', '2']);
    });

    test('GH66-AST-2: a name the enum does not have is still refused '
        '[2026-11-17]', () {
      expect(
        () => _run({
          'package:p/main.dart': _unit(
            [_import('package:p/e.dart', prefix: 'e')],
            [
              _main(
                SPropertyAccess(
                  offset: 0,
                  length: 0,
                  target: _dot('e', 'Color'),
                  operator: '.',
                  propertyName: _id('blue'),
                ),
              ),
            ],
          ),
          'package:p/e.dart': _unit([], [_color()]),
        }),
        _refusedWith("Undefined static property 'blue' on enum 'Color'"),
      );
    });
  });

  group('ghissues66/AST: an enum\'s own names inside its members', () {
    test('GH66-AST-3: `static const Color first = red;`, `values` and a '
        'static field by bare name in static and instance members '
        '[2026-11-17]', () {
      final result = _run({
        'package:p/main.dart': _unit(
          [],
          [
            _color([
              _field('Color', 'first', init: _id('red'), isStatic: true),
              _method('size', _dot('values', 'length'), isStatic: true),
              _method('other', _id('first')),
            ]),
            _main(
              _list([
                _dot('Color', 'first'),
                _call(_id('Color'), 'size'),
                _call(_dot('Color', 'green'), 'other'),
              ]),
            ),
          ],
        ),
      });
      expect([for (final v in result! as List) '$v'], [
        'Color.red',
        '2',
        'Color.red',
      ]);
    });
  });

  group('ghissues66/AST: a field implements an interface getter', () {
    test('GH66-AST-4: `class A implements I { final int x; }` with '
        '`abstract class I { int get x; }` [2026-11-17]', () {
      final result = _run({
        'package:p/main.dart': _unit(
          [],
          [
            SClassDeclaration(
              offset: 0,
              length: 0,
              isAbstract: true,
              namePart: SNameWithTypeParameters(
                offset: 0,
                length: 0,
                typeName: _id('I'),
              ),
              body: SBlockClassBody(
                offset: 0,
                length: 0,
                members: [
                  SMethodDeclaration(
                    offset: 0,
                    length: 0,
                    name: _id('x'),
                    returnType: _type('int'),
                    isGetter: true,
                    isAbstract: true,
                    body: SEmptyFunctionBody(offset: 0, length: 0),
                  ),
                ],
              ),
            ),
            SClassDeclaration(
              offset: 0,
              length: 0,
              namePart: SNameWithTypeParameters(
                offset: 0,
                length: 0,
                typeName: _id('A'),
              ),
              implementsClause: SImplementsClause(
                offset: 0,
                length: 0,
                interfaces: [_type('I')],
              ),
              body: SBlockClassBody(
                offset: 0,
                length: 0,
                members: [
                  _field('int', 'x'),
                  SConstructorDeclaration(
                    offset: 0,
                    length: 0,
                    typeName: _id('A'),
                    parameters: _params([
                      SFieldFormalParameter(
                        offset: 0,
                        length: 0,
                        name: _id('x'),
                      ),
                    ]),
                    body: SEmptyFunctionBody(offset: 0, length: 0),
                  ),
                ],
              ),
            ),
            _main(
              SPropertyAccess(
                offset: 0,
                length: 0,
                target: SInstanceCreationExpression(
                  offset: 0,
                  length: 0,
                  constructorName: SConstructorName(
                    offset: 0,
                    length: 0,
                    type: _type('A'),
                  ),
                  argumentList: _args([_int(3)]),
                ),
                operator: '.',
                propertyName: _id('x'),
              ),
            ),
          ],
        ),
      });
      expect(result, 3);
    });
  });
}
