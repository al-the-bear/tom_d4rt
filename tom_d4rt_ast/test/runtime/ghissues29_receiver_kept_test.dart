// GH29/AST — a receiver proxy is one native object per script instance,
// whichever route creates it first, in the analyzer-free tree (ghissues29).
//
// The mirror of `tom_d4rt/test/ghissues29_receiver_kept_test.dart`, which runs
// source. Here each script is a hand-built bundle. Before the fix a script
// instance crossing into native code got a fresh proxy at every crossing even
// when the proxy was marked as the instance's receiver.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

abstract class Gh29AstBase {
  String name() => 'base';
  String describe() => 'Base(${name()})';
}

/// Shaped like a generated receiver (see the tom_d4rt twin of this test).
class _Receiver extends Gh29AstBase
    implements D4InterpretedProxy, D4ReceiverProxy {
  _Receiver(this._visitor, this._instance);
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;
  final Set<String> _forwarding = <String>{};

  @override
  Object get d4rtInstance => _instance;

  @override
  R d4rtSuperCall<R>(String member, R Function() call) {
    if (!_forwarding.add(member)) return call();
    try {
      return call();
    } finally {
      _forwarding.remove(member);
    }
  }

  String _forward(String member, String Function() native) {
    final method = _instance.klass.findInstanceMethod(member);
    if (method == null || _forwarding.contains(member)) return native();
    _forwarding.add(member);
    try {
      return method.bind(_instance).call(_visitor, [], {}) as String;
    } finally {
      _forwarding.remove(member);
    }
  }

  @override
  String name() => _forward('name', super.name);

  @override
  String describe() => _forward('describe', super.describe);
}

abstract class Gh29AstPlain {}

class _PlainProxy extends Gh29AstPlain implements D4InterpretedProxy {
  _PlainProxy(this._instance);
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;
}

final _seen = <Object>[];

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

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

SExpressionStatement _stmt(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

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
    superclass: SNamedType(offset: 0, length: 0, name: _id(superclass)),
  ),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

/// `main() { final x = Cls(); Gh29AstHost.take(x); Gh29AstHost.take(x); }`,
/// with [cls] for `Cls` and [take] for `take`.
Object? _run(String cls, String take, {bool returnDescribe = false}) {
  _seen.clear();
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh29AstBase,
        name: 'Gh29AstBase',
        isAbstract: true,
        methods: {
          'describe': (visitor, target, positional, named, typeArgs) =>
              (target as Gh29AstBase).describe(),
        },
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh29AstPlain,
        name: 'Gh29AstPlain',
        isAbstract: true,
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Object,
        name: 'Gh29AstHost',
        staticMethods: {
          'takeBase': (visitor, positional, named, typeArgs) {
            _seen.add(
              D4.extractBridgedArg<Gh29AstBase>(positional[0], 'v', visitor),
            );
            return null;
          },
          'takePlain': (visitor, positional, named, typeArgs) {
            _seen.add(
              D4.extractBridgedArg<Gh29AstPlain>(positional[0], 'v', visitor),
            );
            return null;
          },
        },
      ),
      'package:g/g.dart',
    );
  D4.registerInterfaceProxy(
    'Gh29AstBase',
    (visitor, instance) => _Receiver(visitor, instance),
  );
  D4.markProxyIsReceiver('Gh29AstBase');
  D4.registerInterfaceProxy(
    'Gh29AstPlain',
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
            _class('Leaf', 'Gh29AstBase'),
            _class('P', 'Gh29AstPlain'),
            _class('Twice', 'Gh29AstBase', [
              SMethodDeclaration(
                offset: 0,
                length: 0,
                name: _id('describe'),
                returnType: SNamedType(
                  offset: 0,
                  length: 0,
                  name: _id('String'),
                ),
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: SBinaryExpression(
                    offset: 0,
                    length: 0,
                    leftOperand: _str('S:'),
                    operator: '+',
                    rightOperand: _call(
                      SSuperExpression(offset: 0, length: 0),
                      'describe',
                    ),
                  ),
                ),
              ),
            ]),
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SBlockFunctionBody(
                  offset: 0,
                  length: 0,
                  block: SBlock(
                    offset: 0,
                    length: 0,
                    statements: [
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
                              name: _id('x'),
                              initializer: _call(null, cls),
                            ),
                          ],
                        ),
                      ),
                      _stmt(_call(_id('Gh29AstHost'), take, [_id('x')])),
                      _stmt(_call(_id('Gh29AstHost'), take, [_id('x')])),
                      if (returnDescribe)
                        SReturnStatement(
                          offset: 0,
                          length: 0,
                          expression: _call(_id('x'), 'describe'),
                        ),
                    ],
                  ),
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
  group('GH29/AST: a receiver proxy is one native object per instance', () {
    test('F-GH29-AST-3: a script override calling super runs the native '
        'member once on the kept receiver [2026-11-10]', () {
      // The script calls its own override: its `super.describe()` reaches
      // the kept proxy, which must run the native member, not forward again.
      expect(_run('Twice', 'takeBase', returnDescribe: true), 'S:Base(base)');
      // Native code calling the override reaches the script once.
      expect((_seen.first as Gh29AstBase).describe(), 'S:Base(base)');
    });

    test('F-GH29-AST-1: two crossings receive the same receiver proxy '
        '[2026-11-10]', () {
      _run('Leaf', 'takeBase');
      expect(_seen, hasLength(2));
      expect(identical(_seen[0], _seen[1]), isTrue);
      expect(_seen[0], isA<_Receiver>());
    });

    test('F-GH29-AST-2: an unmarked proxy is still created per crossing '
        '[2026-11-10]', () {
      _run('P', 'takePlain');
      expect(identical(_seen[0], _seen[1]), isFalse);
    });
  });
}
