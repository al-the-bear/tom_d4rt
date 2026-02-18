import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

String describeElement(Element element) {
  return switch (element) {
    ClassInfo _ => 'class',
    EnumInfo _ => 'enum',
    MixinInfo _ => 'mixin',
    ExtensionInfo _ => 'extension',
    ExtensionTypeInfo _ => 'extensionType',
    TypeAliasInfo _ => 'alias',
    PackageInfo _ => 'package',
    LibraryInfo _ => 'library',
    AnalysisResult _ => 'analysis',
    FunctionInfo _ => 'function',
    MethodInfo _ => 'method',
    ConstructorInfo _ => 'constructor',
    GetterInfo _ => 'getter',
    SetterInfo _ => 'setter',
    FieldInfo _ => 'field',
    VariableInfo _ => 'variable',
  };
}

void main() {
  test('sealed element switch is exhaustive', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);

    expect(describeElement(classInfo), 'class');
    expect(describeElement(TestModelBuilders.enumInfo(libraryInfo: library)), 'enum');
  });
}
