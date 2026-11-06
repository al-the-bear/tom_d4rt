// VSTDM3: the model mirrors the AST shapes of analyzer 13/14.
//
// analyzer 13 folded the formal-parameter wrappers into one `FormalParameter`
// (a default value is a clause, a function-typed parameter a suffix), split
// `NamedExpression` into `NamedArgument` and `RecordLiteralNamedField`, gave
// labels a token name and break/continue a `LabelReference`, and moved the
// name, type parameters and members of class-like declarations into a
// `ClassNamePart` and a body. Each node here round-trips through JSON and is
// dispatched to its own visit method.
library;

import 'package:test/test.dart';
import 'package:tom_ast_model/tom_ast_model.dart';

SSimpleIdentifier _id(String name, [int offset = 0]) =>
    SSimpleIdentifier(offset: offset, length: name.length, name: name);

SAstNode _roundTrip(SAstNode node) {
  final copy = SAstNodeFactory.fromJson(node.toJson())!;
  final log = <String>[];
  expect(copy.equals(node, log), isTrue, reason: log.join('\n'));
  expect(copy.runtimeType, node.runtimeType);
  return copy;
}

class _Recorder extends SAstVisitor<String> {
  @override
  String? visitNode(SAstNode node) => 'node';
  @override
  String? visitRegularFormalParameter(SRegularFormalParameter node) =>
      'regular';
  @override
  String? visitNamedArgument(SNamedArgument node) => 'namedArgument';
  @override
  String? visitRecordLiteralNamedField(SRecordLiteralNamedField node) =>
      'recordField';
  @override
  String? visitLabelReference(SLabelReference node) => 'labelReference';
  @override
  String? visitPrimaryConstructorDeclaration(
    SPrimaryConstructorDeclaration node,
  ) => 'primaryConstructor';
}

void main() {
  group('VSTDM3: analyzer 14 shapes', () {
    test('F-VSTDM3-1: one formal parameter carries default and kind '
        '[2026-11-06]', () {
      final p = SRegularFormalParameter(
        offset: 1,
        length: 12,
        name: _id('x', 5),
        isRequired: false,
        isNamed: true,
        defaultClause: SFormalParameterDefaultClause(
          offset: 8,
          length: 3,
          value: SIntegerLiteral(offset: 10, length: 1, value: 1),
        ),
      );
      final copy = _roundTrip(p) as SFormalParameter;
      expect(copy.isOptionalNamed, isTrue);
      expect(copy.isRequiredPositional, isFalse);
      expect(copy.defaultClause!.value, isA<SIntegerLiteral>());
      expect(copy.accept(_Recorder()), 'regular');
    });

    test('F-VSTDM3-2: a function-typed parameter keeps its suffix '
        '[2026-11-06]', () {
      final p = SFieldFormalParameter(
        offset: 0,
        length: 20,
        name: _id('cb'),
        functionTypedSuffix: SFunctionTypedFormalParameterSuffix(
          offset: 7,
          length: 8,
          formalParameters: SFormalParameterList(offset: 7, length: 8),
          isNullable: true,
        ),
      );
      final copy = _roundTrip(p) as SFieldFormalParameter;
      expect(copy.functionTypedSuffix!.isNullable, isTrue);
      expect(copy.isRequiredPositional, isTrue);
    });

    test('F-VSTDM3-3: named arguments and named record fields are distinct '
        'nodes [2026-11-06]', () {
      final arg = SNamedArgument(
        offset: 0,
        length: 4,
        name: _id('a'),
        argumentExpression: SIntegerLiteral(offset: 3, length: 1, value: 7),
      );
      final list = SArgumentList(
        offset: 0,
        length: 6,
        arguments: [arg, SIntegerLiteral(offset: 5, length: 1, value: 1)],
      );
      final copy = _roundTrip(list) as SArgumentList;
      expect(copy.arguments.first, isA<SNamedArgument>());
      expect(copy.arguments.first.accept(_Recorder()), 'namedArgument');

      final record = SRecordLiteral(
        offset: 0,
        length: 8,
        fields: [
          SRecordLiteralNamedField(
            offset: 1,
            length: 4,
            name: _id('b'),
            fieldExpression: SIntegerLiteral(offset: 4, length: 1, value: 2),
          ),
        ],
      );
      final recordCopy = _roundTrip(record) as SRecordLiteral;
      expect(recordCopy.fields.single.accept(_Recorder()), 'recordField');
    });

    test('F-VSTDM3-4: break names a label reference [2026-11-06]', () {
      final node = SBreakStatement(
        offset: 0,
        length: 10,
        label: SLabelReference(offset: 6, length: 3, name: _id('out')),
      );
      final copy = _roundTrip(node) as SBreakStatement;
      expect(copy.label!.name.name, 'out');
      expect(copy.label!.accept(_Recorder()), 'labelReference');
    });

    test('F-VSTDM3-5: class and enum names and members sit in name part and '
        'body [2026-11-06]', () {
      final cls = SClassDeclaration(
        offset: 0,
        length: 20,
        namePart: SNameWithTypeParameters(
          offset: 6,
          length: 3,
          typeName: _id('Foo'),
        ),
        body: SEmptyClassBody(offset: 19, length: 1),
      );
      final copy = _roundTrip(cls) as SClassDeclaration;
      expect(copy.namePart.typeName.name, 'Foo');
      expect(copy.body.members, isEmpty);

      final en = SEnumDeclaration(
        offset: 0,
        length: 20,
        namePart: SNameWithTypeParameters(
          offset: 5,
          length: 1,
          typeName: _id('E'),
        ),
        body: SBlockEnumBody(
          offset: 7,
          length: 5,
          constants: [
            SEnumConstantDeclaration(offset: 8, length: 1, name: _id('a')),
          ],
        ),
      );
      final enCopy = _roundTrip(en) as SEnumDeclaration;
      expect(enCopy.body.constants.single.name!.name, 'a');
    });

    test('F-VSTDM3-6: an extension type is named by its primary constructor '
        '[2026-11-06]', () {
      final ext = SExtensionTypeDeclaration(
        offset: 0,
        length: 30,
        namePart: SPrimaryConstructorDeclaration(
          offset: 15,
          length: 10,
          typeName: _id('Id'),
          isConst: true,
          formalParameters: SFormalParameterList(
            offset: 17,
            length: 7,
            parameters: [
              SRegularFormalParameter(offset: 18, length: 5, name: _id('it')),
            ],
          ),
        ),
        body: SBlockClassBody(offset: 26, length: 2),
      );
      final copy = _roundTrip(ext) as SExtensionTypeDeclaration;
      expect(copy.primaryConstructor.isConst, isTrue);
      expect(
        copy.primaryConstructor.formalParameters.parameters.single.name!.name,
        'it',
      );
      expect(copy.namePart.accept(_Recorder()), 'primaryConstructor');
    });
  });
}
