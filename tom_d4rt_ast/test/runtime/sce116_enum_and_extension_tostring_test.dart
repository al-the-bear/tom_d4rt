// SCE116/AST — the analyzer-free twin of
// `tom_d4rt/test/sce116_enum_and_extension_tostring_test.dart`.
//
// SCD72 taught `InterpretedInstance.toString()` to dispatch to a script's own
// override and left two siblings in the same file behind. An extension-type
// instance rendered `<instance of Y>` where Dart prints the wrapped value —
// an extension type IS its representation at run time — and neither it nor an
// enum value dispatched to an override.
//
// WHAT THIS SIDE UNIQUELY ANSWERS is the `declaringVisitor` wiring. Dispatching
// to interpreted code from a plain `Object` override needs a visitor that
// nothing can hand it, so it is stored on the declaring TYPE when the
// declaration is visited. That is interpreter code, and this tree's
// `visitEnumDeclaration` / `visitExtensionTypeDeclaration` are its own.
//
// THE BUNDLE RETURNS THE VALUE and the host interpolates it, which is the
// boundary the defect lived at: `toString()` is what native code reaches.
//
// ABLATED 2026-09-22: dropping the enum's `declaringVisitor` assignment fails
// -1; dropping the extension type's fails -3; restoring `<instance of X>` as
// the fallback fails -4. -2 passes under all three — it is the rail, because
// an enum's DEFAULT was already right and a fix here must not disturb it.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

SNamedType _type(String name) =>
    SNamedType(offset: 0, length: 0, name: _id(name));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

/// `String toString() => <body>;`
SMethodDeclaration _toStringMethod(SExpression body) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id('toString'),
  returnType: _type('String'),
  parameters: _noParams(),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
);

/// `'<left>' + <right>`
SExpression _concat(String left, SExpression right) => SBinaryExpression(
  offset: 0,
  length: 0,
  leftOperand: SSimpleStringLiteral(offset: 0, length: 0, value: left),
  operator: '+',
  rightOperand: right,
);

/// `main() => <expression>;`
SFunctionDeclaration _main(SExpression expression) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id('main'),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _noParams(),
    body: SExpressionFunctionBody(offset: 0, length: 0, expression: expression),
  ),
);

AstBundle _bundle(List<SCompilationUnitMember> declarations) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: declarations,
      ),
    },
  );
}

/// `enum E { a, b; [String toString() => 'E<' + name + '>';] }`
/// with `main() => E.a;`
AstBundle _enumBundle({required bool withOverride}) => _bundle([
  SEnumDeclaration(
    offset: 0,
    length: 0,
    name: _id('E'),
    constants: [
      SEnumConstantDeclaration(offset: 0, length: 0, name: _id('a')),
      SEnumConstantDeclaration(offset: 0, length: 0, name: _id('b')),
    ],
    members: [
      if (withOverride)
        _toStringMethod(
          SBinaryExpression(
            offset: 0,
            length: 0,
            leftOperand: _concat('E<', _id('name')),
            operator: '+',
            rightOperand: SSimpleStringLiteral(
              offset: 0,
              length: 0,
              value: '>',
            ),
          ),
        ),
    ],
  ),
  _main(
    SPrefixedIdentifier(
      offset: 0,
      length: 0,
      prefix: _id('E'),
      identifier: _id('a'),
    ),
  ),
]);

/// `extension type X(int v) { [String toString() => 'X:' + v.toString();] }`
/// with `main() => X(7);`
AstBundle _extensionTypeBundle({required bool withOverride}) => _bundle([
  SExtensionTypeDeclaration(
    offset: 0,
    length: 0,
    name: _id('X'),
    representation: SRepresentationDeclaration(
      offset: 0,
      length: 0,
      fieldName: 'v',
      fieldType: _type('int'),
    ),
    members: [
      if (withOverride)
        _toStringMethod(
          _concat(
            'X:',
            SMethodInvocation(
              offset: 0,
              length: 0,
              target: _id('v'),
              operator: '.',
              methodName: _id('toString'),
              argumentList: _args(),
            ),
          ),
        ),
    ],
  ),
  _main(
    SMethodInvocation(
      offset: 0,
      length: 0,
      methodName: _id('X'),
      argumentList: _args([SIntegerLiteral(offset: 0, length: 1, value: 7)]),
    ),
  ),
]);

/// What a HOST sees when it interpolates what the bundle returned.
String _hostSees(AstBundle bundle) => '${D4rtRunner().executeBundle(bundle)}';

void main() {
  group('SCE116/AST: enum and extension-type toString', () {
    test('F-SCE116-AST-1: an enum override reaches the host [2026-09-22] '
        '(PASS)', () {
      // Needs `InterpretedEnum.declaringVisitor`, assigned in this tree's own
      // `visitEnumDeclaration`. Without it the dispatch has no visitor and the
      // fallback is returned, which is the defect.
      expect(_hostSees(_enumBundle(withOverride: true)), 'E<a>');
    });

    test('F-SCE116-AST-2 (rail): an enum default is unchanged [2026-09-22] '
        '(PASS)', () {
      // This half was ALREADY right, which is why the defect was easy to miss.
      expect(_hostSees(_enumBundle(withOverride: false)), 'E.a');
    });

    test('F-SCE116-AST-3: an extension-type override reaches the host '
        '[2026-09-22] (PASS)', () {
      expect(_hostSees(_extensionTypeBundle(withOverride: true)), 'X:7');
    });

    test('F-SCE116-AST-4: no override renders the representation '
        '[2026-09-22] (PASS)', () {
      // An extension type has no runtime existence to describe, so
      // `Object.toString()` erases to the wrapped value. Real Dart prints 7.
      expect(_hostSees(_extensionTypeBundle(withOverride: false)), '7');
    });
  });
}
