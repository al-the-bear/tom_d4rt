import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

void main() {
  test('SourceLocation holds offsets', () {
    const location = SourceLocation(line: 10, column: 5, offset: 42, length: 3);
    expect(location.line, 10);
    expect(location.column, 5);
    expect(location.offset, 42);
    expect(location.length, 3);
  });

  test('AnnotationInfo captures arguments', () {
    const annotation = AnnotationInfo(
      name: 'Test',
      qualifiedName: 'package:test/Test',
      constructorName: 'named',
      positionalArguments: [ArgumentValue(1), ArgumentValue('value')],
      namedArguments: {'flag': ArgumentValue(true)},
    );

    expect(annotation.name, 'Test');
    expect(annotation.qualifiedName, 'package:test/Test');
    expect(annotation.constructorName, 'named');
    expect(annotation.positionalArguments.length, 2);
    expect(annotation.namedArguments['flag']?.value, true);
  });

  test('ArgumentValue stringifies null', () {
    const arg = ArgumentValue(null);
    expect(arg.toString(), 'null');
  });

  test('TypeParameterInfo stores variance', () {
    final typeParam = TypeParameterInfo(
      id: 't1',
      name: 'T',
      variance: TypeParameterVariance.covariant,
    );

    expect(typeParam.variance, TypeParameterVariance.covariant);
  });

  test('ParameterInfo tracks required flags', () {
    final param = ParameterInfo(
      id: 'p1',
      name: 'value',
      type: TestModelBuilders.typeRef(),
      isRequired: true,
      isNamed: false,
      isPositional: true,
      hasDefaultValue: false,
    );

    expect(param.isRequired, isTrue);
    expect(param.isNamed, isFalse);
    expect(param.isPositional, isTrue);
    expect(param.hasDefaultValue, isFalse);
  });
}
