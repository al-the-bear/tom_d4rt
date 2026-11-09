// GH8/AST: pull request al-the-bear/tom_d4rt#8 in the analyzer-free tree —
// type relationships and parameter types keep their import prefix.
//
// The mirror of `tom_d4rt/test/gh8_prefixed_type_relationships_test.dart`,
// which runs source. Each case here is a hand-built bundle whose entry module
// imports `package:rel/types.dart` (or two bridged libraries) under a prefix.
// Before the fix the class and mixin declarations looked every `extends` /
// `implements` / `with` / `on` type up by its bare name, dropping
// `SNamedType.importPrefix`, and so did a parameter's binding check: next to a
// same-named local class they bound the local one, and without one they
// refused the clause (`Superclass 'Base' not found`) or left the parameter
// unchecked. And a prefixed lookup that missed in the library's exports fell
// through to the script's own declarations, so a hidden name reached a
// same-named script class.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:rel/main.dart';
const _types = 'package:rel/types.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

/// `Name` or `prefix.Name` as a type.
SNamedType _type(String name, [String? prefix]) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(name),
  importPrefix: prefix == null ? null : _id(prefix),
);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SFormalParameterList _params([List<SFormalParameter> p = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: p);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

/// `int <name>() => <value>;`
SMethodDeclaration _method(String name, SExpression value) =>
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      returnType: _type('int'),
      parameters: _params(),
      body: _arrow(value),
    );

/// `<prefix.>Name()`, as an unresolved parse writes it: a call of the class.
SMethodInvocation _new(String name, [String? prefix]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: prefix == null ? null : _id(prefix),
  operator: prefix == null ? null : '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0),
);

/// `<target>.<name>()`
SMethodInvocation _call(SExpression target, String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0),
);

/// `<expression> is <prefix>.<name>`
SIsExpression _is(SExpression expression, String name, String prefix) =>
    SIsExpression(
      offset: 0,
      length: 0,
      expression: expression,
      type: _type(name, prefix),
    );

SClassDeclaration _class(
  String name, {
  SNamedType? extendsType,
  List<SNamedType> implementsTypes = const [],
  List<SNamedType> withTypes = const [],
  List<SClassMember> members = const [],
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: extendsType == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: extendsType),
  implementsClause: implementsTypes.isEmpty
      ? null
      : SImplementsClause(offset: 0, length: 0, interfaces: implementsTypes),
  withClause: withTypes.isEmpty
      ? null
      : SWithClause(offset: 0, length: 0, mixinTypes: withTypes),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

SImportDirective _import(
  String uri,
  String prefix, {
  List<String> hide = const [],
}) => SImportDirective(
  offset: 0,
  length: 0,
  uri: SSimpleStringLiteral(offset: 0, length: 0, value: uri),
  prefix: _id(prefix),
  combinators: [
    if (hide.isNotEmpty)
      SHideCombinator(
        offset: 0,
        length: 0,
        hiddenNames: [for (final n in hide) _id(n)],
      ),
  ],
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

/// `package:rel/types.dart`: `class Base { int base() => 10; }`,
/// `abstract class Contract { int contract(); }`,
/// `mixin Feature { int feature() => 30; }`.
SCompilationUnit _typesLibrary() => SCompilationUnit(
  offset: 0,
  length: 0,
  declarations: [
    _class('Base', members: [_method('base', _int(10))]),
    SClassDeclaration(
      offset: 0,
      length: 0,
      isAbstract: true,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id('Contract'),
      ),
      body: SBlockClassBody(
        offset: 0,
        length: 0,
        members: [
          SMethodDeclaration(
            offset: 0,
            length: 0,
            name: _id('contract'),
            returnType: _type('int'),
            parameters: _params(),
            body: SEmptyFunctionBody(offset: 0, length: 0),
          ),
        ],
      ),
    ),
    SMixinDeclaration(
      offset: 0,
      length: 0,
      name: _id('Feature'),
      body: SBlockClassBody(
        offset: 0,
        length: 0,
        members: [_method('feature', _int(30))],
      ),
    ),
  ],
);

Object? _run(
  List<SDirective> directives,
  List<SCompilationUnitMember> declarations, [
  D4rtRunner? runner,
]) => (runner ?? D4rtRunner()).executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: directives,
        declarations: declarations,
      ),
      _types: _typesLibrary(),
    },
  ),
);

/// Throws whose message contains [part].
Matcher _refusedWith(String part) => throwsA(
  predicate((Object e) => e.toString().contains(part), 'an error naming $part'),
);

class _TokenA {}

class _TokenB {}

D4rtRunner _bridged() => D4rtRunner()
  ..registerBridgedClass(
    BridgedClass(nativeType: _TokenA, name: 'Gh8Token', isAbstract: true),
    'package:a/a.dart',
  )
  ..registerBridgedClass(
    BridgedClass(nativeType: _TokenB, name: 'Gh8Token', isAbstract: true),
    'package:b/b.dart',
  );

void main() {
  group('GH8/AST: a prefixed relationship binds the imported type', () {
    test('F-GH8-AST-1: `extends imported.Base` next to a local Base '
        '[2026-11-09]', () {
      expect(
        _run(
          [_import(_types, 'imported')],
          [
            _class('Base', members: [_method('base', _int(-1))]),
            _class('Child', extendsType: _type('Base', 'imported')),
            _main(_call(_new('Child'), 'base')),
          ],
        ),
        10,
      );
    });

    test('F-GH8-AST-2: implements, with and mixin-on through a prefix with '
        'no local class of that name [2026-11-09]', () {
      expect(
        _run(
          [_import(_types, 'l')],
          [
            _class(
              'Y',
              implementsTypes: [_type('Contract', 'l')],
              members: [_method('contract', _int(40))],
            ),
            _class('Z', withTypes: [_type('Feature', 'l')]),
            SMixinDeclaration(
              offset: 0,
              length: 0,
              name: _id('M'),
              onClause: SOnClause(
                offset: 0,
                length: 0,
                superclassConstraints: [_type('Base', 'l')],
              ),
              body: SBlockClassBody(
                offset: 0,
                length: 0,
                members: [_method('m', _int(11))],
              ),
            ),
            _class(
              'W',
              extendsType: _type('Base', 'l'),
              withTypes: [_type('M')],
            ),
            _main(
              SListLiteral(
                offset: 0,
                length: 0,
                elements: [
                  _call(_new('Y'), 'contract'),
                  _is(_new('Y'), 'Contract', 'l'),
                  _call(_new('Z'), 'feature'),
                  _call(_new('W'), 'm'),
                  _call(_new('W'), 'base'),
                ],
              ),
            ),
          ],
        ),
        [40, true, 30, 11, 10],
      );
    });

    test('F-GH8-AST-3: two same-named bridges under two prefixes '
        '[2026-11-09]', () {
      expect(
        _run(
          [_import('package:a/a.dart', 'a'), _import('package:b/b.dart', 'b')],
          [
            _class('X', implementsTypes: [_type('Gh8Token', 'a')]),
            _main(
              SListLiteral(
                offset: 0,
                length: 0,
                elements: [
                  _is(_new('X'), 'Gh8Token', 'a'),
                  _is(_new('X'), 'Gh8Token', 'b'),
                ],
              ),
            ),
          ],
          _bridged(),
        ),
        [true, false],
      );
    });

    test('F-GH8-AST-4: a name the prefix hides is refused even with a '
        'same-named local class [2026-11-09]', () {
      expect(
        () => _run(
          [
            _import(_types, 'imported', hide: ['Base']),
          ],
          [
            _class('Base'),
            _class('Child', extendsType: _type('Base', 'imported')),
            _main(_int(1)),
          ],
        ),
        _refusedWith("Superclass 'Base' not found"),
      );
      expect(
        () => _run(
          [
            _import(_types, 'imported', hide: ['Base']),
          ],
          [_class('Base'), _main(_new('Base', 'imported'))],
        ),
        _refusedWith("'Base' not found in imported module 'imported'"),
      );
    });

    test('F-GH8-AST-6: a dart:core prefix reaches the core library but not '
        "the script's own declarations [2026-11-09]", () {
      final core = _import('dart:core', 'core');
      expect(
        _run(
          [core],
          [
            _main(
              SListLiteral(
                offset: 0,
                length: 0,
                elements: [
                  _is(_int(1), 'int', 'core'),
                  _is(_int(1), 'String', 'core'),
                ],
              ),
            ),
          ],
        ),
        [true, false],
      );
      expect(
        () => _run(
          [core],
          [
            _class('ScriptLocal'),
            _class('Child', extendsType: _type('ScriptLocal', 'core')),
            _main(_int(1)),
          ],
        ),
        _refusedWith("Superclass 'ScriptLocal' not found"),
      );
    });

    test('F-GH8-AST-5: a prefixed parameter type is checked against the '
        'imported type, not a same-named local one [2026-11-09]', () {
      // `String take(l.Base b) => 'taken';` next to a local `class Base {}`.
      List<SCompilationUnitMember> declarations(SExpression argument) => [
        _class('Base'),
        SFunctionDeclaration(
          offset: 0,
          length: 0,
          name: _id('take'),
          returnType: _type('String'),
          functionExpression: SFunctionExpression(
            offset: 0,
            length: 0,
            parameters: _params([
              SRegularFormalParameter(
                offset: 0,
                length: 0,
                name: _id('b'),
                type: _type('Base', 'l'),
              ),
            ]),
            body: _arrow(
              SSimpleStringLiteral(offset: 0, length: 0, value: 'taken'),
            ),
          ),
        ),
        _main(
          SMethodInvocation(
            offset: 0,
            length: 0,
            methodName: _id('take'),
            argumentList: SArgumentList(
              offset: 0,
              length: 0,
              arguments: [argument],
            ),
          ),
        ),
      ];
      final imports = [_import(_types, 'l')];
      expect(_run(imports, declarations(_new('Base', 'l'))), 'taken');
      expect(
        () => _run(imports, declarations(_new('Base'))),
        _refusedWith("is not a subtype of type 'Base' of 'b'"),
      );
      expect(
        () => _run(imports, declarations(_int(5))),
        _refusedWith("type 'int' is not a subtype of type 'Base' of 'b'"),
      );
    });
  });
}
