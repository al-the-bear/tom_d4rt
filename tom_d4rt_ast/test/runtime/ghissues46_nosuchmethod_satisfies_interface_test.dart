// GH46/AST — GitHub #13: a class whose superclass (bridged or interpreted) or
// the class itself declares noSuchMethod satisfies the interfaces it does not
// implement, in the analyzer-free tree (ghissues46).
//
// The mirror of `tom_d4rt/test/ghissues46_nosuchmethod_satisfies_interface_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// `class Sentinel extends Gh46AstSentinel implements Contract {}` (the bridged
// superclass declaring noSuchMethod) was refused with `Missing concrete
// implementation for interface method 'read'`, and a missing member never
// reached a bridged noSuchMethod. A class relying on Object's noSuchMethod is
// still refused.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Serverpod's `UndefinedSentinel`, reduced.
abstract class Gh46AstSentinel {
  const Gh46AstSentinel();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('gh46 sentinel: ${invocation.memberName}');
}

class _Gh46AstNative extends Gh46AstSentinel {
  const _Gh46AstNative();
}

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

/// `<target>.<name>()`
SMethodInvocation _call(SExpression? target, String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0),
);

/// `<target>.<name>` (a getter read)
SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

/// `<expression> is <type>`
SIsExpression _is(SExpression expression, String type) => SIsExpression(
  offset: 0,
  length: 0,
  expression: expression,
  type: _type(type),
);

/// `abstract class Contract { String read(); }`
final _contract = SClassDeclaration(
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
        name: _id('read'),
        returnType: _type('String'),
        isAbstract: true,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SEmptyFunctionBody(offset: 0, length: 0),
      ),
    ],
  ),
);

/// `class <name> [extends <superclass>] implements Contract { <members> }`
SClassDeclaration _class(
  String name, {
  String? superclass,
  List<SClassMember> members = const [],
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: superclass == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: _type(superclass)),
  implementsClause: SImplementsClause(
    offset: 0,
    length: 0,
    interfaces: [_type('Contract')],
  ),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

/// `dynamic noSuchMethod(Invocation i) => '<answer>';`
SMethodDeclaration _noSuchMethod(String answer) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id('noSuchMethod'),
  returnType: _type('dynamic'),
  parameters: SFormalParameterList(
    offset: 0,
    length: 0,
    parameters: [
      SRegularFormalParameter(
        offset: 0,
        length: 0,
        name: _id('i'),
        type: _type('Invocation'),
      ),
    ],
  ),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: _str(answer)),
);

/// Runs `main() => <result>` after [declarations] and `Contract`.
Object? _run(List<SCompilationUnitMember> declarations, SExpression result) {
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh46AstSentinel,
        name: 'Gh46AstSentinel',
        isAbstract: true,
        constructors: {
          '': (visitor, positional, named) => const _Gh46AstNative(),
        },
        methods: {
          'noSuchMethod': (visitor, target, positional, named, typeArgs) =>
              (target as Gh46AstSentinel).noSuchMethod(
                positional.single as Invocation,
              ),
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
            _contract,
            ...declarations,
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

Matcher _sentinelRefuses(String member) => throwsA(
  predicate(
    (Object? e) => e.toString().contains('gh46 sentinel: Symbol("$member")'),
    "the native sentinel's UnsupportedError for '$member'",
  ),
);

void main() {
  group('GH46/AST: noSuchMethod satisfies an interface', () {
    final sentinel = _class('Sentinel', superclass: 'Gh46AstSentinel');

    test('F-GH46-AST-1: a bridged superclass with noSuchMethod - the class is '
        'valid and implements the interface (GitHub #13) [2026-11-14]', () {
      expect(_run([sentinel], _is(_call(null, 'Sentinel'), 'Contract')), isTrue);
    });

    test('F-GH46-AST-2: a missing method and getter reach the bridged '
        'noSuchMethod [2026-11-14]', () {
      expect(
        () => _run([sentinel], _call(_call(null, 'Sentinel'), 'read')),
        _sentinelRefuses('read'),
      );
      expect(
        () => _run([sentinel], _get(_call(null, 'Sentinel'), 'size')),
        _sentinelRefuses('size'),
      );
    });

    test('F-GH46-AST-3: an interpreted superclass\'s and the class\'s own '
        'noSuchMethod answer the missing member [2026-11-14]', () {
      final base = SClassDeclaration(
        offset: 0,
        length: 0,
        namePart: SNameWithTypeParameters(
          offset: 0,
          length: 0,
          typeName: _id('Base'),
        ),
        body: SBlockClassBody(
          offset: 0,
          length: 0,
          members: [_noSuchMethod('base')],
        ),
      );
      expect(
        _run([
          base,
          _class('C', superclass: 'Base'),
        ], _call(_call(null, 'C'), 'read')),
        'base',
      );
      expect(
        _run([
          _class('D', members: [_noSuchMethod('own')]),
        ], _call(_call(null, 'D'), 'read')),
        'own',
      );
    });

    test('F-GH46-AST-4: Object\'s noSuchMethod satisfies nothing - the class '
        'is still refused [2026-11-14]', () {
      expect(
        () => _run([_class('S')], _call(null, 'S')),
        throwsA(
          predicate(
            (Object? e) =>
                e.toString().contains('Missing concrete implementation'),
            'refused as incomplete',
          ),
        ),
      );
    });
  });
}
