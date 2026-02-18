import 'package:test/test.dart';
import 'package:tom_analyzer/tom_analyzer.dart';

import '../support/test_builders.dart';

void main() {
  test('ClassInfo exposes static members', () {
    final library = TestModelBuilders.library();
    final classInfo = TestModelBuilders.classInfo(libraryInfo: library);

    final staticMethod = MethodInfo(
      id: 'method1',
      name: 'staticMethod',
      qualifiedName: '${classInfo.library.uri}.staticMethod',
      declaringType: classInfo,
      sourceFile: classInfo.sourceFile,
      location: classInfo.location,
      returnType: TestModelBuilders.typeRef(),
      isStatic: true,
    );

    final staticField = FieldInfo(
      id: 'field1',
      name: 'staticField',
      qualifiedName: '${classInfo.library.uri}.staticField',
      declaringType: classInfo,
      sourceFile: classInfo.sourceFile,
      location: classInfo.location,
      type: TestModelBuilders.typeRef(),
      isStatic: true,
    );

    final customClass = ClassInfo(
      id: classInfo.id,
      name: classInfo.name,
      qualifiedName: classInfo.qualifiedName,
      library: classInfo.library,
      sourceFile: classInfo.sourceFile,
      location: classInfo.location,
      methods: [staticMethod],
      fields: [staticField],
    );

    expect(customClass.staticMembers.methods, contains(staticMethod));
    expect(customClass.staticMembers.fields, contains(staticField));
  });

  test('EnumInfo contains values', () {
    final library = TestModelBuilders.library();
    final enumInfo = TestModelBuilders.enumInfo(libraryInfo: library, name: 'Color');
    final value = EnumValueInfo(
      id: 'enumValue1',
      name: 'red',
      parentEnum: enumInfo,
      index: 0,
    );

    final customEnum = EnumInfo(
      id: enumInfo.id,
      name: enumInfo.name,
      qualifiedName: enumInfo.qualifiedName,
      library: enumInfo.library,
      sourceFile: enumInfo.sourceFile,
      location: enumInfo.location,
      values: [value],
    );

    expect(customEnum.values.first.parentEnum, enumInfo);
  });

  test('ExtensionInfo captures extended type', () {
    final library = TestModelBuilders.library();
    final extensionInfo = TestModelBuilders.extensionInfo(libraryInfo: library, name: 'Ext');

    expect(extensionInfo.extendedType.name, 'String');
  });
}
