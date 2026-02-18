import 'package:test/test.dart';
import '../support/test_builders.dart';

void main() {
  test('VariableInfo is static by default', () {
    final library = TestModelBuilders.library();
    final variable = TestModelBuilders.variableInfo(owningLibrary: library);

    expect(variable.isStatic, isTrue);
  });

  test('FieldInfo can be instance member', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);
    final field = TestModelBuilders.fieldInfo(declaringType: classInfo);

    expect(field.isStatic, isFalse);
  });
}
