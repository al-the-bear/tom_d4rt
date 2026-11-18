// GEN-135/AST - a private native class wrapped as its bridged superclass
// still answers the members of the bridged interface it implements
// (addtestscl2).
//
// The mirror of `tom_d4rt/test/addtestscl2_bridged_interface_members_test.dart`,
// which runs source; here each script is a hand-built bundle.
// `Material.of(context)` returns a `_RenderInkFeatures extends RenderProxyBox
// implements MaterialInkController`. The interpreter wraps it as the deeper
// bridged class, `RenderProxyBox`, and before the fix `color`, `vsync` and
// `addInkFeature` - members of `MaterialInkController` only - were undefined.
// Reduced here to `_Impl extends Cl2AstBase implements Cl2AstInk`.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class Cl2AstBase {
  String get base => 'base';
}

abstract interface class Cl2AstInk {
  String get color;
  String paint(String what);
}

abstract interface class Cl2AstOther {
  String get other;
}

class _Impl extends Cl2AstBase implements Cl2AstInk {
  @override
  String get color => 'amber';

  @override
  String paint(String what) => 'painted $what';
}

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

/// `<target>.<name>(<arguments>)`
SMethodInvocation _call(
  SExpression? target,
  String name, [
  List<SExpression> arguments = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: arguments),
);

/// `<target>.<name>`
SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

/// `Cl2AstBase.make()`: the native `_Impl`, returned unwrapped.
final _made = _call(_id('Cl2AstBase'), 'make');

D4rtRunner _runner() => D4rtRunner()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Cl2AstBase,
      name: 'Cl2AstBase',
      isAssignable: (v) => v is Cl2AstBase,
      hierarchyDepth: 2,
      getters: {'base': (visitor, target) => (target as Cl2AstBase).base},
      staticMethods: {
        'make': (visitor, positional, named, typeArgs) => _Impl(),
      },
    ),
    'package:g/g.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Cl2AstInk,
      name: 'Cl2AstInk',
      isAssignable: (v) => v is Cl2AstInk,
      hierarchyDepth: 1,
      getters: {'color': (visitor, target) => (target as Cl2AstInk).color},
      methods: {
        'paint': (visitor, target, positional, named, typeArgs) =>
            (target as Cl2AstInk).paint(positional.single as String),
      },
    ),
    'package:g/g.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Cl2AstOther,
      name: 'Cl2AstOther',
      isAssignable: (v) => v is Cl2AstOther,
      hierarchyDepth: 1,
      getters: {'other': (visitor, target) => (target as Cl2AstOther).other},
    ),
    'package:g/g.dart',
  );

/// Runs `main() => <result>`.
Object? _run(SExpression result) => _runner().executeBundle(
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

void main() {
  group('GEN-135/AST: members of a bridged interface of a private class', () {
    test('CL2A-1: the superclass member still reads [2026-11-18]', () {
      expect(_run(_get(_made, 'base')), 'base');
    });

    test('CL2A-2: a getter of the implemented bridged interface reads '
        '[2026-11-18]', () {
      expect(_run(_get(_made, 'color')), 'amber');
    });

    test('CL2A-3: a method of the implemented bridged interface calls '
        '[2026-11-18]', () {
      expect(_run(_call(_made, 'paint', [_str('ink')])), 'painted ink');
    });

    test('CL2A-4: a member of a bridged interface it does NOT implement '
        'stays undefined [2026-11-18]', () {
      expect(
        () => _run(_get(_made, 'other')),
        throwsA(
          predicate(
            (Object? e) => e.toString().contains(
              "Undefined property or method 'other'",
            ),
            'the undefined-member error for other',
          ),
        ),
      );
    });
  });
}
