// ghissues78 (GitHub #22) - an annotation's name is an SIdentifier, as the
// analyzer's `Annotation.name` is an `Identifier`: a prefixed annotation
// (`@m.useResult`) keeps its SPrefixedIdentifier shape through JSON, and a
// bundle written with a simple-identifier name still reads.

import 'package:test/test.dart';
import 'package:tom_ast_model/tom_ast_model.dart';

SSimpleIdentifier _id(String name, int offset) =>
    SSimpleIdentifier(offset: offset, length: name.length, name: name);

SAnnotation _roundTrip(SAnnotation annotation) =>
    SAstNodeFactory.fromJson(annotation.toJson())! as SAnnotation;

void main() {
  group('ghissues78: SAnnotation.name is an SIdentifier', () {
    test('GH78-M1: a prefixed name keeps its shape through JSON, with a '
        'constructor name and arguments [2026-11-18]', () {
      final annotation = _roundTrip(
        SAnnotation(
          offset: 0,
          length: 17,
          name: SPrefixedIdentifier(
            offset: 1,
            length: 5,
            prefix: _id('m', 1),
            identifier: _id('Foo', 3),
          ),
          constructorName: _id('named', 7),
          arguments: SArgumentList(
            offset: 12,
            length: 3,
            arguments: [SIntegerLiteral(offset: 13, length: 1, value: 1)],
          ),
        ),
      );
      final name = annotation.name;
      expect(name, isA<SPrefixedIdentifier>());
      name as SPrefixedIdentifier;
      expect(name.prefix?.name, 'm');
      expect(name.identifier?.name, 'Foo');
      expect(name.identifierName, 'm.Foo');
      expect(annotation.constructorName?.name, 'named');
      expect(annotation.arguments?.arguments, hasLength(1));
    });

    test('GH78-M2: a simple name, as every bundle before ghissues78 wrote '
        'it, still reads [2026-11-18]', () {
      final json = <String, dynamic>{
        'nodeType': 'Annotation',
        'offset': 0,
        'length': 9,
        'name': {
          'nodeType': 'SimpleIdentifier',
          'offset': 1,
          'length': 8,
          'name': 'override',
        },
      };
      final annotation = SAnnotation.fromJson(json);
      expect(annotation.name, isA<SSimpleIdentifier>());
      expect((annotation.name! as SSimpleIdentifier).name, 'override');
      expect(
        SAnnotation.fromJson(annotation.toJson()).toJson(),
        annotation.toJson(),
      );
    });

    test('GH78-M3: no name reads as none [2026-11-18]', () {
      expect(
        SAnnotation.fromJson({
          'nodeType': 'Annotation',
          'offset': 0,
          'length': 1,
        }).name,
        isNull,
      );
    });
  });
}
