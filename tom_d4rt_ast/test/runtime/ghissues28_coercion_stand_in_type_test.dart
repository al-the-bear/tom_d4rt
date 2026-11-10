// GH28/AST — a value a registered type coercion converts to a bridged type
// stands in for that type in a type check, in the analyzer-free tree
// (ghissues28).
//
// The mirror of `tom_d4rt/test/ghissues28_coercion_stand_in_type_test.dart`,
// which runs source. Here each script is a hand-built bundle. The Flutter
// twins build a painting `StrutStyle` for a dart:ui `StrutStyle(...)` call and
// register the coercion painting -> dart:ui; since a prefixed annotation
// resolves to the prefixed library's own class (ghissues7, 0.219.0) rather
// than by its bare name, `ui.StrutStyle? strut` refused the stand-in (`type
// 'StrutStyle' is not a subtype of type 'StrutStyle?' of 'strut'`), and `is`
// never accepted it. A registered coercion now declares it.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class Gh28AstRich {
  const Gh28AstRich();
}

class Gh28AstEngine {
  const Gh28AstEngine();
}

class Gh28AstOther {
  const Gh28AstOther();
}

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

/// `prefix.Gh28AstStrut` as a type, `?` when [nullable].
SNamedType _type(String prefix, {bool nullable = false}) => SNamedType(
  offset: 0,
  length: 0,
  name: _id('Gh28AstStrut'),
  importPrefix: _id(prefix),
  isNullable: nullable,
);

/// `prefix.Gh28AstStrut()`
SMethodInvocation _new(String prefix) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: _id(prefix),
  operator: '.',
  methodName: _id('Gh28AstStrut'),
  argumentList: SArgumentList(offset: 0, length: 0),
);

/// `String <name>(<type> s) => '<answer>';`
SFunctionDeclaration _fn(String name, SNamedType type, String answer) =>
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      returnType: SNamedType(offset: 0, length: 0, name: _id('String')),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(
          offset: 0,
          length: 0,
          parameters: [
            SRegularFormalParameter(
              offset: 0,
              length: 0,
              name: _id('s'),
              type: type,
            ),
          ],
        ),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: _str(answer),
        ),
      ),
    );

SMethodInvocation _call(String name, SExpression arg) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: [arg]),
);

SImportDirective _import(String uri, String prefix) =>
    SImportDirective(offset: 0, length: 0, uri: _str(uri), prefix: _id(prefix));

Object? _run(SExpression result) {
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh28AstRich,
        name: 'Gh28AstStrut',
        constructors: {'': (v, p, n) => const Gh28AstRich()},
      ),
      'package:g/painting.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh28AstEngine,
        name: 'Gh28AstStrut',
        // The stand-in constructor, as the twins' StrutStyle user bridge.
        constructors: {'': (v, p, n) => const Gh28AstRich()},
      ),
      'package:g/ui.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh28AstOther,
        name: 'Gh28AstStrut',
        constructors: {'': (v, p, n) => const Gh28AstOther()},
      ),
      'package:g/other.dart',
    );
  D4.registerTypeCoercion(
    sourceType: Gh28AstRich,
    targetType: Gh28AstEngine,
    factory: (value) => const Gh28AstEngine(),
  );
  return runner.executeBundle(
    AstBundle(
      entryPointUri: _entry,
      modules: {
        _entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            _import('package:g/ui.dart', 'ui'),
            _import('package:g/other.dart', 'other'),
          ],
          declarations: [
            _fn('f', _type('ui', nullable: true), 'ok'),
            _fn('g', _type('other'), 'other'),
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
  group('GH28/AST: a coercion stand-in passes a check of its target', () {
    test('F-GH28-AST-1: a prefixed parameter and `is` accept the stand-in '
        '[2026-11-10]', () {
      expect(
        _run(
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              _call('f', _new('ui')),
              SIsExpression(
                offset: 0,
                length: 0,
                expression: _new('ui'),
                type: _type('ui'),
              ),
            ],
          ),
        ),
        ['ok', true],
      );
    });

    test('F-GH28-AST-2: a same-named bridge without a coercion is still '
        'another type [2026-11-10]', () {
      expect(
        () => _run(_call('g', _new('ui'))),
        throwsA(
          isA<D4rtTypeError>().having(
            (e) => e.toString(),
            'text',
            contains('is not a subtype of'),
          ),
        ),
      );
    });
  });
}
