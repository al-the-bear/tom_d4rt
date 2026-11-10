// GH34/AST — with debug logging off, the interpreter builds no debug message,
// so it never stringifies the values a message would name, in the
// analyzer-free tree (ghissues34).
//
// The mirror of `tom_d4rt/test/ghissues34_debug_message_lazy_test.dart`,
// which runs source. Here the script is a hand-built bundle: it reads a
// getter, calls a method and passes a bridged probe object to a static
// method; the probe counts how often its `toString()` runs.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class Gh34AstProbe {
  static int stringified = 0;
  int value = 1;
  int bump() => ++value;

  @override
  String toString() {
    stringified++;
    return 'Gh34AstProbe($value)';
  }
}

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

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

/// `class Holder { Holder(this.held); Object? held; }` - a script object
/// whose field holds the probe: storing and reading a field are where the
/// interpreter's debug lines named the value.
final SClassDeclaration _holder = SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(
    offset: 0,
    length: 0,
    typeName: _id('Holder'),
  ),
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
          type: SNamedType(
            offset: 0,
            length: 0,
            name: _id('Object'),
            isNullable: true,
          ),
          variables: [
            SVariableDeclaration(offset: 0, length: 0, name: _id('held')),
          ],
        ),
      ),
      SConstructorDeclaration(
        offset: 0,
        length: 0,
        typeName: _id('Holder'),
        parameters: SFormalParameterList(
          offset: 0,
          length: 0,
          parameters: [
            SFieldFormalParameter(
              offset: 0,
              length: 0,
              name: _id('held'),
              isRequired: true,
            ),
          ],
        ),
        body: SEmptyFunctionBody(offset: 0, length: 0),
      ),
    ],
  ),
);

Object? _run(SExpression result) {
  const entry = 'package:p/main.dart';
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh34AstProbe,
        name: 'Gh34AstProbe',
        constructors: {'': (visitor, positional, named) => Gh34AstProbe()},
        getters: {'value': (visitor, target) => (target as Gh34AstProbe).value},
        methods: {
          'bump': (visitor, target, positional, named, typeArgs) =>
              (target as Gh34AstProbe).bump(),
        },
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Object,
        name: 'Gh34AstHost',
        staticMethods: {
          'take': (visitor, positional, named, typeArgs) => D4
              .extractBridgedArg<Gh34AstProbe>(positional[0], 'p', visitor)
              .value,
        },
      ),
      'package:g/g.dart',
    );
  return runner.executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            SImportDirective(
              offset: 0,
              length: 0,
              uri: SSimpleStringLiteral(
                offset: 0,
                length: 18,
                value: 'package:g/g.dart',
              ),
            ),
          ],
          declarations: [
            _holder,
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

void main() {
  setUp(() {
    Logger.setDebug(false);
    Gh34AstProbe.stringified = 0;
  });

  test('F-GH34-AST-1: a getter read, a method call and an argument never '
      'stringify a value with logging off [2026-11-10]', () {
    final probe = _call(null, 'Gh34AstProbe');
    expect(
      _run(
        SListLiteral(
          offset: 0,
          length: 0,
          elements: [
            SPropertyAccess(
              offset: 0,
              length: 0,
              target: probe,
              operator: '.',
              propertyName: _id('value'),
            ),
            _call(probe, 'bump'),
            _call(_id('Gh34AstHost'), 'take', [probe]),
          ],
        ),
      ),
      [1, 2, 1],
    );
    expect(Gh34AstProbe.stringified, 0);
  });

  test('F-GH34-AST-2: storing the probe in a script field and reading it '
      'back never stringifies it with logging off [2026-11-10]', () {
    final held = SPropertyAccess(
      offset: 0,
      length: 0,
      target: _call(null, 'Holder', [_call(null, 'Gh34AstProbe')]),
      operator: '.',
      propertyName: _id('held'),
    );
    expect(_run(_call(_id('Gh34AstHost'), 'take', [held])), 1);
    expect(Gh34AstProbe.stringified, 0);
  });
}
