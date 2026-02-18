import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

void main() {
  test('type declarations extend base hierarchy', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);
    final enumInfo = TestModelBuilders.enumInfo(libraryInfo: library);
    final mixinInfo = TestModelBuilders.mixinInfo(libraryInfo: library);
    final extensionInfo = TestModelBuilders.extensionInfo(libraryInfo: library);
    final extensionTypeInfo = TestModelBuilders.extensionTypeInfo(libraryInfo: library);
    final typeAliasInfo = TestModelBuilders.typeAliasInfo(libraryInfo: library);

    expect(classInfo, isA<TypeDeclaration>());
    expect(enumInfo, isA<TypeDeclaration>());
    expect(mixinInfo, isA<TypeDeclaration>());
    expect(extensionInfo, isA<TypeDeclaration>());
    expect(extensionTypeInfo, isA<TypeDeclaration>());
    expect(typeAliasInfo, isA<TypeDeclaration>());
  });

  test('executables extend executable element', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);
    final functionInfo = TestModelBuilders.functionInfo(libraryInfo: library);
    final methodInfo = TestModelBuilders.methodInfo(declaringType: classInfo);
    final ctorInfo = TestModelBuilders.constructorInfo(declaringType: classInfo);
    final getterInfo = TestModelBuilders.getterInfo(declaringType: classInfo);
    final setterInfo = TestModelBuilders.setterInfo(declaringType: classInfo);

    expect(functionInfo, isA<ExecutableElement>());
    expect(methodInfo, isA<ExecutableElement>());
    expect(ctorInfo, isA<ExecutableElement>());
    expect(getterInfo, isA<ExecutableElement>());
    expect(setterInfo, isA<ExecutableElement>());
  });

  test('variables extend variable element', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);
    final fieldInfo = TestModelBuilders.fieldInfo(declaringType: classInfo);
    final variableInfo = TestModelBuilders.variableInfo(owningLibrary: library);

    expect(fieldInfo, isA<VariableElement>());
    expect(variableInfo, isA<VariableElement>());
  });

  test('container elements extend base element', () {
    final analysisResult = AnalysisResult(
      id: 'analysis_1',
      timestamp: DateTime(2026, 1, 1),
      dartSdkVersion: '3.10.4',
      analyzerVersion: '7.7.1',
      schemaVersion: '1.0',
      rootPackage: TestModelBuilders.package(),
      packages: const {},
      libraries: const {},
      files: const {},
    );

    expect(analysisResult, isA<ContainerElement>());
  });
}
