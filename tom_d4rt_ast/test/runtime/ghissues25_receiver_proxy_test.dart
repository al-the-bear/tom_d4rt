// GH25/AST — a receiver proxy stands in as an interpreted instance's native
// object in the analyzer-free tree, so a member it inherits from an abstract
// bridged class runs (ghissues25).
//
// The mirror of `tom_d4rt/test/ghissues25_receiver_proxy_test.dart`, which
// runs source. Here each script is a hand-built bundle. Before the fix an
// inherited member of an abstract bridged class, which gives a script subclass
// no native super-object, reached the RC-9 fallback: `Leaf().describe()` and
// `Leaf().label` answered null, and `super.describe()` was a no-op (GEN-130:
// `toDiagnosticsNode()` on a script `DiagnosticableTree`).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// A native abstract class: `describe` calls the overridable `name`.
abstract class Gh25AstBase {
  String name() => 'base';
  String describe() => 'Base(${name()})';
  String get label => 'label:${name()}';
}

/// The receiver proxy: forwards `name` to the script's override.
class _Receiver extends Gh25AstBase implements D4InterpretedProxy {
  _Receiver(this._visitor, this._instance);
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  String name() {
    final method = _instance.klass.findInstanceMethod('name');
    if (method == null) return super.name();
    return method.bind(_instance).call(_visitor, [], {}) as String;
  }
}

/// The same shape, registered as a plain interface proxy only.
abstract class Gh25AstPlain {
  String describe() => 'Plain';
}

class _PlainProxy extends Gh25AstPlain implements D4InterpretedProxy {
  _PlainProxy(this._instance);
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;
}

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SFormalParameterList _params() => SFormalParameterList(offset: 0, length: 0);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

SArgumentList _noArgs() => SArgumentList(offset: 0, length: 0);

/// `String <name>() => <value>;`
SMethodDeclaration _method(String name, SExpression value) =>
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      returnType: _type('String'),
      parameters: _params(),
      body: _arrow(value),
    );

/// `class <name> extends <superclass> { <members> }`
SClassDeclaration _class(
  String name,
  String superclass, [
  List<SClassMember> members = const [],
]) => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: _type(superclass),
  ),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

/// `<Name>()`
SMethodInvocation _new(String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  argumentList: _noArgs(),
);

/// `<target>.<name>()`
SMethodInvocation _call(SExpression target, String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  methodName: _id(name),
  argumentList: _noArgs(),
);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

Object? _run(List<SExpression> results) {
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh25AstBase,
        name: 'Gh25AstBase',
        isAbstract: true,
        methods: {
          'name': (visitor, target, positional, named, typeArgs) =>
              (target as Gh25AstBase).name(),
          'describe': (visitor, target, positional, named, typeArgs) =>
              (target as Gh25AstBase).describe(),
        },
        getters: {'label': (visitor, target) => (target as Gh25AstBase).label},
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh25AstPlain,
        name: 'Gh25AstPlain',
        isAbstract: true,
        methods: {
          'describe': (visitor, target, positional, named, typeArgs) =>
              (target as Gh25AstPlain).describe(),
        },
      ),
      'package:g/g.dart',
    );
  D4.registerInterfaceProxy(
    'Gh25AstBase',
    (visitor, instance) => _Receiver(visitor, instance),
  );
  D4.markProxyIsReceiver('Gh25AstBase');
  D4.registerInterfaceProxy(
    'Gh25AstPlain',
    (visitor, instance) => _PlainProxy(instance),
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
            // class Leaf extends Gh25AstBase { String name() => 'leaf'; }
            _class('Leaf', 'Gh25AstBase', [_method('name', _str('leaf'))]),
            // class Wrapped extends Gh25AstBase {
            //   String name() => 'wrapped';
            //   String describe() => super.describe();
            // }
            _class('Wrapped', 'Gh25AstBase', [
              _method('name', _str('wrapped')),
              _method(
                'describe',
                _call(SSuperExpression(offset: 0, length: 0), 'describe'),
              ),
            ]),
            _class('P', 'Gh25AstPlain'),
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: _params(),
                body: _arrow(
                  SListLiteral(offset: 0, length: 0, elements: results),
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

void main() {
  group('GH25/AST: a receiver proxy stands in as the native object', () {
    test('F-GH25-AST-1: an inherited method and getter run on the receiver '
        'and reach the script\'s override [2026-11-10]', () {
      expect(
        _run([
          _call(_new('Leaf'), 'describe'),
          SPropertyAccess(
            offset: 0,
            length: 0,
            target: _new('Leaf'),
            operator: '.',
            propertyName: _id('label'),
          ),
        ]),
        ['Base(leaf)', 'label:leaf'],
      );
    });

    test('F-GH25-AST-2: a script override calling super reaches the '
        'inherited member through the receiver [2026-11-10]', () {
      expect(_run([_call(_new('Wrapped'), 'describe')]), ['Base(wrapped)']);
    });

    test('F-GH25-AST-3: an unmarked interface proxy is not consulted for an '
        'inherited member [2026-11-10]', () {
      // An error since ghissues31 (it answered null before): the member has
      // no native object to run on.
      expect(
        () => _run([_call(_new('P'), 'describe')]),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("'Gh25AstPlain.describe'"),
          ),
        ),
      );
    });
  });
}
