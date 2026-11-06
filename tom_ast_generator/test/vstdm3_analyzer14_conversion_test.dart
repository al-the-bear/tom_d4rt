// VSTDM3: the copier carries analyzer 14's reshaped nodes into the mirror.
//
// The first exec run on analyzer 14 failed 169 tests because the argument
// list still collected `SExpression`s and the list helper dropped anything
// else in silence, so every named argument vanished. These tests hold the
// shapes the interpreter reads, one per reshaped family.
library;

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';

import 'test_helpers.dart';

SExpression _bodyExpression(SCompilationUnit unit, String fn) {
  final decl = unit.declarations.whereType<SFunctionDeclaration>().singleWhere(
    (d) => d.name?.name == fn,
  );
  final body = decl.functionExpression!.body as SExpressionFunctionBody;
  return body.expression!;
}

void main() {
  group('VSTDM3: analyzer 14 shapes reach the mirror', () {
    test('F-VSTDM3-GEN-1: named arguments survive, in order with positional '
        'ones [2026-11-06]', () {
      final unit = parseSource('''
int f(int a, {required int b}) => a + b;
int g() => f(1, b: 2);
''');
      final call = _bodyExpression(unit, 'g') as SMethodInvocation;
      final args = call.argumentList!.arguments;
      expect(args, hasLength(2));
      expect(args.first, isA<SIntegerLiteral>());
      final named = args.last as SNamedArgument;
      expect(named.name.name, 'b');
      expect(named.argumentExpression, isA<SIntegerLiteral>());
    });

    test('F-VSTDM3-GEN-2: a named record field is its own node '
        '[2026-11-06]', () {
      final unit = parseSource('''
Object r() => (1, x: 2);
''');
      final record = _bodyExpression(unit, 'r') as SRecordLiteral;
      expect(record.fields, hasLength(2));
      final named = record.fields.last as SRecordLiteralNamedField;
      expect(named.name.name, 'x');
    });

    test('F-VSTDM3-GEN-3: parameters carry kind, default and function-typed '
        'suffix [2026-11-06]', () {
      final unit = parseSource('''
void f(int a, [int b = 1]) {}
void g({required int c, int d = 2, int cb(String s)?}) {}
''');
      List<SFormalParameter> paramsOf(String name) => unit.declarations
          .whereType<SFunctionDeclaration>()
          .singleWhere((d) => d.name?.name == name)
          .functionExpression!
          .parameters!
          .parameters;
      final params = [...paramsOf('f'), ...paramsOf('g')];
      expect(params.map((p) => p.name!.name), ['a', 'b', 'c', 'd', 'cb']);
      expect(params[0].isRequiredPositional, isTrue);
      expect(params[1].isOptionalPositional, isTrue);
      expect(params[1].defaultClause!.value, isA<SIntegerLiteral>());
      expect(params[2].isRequiredNamed, isTrue);
      expect(params[3].isOptionalNamed, isTrue);
      expect(params[4].functionTypedSuffix, isNotNull);
      expect(params[4].functionTypedSuffix!.isNullable, isTrue);
    });

    test('F-VSTDM3-GEN-4: class, enum and extension type names and members '
        'sit in name part and body [2026-11-06]', () {
      final unit = parseSource('''
class C<T> { int x = 0; }
enum E { a, b; int get n => 1; }
extension type const Id(int it) { int get twice => it * 2; }
''');
      final c = unit.declarations.whereType<SClassDeclaration>().single;
      expect(c.namePart.typeName.name, 'C');
      expect(c.namePart.typeParameters, isNotNull);
      expect(c.body.members, hasLength(1));
      final e = unit.declarations.whereType<SEnumDeclaration>().single;
      expect(e.body.constants.map((k) => k.name!.name), ['a', 'b']);
      expect(e.body.members, hasLength(1));
      final x = unit.declarations.whereType<SExtensionTypeDeclaration>().single;
      expect(x.primaryConstructor.typeName.name, 'Id');
      expect(x.primaryConstructor.isConst, isTrue);
      expect(
        x.primaryConstructor.formalParameters.parameters.single.name!.name,
        'it',
      );
    });

    test('F-VSTDM3-GEN-5: labels and break targets [2026-11-06]', () {
      final unit = parseSource('''
void f() { outer: for (;;) { break outer; } }
''');
      final body =
          unit.declarations
                  .whereType<SFunctionDeclaration>()
                  .single
                  .functionExpression!
                  .body
              as SBlockFunctionBody;
      final labeled = body.block!.statements.single as SLabeledStatement;
      expect(labeled.labels.single.name.name, 'outer');
      final loop = labeled.statement as SForStatement;
      final brk = (loop.body as SBlock).statements.single as SBreakStatement;
      expect(brk.label!.name.name, 'outer');
    });
  });
}
