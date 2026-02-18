import 'package:test/test.dart';
import '../support/test_builders.dart';

void main() {
  test('FunctionInfo is static by default', () {
    final library = TestModelBuilders.library();
    final functionInfo = TestModelBuilders.functionInfo(libraryInfo: library);

    expect(functionInfo.isStatic, isTrue);
    expect(functionInfo.isExternal, isFalse);
  });

  test('ConstructorInfo uses declaring type library', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);
    final ctor = TestModelBuilders.constructorInfo(declaringType: classInfo);

    expect(ctor.library, library);
    expect(ctor.isStatic, isFalse);
  });

  test('SetterInfo exposes parameter list', () {
    final library = TestModelBuilders.library();
    final setter = TestModelBuilders.setterInfo(owningLibrary: library);

    expect(setter.parameters.length, 1);
    expect(setter.parameters.first.name, 'value');
  });
}
